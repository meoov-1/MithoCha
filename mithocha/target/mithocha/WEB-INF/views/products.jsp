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
                        "tertiary-fixed": "#e4e3d7",
                        "on-primary-fixed": "#2e140a",
                        "on-tertiary-fixed-variant": "#46473f",
                        "surface-variant": "#f4f3f0",
                        "error": "#ba1a1a",
                        "inverse-primary": "#d1b5a5",
                        "on-secondary-container": "#4a332d",
                        "surface-dim": "#e9e7e2",
                        "on-tertiary-container": "#8b8b80",
                        "on-secondary-fixed-variant": "#623f18",
                        "tertiary-fixed-dim": "#c7c7bc",
                        "primary-fixed": "#f2e6e1",
                        "primary-fixed-dim": "#d1b5a5",
                        "background": "#fdfdfc",
                        "surface-container-lowest": "#ffffff",
                        "primary": "#4a332d",
                        "on-tertiary": "#ffffff",
                        "outline-variant": "#d9d5d1",
                        "on-error": "#ffffff",
                        "primary-container": "#7a5c53",
                        "secondary-container": "#e8d5c8",
                        "surface-container-highest": "#f4f3f0",
                        "on-tertiary-fixed": "#1b1c15",
                        "surface-container-low": "#faf9f7",
                        "on-primary": "#ffffff",
                        "inverse-on-surface": "#fcfaf8",
                        "on-primary-container": "#f2e6e1",
                        "on-error-container": "#93000a",
                        "secondary-fixed": "#f2e4d9",
                        "surface-tint": "#8c6c62",
                        "secondary-fixed-dim": "#d9c3b2",
                        "secondary": "#8c6c62",
                        "tertiary-container": "#34352d",
                        "on-secondary-fixed": "#2c1600",
                        "on-background": "#211b19",
                        "on-secondary": "#ffffff",
                        "on-surface": "#211b19",
                        "error-container": "#ffdad6",
                        "tertiary": "#1e2019",
                        "on-primary-fixed-variant": "#613e31",
                        "surface-container": "#f2f1ed",
                        "surface-bright": "#fdfdfc",
                        "surface": "#fdfdfc",
                        "outline": "#857e7b",
                        "inverse-surface": "#36302e",
                        "surface-container-high": "#ebeae6"
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
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .tap-highlight-transparent { -webkit-tap-highlight-color: transparent; }
        .hero-mask { mask-image: linear-gradient(to bottom, black 80%, transparent 100%); }
    </style>
</head>
<body class="bg-background text-on-background font-body-md selection:bg-secondary-container">
<!-- TopAppBar from COMPONENTS_38 -->
<nav class="bg-stone-50/80 dark:bg-stone-950/80 backdrop-blur-md fixed top-0 w-full z-50 border-b border-stone-200/50 dark:border-stone-800/50 shadow-sm dark:shadow-none">
    <div class="flex justify-between items-center h-20 px-6 md:px-12 max-w-7xl mx-auto">
        <div class="text-2xl font-serif font-bold text-[#4B2C20] dark:text-stone-100">MithoCha</div>
        <div class="hidden md:flex items-center space-x-8 font-serif text-base tracking-wide">
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors active:scale-95 duration-200" href="#">Home</a>
            <a class="text-[#4B2C20] dark:text-amber-200 border-b-2 border-amber-500 pb-1 font-bold active:scale-95 duration-200" href="#">Menu</a>
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors active:scale-95 duration-200" href="#">Rewards</a>
            <a class="text-stone-600 dark:text-stone-400 hover:text-[#4B2C20] dark:hover:text-stone-200 transition-colors active:scale-95 duration-200" href="#">Profile</a>
        </div>
        <div class="flex items-center space-x-4">
            <button class="p-2 text-[#4B2C20] dark:text-stone-200 hover:opacity-80 transition-opacity duration-300 active:scale-95">
                <span class="material-symbols-outlined" data-icon="shopping_bag">shopping_bag</span>
            </button>
            <button class="p-2 text-[#4B2C20] dark:text-stone-200 hover:opacity-80 transition-opacity duration-300 active:scale-95">
                <span class="material-symbols-outlined" data-icon="notifications">notifications</span>
            </button>
        </div>
    </div>
</nav>
<main class="pt-24 pb-32">
    <header class="max-w-7xl mx-auto px-6 py-12 md:py-20 text-center">
        <h1 class="font-headline-xl text-primary mb-4">Mitho Bubble Tea</h1>
        <p class="font-body-lg text-on-surface-variant max-w-2xl mx-auto italic">Delight in every sip. Our authentic bubble teas are crafted with premium tea leaves, fresh milk, and the perfect chewy pearls.</p>
    </header>
    <section class="max-w-7xl mx-auto px-6 mb-16">
        <div class="flex flex-wrap gap-4 justify-center md:justify-start">
            <button class="px-6 py-2 rounded-full bg-secondary-container text-on-secondary-container font-label-md shadow-sm border border-secondary transition-all">All Bubble Teas</button>
            <button class="px-6 py-2 rounded-full bg-surface-container-low text-on-surface-variant font-label-md border border-outline-variant hover:border-secondary transition-all">Signature Blends</button>
            <button class="px-6 py-2 rounded-full bg-surface-container-low text-on-surface-variant font-label-md border border-outline-variant hover:border-secondary transition-all">Fruit Teas</button>
        </div>
    </section>
    <section class="max-w-7xl mx-auto px-6 space-y-20">
        <div>
            <h2 class="font-headline-lg text-primary mb-10 border-l-4 border-secondary pl-4">Signature Blends</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Butterscotch -->
                <div class="bg-surface-container-low rounded-xl overflow-hidden group hover:shadow-[0_10px_30px_rgba(75,44,32,0.05)] transition-all duration-500">
                    <div class="relative h-64 overflow-hidden">
                        <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="caramel colored bubble tea with syrup swirls" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDYZrGNHM-JSrZ_-EjQi0OE19cCc7gMWzcDxsbuq4KfoTE7CtfKH5v9F2rLZXPMtAlkDMkFtxfZICYUWw_eIZ6LfISL9yvx2lNmx3olN6xdIeoH7K3Ee_K5Tz3yjZ432htCEc0WCNTCzV6LUYOFfsEs_J9k4X5j8M3lhBvZO4l85-hcR2R7Xx_rJUWQby4784tXie9wCktgeXSgu6aYRS8vPAfYlZ_R_7ZsDB-By-QVoD3UfnsEtSOQIv-6WTnDHaQs7WFJ_snolrQ2"/>
                        <div class="absolute top-4 right-4 bg-amber-100/80 backdrop-blur-sm px-3 py-1 rounded-full">
                            <span class="font-label-md text-secondary text-xs uppercase tracking-tighter">Bestseller</span>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="flex justify-between items-start mb-2">
                            <h3 class="font-headline-md text-primary">Gud-Caramel Butterscotch</h3>
                            <span class="font-headline-md text-secondary">Rs. 350</span>
                        </div>
                        <p class="font-body-md text-on-surface-variant mb-6 line-clamp-2 italic">A rich, jaggery-infused butterscotch blend that captures the warmth of traditional Nepali sweetness.</p>
                        <div class="flex gap-2 mb-6">
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Gurmuri</span>
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Caramelized</span>
                        </div>
                        <div class="flex gap-3">
                            <button class="flex-1 bg-secondary text-on-secondary font-label-md py-3 rounded-lg hover:bg-primary transition-all active:scale-95">Order</button>
                            <button class="px-4 border border-outline text-primary rounded-lg hover:bg-stone-100 transition-all">
                                <span class="material-symbols-outlined align-middle" data-icon="settings">settings</span>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Chocolate -->
                <div class="bg-surface-container-low rounded-xl overflow-hidden group hover:shadow-[0_10px_30px_rgba(75,44,32,0.05)] transition-all duration-500">
                    <div class="relative h-64 overflow-hidden">
                        <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="rich dark chocolate bubble tea" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBquX2fNKHlLm4aGMoIl5OqewCbVzo7BJDy19gbdy2Ln-en1dklix1Ih2kfAWeSbVhSA6J_kn1hsGEEVw_qFl-QZNN0Md4DwIX9Sx4zMNkHrFeitnutGAQTMJxW9TJl9Xc3P3rbm_qCkVI3J_gEqG5q-3X0UqobxtPHei962zde8ElnRyawz1spQALNeqLOawkrAc-OE6MXjTfddoh10SokxQ-b6IGsvZbc3m6KWNQZ4a1Qjcq6S-AiOg3l60fMoE-oMv13HFSMPIdo"/>
                    </div>
                    <div class="p-6">
                        <div class="flex justify-between items-start mb-2">
                            <h3 class="font-headline-md text-primary">Dark Chocolate</h3>
                            <span class="font-headline-md text-secondary">Rs. 380</span>
                        </div>
                        <p class="font-body-md text-on-surface-variant mb-6 line-clamp-2 italic">Deep cocoa layers met with fresh Himalayan milk for an intense, velvety chocolate escape.</p>
                        <div class="flex gap-2 mb-6">
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Bold</span>
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Indulgent</span>
                        </div>
                        <div class="flex gap-3">
                            <button class="flex-1 bg-secondary text-on-secondary font-label-md py-3 rounded-lg hover:bg-primary transition-all active:scale-95">Order</button>
                            <button class="px-4 border border-outline text-primary rounded-lg hover:bg-stone-100 transition-all">
                                <span class="material-symbols-outlined align-middle" data-icon="settings">settings</span>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Vanilla -->
                <div class="bg-surface-container-low rounded-xl overflow-hidden group hover:shadow-[0_10px_30px_rgba(75,44,32,0.05)] transition-all duration-500">
                    <div class="relative h-64 overflow-hidden">
                        <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="creamy white vanilla bubble tea" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCsV8N6lfd0nZJ_tE4Kk3Wvf-qo4Qw5eiRl6-t3zusw0K-IHaZGd5WJjtk6-nVxVQl43jhFQSILOzm4BMSO2x-kKoVpgVG3Z2gHN3TGpSW6vFIiZL2D8zWkT0mYWGDAxYyaNKsk3rZSZ5HH3eiFwXTaA7zhhH_3enTRWDhFQ83FiW_yG9FDPrN6F0KdLcDqoLQusQa25hajZ8f3b80lBQr1WHydmT8yT0LDGRD5N0bwXlW0D10GwifLqhh1dp6XRxK-FHziYTr4OusY"/>
                    </div>
                    <div class="p-6">
                        <div class="flex justify-between items-start mb-2">
                            <h3 class="font-headline-md text-primary">Pure Vanilla</h3>
                            <span class="font-headline-md text-secondary">Rs. 320</span>
                        </div>
                        <p class="font-body-md text-on-surface-variant mb-6 line-clamp-2 italic">Classic, pure, and elegant. A serene vanilla blend that tastes like snow-capped mountain mornings.</p>
                        <div class="flex gap-2 mb-6">
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Pure</span>
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Smooth</span>
                        </div>
                        <div class="flex gap-3">
                            <button class="flex-1 bg-secondary text-on-secondary font-label-md py-3 rounded-lg hover:bg-primary transition-all active:scale-95">Order</button>
                            <button class="px-4 border border-outline text-primary rounded-lg hover:bg-stone-100 transition-all">
                                <span class="material-symbols-outlined align-middle" data-icon="settings">settings</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <h2 class="font-headline-lg text-primary mb-10 border-l-4 border-secondary pl-4">Fruit Teas</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Strawberry -->
                <div class="bg-surface-container-low rounded-xl overflow-hidden group hover:shadow-[0_10px_30px_rgba(75,44,32,0.05)] transition-all duration-500">
                    <div class="relative h-64 overflow-hidden">
                        <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="vibrant pink strawberry bubble tea" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBjKtMt-cGyRjuS3wBgvv9GGeZQg18oha7X_8eOHFae6vCPJjeh4fB4ROD2lOhGwSkucYk1HDc5wzBhWDNTltTAvFEwxzzcgDS2mjjKISVl-PxnnYJ4AWwgda-04CNuoaKlSKo2IcvmJAS5HM0Pex-vVwp-ndfz3B5N4Ay04jVEn5i6oMVl7BCP-2D9g5IHXFqULub4i1JTnch08XXber5QQW6jsuiS2bDB5nQYyf_V6DgU3QuG3Am0u_X52iO654WXwJvE8peSm2zT"/>
                    </div>
                    <div class="p-6">
                        <div class="flex justify-between items-start mb-2">
                            <h3 class="font-headline-md text-primary">Red Strawberry</h3>
                            <span class="font-headline-md text-secondary">Rs. 400</span>
                        </div>
                        <p class="font-body-md text-on-surface-variant mb-6 line-clamp-2 italic">Sun-ripened strawberries blended into a refreshing tea for a burst of crimson joy.</p>
                        <div class="flex gap-2 mb-6">
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Tangy</span>
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Sweet</span>
                        </div>
                        <div class="flex gap-3">
                            <button class="flex-1 bg-secondary text-on-secondary font-label-md py-3 rounded-lg hover:bg-primary transition-all active:scale-95">Order</button>
                            <button class="px-4 border border-outline text-primary rounded-lg hover:bg-stone-100 transition-all">
                                <span class="material-symbols-outlined align-middle" data-icon="settings">settings</span>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Blueberry -->
                <div class="bg-surface-container-low rounded-xl overflow-hidden group hover:shadow-[0_10px_30px_rgba(75,44,32,0.05)] transition-all duration-500">
                    <div class="relative h-64 overflow-hidden">
                        <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="deep purple blueberry bubble tea" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC7SeL4pRya8ife9IlLFFFzp9eD8AKIRoGGdxwNkOMaoW--dspOvTfCkvayr-23Ryms2nP8ykipJi6ULdxemCNZyHYjDQZHsF6yYhWzh3FEUpZrsU4rHvlA4Ok_mBKxdhbBqFEm5jYMzZABmDgftj32j8XwXeGwblK6TpzjhnqrSWKg1vsoPLCqNalW7e7dMAjyWljLeLkQxgCbYO8kqlZfYDYQ5q8Tly8HZ1wULU_MRUan53-GItmlutxTet4jSi3vHsidL3GQB_X_"/>
                    </div>
                    <div class="p-6">
                        <div class="flex justify-between items-start mb-2">
                            <h3 class="font-headline-md text-primary">Blueberry Bliss</h3>
                            <span class="font-headline-md text-secondary">Rs. 420</span>
                        </div>
                        <p class="font-body-md text-on-surface-variant mb-6 line-clamp-2 italic">A magical purple-blue infusion of forest blueberries and premium jasmine green tea.</p>
                        <div class="flex gap-2 mb-6">
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Tart</span>
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Antioxidant</span>
                        </div>
                        <div class="flex gap-3">
                            <button class="flex-1 bg-secondary text-on-secondary font-label-md py-3 rounded-lg hover:bg-primary transition-all active:scale-95">Order</button>
                            <button class="px-4 border border-outline text-primary rounded-lg hover:bg-stone-100 transition-all">
                                <span class="material-symbols-outlined align-middle" data-icon="settings">settings</span>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Honey Dew -->
                <div class="bg-surface-container-low rounded-xl overflow-hidden group hover:shadow-[0_10px_30px_rgba(75,44,32,0.05)] transition-all duration-500">
                    <div class="relative h-64 overflow-hidden">
                        <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="soft green honeydew bubble tea" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB9P67L4BG5zx620CFzS9qoNhi4iANNoYSMgOnXr_k8TOZaNieM5f2Q-lNaKT4uIZzVia82UUNhrFS5DYycYNQSZ7UHRRVyle90pOkV_OT0cVQWaj1BXjCpU7LygfqhWAO-LLuF7IlpXySpt6nSh9KR6eU-KrboT0MSO7_4lS7d7xZ6BcFS6v6sdijpKt_Pyq1G0tuqkbPqYRgkvd3fznL6m5HatqWkyu0tiGw-HgZFEEqGqjpZ2DKUC-0O8xgGGY3ERFMztGFZUlhj"/>
                    </div>
                    <div class="p-6">
                        <div class="flex justify-between items-start mb-2">
                            <h3 class="font-headline-md text-primary">Honey Dew</h3>
                            <span class="font-headline-md text-secondary">Rs. 390</span>
                        </div>
                        <p class="font-body-md text-on-surface-variant mb-6 line-clamp-2 italic">Refreshing light green melon essence that cools the soul like a breeze from the valley.</p>
                        <div class="flex gap-2 mb-6">
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Cooling</span>
                            <span class="text-[10px] uppercase tracking-widest bg-stone-100 text-stone-600 px-2 py-0.5 rounded border border-stone-200">Refreshing</span>
                        </div>
                        <div class="flex gap-3">
                            <button class="flex-1 bg-secondary text-on-secondary font-label-md py-3 rounded-lg hover:bg-primary transition-all active:scale-95">Order</button>
                            <button class="px-4 border border-outline text-primary rounded-lg hover:bg-stone-100 transition-all">
                                <span class="material-symbols-outlined align-middle" data-icon="settings">settings</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
<!-- Footer from COMPONENTS_38 -->
<footer class="w-full mt-20 bg-stone-100 dark:bg-stone-900 text-[#4B2C20] dark:text-stone-300 font-serif text-sm border-t border-stone-200 dark:border-stone-800 transition-all duration-300">
    <div class="grid grid-cols-1 md:grid-cols-4 gap-12 px-8 py-16 max-w-7xl mx-auto">
        <div class="md:col-span-1">
            <span class="text-xl font-serif font-bold text-[#4B2C20] dark:text-stone-100 mb-4 block">MithoCha</span>
            <p class="leading-relaxed opacity-80">Experience the ritual of authentic bubble tea. Crafting moments of sweet joy in every cup since 2024.</p>
        </div>
        <div class="flex flex-col space-y-3">
            <h4 class="font-bold uppercase tracking-wider mb-2">Shop</h4>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4" href="#">All Menu</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Signature</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Our Story</a>
        </div>
        <div class="flex flex-col space-y-3">
            <h4 class="font-bold uppercase tracking-wider mb-2">Company</h4>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Rewards</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Sustainability</a>
            <a class="text-stone-500 dark:text-stone-500 hover:text-[#4B2C20] dark:hover:text-stone-300 hover:underline decoration-amber-500 underline-offset-4" href="#">Careers</a>
        </div>
        <div class="flex flex-col space-y-3">
            <h4 class="font-bold uppercase tracking-wider mb-2">Newsletter</h4>
            <p class="mb-2">Join our boba list for exclusive releases.</p>
            <div class="flex border border-stone-200 dark:border-stone-800 rounded-lg overflow-hidden">
                <input class="bg-white/50 dark:bg-stone-800 px-4 py-2 w-full outline-none" placeholder="Email address" type="email"/>
                <button class="bg-[#4B2C20] text-white px-4 py-2 hover:opacity-90 transition-opacity">Join</button>
            </div>
        </div>
    </div>
    <div class="max-w-7xl mx-auto px-8 py-8 border-t border-stone-200 dark:border-stone-800 text-center">
        <span class="opacity-70">© 2024 MithoCha Premium Bubble Tea. Sip into Sophistication.</span>
    </div>
</footer>
<!-- Mobile Nav -->
<nav class="md:hidden bg-stone-50/95 dark:bg-stone-950/95 backdrop-blur-lg text-[#4B2C20] dark:text-amber-200 font-serif text-[10px] uppercase tracking-widest fixed bottom-0 w-full z-50 border-t border-stone-200/50 shadow-[0_-4px_20px_rgba(75,44,32,0.05)] transition-all h-20 px-4 pb-safe flex justify-around items-center">
    <a class="flex flex-col items-center justify-center text-stone-400 dark:text-stone-600 active:scale-95 transition-transform" href="#">
        <span class="material-symbols-outlined" data-icon="home">home</span>
        <span class="mt-1">Home</span>
    </a>
    <a class="flex flex-col items-center justify-center bg-amber-100/50 dark:bg-amber-900/30 text-[#4B2C20] dark:text-amber-200 rounded-xl px-4 py-1 active:scale-95 transition-transform" href="#">
        <span class="material-symbols-outlined" data-icon="bubble_tea">bubbles</span>
        <span class="mt-1">Menu</span>
    </a>
    <a class="flex flex-col items-center justify-center text-stone-400 dark:text-stone-600 active:scale-95 transition-transform" href="#">
        <span class="material-symbols-outlined" data-icon="shopping_bag">shopping_bag</span>
        <span class="mt-1">Cart</span>
    </a>
    <a class="flex flex-col items-center justify-center text-stone-400 dark:text-stone-600 active:scale-95 transition-transform" href="#">
        <span class="material-symbols-outlined" data-icon="person">person</span>
        <span class="mt-1">Profile</span>
    </a>
</nav>
<!-- Floating Cart Button -->
<button class="fixed bottom-24 right-6 md:bottom-8 md:right-8 bg-secondary text-on-secondary p-4 rounded-full shadow-lg shadow-secondary/20 hover:scale-105 active:scale-95 transition-all z-40 hidden md:flex items-center gap-2 px-6">
    <span class="material-symbols-outlined" data-icon="shopping_bag" style="font-variation-settings: 'FILL' 1;">shopping_bag</span>
    <span class="font-label-md">View Cart (Rs. 0)</span>
</button>
</body></html>