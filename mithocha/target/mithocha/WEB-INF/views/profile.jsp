<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="light" lang="en"><head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>MithoCha | Profile</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@600;700&amp;family=Be+Vietnam+Pro:wght@400;600&amp;family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
                        "surface-variant": "#f4f1ed",
                        "error": "#ba1a1a",
                        "inverse-primary": "#ecbcaa",
                        "on-secondary-container": "#7a532a",
                        "surface-dim": "#efefef",
                        "on-tertiary-container": "#9d9d93",
                        "on-secondary-fixed-variant": "#623f18",
                        "tertiary-fixed-dim": "#c7c7bc",
                        "primary-fixed": "#ffdbce",
                        "primary-fixed-dim": "#ecbcaa",
                        "background": "#ffffff",
                        "surface-container-lowest": "#ffffff",
                        "primary": "#32170d",
                        "on-tertiary": "#ffffff",
                        "outline-variant": "#d5c3bd",
                        "on-error": "#ffffff",
                        "primary-container": "#4b2c20",
                        "secondary-container": "#ffca98",
                        "surface-container-highest": "#f4f1ed",
                        "on-tertiary-fixed": "#1b1c15",
                        "surface-container-low": "#fcfaf9",
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
                        "surface-container": "#f8f5f2",
                        "surface-bright": "#ffffff",
                        "surface": "#ffffff",
                        "outline": "#83746f",
                        "inverse-surface": "#3e2c28",
                        "surface-container-high": "#fceee9"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "fontFamily": {
                        "headline-xl": ["Noto Serif"],
                        "label-md": ["Be Vietnam Pro"],
                        "headline-md": ["Noto Serif"],
                        "headline-lg": ["Noto Serif"],
                        "body-md": ["Be Vietnam Pro"],
                        "body-lg": ["Be Vietnam Pro"],
                        "serif": ["Noto Serif", "serif"]
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
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .tap-highlight-transparent {
            -webkit-tap-highlight-color: transparent;
        }
    </style>
</head>
<body class="bg-background text-on-background font-body-md antialiased min-h-screen">
<!-- TopAppBar from COMPONENTS_38 -->
<header class="fixed top-0 w-full z-50 bg-stone-50/80 dark:bg-stone-950/80 backdrop-blur-md border-b border-stone-200/50 dark:border-stone-800/50 shadow-sm dark:shadow-none">
    <div class="flex justify-between items-center h-20 px-6 md:px-12 max-w-7xl mx-auto">
        <div class="text-2xl font-serif font-bold text-[#4B2C20] dark:text-stone-100">MithoCha</div>
        <nav class="hidden md:flex items-center space-x-8">
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors font-serif text-base tracking-wide" href="#">Home</a>
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors font-serif text-base tracking-wide" href="#">Menu</a>
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors font-serif text-base tracking-wide" href="#">Rewards</a>
            <a class="text-[#4B2C20] dark:text-amber-200 border-b-2 border-amber-500 pb-1 font-bold font-serif text-base tracking-wide" href="#">Profile</a>
        </nav>
        <div class="flex items-center space-x-6">
            <button class="text-[#4B2C20] dark:text-stone-200 hover:opacity-80 transition-opacity duration-300 active:scale-95 transition-transform duration-200">
                <span class="material-symbols-outlined">shopping_bag</span>
            </button>
            <button class="text-[#4B2C20] dark:text-stone-200 hover:opacity-80 transition-opacity duration-300 active:scale-95 transition-transform duration-200">
                <span class="material-symbols-outlined">notifications</span>
            </button>
        </div>
    </div>
</header>
<main class="pt-32 pb-32 max-w-7xl mx-auto px-6">
    <!-- Profile Header Section -->
    <section class="mb-12">
        <div class="flex flex-col md:flex-row items-center md:items-start gap-8">
            <div class="relative group">
                <div class="w-32 h-32 rounded-full overflow-hidden border-4 border-white shadow-lg shadow-primary/5">
                    <img alt="User Avatar" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDJj2JhWMzx__YLrdkW6qsRV3-Z3tQumHwxnix-uMkAMDrVmhfJON_x2h0ek0DzTq0JNGm7xHEbO8iTEQLgaCtBxqYaUXtI6d-t6w45e0QEtGQ-CjEPNYRCeVLSt_B9I7TPaFJ4sbPHFp9JvQ_EVPWwaqZgAKmGBs5HL3ALZIXNoZ8sAmWEBckG2ugyOzL4rnu1OVVBpc4ey-63Zn_FHif0Gi5lmZcUJX0EOd4qx8fFCdW80aEXQdwIzPUNXN5W6QWeba0BV96Vfxdk"/>
                </div>
                <button class="absolute bottom-0 right-0 p-2 bg-secondary rounded-full text-white shadow-md hover:scale-105 transition-transform">
                    <span class="material-symbols-outlined text-sm">edit</span>
                </button>
            </div>
            <div class="text-center md:text-left">
                <h1 class="font-headline-xl text-primary mb-2">Aarya Nepal</h1>
                <p class="font-body-lg text-on-surface-variant italic mb-4">MithoCha Member since Ashwin 2080</p>
                <div class="flex flex-wrap justify-center md:justify-start gap-3">
                    <span class="px-4 py-1.5 bg-secondary-container text-on-secondary-container rounded-full text-xs font-label-md">Ilam Tea Connoisseur</span>
                    <span class="px-4 py-1.5 bg-tertiary-fixed text-on-tertiary-fixed-variant rounded-full text-xs font-label-md">1,240 Pearl Points</span>
                </div>
            </div>
        </div>
    </section>
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-12 items-start">
        <!-- Left Column: Personal Info & Payment -->
        <div class="lg:col-span-1 space-y-12">
            <!-- Personal Information -->
            <div class="bg-surface-container-low p-8 rounded-xl">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="font-headline-md text-primary">Personal Details</h2>
                    <button class="text-secondary hover:underline font-label-md">Edit</button>
                </div>
                <div class="space-y-6">
                    <div>
                        <label class="block font-label-md text-[10px] uppercase tracking-widest text-on-surface-variant mb-1">Email Address</label>
                        <p class="font-body-md text-primary">aarya.nepal@example.com</p>
                    </div>
                    <div>
                        <label class="block font-label-md text-[10px] uppercase tracking-widest text-on-surface-variant mb-1">Phone Number</label>
                        <p class="font-body-md text-primary">+977 984-1234567</p>
                    </div>
                    <div>
                        <label class="block font-label-md text-[10px] uppercase tracking-widest text-on-surface-variant mb-1">Preferred Tea House</label>
                        <p class="font-body-md text-primary">MithoCha - Thamel Branch</p>
                    </div>
                </div>
            </div>
            <!-- Saved Payment Methods -->
            <div class="bg-surface-container-low p-8 rounded-xl">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="font-headline-md text-primary">Payment</h2>
                    <button class="text-secondary hover:underline font-label-md">Add New</button>
                </div>
                <div class="space-y-4">
                    <div class="flex items-center p-4 bg-white rounded-lg border border-stone-100 shadow-sm">
                        <span class="material-symbols-outlined text-primary mr-4">credit_card</span>
                        <div class="flex-1">
                            <p class="font-body-md text-primary font-bold">•••• •••• •••• 4242</p>
                            <p class="text-[10px] font-label-md text-on-surface-variant uppercase">Expires 12/26</p>
                        </div>
                        <span class="px-2 py-0.5 bg-amber-50 text-secondary text-[10px] font-bold rounded">PRIMARY</span>
                    </div>
                    <div class="flex items-center p-4 bg-white rounded-lg border border-stone-100 shadow-sm opacity-60">
                        <span class="material-symbols-outlined text-primary mr-4">qr_code_scanner</span>
                        <div class="flex-1">
                            <p class="font-body-md text-primary font-bold">Fonepay / eSewa</p>
                            <p class="text-[10px] font-label-md text-on-surface-variant uppercase">Connected</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Right Column: Order History -->
        <div class="lg:col-span-2 space-y-8">
            <div class="flex items-center justify-between">
                <h2 class="font-headline-lg text-primary">Order History</h2>
                <div class="flex gap-2">
                    <button class="px-4 py-2 rounded-full border border-primary/20 text-xs font-label-md text-primary bg-surface-container-low">All Orders</button>
                    <button class="px-4 py-2 rounded-full border border-transparent text-xs font-label-md text-on-surface-variant hover:bg-surface-container-low">In Progress</button>
                </div>
            </div>
            <!-- Recent Order Card - Active -->
            <div class="group bg-surface-container-high rounded-2xl overflow-hidden shadow-sm hover:shadow-md transition-shadow">
                <div class="p-8">
                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
                        <div>
                            <span class="text-[10px] font-label-md text-secondary uppercase tracking-widest">Order #MC-88291</span>
                            <h3 class="font-headline-md text-primary">Morning Everest Tea</h3>
                            <p class="text-on-surface-variant font-body-md italic">Today, 2:14 PM</p>
                        </div>
                        <div class="flex flex-col items-end">
<span class="px-4 py-1.5 bg-secondary-container text-on-secondary-container rounded-full text-xs font-label-md mb-2 flex items-center">
<span class="material-symbols-outlined text-sm mr-2" style="font-variation-settings: 'FILL' 1;">restaurant_menu</span>
                                    Preparing
                                </span>
                            <div class="w-32 h-1.5 bg-outline-variant rounded-full overflow-hidden">
                                <div class="w-1/3 h-full bg-secondary"></div>
                            </div>
                        </div>
                    </div>
                    <div class="flex items-center gap-4 mb-6 border-t border-primary/5 pt-6">
                        <img class="w-16 h-16 rounded-xl object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAoqAaBdfI_ILvunJe5AaA5SwlaIGQns7Vsm228NnlIY9hDA2D2mMMD7riK8zs0MpMzcNa23pp5d7dh4SgZaqJ1E6fmXhihcbLTaYOqSHPDXzDxy4TyGnpcl3OUcjWryJbdM-glDLTmTug5lC8UN4VOLmG7x5DVp6NA-oLgY8wJS-lBYJX0WcqHdQeKCaXjJ8OI7FfGOcUMkpiiLEezpJ_njye0BX2wDAiY2XrzwEoOx9dK0B00yIsoIayKCiaXv5OyEyFJsxyIOu5m"/>
                        <div class="flex-1">
                            <p class="font-body-md text-primary font-semibold">Golden Peak Bubble Tea</p>
                            <p class="text-xs text-on-surface-variant font-body-md italic">Kanchanjunga Pearls, 50% Sugar, Large</p>
                        </div>
                        <p class="font-headline-md text-primary">Rs. 825</p>
                    </div>
                    <button class="w-full py-3 bg-secondary text-white rounded-xl font-label-md tracking-widest hover:opacity-90 transition-opacity">
                        TRACK PICKUP
                    </button>
                </div>
            </div>
            <!-- Past Order Card -->
            <div class="group bg-surface-container-low rounded-2xl overflow-hidden border border-stone-100 shadow-sm">
                <div class="p-8">
                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
                        <div>
                            <span class="text-[10px] font-label-md text-on-surface-variant uppercase tracking-widest">Order #MC-88102</span>
                            <h3 class="font-headline-md text-primary">Morning Everest Tea</h3>
                            <p class="text-on-surface-variant font-body-md italic">Baisakh 14, 11:30 AM</p>
                        </div>
                        <div class="flex flex-col items-end">
<span class="px-4 py-1.5 bg-tertiary-fixed text-on-tertiary-fixed-variant rounded-full text-xs font-label-md flex items-center">
<span class="material-symbols-outlined text-sm mr-2">check_circle</span>
                                    Delivered
                                </span>
                        </div>
                    </div>
                    <div class="flex items-center gap-4 border-t border-primary/5 pt-6">
                        <div class="flex -space-x-4">
                            <img class="w-12 h-12 rounded-full border-2 border-surface-container-low object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAWDeRCK6bY0mMK3H4TEu9Nd9B-pUPnDfBVAQ4dc6sGTU0S43vtw4eggPRvAgR1YReXGE2mTYk0g8OQ6pX3yQSy38stB2zbL9hSNd3sO4gIls1NpBr0DZ7v5a-OBDdePp9z9EDX2GrO5P4F_hfchYziopgvtz5i2BrZ1WC_2F9JFNSFn4dKGuBCUzLZHsg7nwEfWtOWuUuuQ5Em6lknyN-M5OLfOHZoSMeSX65mzzVAqp89Vlw33fZpihq1xM1nl0dc6AVkbmahE4ZT"/>
                            <img class="w-12 h-12 rounded-full border-2 border-surface-container-low object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAoqAaBdfI_ILvunJe5AaA5SwlaIGQns7Vsm228NnlIY9hDA2D2mMMD7riK8zs0MpMzcNa23pp5d7dh4SgZaqJ1E6fmXhihcbLTaYOqSHPDXzDxy4TyGnpcl3OUcjWryJbdM-glDLTmTug5lC8UN4VOLmG7x5DVp6NA-oLgY8wJS-lBYJX0WcqHdQeKCaXjJ8OI7FfGOcUMkpiiLEezpJ_njye0BX2wDAiY2XrzwEoOx9dK0B00yIsoIayKCiaXv5OyEyFJsxyIOu5m"/>
                        </div>
                        <div class="flex-1 ml-6">
                            <p class="font-body-md text-primary font-semibold">Golden Peak Bubble Tea</p>
                            <p class="text-xs text-on-surface-variant font-body-md">2 items • Paid via Fonepay</p>
                        </div>
                        <p class="font-body-md text-primary mr-4">Rs. 1,250</p>
                        <button class="p-3 rounded-full border border-secondary text-secondary hover:bg-secondary hover:text-white transition-all">
                            <span class="material-symbols-outlined">reorder</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- Footer from COMPONENTS_38 -->
<footer class="w-full mt-20 bg-stone-100 dark:bg-stone-900 border-t border-stone-200 dark:border-stone-800">
    <div class="grid grid-cols-1 md:grid-cols-4 gap-12 px-8 py-16 max-w-7xl mx-auto font-serif text-sm leading-relaxed">
        <div class="md:col-span-1">
            <span class="text-xl font-serif font-bold text-[#4B2C20] dark:text-stone-100 mb-4 block">MithoCha</span>
            <p class="text-stone-500 dark:text-stone-500">© 2024 MithoCha Premium Bubble Tea. Sip into Sophistication.</p>
        </div>
        <div class="flex flex-col space-y-4">
            <h4 class="text-[#4B2C20] dark:text-stone-300 font-semibold uppercase tracking-widest text-[10px]">Explore</h4>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Shop</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Our Story</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Rewards</a>
        </div>
        <div class="flex flex-col space-y-4">
            <h4 class="text-[#4B2C20] dark:text-stone-300 font-semibold uppercase tracking-widest text-[10px]">Values</h4>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Sustainability</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Careers</a>
        </div>
        <div class="flex flex-col space-y-4">
            <h4 class="text-[#4B2C20] dark:text-stone-300 font-semibold uppercase tracking-widest text-[10px]">Legal</h4>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Privacy Policy</a>
        </div>
    </div>
</footer>
<!-- Mobile Navigation (Kept as supplemental interaction for small screens) -->
<nav class="md:hidden fixed bottom-0 w-full z-50 bg-white/95 backdrop-blur-lg border-t border-stone-200/50 h-20 px-4 pb-safe flex justify-around items-center">
    <a class="flex flex-col items-center justify-center text-stone-400 active:scale-95 transition-transform" href="#">
        <span class="material-symbols-outlined">home</span>
        <span class="font-serif text-[10px] uppercase tracking-widest mt-1">Ghar</span>
    </a>
    <a class="flex flex-col items-center justify-center text-stone-400 active:scale-95 transition-transform" href="#">
        <span class="material-symbols-outlined">bubbles</span>
        <span class="font-serif text-[10px] uppercase tracking-widest mt-1">Menu</span>
    </a>
    <a class="flex flex-col items-center justify-center text-stone-400 active:scale-95 transition-transform" href="#">
        <span class="material-symbols-outlined">shopping_bag</span>
        <span class="font-serif text-[10px] uppercase tracking-widest mt-1">Jhola</span>
    </a>
    <a class="flex flex-col items-center justify-center bg-amber-100/50 text-[#4B2C20] rounded-xl px-4 py-1 active:scale-95 transition-transform" href="#">
        <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">person</span>
        <span class="font-serif text-[10px] uppercase tracking-widest mt-1">Profile</span>
    </a>
</nav>
</body></html>