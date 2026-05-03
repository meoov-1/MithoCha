package com.mithocha.servlet;

import com.mithocha.dao.OrderDAO;
import com.mithocha.dao.ProfileDAO;
import com.mithocha.dao.UserDAO;
import com.mithocha.dao.impl.OrderDAOImpl;
import com.mithocha.dao.impl.ProfileDAOImpl;
import com.mithocha.dao.impl.UserDAOImpl;
import com.mithocha.model.Order;
import com.mithocha.model.Profile;
import com.mithocha.model.User;
import com.mithocha.util.SessionUtil;
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

/**
 * ProfileServlet – serves the profile page and handles profile save.
 */
@WebServlet("/profile")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 6 * 1024 * 1024
)
public class ProfileServlet extends HttpServlet {

    private final ProfileDAO profileDAO = new ProfileDAOImpl();
    private final OrderDAO orderDAO = new OrderDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = SessionUtil.getUser(request);
        Profile profile = profileDAO.findByUserId(user.getUserId());
        List<Order> orders = orderDAO.findByUserId(user.getUserId());

        populateViewAttributes(request, user, profile, orders);
        forwardToProfile(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = SessionUtil.getUser(request);
        int userId = user.getUserId();
        Profile existing = profileDAO.findByUserId(userId);
        List<Order> orders = orderDAO.findByUserId(userId);

        String fullName = trimToNull(request.getParameter("fullName"));
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String postalCode = request.getParameter("postalCode");
        String dobStr = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");
        String profileNotes = request.getParameter("profileNotes");
        String favoriteDrink = request.getParameter("favoriteDrink");
        String profileImageUrl = existing != null ? existing.getProfileImageUrl() : null;

        Part profileImagePart = request.getPart("profileImage");
        String uploadedImageUrl = saveProfileImage(profileImagePart, request);
        if (uploadedImageUrl != null) {
            profileImageUrl = uploadedImageUrl;
        }

        if (ValidationUtil.isNullOrEmpty(fullName)) {
            request.setAttribute("errorMessage", "Full name is required.");
            populateViewAttributes(request,
                    buildViewUser(user, fullName),
                    buildViewProfile(userId, existing, phone, address, city, postalCode,
                            profileImageUrl, gender, favoriteDrink, profileNotes, dobStr),
                    orders, gender, favoriteDrink, profileNotes);
            forwardToProfile(request, response);
            return;
        }

        if (!ValidationUtil.isValidPhone(phone)) {
            request.setAttribute("errorMessage", "Please enter a valid phone number.");
            populateViewAttributes(request,
                    buildViewUser(user, fullName),
                    buildViewProfile(userId, existing, phone, address, city, postalCode,
                            profileImageUrl, gender, favoriteDrink, profileNotes, dobStr),
                    orders, gender, favoriteDrink, profileNotes);
            forwardToProfile(request, response);
            return;
        }

        if (!fullName.equals(user.getName())) {
            user.setName(fullName);
            userDAO.updateUser(user);
            SessionUtil.setUser(request, user);
        }

        Date dob = parseDate(dobStr);
        String bio = buildBio(gender, favoriteDrink, profileNotes);

        if (existing == null) {
            Profile newProfile = new Profile(userId, trimToNull(phone), trimToNull(address),
                    trimToNull(city), trimToNull(postalCode), trimToNull(profileImageUrl),
                    null, bio, dob);
            profileDAO.insertProfile(newProfile);
        } else {
            existing.setPhone(trimToNull(phone));
            existing.setAddress(trimToNull(address));
            existing.setCity(trimToNull(city));
            existing.setPostalCode(trimToNull(postalCode));
            existing.setProfileImageUrl(trimToNull(profileImageUrl));
            existing.setDateOfBirth(dob);
            existing.setBio(bio);
            profileDAO.updateProfile(existing);
        }

        response.sendRedirect(request.getContextPath() + "/profile?saved=true");
    }

    private String saveProfileImage(Part imagePart, HttpServletRequest request) throws IOException {
        if (imagePart == null || imagePart.getSize() <= 0) {
            return null;
        }

        String submittedName = imagePart.getSubmittedFileName();
        if (ValidationUtil.isNullOrEmpty(submittedName)) {
            return null;
        }

        String extension = getFileExtension(submittedName);
        if (!isSupportedImageExtension(extension)) {
            return null;
        }

        Path uploadDir = resolveUploadDirectory(request);
        Files.createDirectories(uploadDir);

        String fileName = "profile-" + UUID.randomUUID() + extension;
        Path target = uploadDir.resolve(fileName);

        try (InputStream inputStream = imagePart.getInputStream()) {
            Files.copy(inputStream, target, StandardCopyOption.REPLACE_EXISTING);
        }

        return "uploads/profiles/" + fileName;
    }

    private void forwardToProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp")
               .forward(request, response);
    }

    private void populateViewAttributes(HttpServletRequest request, User user, Profile profile,
                                        List<Order> orders) {
        populateViewAttributes(request, user, profile, orders,
                extractBioField(profile != null ? profile.getBio() : null, "Gender"),
                extractBioField(profile != null ? profile.getBio() : null, "Favorite drink"),
                extractBioField(profile != null ? profile.getBio() : null, "Notes"));
    }

    private void populateViewAttributes(HttpServletRequest request, User user, Profile profile,
                                        List<Order> orders, String gender,
                                        String favoriteDrink, String profileNotes) {
        request.setAttribute("user", user);
        request.setAttribute("profile", profile);
        request.setAttribute("orders", orders);
        request.setAttribute("profileGender", defaultString(gender));
        request.setAttribute("profileFavoriteDrink", defaultString(favoriteDrink));
        request.setAttribute("profileNotes", defaultString(profileNotes));
    }

    private User buildViewUser(User source, String fullName) {
        User viewUser = new User(source.getUserId(), source.getName(), source.getEmail(),
                source.getPassword(), source.getRole(), source.getCreatedAt());
        if (!ValidationUtil.isNullOrEmpty(fullName)) {
            viewUser.setName(fullName.trim());
        }
        return viewUser;
    }

    private Profile buildViewProfile(int userId, Profile existing, String phone, String address,
                                     String city, String postalCode, String profileImageUrl,
                                     String gender, String favoriteDrink, String profileNotes,
                                     String dobStr) {
        Profile viewProfile = existing == null
                ? new Profile()
                : new Profile(existing.getProfileId(), existing.getUserId(), existing.getPhone(),
                        existing.getAddress(), existing.getCity(), existing.getPostalCode(),
                        existing.getProfileImageUrl(), existing.getCoverImageUrl(),
                        existing.getBio(), existing.getDateOfBirth());

        viewProfile.setUserId(userId);
        viewProfile.setPhone(trimToNull(phone));
        viewProfile.setAddress(trimToNull(address));
        viewProfile.setCity(trimToNull(city));
        viewProfile.setPostalCode(trimToNull(postalCode));
        viewProfile.setProfileImageUrl(trimToNull(profileImageUrl));
        viewProfile.setBio(buildBio(gender, favoriteDrink, profileNotes));
        viewProfile.setDateOfBirth(parseDate(dobStr));
        return viewProfile;
    }

    private Date parseDate(String dobStr) {
        if (ValidationUtil.isNullOrEmpty(dobStr)) {
            return null;
        }
        try {
            return Date.valueOf(dobStr);
        } catch (IllegalArgumentException ignored) {
            return null;
        }
    }

    private String buildBio(String gender, String favoriteDrink, String profileNotes) {
        StringBuilder builder = new StringBuilder();
        appendBioLine(builder, "Gender", gender);
        appendBioLine(builder, "Favorite drink", favoriteDrink);
        appendBioLine(builder, "Notes", profileNotes);
        return builder.toString();
    }

    private void appendBioLine(StringBuilder builder, String label, String value) {
        if (ValidationUtil.isNullOrEmpty(value)) {
            return;
        }
        if (builder.length() > 0) {
            builder.append('\n');
        }
        builder.append(label)
               .append(": ")
               .append(value.trim().replaceAll("\\s*\\R\\s*", " "));
    }

    private String extractBioField(String bio, String label) {
        if (ValidationUtil.isNullOrEmpty(bio)) {
            return "";
        }
        String prefix = label + ":";
        for (String line : bio.split("\\R")) {
            if (line.startsWith(prefix)) {
                return line.substring(prefix.length()).trim();
            }
        }
        return "";
    }

    private String trimToNull(String value) {
        if (ValidationUtil.isNullOrEmpty(value)) {
            return null;
        }
        return value.trim();
    }

    private String defaultString(String value) {
        return value == null ? "" : value;
    }

    private Path resolveUploadDirectory(HttpServletRequest request) {
        String realPath = request.getServletContext().getRealPath("/uploads/profiles");
        if (!ValidationUtil.isNullOrEmpty(realPath)) {
            return Paths.get(realPath);
        }
        return Paths.get(System.getProperty("user.dir"), "src", "main", "webapp", "uploads", "profiles");
    }

    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex < 0) {
            return "";
        }
        return fileName.substring(dotIndex).toLowerCase();
    }

    private boolean isSupportedImageExtension(String extension) {
        return ".jpg".equals(extension)
                || ".jpeg".equals(extension)
                || ".png".equals(extension)
                || ".webp".equals(extension)
                || ".gif".equals(extension);
    }
}
