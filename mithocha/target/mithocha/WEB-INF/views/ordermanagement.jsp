<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="light" lang="en"><head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&amp;family=Be+Vietnam+Pro:wght@400;500;600&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-container-highest": "#fadcd5",
                        "on-tertiary-container": "#9d9d93",
                        "on-error": "#ffffff",
                        "inverse-surface": "#3e2c28",
                        "surface-container-lowest": "#ffffff",
                        "secondary-fixed": "#ffdcbd",
                        "on-secondary-container": "#7a532a",
                        "on-secondary-fixed-variant": "#623f18",
                        "primary-fixed": "#ffdbce",
                        "on-secondary": "#ffffff",
                        "on-error-container": "#93000a",
                        "tertiary-fixed-dim": "#c7c7bc",
                        "on-tertiary": "#ffffff",
                        "surface-container": "#ffe9e4",
                        "on-primary": "#ffffff",
                        "surface-container-high": "#ffe2db",
                        "outline-variant": "#d5c3bd",
                        "inverse-primary": "#ecbcaa",
                        "background": "#fff8f6",
                        "on-tertiary-fixed-variant": "#46473f",
                        "tertiary": "#1e2019",
                        "surface-tint": "#7b5647",
                        "primary-fixed-dim": "#ecbcaa",
                        "outline": "#83746f",
                        "surface-dim": "#f1d4cd",
                        "secondary": "#7d562d",
                        "primary": "#32170d",
                        "on-surface-variant": "#504440",
                        "on-secondary-fixed": "#2c1600",
                        "surface-variant": "#fadcd5",
                        "surface-container-low": "#fff1ed",
                        "surface": "#fff8f6",
                        "secondary-container": "#ffca98",
                        "on-primary-fixed-variant": "#613e31",
                        "on-primary-container": "#bf9282",
                        "error": "#ba1a1a",
                        "secondary-container-hover": "#f0bd8b",
                        "primary-container": "#4b2c20"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "fontFamily": {
                        "headline-lg": ["Noto Serif"],
                        "body-md": ["Be Vietnam Pro"],
                        "headline-xl": ["Noto Serif"],
                        "label-md": ["Be Vietnam Pro"],
                        "body-lg": ["Be Vietnam Pro"],
                        "headline-md": ["Noto Serif"]
                    },
                    "fontSize": {
                        "headline-lg": ["32px", {"lineHeight": "1.2", "fontWeight": "600"}],
                        "body-md": ["16px", {"lineHeight": "1.5", "fontWeight": "400"}],
                        "headline-xl": ["48px", {"lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                        "label-md": ["14px", {"lineHeight": "1.2", "letterSpacing": "0.05em", "fontWeight": "600"}],
                        "body-lg": ["18px", {"lineHeight": "1.6", "fontWeight": "400"}],
                        "headline-md": ["24px", {"lineHeight": "1.3", "fontWeight": "600"}]
                    }
                }
            }
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        body { font-family: 'Be Vietnam Pro', sans-serif; }
        .glass-panel {
            backdrop-filter: blur(12px);
            background: rgba(255, 248, 246, 0.8);
        }
        .brew-progress {
            height: 4px;
            background: #ffe9e4;
            border-radius: 2px;
            overflow: hidden;
        }
        .brew-progress-fill {
            height: 100%;
            background: #7d562d;
            transition: width 0.3s ease;
        }
    </style>
</head>
<body class="bg-background text-on-background min-h-screen">
<!-- TopAppBar -->
<nav class="flex justify-between items-center px-6 py-3 w-full sticky top-0 bg-stone-50/80 dark:bg-stone-950/80 backdrop-blur-md text-stone-800 dark:text-stone-100 font-serif font-medium docked full-width top-0 z-40 border-b border-stone-200 dark:border-stone-800 shadow-sm">
    <div class="flex items-center gap-4">
        <span class="text-xl font-bold text-stone-900 dark:text-white font-serif tracking-tight">MithoCha</span>
        <div class="hidden md:flex items-center gap-6 ml-8">
            <span class="text-amber-700 dark:text-amber-400 font-semibold cursor-pointer">Orders</span>
            <span class="text-stone-500 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 transition-colors px-3 py-1 rounded cursor-pointer">Menu</span>
            <span class="text-stone-500 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 transition-colors px-3 py-1 rounded cursor-pointer">Analytics</span>
        </div>
    </div>
    <div class="flex items-center gap-4">
        <button class="p-2 hover:bg-stone-100 dark:hover:bg-stone-800 transition-colors rounded-full">
            <span class="material-symbols-outlined">notifications</span>
        </button>
        <button class="p-2 hover:bg-stone-100 dark:hover:bg-stone-800 transition-colors rounded-full">
            <span class="material-symbols-outlined">settings</span>
        </button>
        <img alt="Admin profile" class="w-8 h-8 rounded-full border border-outline-variant object-cover" data-alt="Professional headshot of a boutique cafe manager with soft morning light and a modern minimalist office background" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC0LDRb91fLEhTGwGeJ2fH1e4eBSsVfC9GFIgoxLapgpKxaQV4STHcW6QEH136wqEZM8HESLAesP4vUBeJrKVcZvSkvwiBkFb-GmznqHPqGC_NkFYN7sK5TuxXrMruh8n3HZaLgRdvncdi4veGHHQy_JB0S3ZTA1J7h6_ldQFj9nmr2V33u79OoYsW9btED2Gsy8vX0JGMjxDOtz1X3L1ytjErOFZVwLZYs0VItotvaqCdNuDrKFUkCwPkeuFEA3KAjOECw2OKhjmaK"/>
    </div>
</nav>
<div class="flex">
    <!-- SideNavBar -->
    <aside class="hidden lg:flex flex-col h-[calc(100vh-64px)] w-64 border-r border-stone-200 dark:border-stone-800 bg-stone-50 dark:bg-stone-900 sticky top-16 py-6 font-serif text-sm tracking-wide shrink-0">
        <div class="flex-1 space-y-1">
            <div class="px-4 mb-4">
                <p class="text-xs uppercase font-bold text-stone-400 tracking-widest mb-4">Main Menu</p>
                <nav class="space-y-1">
                    <a class="flex items-center gap-3 px-4 py-2 text-stone-600 dark:text-stone-400 hover:translate-x-1 transition-transform duration-200 rounded-lg" href="#">
                        <span class="material-symbols-outlined">dashboard</span> Dashboard
                    </a>
                    <a class="flex items-center gap-3 px-4 py-2 text-stone-600 dark:text-stone-400 hover:translate-x-1 transition-transform duration-200 rounded-lg" href="#">
                        <span class="material-symbols-outlined">bubble_chart</span> Menu Management
                    </a>
                    <a class="flex items-center gap-3 px-4 py-2 text-amber-800 dark:text-amber-200 bg-amber-50 dark:bg-amber-900/20 border-r-4 border-amber-600" href="#">
                        <span class="material-symbols-outlined">shopping_bag</span> Orders
                    </a>
                    <a class="flex items-center gap-3 px-4 py-2 text-stone-600 dark:text-stone-400 hover:translate-x-1 transition-transform duration-200 rounded-lg" href="#">
                        <span class="material-symbols-outlined">group</span> Customers
                    </a>
                    <a class="flex items-center gap-3 px-4 py-2 text-stone-600 dark:text-stone-400 hover:translate-x-1 transition-transform duration-200 rounded-lg" href="#">
                        <span class="material-symbols-outlined">inventory_2</span> Inventory
                    </a>
                    <a class="flex items-center gap-3 px-4 py-2 text-stone-600 dark:text-stone-400 hover:translate-x-1 transition-transform duration-200 rounded-lg" href="#">
                        <span class="material-symbols-outlined">local_offer</span> Offers &amp; Discounts
                    </a>
                    <a class="flex items-center gap-3 px-4 py-2 text-stone-600 dark:text-stone-400 hover:translate-x-1 transition-transform duration-200 rounded-lg" href="#">
                        <span class="material-symbols-outlined">analytics</span> Analytics
                    </a>
                    <a class="flex items-center gap-3 px-4 py-2 text-stone-600 dark:text-stone-400 hover:translate-x-1 transition-transform duration-200 rounded-lg" href="#">
                        <span class="material-symbols-outlined">receipt_long</span> Invoices
                    </a>
                </nav>
            </div>
        </div>
        <div class="px-4 border-t border-stone-200 dark:border-stone-800 pt-4 space-y-1">
            <a class="flex items-center gap-3 px-4 py-2 text-stone-600 dark:text-stone-400 hover:translate-x-1 transition-transform duration-200 rounded-lg" href="#">
                <span class="material-symbols-outlined">help</span> Help Center
            </a>
            <a class="flex items-center gap-3 px-4 py-2 text-stone-600 dark:text-stone-400 hover:translate-x-1 transition-transform duration-200 rounded-lg" href="#">
                <span class="material-symbols-outlined">logout</span> Logout
            </a>
        </div>
    </aside>
    <!-- Main Content Canvas -->
    <main class="flex-1 p-6 md:p-10 max-w-7xl mx-auto w-full">
        <!-- Header Section -->
        <div class="mb-10 flex flex-col md:flex-row md:items-end justify-between gap-6">
            <div>
                <h1 class="font-headline-xl text-headline-xl text-primary mb-2">Order Management</h1>
                <p class="font-body-lg text-body-lg text-on-surface-variant">Manage your premium bubble tea requests with precision.</p>
            </div>
            <div class="flex gap-3">
                <button class="bg-secondary text-on-secondary px-6 py-2 rounded-full font-label-md text-label-md hover:bg-opacity-90 transition-all flex items-center gap-2">
                    <span class="material-symbols-outlined text-sm">download</span> Export Daily Report
                </button>
            </div>
        </div>
        <!-- Bento Grid Layout -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Left Column: Order List -->
            <div class="lg:col-span-2 space-y-6">
                <!-- Status Filter Chips -->
                <div class="flex flex-wrap gap-2 mb-6">
                    <button class="bg-secondary text-on-secondary px-4 py-1.5 rounded-full font-label-md text-label-md">All Orders</button>
                    <button class="bg-surface-container-high text-on-secondary-container px-4 py-1.5 rounded-full font-label-md text-label-md hover:bg-surface-container-highest transition-colors">Preparing (4)</button>
                    <button class="bg-surface-container-high text-on-secondary-container px-4 py-1.5 rounded-full font-label-md text-label-md hover:bg-surface-container-highest transition-colors">Out for Delivery (2)</button>
                    <button class="bg-surface-container-high text-on-secondary-container px-4 py-1.5 rounded-full font-label-md text-label-md hover:bg-surface-container-highest transition-colors">Delivered (12)</button>
                </div>
                <!-- Order Cards Stack -->
                <div class="space-y-4">
                    <!-- Active Order 1 -->
                    <div class="bg-surface-container-low p-6 rounded-xl transition-all hover:bg-surface-container-high cursor-pointer group relative overflow-hidden">
                        <div class="absolute top-0 left-0 w-1.5 h-full bg-secondary"></div>
                        <div class="flex justify-between items-start mb-4">
                            <div>
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="font-headline-md text-headline-md text-primary">#ORD-4921</span>
                                    <span class="bg-secondary-container text-on-secondary-container px-2 py-0.5 rounded text-[10px] font-bold uppercase tracking-widest">Preparing</span>
                                </div>
                                <p class="font-body-md text-body-md text-on-surface-variant">Aarya Sharma • <span class="italic">2 items</span></p>
                            </div>
                            <div class="text-right">
                                <p class="font-headline-md text-headline-md text-primary">Rs. 1,450</p>
                                <p class="text-xs text-on-surface-variant">12:30 PM</p>
                            </div>
                        </div>
                        <div class="flex items-center gap-6 mt-4 pt-4 border-t border-outline-variant/30">
                            <div class="flex -space-x-3">
                                <img class="w-10 h-10 rounded-full border-2 border-white object-cover" data-alt="Classic brown sugar boba milk tea with tiger stripes syrup and golden pearls in a tall glass" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBB7WYEP0XrX9hH7iBYSAE8T5fqoDwCYYNEPRIa972mZv98QM2Ox5MH9jejqrtFs2JjOqJT8jllVfWbIQu-ajdvOpn1ocX3su0MoOE6WSSXUwBI2uAsJeRn_fRjdnffEsJ6AkZbFRwSjQm2qRHLMLXQdJSoC-FiqPppO_2J1ZZju7MS7LPvruBirgBfy4_1m1Y6X_gVvsW3MeYjjyiMt77aEnCxNA_8QFwdXT3lEgU85GGEPciTqniXgN-Su9qj4bsdeiDhyU5KA_Xq"/>
                                <img class="w-10 h-10 rounded-full border-2 border-white object-cover" data-alt="Vibrant purple taro bubble tea with dark tapioca pearls and whipped cream topping" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDrkxT51Fn199BgI1o7No2JZ0XK0kFDpI_gYAcdYXYuehzGkuVcoRTGQAEx4Tzz1G6boCc2FG5uQktJeSIaa2WCkL_c1clIn5_RUxuTyDe27Kaqt7SiUIFpv_WHsoiu1Ia2f_TIagCPfTN6vw9Cd-K5rLeXc95oa77xcp5BtsqKc4LZ7IBm9guuXabZJRSSi-YyLt7ndwtlZql0qvm5C9THj_YHPGJ28vwAWi_oIiZyJdaw9-Hmz_zRisqXW9Odn37pqqiIy-3IFOgR"/>
                            </div>
                            <div class="flex-1">
                                <div class="brew-progress mb-1">
                                    <div class="brew-progress-fill w-[65%]"></div>
                                </div>
                                <p class="text-[10px] text-on-surface-variant font-bold uppercase">Steeping Tea • 4 min remaining</p>
                            </div>
                        </div>
                    </div>
                    <!-- Active Order 2 -->
                    <div class="bg-surface-container-low p-6 rounded-xl transition-all hover:bg-surface-container-high cursor-pointer group relative overflow-hidden">
                        <div class="absolute top-0 left-0 w-1.5 h-full bg-blue-500"></div>
                        <div class="flex justify-between items-start mb-4">
                            <div>
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="font-headline-md text-headline-md text-primary">#ORD-4918</span>
                                    <span class="bg-blue-100 text-blue-700 px-2 py-0.5 rounded text-[10px] font-bold uppercase tracking-widest">Out for Delivery</span>
                                </div>
                                <p class="font-body-md text-body-md text-on-surface-variant">Rohan Karki • <span class="italic">1 item</span></p>
                            </div>
                            <div class="text-right">
                                <p class="font-headline-md text-headline-md text-primary">Rs. 680</p>
                                <p class="text-xs text-on-surface-variant">12:15 PM</p>
                            </div>
                        </div>
                        <div class="flex items-center justify-between mt-4 pt-4 border-t border-outline-variant/30 text-on-surface-variant text-sm">
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">distance</span> 2.4 km away</span>
                            <span class="font-medium text-blue-600">Arriving in ~10 mins</span>
                        </div>
                    </div>
                    <!-- Past Order -->
                    <div class="bg-stone-50/50 opacity-75 p-6 rounded-xl border border-stone-200 transition-all hover:bg-stone-100/50 cursor-pointer">
                        <div class="flex justify-between items-start">
                            <div>
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="font-headline-md text-headline-md text-stone-500">#ORD-4902</span>
                                    <span class="bg-stone-200 text-stone-600 px-2 py-0.5 rounded text-[10px] font-bold uppercase tracking-widest">Delivered</span>
                                </div>
                                <p class="font-body-md text-body-md text-stone-400">Sneha Tamang • <span class="italic">3 items</span></p>
                            </div>
                            <div class="text-right">
                                <p class="font-headline-md text-headline-md text-stone-500">Rs. 2,100</p>
                                <p class="text-xs text-stone-400">11:05 AM</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Right Column: Detail View (The "Glass" Panel) -->
            <div class="lg:sticky lg:top-24 h-fit">
                <div class="glass-panel border border-surface-container-highest p-8 rounded-3xl shadow-lg shadow-primary/5">
                    <div class="flex justify-between items-start mb-8">
                        <h2 class="font-headline-lg text-headline-lg text-primary">Order Detail</h2>
                        <button class="text-on-surface-variant hover:text-primary transition-colors">
                            <span class="material-symbols-outlined">close</span>
                        </button>
                    </div>
                    <div class="space-y-8">
                        <!-- Header Info -->
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 rounded-full bg-surface-container-high flex items-center justify-center text-secondary">
                                <span class="material-symbols-outlined text-3xl">person</span>
                            </div>
                            <div>
                                <p class="font-headline-md text-headline-md text-primary">Aarya Sharma</p>
                                <p class="font-label-md text-label-md text-on-surface-variant">Contact: +977-9801234567</p>
                            </div>
                        </div>
                        <!-- Items Detail -->
                        <div class="space-y-6">
                            <p class="text-xs font-bold uppercase tracking-widest text-secondary border-b border-outline-variant pb-2">Order Items (2)</p>
                            <!-- Item 1 -->
                            <div class="space-y-3">
                                <div class="flex justify-between font-headline-md text-headline-md">
                                    <span class="text-primary">Royal Assam Milk Tea</span>
                                    <span class="text-primary">Rs. 750</span>
                                </div>
                                <div class="grid grid-cols-2 gap-2">
                                    <div class="bg-surface-container-low px-3 py-2 rounded-lg">
                                        <p class="text-[10px] text-on-surface-variant font-bold uppercase">Sugar Level</p>
                                        <p class="font-body-md text-body-md text-primary">50% (Half Sugar)</p>
                                    </div>
                                    <div class="bg-surface-container-low px-3 py-2 rounded-lg">
                                        <p class="text-[10px] text-on-surface-variant font-bold uppercase">Ice Level</p>
                                        <p class="font-body-md text-body-md text-primary">Less Ice</p>
                                    </div>
                                    <div class="col-span-2 bg-surface-container-low px-3 py-2 rounded-lg">
                                        <p class="text-[10px] text-on-surface-variant font-bold uppercase">Toppings</p>
                                        <div class="flex flex-wrap gap-1 mt-1">
                                            <span class="text-[11px] bg-secondary-container px-2 py-0.5 rounded italic">Golden Pearls</span>
                                            <span class="text-[11px] bg-secondary-container px-2 py-0.5 rounded italic">Cheese Foam</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Item 2 -->
                            <div class="space-y-3">
                                <div class="flex justify-between font-headline-md text-headline-md">
                                    <span class="text-primary">Matcha Cloud Latte</span>
                                    <span class="text-primary">Rs. 700</span>
                                </div>
                                <div class="grid grid-cols-2 gap-2">
                                    <div class="bg-surface-container-low px-3 py-2 rounded-lg">
                                        <p class="text-[10px] text-on-surface-variant font-bold uppercase">Sugar Level</p>
                                        <p class="font-body-md text-body-md text-primary">100% (Regular)</p>
                                    </div>
                                    <div class="bg-surface-container-low px-3 py-2 rounded-lg">
                                        <p class="text-[10px] text-on-surface-variant font-bold uppercase">Size</p>
                                        <p class="font-body-md text-body-md text-primary">Grande (L)</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Total -->
                        <div class="pt-6 border-t-2 border-dashed border-outline-variant">
                            <div class="flex justify-between items-center mb-6">
                                <p class="font-body-lg text-body-lg text-on-surface-variant">Grand Total</p>
                                <p class="font-headline-xl text-headline-xl text-primary">Rs. 1,450</p>
                            </div>
                            <div class="grid grid-cols-2 gap-4">
                                <button class="border border-primary text-primary px-4 py-3 rounded-xl font-label-md text-label-md hover:bg-primary hover:text-white transition-all">Print Receipt</button>
                                <button class="bg-secondary text-on-secondary px-4 py-3 rounded-xl font-label-md text-label-md hover:shadow-lg transition-all shadow-secondary/20">Ready for Pickup</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body></html>