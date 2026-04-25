<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="light" lang="en"><head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@600;700&amp;family=Be+Vietnam+Pro:wght@400;500;600&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "on-surface-variant": "#504440",
                        "tertiary-fixed": "#f5f5f0",
                        "on-primary-fixed": "#2e140a",
                        "on-tertiary-fixed-variant": "#46473f",
                        "surface-variant": "#f4f4f4",
                        "error": "#ba1a1a",
                        "inverse-primary": "#ecbcaa",
                        "on-secondary-container": "#7a532a",
                        "surface-dim": "#f8f8f8",
                        "on-tertiary-container": "#9d9d93",
                        "on-secondary-fixed-variant": "#623f18",
                        "tertiary-fixed-dim": "#c7c7bc",
                        "primary-fixed": "#ffdbce",
                        "primary-fixed-dim": "#ecbcaa",
                        "background": "#ffffff",
                        "surface-container-lowest": "#ffffff",
                        "primary": "#32170d",
                        "on-tertiary": "#ffffff",
                        "outline-variant": "#e5e5e5",
                        "on-error": "#ffffff",
                        "primary-container": "#4b2c20",
                        "secondary-container": "#fdf8ef",
                        "surface-container-highest": "#f4f4f4",
                        "on-tertiary-fixed": "#1b1c15",
                        "surface-container-low": "#fafafa",
                        "on-primary": "#ffffff",
                        "inverse-on-surface": "#ffffff",
                        "on-primary-container": "#bf9282",
                        "on-error-container": "#93000a",
                        "secondary-fixed": "#ffdcbd",
                        "surface-tint": "#7b5647",
                        "secondary-fixed-dim": "#f0bd8b",
                        "secondary": "#7b5647",
                        "tertiary-container": "#34352d",
                        "on-secondary-fixed": "#2c1600",
                        "on-background": "#271814",
                        "on-secondary": "#ffffff",
                        "on-surface": "#271814",
                        "error-container": "#ffdad6",
                        "tertiary": "#1e2019",
                        "on-primary-fixed-variant": "#613e31",
                        "surface-container": "#f9f9f9",
                        "surface-bright": "#ffffff",
                        "surface": "#ffffff",
                        "outline": "#d1d5db",
                        "inverse-surface": "#3e2c28",
                        "surface-container-high": "#f5f5f5"
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
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .bg-glass {
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
        }
    </style>
</head>
<body class="bg-background text-on-background font-body-md">
<!-- TopAppBar from COMPONENTS_38 -->
<nav class="fixed top-0 w-full z-50 bg-stone-50/80 dark:bg-stone-950/80 backdrop-blur-md border-b border-stone-200/50 dark:border-stone-800/50 shadow-sm dark:shadow-none">
    <div class="flex justify-between items-center h-20 px-6 md:px-12 max-w-7xl mx-auto">
        <span class="text-2xl font-serif font-bold text-[#4B2C20] dark:text-stone-100">MithoCha</span>
        <div class="hidden md:flex items-center space-x-8 font-serif text-base tracking-wide">
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors hover:opacity-80 transition-opacity duration-300" href="#">Home</a>
            <a class="text-[#4B2C20] dark:text-amber-200 border-b-2 border-amber-500 pb-1 font-bold transition-all duration-300" href="#">Menu</a>
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors hover:opacity-80 transition-opacity duration-300" href="#">Rewards</a>
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors hover:opacity-80 transition-opacity duration-300" href="#">Profile</a>
        </div>
        <div class="flex items-center space-x-4">
            <button class="p-2 text-[#4B2C20] dark:text-stone-200 active:scale-95 transition-transform duration-200 relative hover:opacity-80 transition-opacity duration-300">
                <span class="material-symbols-outlined" data-icon="shopping_bag">shopping_bag</span>
                <span class="absolute top-1 right-1 w-2 h-2 bg-secondary rounded-full"></span>
            </button>
            <button class="p-2 text-[#4B2C20] dark:text-stone-200 active:scale-95 transition-transform duration-200 hover:opacity-80 transition-opacity duration-300">
                <span class="material-symbols-outlined" data-icon="notifications">notifications</span>
            </button>
        </div>
    </div>
</nav>
<main class="pt-24 pb-32 max-w-7xl mx-auto px-4 md:px-8">
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-12">
        <!-- Left Column: Customization -->
        <div class="lg:col-span-7 space-y-10">
            <section>
                <div class="flex items-center space-x-2 mb-6 cursor-pointer group">
                    <span class="material-symbols-outlined text-stone-600 group-hover:-translate-x-1 transition-transform" data-icon="arrow_back">arrow_back</span>
                    <span class="font-label-md text-label-md text-stone-600 uppercase">Back to Menu</span>
                </div>
                <div class="flex flex-col md:flex-row gap-8 items-start">
                    <div class="w-full md:w-48 aspect-square rounded-xl overflow-hidden shadow-sm">
                        <img alt="Butterscotch Pearl milk tea with rich golden syrup and chewy boba" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDQIxEj9ZkE7z_nCF8QKYqJcNgVoQUcEF2tI1CzyImp-Jemfk_LA1DDrJ3AKOf521YGqBLe4sXFwmK9MvcBehhUFQM-S9esAR5cOPJxwFkcOp8veHsMjaVT0oxV_wH2yhEQGYTlx8wSoGeUG7Y-hwB9KO9_Ks-dAUCwkmOT0v5z9qgD4SN4I8ugus6sIAviq_LjIPh7-ezwq62fBon28VxehF1QY5JlbhKsxFpff3diSZlryDo8oVCbII2N11Vf3jWE2opS0YrDNSRP"/>
                    </div>
                    <div>
                        <h1 class="font-headline-lg text-headline-lg text-primary mb-2">Caramel Butterscotch Bubble Tea</h1>
                        <p class="text-on-surface-variant font-body-md italic mb-4">Caramelized Himalayan sweetness &amp; hand-crafted pearls</p>
                        <div class="flex flex-wrap gap-2">
                            <span class="px-3 py-1 bg-amber-100 text-amber-800 rounded-lg text-xs font-semibold">Naya Swad (New)</span>
                            <span class="px-3 py-1 bg-stone-100 text-stone-600 rounded-lg text-xs font-semibold">Freshly Brewed</span>
                        </div>
                    </div>
                </div>
            </section>
            <div class="space-y-8 border-t border-stone-100 pt-8">
                <!-- Cup Size -->
                <section>
                    <h3 class="font-label-md text-label-md text-primary uppercase mb-4 tracking-widest">Cup Size</h3>
                    <div class="grid grid-cols-2 gap-4">
                        <label class="relative flex flex-col items-center justify-center p-6 border-2 border-amber-400 bg-white rounded-xl cursor-pointer transition-all">
                            <input checked="" class="hidden" name="size" type="radio"/>
                            <span class="material-symbols-outlined text-primary mb-2" data-icon="local_cafe">local_cafe</span>
                            <span class="font-body-md font-semibold text-primary">Large</span>
                            <span class="text-xs text-on-surface-variant">500ml</span>
                        </label>
                        <label class="relative flex flex-col items-center justify-center p-6 border-2 border-transparent bg-stone-50 rounded-xl cursor-pointer hover:border-stone-200 transition-all">
                            <input class="hidden" name="size" type="radio"/>
                            <span class="material-symbols-outlined text-stone-400 mb-2" data-icon="local_cafe" style="font-size: 32px;">local_cafe</span>
                            <span class="font-body-md font-semibold text-on-surface-variant">Large</span>
                            <span class="text-xs text-on-surface-variant">+Rs. 150</span>
                        </label>
                    </div>
                </section>
                <!-- Ice Level -->
                <section>
                    <h3 class="font-label-md text-label-md text-primary uppercase mb-4 tracking-widest">Ice Level</h3>
                    <div class="flex flex-wrap gap-3">
                        <button class="px-6 py-2 rounded-full border border-stone-200 text-stone-500 font-body-md hover:bg-stone-50 transition-colors">No Ice</button>
                        <button class="px-6 py-2 rounded-full border border-stone-200 text-stone-500 font-body-md hover:bg-stone-50 transition-colors">Less Ice</button>
                        <button class="px-6 py-2 rounded-full border-2 border-amber-400 bg-white text-primary font-semibold font-body-md">Regular</button>
                        <button class="px-6 py-2 rounded-full border border-stone-200 text-stone-500 font-body-md hover:bg-stone-50 transition-colors">Extra Ice</button>
                    </div>
                </section>
                <!-- Sugar Level -->
                <section>
                    <h3 class="font-label-md text-label-md text-primary uppercase mb-4 tracking-widest">Sugar Level</h3>
                    <div class="relative pt-6 px-4">
                        <input class="w-full h-1 bg-stone-200 rounded-lg appearance-none cursor-pointer accent-secondary" max="4" min="0" step="1" type="range" value="2"/>
                        <div class="flex justify-between mt-4 text-[10px] font-medium text-stone-500">
                            <span>No Sugar</span>
                            <span>Low (25%)</span>
                            <span>Medium (50%)</span>
                            <span>Sweet (75%)</span>
                            <span>Full Sugar</span>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <!-- Right Column: Cart & Checkout -->
        <div class="lg:col-span-5">
            <div class="sticky top-28 bg-[#faf7f5] rounded-3xl p-8 border border-stone-100">
                <h2 class="font-headline-md text-headline-md text-primary mb-8 border-b border-stone-200/50 pb-4">Order Summary</h2>
                <div class="space-y-6 mb-8">
                    <div class="flex justify-between items-start">
                        <div class="flex-1">
                            <p class="font-body-lg font-semibold text-primary">Caramel Butterscotch Bubble Tea</p>
                            <p class="text-sm text-on-surface-variant">Regular · Medium (50%) Sugar · Regular Ice</p>
                        </div>
                        <span class="font-body-lg font-bold text-primary">Rs. 450</span>
                    </div>
                </div>
                <div class="space-y-4 border-t border-stone-200/50 pt-6 mb-8">
                    <div class="flex justify-between text-on-surface-variant">
                        <span>Subtotal</span>
                        <span>Rs. 450</span>
                    </div>
                    <div class="flex justify-between text-on-surface-variant">
                        <span>Delivery Fee</span>
                        <span>Rs. 50</span>
                    </div>
                    <div class="flex justify-between font-headline-md text-headline-md text-primary pt-2">
                        <span>Total</span>
                        <span>Rs. 500</span>
                    </div>
                </div>
                <!-- Payment Method -->
                <section class="mb-10">
                    <h3 class="font-label-md text-label-md text-primary uppercase mb-4 tracking-widest">Payment Method</h3>
                    <div class="space-y-3">
                        <label class="flex items-center p-4 bg-white border-2 border-amber-400 rounded-xl cursor-pointer shadow-sm">
                            <input checked="" class="w-4 h-4 text-secondary focus:ring-secondary" name="payment" type="radio"/>
                            <div class="ml-4 flex items-center">
                                <span class="material-symbols-outlined text-secondary mr-2" data-icon="payments">payments</span>
                                <span class="font-body-md font-medium text-primary">Online Payment (Fonepay/Khalti)</span>
                            </div>
                        </label>
                        <label class="flex items-center p-4 bg-white border-2 border-transparent rounded-xl cursor-pointer hover:border-stone-200 transition-all shadow-sm">
                            <input class="w-4 h-4 text-secondary focus:ring-secondary" name="payment" type="radio"/>
                            <div class="ml-4 flex items-center">
                                <span class="material-symbols-outlined text-stone-400 mr-2" data-icon="delivery_dining">delivery_dining</span>
                                <span class="font-body-md font-medium text-on-surface-variant">Cash on Delivery</span>
                            </div>
                        </label>
                    </div>
                </section>
                <button class="w-full bg-[#7d562d] text-white py-5 rounded-xl font-label-md text-label-md uppercase tracking-[0.2em] shadow-md hover:bg-[#623f18] transition-all active:scale-[0.98]">
                    Confirm Order
                </button>
                <p class="text-center text-[10px] text-stone-400 mt-4 uppercase tracking-tighter">Dhanyabaad! Secure checkout powered by MithoCha</p>
            </div>
        </div>
    </div>
</main>
<!-- BottomNavBar (Mobile Only) -->
<nav class="md:hidden fixed bottom-0 w-full z-50 bg-white/95 backdrop-blur-lg border-t border-stone-100 font-serif text-[10px] uppercase tracking-widest">
    <div class="flex justify-around items-center h-20 px-4 pb-safe">
        <div class="flex flex-col items-center justify-center text-stone-400">
            <span class="material-symbols-outlined" data-icon="home">home</span>
            <span>Home</span>
        </div>
        <div class="flex flex-col items-center justify-center text-stone-400">
            <span class="material-symbols-outlined" data-icon="bubble_tea">bubbles</span>
            <span>Menu</span>
        </div>
        <div class="flex flex-col items-center justify-center bg-stone-50 text-[#4B2C20] rounded-xl px-4 py-1">
            <span class="material-symbols-outlined" data-icon="shopping_bag">shopping_bag</span>
            <span>Cart</span>
        </div>
        <div class="flex flex-col items-center justify-center text-stone-400">
            <span class="material-symbols-outlined" data-icon="person">person</span>
            <span>Profile</span>
        </div>
    </div>
</nav>
<!-- Footer from COMPONENTS_38 -->
<footer class="w-full mt-20 bg-stone-100 dark:bg-stone-900 border-t border-stone-200 dark:border-stone-800 font-serif text-sm leading-relaxed text-[#4B2C20] dark:text-stone-300">
    <div class="grid grid-cols-1 md:grid-cols-4 gap-12 px-8 py-16 max-w-7xl mx-auto">
        <div class="md:col-span-1">
            <span class="text-xl font-serif font-bold text-[#4B2C20] dark:text-stone-100 mb-4 block">MithoCha</span>
            <p class="text-stone-500 dark:text-stone-500">© 2024 MithoCha Premium Bubble Tea. Sip into Sophistication.</p>
        </div>
        <div class="flex flex-col space-y-4">
            <h4 class="font-bold uppercase text-[10px] tracking-widest opacity-50">Quick Links</h4>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Shop</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Our Story</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Rewards</a>
        </div>
        <div class="flex flex-col space-y-4">
            <h4 class="font-bold uppercase text-[10px] tracking-widest opacity-50">Company</h4>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Sustainability</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Careers</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4 transition-all duration-300" href="#">Privacy Policy</a>
        </div>
        <div class="flex space-x-4 md:justify-end items-start pt-8 md:pt-0">
            <div class="w-10 h-10 rounded-full bg-white dark:bg-stone-800 flex items-center justify-center shadow-sm hover:opacity-80 transition-all cursor-pointer">
                <span class="material-symbols-outlined text-[#4B2C20] dark:text-stone-200" data-icon="coffee">coffee</span>
            </div>
            <div class="w-10 h-10 rounded-full bg-white dark:bg-stone-800 flex items-center justify-center shadow-sm hover:opacity-80 transition-all cursor-pointer">
                <span class="material-symbols-outlined text-[#4B2C20] dark:text-stone-200" data-icon="eco">eco</span>
            </div>
        </div>
    </div>
</footer>
</body></html>