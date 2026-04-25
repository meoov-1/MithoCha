<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="light" lang="en"><head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>MithoCha | Artisanal Bubble Tea</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&amp;family=Be+Vietnam+Pro:wght@400;500;600&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .liquid-fill {
            background: linear-gradient(0deg, #ffca98 0%, #7d562d 100%);
        }
        .glass-card {
            backdrop-filter: blur(12px);
            background: rgba(255, 248, 246, 0.7);
        }
    </style>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "on-surface-variant": "#504440",
                        "tertiary-fixed": "#e4e3d7",
                        "on-primary-fixed": "#2e140a",
                        "on-tertiary-fixed-variant": "#46473f",
                        "surface-variant": "#fadcd5",
                        "error": "#ba1a1a",
                        "inverse-primary": "#ecbcaa",
                        "on-secondary-container": "#7a532a",
                        "surface-dim": "#f1d4cd",
                        "on-tertiary-container": "#9d9d93",
                        "on-secondary-fixed-variant": "#623f18",
                        "tertiary-fixed-dim": "#c7c7bc",
                        "primary-fixed": "#ffdbce",
                        "primary-fixed-dim": "#ecbcaa",
                        "background": "#fff8f6",
                        "surface-container-lowest": "#ffffff",
                        "primary": "#32170d",
                        "on-tertiary": "#ffffff",
                        "outline-variant": "#d5c3bd",
                        "on-error": "#ffffff",
                        "primary-container": "#4b2c20",
                        "secondary-container": "#ffca98",
                        "surface-container-highest": "#fadcd5",
                        "on-tertiary-fixed": "#1b1c15",
                        "surface-container-low": "#fff1ed",
                        "on-primary": "#ffffff",
                        "inverse-on-surface": "#ffede9",
                        "on-primary-container": "#bf9282",
                        "on-error-container": "#93000a",
                        "secondary-fixed": "#ffdcbd",
                        "surface-tint": "#7b5647",
                        "secondary-fixed-dim": "#f0bd8b",
                        "secondary": "#7d562d",
                        "tertiary-container": "#34352d",
                        "on-secondary-fixed": "#2c1600",
                        "on-background": "#271814",
                        "on-secondary": "#ffffff",
                        "on-surface": "#271814",
                        "error-container": "#ffdad6",
                        "tertiary": "#1e2019",
                        "on-primary-fixed-variant": "#613e31",
                        "surface-container": "#ffe9e4",
                        "surface-bright": "#fff8f6",
                        "surface": "#fff8f6",
                        "outline": "#83746f",
                        "inverse-surface": "#3e2c28",
                        "surface-container-high": "#ffe2db"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "unit": "8px",
                        "margin-desktop": "64px",
                        "container-max": "1200px",
                        "margin-mobile": "20px",
                        "gutter": "24px"
                    },
                    "fontFamily": {
                        "headline-xl": ["Noto Serif"],
                        "label-md": ["Be Vietnam Pro"],
                        "headline-md": ["Noto Serif"],
                        "headline-lg": ["Noto Serif"],
                        "body-md": ["Be Vietnam Pro"],
                        "body-lg": ["Be Vietnam Pro"]
                    },
                    "fontSize": {
                        "headline-xl": ["48px", {"lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                        "label-md": ["14px", {"lineHeight": "1.2", "letterSpacing": "0.05em", "fontWeight": "600"}],
                        "headline-md": ["24px", {"lineHeight": "1.3", "fontWeight": "600"}],
                        "headline-lg": ["32px", {"lineHeight": "1.2", "fontWeight": "600"}],
                        "body-md": ["16px", {"lineHeight": "1.5", "fontWeight": "400"}],
                        "body-lg": ["18px", {"lineHeight": "1.6", "fontWeight": "400"}]
                    }
                },
            },
        }
    </script>
</head>
<body class="bg-background text-on-background font-body-md selection:bg-secondary-container">
<!-- TopAppBar -->
<nav class="fixed top-0 w-full z-50 bg-stone-50/80 dark:bg-stone-950/80 backdrop-blur-md border-b border-stone-200/50 dark:border-stone-800/50 shadow-sm dark:shadow-none">
    <div class="flex justify-between items-center h-20 px-6 md:px-12 max-w-7xl mx-auto">
        <div class="text-2xl font-serif font-bold text-[#4B2C20] dark:text-stone-100">
            MithoCha
        </div>
        <div class="hidden md:flex items-center space-x-8 font-serif text-base tracking-wide">
            <a class="text-[#4B2C20] dark:text-amber-200 border-b-2 border-amber-500 pb-1 font-bold active:scale-95 transition-transform duration-200" href="#">Home</a>
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors active:scale-95 transition-transform duration-200" href="#">Menu</a>
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors active:scale-95 transition-transform duration-200" href="#">Rewards</a>
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors active:scale-95 transition-transform duration-200" href="#">Profile</a>
        </div>
        <div class="flex items-center space-x-4">
            <button class="p-2 hover:opacity-80 transition-opacity duration-300 active:scale-95 transition-transform duration-200">
                <span class="material-symbols-outlined text-[#4B2C20] dark:text-stone-200">shopping_bag</span>
            </button>
            <button class="p-2 hover:opacity-80 transition-opacity duration-300 active:scale-95 transition-transform duration-200">
                <span class="material-symbols-outlined text-[#4B2C20] dark:text-stone-200">notifications</span>
            </button>
        </div>
    </div>
</nav>
<main class="pt-24">
    <!-- Hero Section -->
    <section class="max-w-7xl mx-auto px-6 py-12 md:py-24">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
            <div class="space-y-8">
                <div class="inline-block px-4 py-1 rounded-full bg-secondary-container text-on-secondary-container font-label-md text-label-md">
                    NEW SEASONAL BLENDS
                </div>
                <h1 class="font-headline-xl text-headline-xl text-primary leading-none">
                    Elevating the <br/><span class="text-secondary italic font-normal">Art of Tea</span>
                </h1>
                <p class="text-body-lg font-body-lg text-on-surface-variant max-w-lg">
                    Discover a sanctuary where traditional craftsmanship meets modern innovation. Our artisanal bubble teas are brewed from whole-leaf exports and paired with organic house-made inclusions.
                </p>
                <div class="flex flex-wrap gap-4">
                    <button class="px-8 py-4 bg-secondary text-on-secondary font-label-md text-label-md rounded-xl hover:opacity-90 transition-all shadow-lg shadow-secondary/20">
                        Explore Menu
                    </button>
                    <button class="px-8 py-4 border-2 border-primary text-primary font-label-md text-label-md rounded-xl hover:bg-primary hover:text-white transition-all">
                        Find a Store
                    </button>
                </div>
            </div>
            <div class="relative">
                <div class="aspect-[4/5] rounded-[40px] overflow-hidden shadow-2xl shadow-primary/10">
                    <img alt="Luxury Bubble Tea" class="w-full h-full object-cover" data-alt="Close-up of a premium brown sugar pearl milk tea in a tall glass with swirling cream, dense tapioca pearls, and soft warm lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDF8SgqpiGHpWx_a3eXW4KfUvGhW65fpx9ztHhnlhjgDwmfWV35r7nDv5gKWcywovvCze4KKKf57feGVSxa2niRA2JyyrqZIPvvbi_z-SkEmbh8ab-DD3-cwIkZ3EgSN1kI-Z2gaxUC-AS8hdTcPS8IpRhTb4yB-wulTrLI5vz3WlrzwCGxcqZWwzLMLStegoIc1YgydRFQF95wmASkCYurZsS1MUliTYa0hvwpUSF4lBe3oKgZFyLolAlLhtooOoT_wcxnLLTsCNdb"/>
                </div>
                <div class="absolute -bottom-8 -left-8 glass-card p-6 rounded-3xl shadow-xl max-w-xs hidden md:block border border-white/20">
                    <div class="flex gap-4 items-center">
                        <div class="w-12 h-12 rounded-full bg-secondary-fixed-dim flex items-center justify-center">
                            <span class="material-symbols-outlined text-primary">local_cafe</span>
                        </div>
                        <div>
                            <p class="font-headline-md text-sm text-primary">Artisanal Pearls</p>
                            <p class="text-xs text-on-surface-variant">Made fresh every 4 hours with organic muscovado.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Discover our Blends (Bento Grid) -->
    <section class="bg-surface-container-low py-24 px-6">
        <div class="max-w-7xl mx-auto">
            <div class="text-center mb-16">
                <h2 class="font-headline-lg text-headline-lg text-primary mb-4 italic">Discover our Blends</h2>
                <div class="w-24 h-1 bg-secondary mx-auto rounded-full"></div>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6 h-auto md:h-[600px]">
                <!-- Large Feature -->
                <div class="md:col-span-2 md:row-span-2 relative rounded-3xl overflow-hidden group">
                    <img alt="Matcha Latte" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="A vibrant green ceremonial grade matcha latte with artisanal boba pearls, presented in a minimalist ceramic cup on a wooden tray" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDXL8nrlJ6LiQc4CaTyylJ6vQpciZAlOa1LjJOBcFAuuxHlNt-0mE5TX1OCO4xV84quGGa9Z0R4TyWkB4Ky3gcf6yGCmEQ3q8Mc92nOEAHlamRkOu20os4vARCKtIoDWUWrMwk1R1VMwPrYsJM4m1-_H0MWqj_ROZqnyFX5AXgAnqjMOuorwl2qO8b6HJXJFaTNnwUF7dGSbS6JhL7HBn-x8tFD2QNZqnbA_5gZ9eD8U6AlMSeEVnLTCxK4lfCArRkeAaftUP9PjVnB"/>
                    <div class="absolute inset-0 bg-gradient-to-t from-primary/80 to-transparent flex flex-col justify-end p-8 text-white">
                        <span class="text-xs font-label-md uppercase tracking-widest mb-2 opacity-80">Signature Series</span>
                        <h3 class="font-headline-md text-headline-md mb-2">Ceremonial Matcha Pearl</h3>
                        <p class="text-sm opacity-90 max-w-sm">Hand-whisked Uji matcha paired with honey-soaked crystals.</p>
                    </div>
                </div>
                <!-- Small Feature 1 -->
                <div class="relative rounded-3xl overflow-hidden group h-64 md:h-auto">
                    <img alt="Taro Tea" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Rich purple taro bubble tea with creamy foam top, garnished with edible flower petals in a sleek modern aesthetic" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBK65DJ-v_UWoUzqRH2hHiFoNZw7r0ElnxSb8hwQqG050UdaHAkOuBYlsiLgy3Y2I8n_F4lgeVPXIulFmjT1Rvp0mrPj5apWrsw93Xf8Ji0K49kM9_CRS7PCaoc5FVA2_F67PCpiqlnIzlwO_L9TAAfbMxhD5meUP1PED-tUehOGL908Alw18abItwj4-uNm7k0Z27wiUJyvy1mglblg9dUjqPZzE4DjWkxf8ltZpjrDAJFjmJWdJcIxo5juhcS-pCvAuAblJQDsQjK"/>
                    <div class="absolute inset-0 bg-primary/20 group-hover:bg-primary/40 transition-colors"></div>
                    <div class="absolute bottom-4 left-4 text-white">
                        <h4 class="font-headline-md text-lg">Velvet Taro</h4>
                    </div>
                </div>
                <!-- Small Feature 2 -->
                <div class="relative rounded-3xl overflow-hidden group h-64 md:h-auto">
                    <img alt="Oolong Tea" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Clear golden roasted oolong tea with dark brown sugar pearls and fresh mint leaf garnish in a bright sunlit cafe" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAgE0niogYkIw52o8JGSK1xpvKcsnEGZUsUPg_mlf4jUgKKElwQOz1wJOsh1T2lN6ADLVh6gatI-eJtg1SjsWqspxYGg8gUHdLWohxyui8HQG5n-XoH0DIU4lFEmfHMcSxd3X3EvvXLXZPw-Yfff_vgYv8DOGR1j21RahtYuea4DGc2UhCXxIwL9xvBc6CyGoNjoHwe4Q14j6qnQAe3ZMgdmjtydc9c-Qjvi2sC3pihPvL2eNf4NrXpn4Yj527pMeviOaSZ75FLw_vk"/>
                    <div class="absolute bottom-4 left-4 text-white">
                        <h4 class="font-headline-md text-lg">Roasted Oolong</h4>
                    </div>
                </div>
                <!-- Wide Feature -->
                <div class="md:col-span-2 relative rounded-3xl overflow-hidden group h-64 md:h-auto">
                    <img alt="Fruit Tea" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Vibrant tropical fruit tea with floating slices of orange and strawberry, sparkling aesthetic with soft condensation on the glass" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAHh0Uk_q7zPyKX0QRSU126xdoWiqvlojXxBQEF9H7R7O8PpK9CffUK-a2qZ-k_8bWW4ExPS1EPQgvvs13bhSjga9GBnwdmPgRVmmeEVuO3HwUdC2xCwx6JGrp8a7kdDAsF1-yzOC4KDjOH8kDoH59T95EQcboYRmSIO4r3BQloT4caQyalXK0KlJ2s9zm_-mj9flxmlMp85k3r3zajauXy1SWFodxbjxS-nH3wuMF22EYxyV9C9HvOcCmSC4rflUmxlGFUOwKYc8He"/>
                    <div class="absolute inset-0 bg-gradient-to-r from-primary/60 to-transparent flex flex-col justify-center p-8 text-white">
                        <h3 class="font-headline-md text-headline-md">Summer Tropics</h3>
                        <p class="text-sm">Infused with real dragon fruit and lychee.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Why MithoCha? -->
    <section class="py-24 px-6 max-w-7xl mx-auto">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
            <div class="text-center space-y-4">
                <div class="w-16 h-16 bg-surface-container mx-auto rounded-2xl flex items-center justify-center text-secondary">
                    <span class="material-symbols-outlined !text-4xl">eco</span>
                </div>
                <h3 class="font-headline-md text-primary">Ethical Sourcing</h3>
                <p class="text-on-surface-variant font-body-md">We partner directly with high-altitude tea estates in Taiwan and Kyoto, ensuring fair pay and sustainable practices.</p>
            </div>
            <div class="text-center space-y-4">
                <div class="w-16 h-16 bg-surface-container mx-auto rounded-2xl flex items-center justify-center text-secondary">
                    <span class="material-symbols-outlined !text-4xl">science</span>
                </div>
                <h3 class="font-headline-md text-primary">Pure Ingredients</h3>
                <p class="text-on-surface-variant font-body-md">No artificial powders or syrups. We use organic cane sugar, fresh dairy, and real fruit purees in every cup.</p>
            </div>
            <div class="text-center space-y-4">
                <div class="w-16 h-16 bg-surface-container mx-auto rounded-2xl flex items-center justify-center text-secondary">
                    <span class="material-symbols-outlined !text-4xl">hourglass_empty</span>
                </div>
                <h3 class="font-headline-md text-primary">Small Batch Craft</h3>
                <p class="text-on-surface-variant font-body-md">Each tea is brewed to order at precise temperatures to preserve the delicate aroma and flavor profiles.</p>
            </div>
        </div>
    </section>
    <!-- Customer Favorites (Product Cards) -->
    <section class="py-24 px-6 bg-white/50">
        <div class="max-w-7xl mx-auto">
            <div class="flex justify-between items-end mb-12">
                <div>
                    <h2 class="font-headline-lg text-headline-lg text-primary">Customer Favorites</h2>
                    <p class="text-on-surface-variant">The most loved brews of the season.</p>
                </div>
                <a class="text-secondary font-label-md flex items-center gap-2 hover:underline" href="#">
                    View Full Menu <span class="material-symbols-outlined">arrow_forward</span>
                </a>
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
                <!-- Product 1 -->
                <div class="group cursor-pointer">
                    <div class="aspect-[3/4] rounded-3xl overflow-hidden mb-4 bg-surface-container-low relative">
                        <img alt="Brown Sugar Deerioca" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Tall aesthetic glass of brown sugar boba milk with cream foam and dark caramel streaks, warm cozy mood" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAi9sl0lPJBbcudDWGhYVHush-4FxKHOm_mt0TFsEL8HefqZuo1bsBLDub2pjyS9lOkQ0Vlk0UolybAbp5hAOrXgr1WTwqkSkfJaYO4FbuFRx0XLNOcDh1m2nUKbxWCnDleGgaK4GUnHJNjT0mjjn2o0w6evSJrBrQBQJ2jx_7aykKkwGgbjmrNukXLu-shftY0CyJYcM4ErLhvlXDVnGMet1Q_Rb0PSCSTzzljdm8tStFbCivnp9HaIJlhzfvXakmfjkVv9jrfyZBA"/>
                        <div class="absolute top-4 right-4 flex flex-col gap-2">
                            <span class="bg-white/90 backdrop-blur px-3 py-1 rounded-full text-[10px] font-label-md text-primary italic uppercase tracking-wider">Floral</span>
                        </div>
                    </div>
                    <h3 class="font-headline-md text-primary text-lg">Amber Pearl Milk</h3>
                    <p class="text-sm text-on-surface-variant mb-4">Aged Black Tea, Brown Sugar Pearls, Organic Milk</p>
                    <div class="flex justify-between items-center">
                        <span class="font-bold text-primary">Rs. 450</span>
                        <button class="w-10 h-10 rounded-full border border-outline flex items-center justify-center hover:bg-primary hover:text-white transition-colors">
                            <span class="material-symbols-outlined text-sm">add</span>
                        </button>
                    </div>
                </div>
                <!-- Product 2 -->
                <div class="group cursor-pointer">
                    <div class="aspect-[3/4] rounded-3xl overflow-hidden mb-4 bg-surface-container-low relative">
                        <img alt="Royal Oolong" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Professional studio shot of a sparkling fruit tea with peach slices and ice, minimal aesthetic" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC9My-y0WOV7Mo544ADXhBMXnArt_zyNZJya8gX-GrbK7IZWrzbwIr2lsScmGDF2VEHr1wKHt7vTfxyoLRjmEMyCKrx7f1rXJKOKA1mM-smrQ2vkkpuoKKadhZkwzdU-Q4RImFPH-sY6Y-tqrS3symZgnPMWCttKXCqwe9lDLl6UGnuVl8uFfUPF50RtuV3TJ63s0rXucv10eJ7ptqoK7ZG5LsqPoiaxOiIIsqmqZWriqiF0ptcxdm__lw6Ru18mHHl7C9c60mJZouf"/>
                        <div class="absolute top-4 right-4 flex flex-col gap-2">
                            <span class="bg-white/90 backdrop-blur px-3 py-1 rounded-full text-[10px] font-label-md text-primary italic uppercase tracking-wider">Velvety</span>
                        </div>
                    </div>
                    <h3 class="font-headline-md text-primary text-lg">Sparkling Peach Oolong</h3>
                    <p class="text-sm text-on-surface-variant mb-4">Carbonated Oolong, White Peach, Lychee Jelly</p>
                    <div class="flex justify-between items-center">
                        <span class="font-bold text-primary">Rs. 420</span>
                        <button class="w-10 h-10 rounded-full border border-outline flex items-center justify-center hover:bg-primary hover:text-white transition-colors">
                            <span class="material-symbols-outlined text-sm">add</span>
                        </button>
                    </div>
                </div>
                <!-- Product 3 -->
                <div class="group cursor-pointer">
                    <div class="aspect-[3/4] rounded-3xl overflow-hidden mb-4 bg-surface-container-low relative">
                        <img alt="Matcha Bliss" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Minimalist top down view of a creamy matcha tea with a perfect foam layer and golden tapioca" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBSWOkRNi86vClgS1SqMtE0nbbXLQ8u4Osxv_UunMk6OlKinGR8vWPmRcz5Ug7hLHL5hi9IlLAanMLR5G7AEJlLueey4CIzM_9j4iRPuQ6Y_gCox015n6Qr10-6aQeJq8phEllJ5mYypsQsvg_rVw0UFFky-qGkCu2X6vw7GBclHPB0iH2NDvi4z7dt4P4OHSIuMNCIp8BLeiZ_Ca-z6k-TjYmKfwtIQkfxVQ7lovNnU0u0BF45pBQcKh1h9bdVv2-EBbeb4FnqD8Zq"/>
                        <div class="absolute top-4 right-4 flex flex-col gap-2">
                            <span class="bg-white/90 backdrop-blur px-3 py-1 rounded-full text-[10px] font-label-md text-primary italic uppercase tracking-wider">Earthy</span>
                        </div>
                    </div>
                    <h3 class="font-headline-md text-primary text-lg">Matcha Cloud Foam</h3>
                    <p class="text-sm text-on-surface-variant mb-4">Premium Matcha, Sea Salt Cream, Honey Boba</p>
                    <div class="flex justify-between items-center">
                        <span class="font-bold text-primary">Rs. 480</span>
                        <button class="w-10 h-10 rounded-full border border-outline flex items-center justify-center hover:bg-primary hover:text-white transition-colors">
                            <span class="material-symbols-outlined text-sm">add</span>
                        </button>
                    </div>
                </div>
                <!-- Product 4 -->
                <div class="group cursor-pointer">
                    <div class="aspect-[3/4] rounded-3xl overflow-hidden mb-4 bg-surface-container-low relative">
                        <img alt="Earl Grey Bloom" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Glass of tea with lavender sprig and clear bubbles, dreamy and artistic lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAaYhM16ykqUs--ExKBvMBoDkSeOlpXWRiJQbRHoBtqK9JVD5Up3HMev_Jus5G-wyWjzD46LrgJKtabqZm6_f1DqoRgGwOulc0lpRqeyQ2kLkSFC3l-3liiVK-zQL46BY31BbEVIi5xYmu0j-aiCaryQeShLjjAa21zMEjcyCs4858ke6Xa111EEkvSYFSvQLZjoih8BW5N6iWjXFrPnS0a4_1q6umIT1UcQjrdK7KLuRziA_P2GZMBTshKs8DlTSMZOKZ1TdpHIBQF"/>
                        <div class="absolute top-4 right-4 flex flex-col gap-2">
                            <span class="bg-white/90 backdrop-blur px-3 py-1 rounded-full text-[10px] font-label-md text-primary italic uppercase tracking-wider">Citrus</span>
                        </div>
                    </div>
                    <h3 class="font-headline-md text-primary text-lg">Lavender Earl Grey</h3>
                    <p class="text-sm text-on-surface-variant mb-4">Infused Black Tea, French Lavender, Crystal Jelly</p>
                    <div class="flex justify-between items-center">
                        <span class="font-bold text-primary">Rs. 440</span>
                        <button class="w-10 h-10 rounded-full border border-outline flex items-center justify-center hover:bg-primary hover:text-white transition-colors">
                            <span class="material-symbols-outlined text-sm">add</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- MithoCha Progress CTA -->
    <section class="max-w-7xl mx-auto px-6 py-24">
        <div class="bg-primary-container rounded-[40px] p-8 md:p-16 text-center text-on-primary-container relative overflow-hidden">
            <div class="absolute inset-0 opacity-10">
                <div class="absolute top-0 right-0 w-64 h-64 bg-amber-400 rounded-full blur-[100px]"></div>
                <div class="absolute bottom-0 left-0 w-96 h-96 bg-secondary-container rounded-full blur-[120px]"></div>
            </div>
            <h2 class="font-headline-xl text-headline-xl mb-6 text-on-primary relative z-10">Ready for your daily <br/>pearl?</h2>
            <p class="text-body-lg mb-10 max-w-xl mx-auto text-on-primary-container relative z-10">Join our MithoCha Rewards and get your 10th cup on the house. Earn points for every artisanal brew you enjoy.</p>
            <div class="flex flex-col items-center gap-6 relative z-10">
                <div class="w-full max-w-md bg-stone-800/50 h-3 rounded-full overflow-hidden mb-4">
                    <div class="liquid-fill h-full w-2/3"></div>
                </div>
                <p class="font-label-md text-xs uppercase tracking-widest text-on-primary-container/60 mb-2">Almost at your goal: 6/10 Pearls</p>
                <button class="px-10 py-5 bg-secondary-container text-on-secondary-container font-label-md text-label-md rounded-2xl hover:bg-secondary-fixed transition-all shadow-xl">
                    Sign Up for Rewards
                </button>
            </div>
        </div>
    </section>
</main>
<!-- Footer -->
<footer class="w-full mt-20 bg-stone-100 dark:bg-stone-900 border-t border-stone-200 dark:border-stone-800 font-serif text-sm leading-relaxed">
    <div class="grid grid-cols-1 md:grid-cols-4 gap-12 px-8 py-16 max-w-7xl mx-auto">
        <div>
            <span class="text-xl font-serif font-bold text-[#4B2C20] dark:text-stone-100 mb-4 block">MithoCha</span>
            <p class="text-[#4B2C20] dark:text-stone-300">© 2024 MithoCha Premium Bubble Tea. Sip into Sophistication.</p>
        </div>
        <div class="flex flex-col space-y-4">
            <span class="font-bold text-[#4B2C20] dark:text-stone-100">Quick Links</span>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 transition-all duration-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Shop</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 transition-all duration-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Our Story</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 transition-all duration-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Rewards</a>
        </div>
        <div class="flex flex-col space-y-4">
            <span class="font-bold text-[#4B2C20] dark:text-stone-100">Company</span>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 transition-all duration-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Sustainability</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 transition-all duration-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Careers</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 transition-all duration-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Privacy Policy</a>
        </div>
        <div>
            <span class="font-bold text-[#4B2C20] dark:text-stone-100 block mb-4">Follow our journey</span>
            <div class="flex gap-6">
                <a class="text-[#4B2C20] dark:text-stone-300 hover:opacity-80 transition-opacity" href="#">
                    <span class="material-symbols-outlined">camera</span>
                </a>
                <a class="text-[#4B2C20] dark:text-stone-300 hover:opacity-80 transition-opacity" href="#">
                    <span class="material-symbols-outlined">share</span>
                </a>
                <a class="text-[#4B2C20] dark:text-stone-300 hover:opacity-80 transition-opacity" href="#">
                    <span class="material-symbols-outlined">mail</span>
                </a>
            </div>
        </div>
    </div>
</footer>
<!-- BottomNavBar (Mobile Only) -->
<nav class="md:hidden fixed bottom-0 w-full z-50 bg-stone-50/95 dark:bg-stone-950/95 backdrop-blur-lg border-t border-stone-200/50 shadow-[0_-4px_20px_rgba(75,44,32,0.05)]">
    <div class="flex justify-around items-center h-20 px-4 pb-safe">
        <div class="flex flex-col items-center justify-center bg-amber-100/50 dark:bg-amber-900/30 text-[#4B2C20] dark:text-amber-200 rounded-xl px-4 py-1 active:scale-95 transition-transform">
            <span class="material-symbols-outlined" data-icon="home">home</span>
            <span class="font-serif text-[10px] uppercase tracking-widest mt-1">Home</span>
        </div>
        <div class="flex flex-col items-center justify-center text-stone-400 dark:text-stone-600 active:scale-95 transition-transform">
            <span class="material-symbols-outlined" data-icon="bubble_tea">bubbles</span>
            <span class="font-serif text-[10px] uppercase tracking-widest mt-1">Menu</span>
        </div>
        <div class="flex flex-col items-center justify-center text-stone-400 dark:text-stone-600 active:scale-95 transition-transform">
            <span class="material-symbols-outlined" data-icon="shopping_bag">shopping_bag</span>
            <span class="font-serif text-[10px] uppercase tracking-widest mt-1">Cart</span>
        </div>
        <div class="flex flex-col items-center justify-center text-stone-400 dark:text-stone-600 active:scale-95 transition-transform">
            <span class="material-symbols-outlined" data-icon="person">person</span>
            <span class="font-serif text-[10px] uppercase tracking-widest mt-1">Profile</span>
        </div>
    </div>
</nav>
</body></html>
