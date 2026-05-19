import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayDeque;
import java.util.Arrays;
import javax.imageio.ImageIO;

public class PrepareHeroCup {
    private static final class Pixel {
        final int x;
        final int y;
        final int argb;

        Pixel(int x, int y, int argb) {
            this.x = x;
            this.y = y;
            this.argb = argb;
        }
    }

    public static void main(String[] args) throws IOException {
        if (args.length != 2) {
            throw new IllegalArgumentException("Usage: PrepareHeroCup <input> <output>");
        }

        BufferedImage source = ImageIO.read(new File(args[0]));
        if (source == null) {
            throw new IllegalArgumentException("Could not read image: " + args[0]);
        }

        int width = source.getWidth();
        int height = source.getHeight();
        int[] pixels = source.getRGB(0, 0, width, height, null, 0, width);
        boolean[] background = detectBackground(pixels, width, height);
        keepLargestOpaqueRegion(background, width, height);

        int[] outputPixels = Arrays.copyOf(pixels, pixels.length);
        int minX = width;
        int minY = height;
        int maxX = -1;
        int maxY = -1;

        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int index = (y * width) + x;
                if (background[index]) {
                    outputPixels[index] = 0;
                    continue;
                }

                int softened = softenEdgePixel(outputPixels, background, width, height, x, y, index);
                outputPixels[index] = softened;

                int alpha = (softened >>> 24) & 0xff;
                if (alpha > 0) {
                    if (x < minX) minX = x;
                    if (y < minY) minY = y;
                    if (x > maxX) maxX = x;
                    if (y > maxY) maxY = y;
                }
            }
        }

        if (maxX < minX || maxY < minY) {
            throw new IllegalStateException("No opaque subject remained after background detection.");
        }

        int paddingX = 46;
        int paddingY = 40;
        minX = Math.max(0, minX - paddingX);
        minY = Math.max(0, minY - paddingY);
        maxX = Math.min(width - 1, maxX + paddingX);
        maxY = Math.min(height - 1, maxY + paddingY);

        int outWidth = maxX - minX + 1;
        int outHeight = maxY - minY + 1;
        BufferedImage output = new BufferedImage(outWidth, outHeight, BufferedImage.TYPE_INT_ARGB);
        output.setRGB(0, 0, outWidth, outHeight, crop(outputPixels, width, minX, minY, outWidth, outHeight), 0, outWidth);

        File outFile = new File(args[1]);
        File parent = outFile.getParentFile();
        if (parent != null && !parent.exists()) {
            parent.mkdirs();
        }
        ImageIO.write(output, "png", outFile);
    }

    private static boolean[] detectBackground(int[] pixels, int width, int height) {
        boolean[] visited = new boolean[pixels.length];
        boolean[] background = new boolean[pixels.length];
        ArrayDeque<Pixel> queue = new ArrayDeque<>();
        double[] borderMean = computeBorderMean(pixels, width, height);

        for (int x = 0; x < width; x++) {
            seed(queue, visited, background, pixels, width, height, x, 0, borderMean);
            seed(queue, visited, background, pixels, width, height, x, height - 1, borderMean);
        }
        for (int y = 1; y < height - 1; y++) {
            seed(queue, visited, background, pixels, width, height, 0, y, borderMean);
            seed(queue, visited, background, pixels, width, height, width - 1, y, borderMean);
        }

        int[] dx = {1, -1, 0, 0};
        int[] dy = {0, 0, 1, -1};

        while (!queue.isEmpty()) {
            Pixel current = queue.removeFirst();

            for (int i = 0; i < 4; i++) {
                int nx = current.x + dx[i];
                int ny = current.y + dy[i];
                if (nx < 0 || ny < 0 || nx >= width || ny >= height) {
                    continue;
                }

                int nIndex = (ny * width) + nx;
                if (visited[nIndex]) {
                    continue;
                }
                visited[nIndex] = true;

                int candidate = pixels[nIndex];
                if (canGrowBackground(candidate, current.argb, borderMean)) {
                    background[nIndex] = true;
                    queue.addLast(new Pixel(nx, ny, candidate));
                }
            }
        }

        return background;
    }

    private static void seed(ArrayDeque<Pixel> queue, boolean[] visited, boolean[] background,
                             int[] pixels, int width, int height, int x, int y, double[] borderMean) {
        int index = (y * width) + x;
        if (visited[index]) {
            return;
        }
        visited[index] = true;
        int argb = pixels[index];
        if (isBorderLike(argb, borderMean)) {
            background[index] = true;
            queue.addLast(new Pixel(x, y, argb));
        }
    }

    private static boolean isBorderLike(int argb, double[] borderMean) {
        int[] rgb = rgb(argb);
        int chroma = chroma(rgb);
        int brightness = brightness(rgb);
        double distanceToBorder = distance(rgb, borderMean);
        return chroma <= 36 && brightness >= 180 && distanceToBorder <= 68.0;
    }

    private static boolean canGrowBackground(int argb, int previousArgb, double[] borderMean) {
        int[] rgb = rgb(argb);
        int[] previous = rgb(previousArgb);
        int chroma = chroma(rgb);
        int brightness = brightness(rgb);

        if (chroma > 58 || brightness < 80) {
            return false;
        }

        double stepDistance = distance(rgb, previous);
        double borderDistance = distance(rgb, borderMean);

        if (stepDistance <= 14.0) {
            return true;
        }

        return borderDistance <= 72.0 && chroma <= 36 && brightness >= 140;
    }

    private static void keepLargestOpaqueRegion(boolean[] background, int width, int height) {
        int length = background.length;
        boolean[] visited = new boolean[length];
        int[] labels = new int[length];
        int nextLabel = 1;
        int largestLabel = 0;
        int largestSize = 0;
        int[] dx = {1, -1, 0, 0, 1, -1, 1, -1};
        int[] dy = {0, 0, 1, -1, 1, -1, -1, 1};

        for (int index = 0; index < length; index++) {
            if (background[index] || visited[index]) {
                continue;
            }

            ArrayDeque<Integer> queue = new ArrayDeque<>();
            queue.add(index);
            visited[index] = true;
            labels[index] = nextLabel;
            int size = 0;

            while (!queue.isEmpty()) {
                int current = queue.removeFirst();
                size++;
                int x = current % width;
                int y = current / width;

                for (int i = 0; i < dx.length; i++) {
                    int nx = x + dx[i];
                    int ny = y + dy[i];
                    if (nx < 0 || ny < 0 || nx >= width || ny >= height) {
                        continue;
                    }

                    int nIndex = (ny * width) + nx;
                    if (background[nIndex] || visited[nIndex]) {
                        continue;
                    }
                    visited[nIndex] = true;
                    labels[nIndex] = nextLabel;
                    queue.addLast(nIndex);
                }
            }

            if (size > largestSize) {
                largestSize = size;
                largestLabel = nextLabel;
            }
            nextLabel++;
        }

        for (int i = 0; i < length; i++) {
            if (!background[i] && labels[i] != largestLabel) {
                background[i] = true;
            }
        }
    }

    private static int softenEdgePixel(int[] pixels, boolean[] background, int width, int height,
                                       int x, int y, int index) {
        int argb = pixels[index];
        int alpha = (argb >>> 24) & 0xff;
        if (alpha == 0) {
            return argb;
        }

        int backgroundNeighbors = 0;
        for (int ny = Math.max(0, y - 1); ny <= Math.min(height - 1, y + 1); ny++) {
            for (int nx = Math.max(0, x - 1); nx <= Math.min(width - 1, x + 1); nx++) {
                if (nx == x && ny == y) {
                    continue;
                }
                if (background[(ny * width) + nx]) {
                    backgroundNeighbors++;
                }
            }
        }

        if (backgroundNeighbors == 0) {
            return argb;
        }

        int[] rgb = rgb(argb);
        int brightness = brightness(rgb);
        int chroma = chroma(rgb);
        int softenedAlpha = alpha;

        if (backgroundNeighbors >= 5 && brightness >= 225 && chroma <= 40) {
            softenedAlpha = Math.min(softenedAlpha, 128);
        } else if (backgroundNeighbors >= 3 && brightness >= 205 && chroma <= 46) {
            softenedAlpha = Math.min(softenedAlpha, 180);
        }

        return (softenedAlpha << 24) | (rgb[0] << 16) | (rgb[1] << 8) | rgb[2];
    }

    private static double[] computeBorderMean(int[] pixels, int width, int height) {
        long sumR = 0;
        long sumG = 0;
        long sumB = 0;
        long count = 0;

        for (int x = 0; x < width; x++) {
            int[] rgb = rgb(pixels[x]);
            sumR += rgb[0];
            sumG += rgb[1];
            sumB += rgb[2];
            count++;
        }
        for (int x = 0; x < width; x++) {
            int[] rgb = rgb(pixels[((height - 1) * width) + x]);
            sumR += rgb[0];
            sumG += rgb[1];
            sumB += rgb[2];
            count++;
        }
        for (int y = 1; y < height - 1; y++) {
            int[] left = rgb(pixels[y * width]);
            sumR += left[0];
            sumG += left[1];
            sumB += left[2];
            count++;

            int[] right = rgb(pixels[(y * width) + (width - 1)]);
            sumR += right[0];
            sumG += right[1];
            sumB += right[2];
            count++;
        }

        return new double[] {sumR / (double) count, sumG / (double) count, sumB / (double) count};
    }

    private static int[] crop(int[] pixels, int width, int startX, int startY, int outWidth, int outHeight) {
        int[] cropped = new int[outWidth * outHeight];
        for (int y = 0; y < outHeight; y++) {
            int sourceOffset = ((startY + y) * width) + startX;
            int targetOffset = y * outWidth;
            System.arraycopy(pixels, sourceOffset, cropped, targetOffset, outWidth);
        }
        return cropped;
    }

    private static int[] rgb(int argb) {
        return new int[] {
            (argb >>> 16) & 0xff,
            (argb >>> 8) & 0xff,
            argb & 0xff
        };
    }

    private static int brightness(int[] rgb) {
        return (rgb[0] + rgb[1] + rgb[2]) / 3;
    }

    private static int chroma(int[] rgb) {
        int max = Math.max(rgb[0], Math.max(rgb[1], rgb[2]));
        int min = Math.min(rgb[0], Math.min(rgb[1], rgb[2]));
        return max - min;
    }

    private static double distance(int[] rgb, int[] other) {
        int dr = rgb[0] - other[0];
        int dg = rgb[1] - other[1];
        int db = rgb[2] - other[2];
        return Math.sqrt((dr * dr) + (dg * dg) + (db * db));
    }

    private static double distance(int[] rgb, double[] other) {
        double dr = rgb[0] - other[0];
        double dg = rgb[1] - other[1];
        double db = rgb[2] - other[2];
        return Math.sqrt((dr * dr) + (dg * dg) + (db * db));
    }
}
