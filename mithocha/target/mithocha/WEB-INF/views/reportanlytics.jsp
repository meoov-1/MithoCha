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
                        "secondary-fixed-dim": "#f0bd8b",
                        "tertiary-fixed": "#e4e3d7",
                        "surface-bright": "#fff8f6",
                        "error-container": "#ffdad6",
                        "on-tertiary-fixed": "#1b1c15",
                        "tertiary-container": "#34352d",
                        "on-primary-fixed": "#2e140a",
                        "on-background": "#271814",
                        "on-surface": "#271814",
                        "inverse-on-surface": "#ffede9",
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
                },
            },
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }
        .chart-bar-glow {
            box-shadow: 0 0 15px rgba(125, 86, 45, 0.1);
        }
        .custom-scrollbar::-webkit-scrollbar {
            width: 4px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
            background: transparent;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #d5c3bd;
            border-radius: 10px;
        }
    </style>
</head>
<body class="bg-background text-on-background font-body-md selection:bg-secondary-container">
<!-- SideNavBar Anchor -->
<aside class="hidden md:flex flex-col h-full py-6 bg-stone-50 border-r border-stone-200 h-screen w-64 fixed left-0 top-0 z-50 font-serif text-sm tracking-wide">
    <div class="px-6 mb-10">
        <h1 class="text-lg font-bold text-stone-900 font-serif">MithoCha Admin</h1>
        <p class="text-xs text-stone-500 font-body-md mt-1">Premium Bubble Tea</p>
    </div>
    <nav class="flex-1 space-y-1 px-3">
        <a class="flex items-center px-3 py-2.5 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined mr-3" data-icon="dashboard">dashboard</span>
            Dashboard
        </a>
        <a class="flex items-center px-3 py-2.5 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined mr-3" data-icon="bubble_chart">bubble_chart</span>
            Menu Management
        </a>
        <a class="flex items-center px-3 py-2.5 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined mr-3" data-icon="shopping_bag">shopping_bag</span>
            Orders
        </a>
        <a class="flex items-center px-3 py-2.5 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined mr-3" data-icon="group">group</span>
            Customers
        </a>
        <a class="flex items-center px-3 py-2.5 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined mr-3" data-icon="inventory_2">inventory_2</span>
            Inventory
        </a>
        <a class="flex items-center px-3 py-2.5 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined mr-3" data-icon="local_offer">local_offer</span>
            Offers &amp; Discounts
        </a>
        <a class="flex items-center px-3 py-2.5 text-amber-800 bg-amber-50 border-r-4 border-amber-600 font-semibold translate-x-1" href="#">
            <span class="material-symbols-outlined mr-3" data-icon="analytics">analytics</span>
            Analytics
        </a>
        <a class="flex items-center px-3 py-2.5 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined mr-3" data-icon="receipt_long">receipt_long</span>
            Invoices
        </a>
    </nav>
    <div class="px-3 mt-auto pt-6 border-t border-stone-100">
        <a class="flex items-center px-3 py-2 text-stone-500 hover:bg-stone-100" href="#">
            <span class="material-symbols-outlined mr-3" data-icon="help">help</span>
            Help Center
        </a>
        <a class="flex items-center px-3 py-2 text-stone-500 hover:bg-stone-100" href="#">
            <span class="material-symbols-outlined mr-3" data-icon="logout">logout</span>
            Logout
        </a>
    </div>
</aside>
<!-- Main Content Canvas -->
<main class="md:ml-64 min-h-screen">
    <!-- TopAppBar Anchor -->
    <header class="flex justify-between items-center px-6 py-3 w-full sticky top-0 bg-stone-50/80 backdrop-blur-md z-40 border-b border-stone-200 shadow-sm font-serif font-medium">
        <div class="flex items-center gap-4">
            <span class="md:hidden material-symbols-outlined text-stone-800" data-icon="menu">menu</span>
            <span class="text-xl font-bold text-stone-900 tracking-tight">MithoCha</span>
        </div>
        <div class="flex items-center gap-6">
            <div class="hidden sm:flex items-center bg-stone-100 rounded-full px-4 py-1.5 border border-stone-200">
                <span class="material-symbols-outlined text-stone-400 text-sm" data-icon="search">search</span>
                <input class="bg-transparent border-none focus:ring-0 text-sm font-body-md w-48 text-stone-800" placeholder="Search data..." type="text"/>
            </div>
            <div class="flex items-center gap-3">
                <button class="p-2 text-stone-500 hover:bg-stone-100 transition-colors rounded-full relative">
                    <span class="material-symbols-outlined" data-icon="notifications">notifications</span>
                    <span class="absolute top-2 right-2 w-2 h-2 bg-secondary rounded-full border-2 border-stone-50"></span>
                </button>
                <button class="p-2 text-stone-500 hover:bg-stone-100 transition-colors rounded-full">
                    <span class="material-symbols-outlined" data-icon="settings">settings</span>
                </button>
                <img alt="Admin profile" class="w-8 h-8 rounded-full border border-stone-300" data-alt="Close-up portrait of a professional man in his 30s with a kind expression and warm lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuABYay2jYhZO5Cc_EmE_76hEa6Swc7AX8egeEDT5wvsOeAj7tig_yJjdkIM09_sQT3ARkNGKKqcBNuv_xpxNWjNbfN3sI7dXe2LabYlnrU6yuAaenSmKFft7XvwR93U8Et_hEEzze_mkaIHJrTNUfZWhM2eycS8i3_rF-U2Q2K6dIadqfHlmn-NC9p10q3t4OsO0Wq6vMd0rC3m8ATIpSmlsPNoioXcDkzpHC7MbrEUAAZ5xJYfxwwSeUkDnMHWYdwdGVVniXl1fDH-"/>
            </div>
        </div>
    </header>
    <!-- Analytics Content -->
    <div class="p-6 md:p-10 max-w-container-max mx-auto">
        <!-- Header Section -->
        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-12">
            <div>
                <h2 class="font-headline-xl text-primary mb-2">Business Intelligence</h2>
                <p class="text-body-lg text-on-surface-variant max-w-2xl">Visualizing your premium bubble tea performance. Track sales velocity, customer acquisition, and flavor trends.</p>
            </div>
            <div class="flex gap-3">
                <div class="flex bg-surface-container rounded-lg p-1">
                    <button class="px-4 py-1.5 rounded text-label-md bg-white shadow-sm text-secondary">Daily</button>
                    <button class="px-4 py-1.5 rounded text-label-md text-on-surface-variant hover:text-secondary">Weekly</button>
                    <button class="px-4 py-1.5 rounded text-label-md text-on-surface-variant hover:text-secondary">Monthly</button>
                </div>
                <button class="bg-secondary text-on-secondary px-6 py-2 rounded-lg text-label-md flex items-center gap-2 hover:opacity-90 transition-opacity">
                    <span class="material-symbols-outlined text-sm" data-icon="download">download</span>
                    Export Report
                </button>
            </div>
        </div>
        <!-- Bento Grid - Key Metrics -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-12">
            <div class="bg-white p-6 rounded-xl shadow-[0_10px_30px_rgba(75,44,32,0.05)] border-l-4 border-secondary">
                <p class="text-label-md text-on-surface-variant mb-1">Total Sales</p>
                <h3 class="text-headline-md text-primary">Rs. 4,28,500</h3>
                <div class="flex items-center gap-1 mt-2 text-green-600 text-sm font-medium">
                    <span class="material-symbols-outlined text-sm" data-icon="trending_up">trending_up</span>
                    12.5% vs last month
                </div>
            </div>
            <div class="bg-white p-6 rounded-xl shadow-[0_10px_30px_rgba(75,44,32,0.05)] border-l-4 border-on-primary-container">
                <p class="text-label-md text-on-surface-variant mb-1">Average Order Value</p>
                <h3 class="text-headline-md text-primary">Rs. 540</h3>
                <div class="flex items-center gap-1 mt-2 text-green-600 text-sm font-medium">
                    <span class="material-symbols-outlined text-sm" data-icon="trending_up">trending_up</span>
                    4.2% from peak
                </div>
            </div>
            <div class="bg-white p-6 rounded-xl shadow-[0_10px_30px_rgba(75,44,32,0.05)] border-l-4 border-on-tertiary-container">
                <p class="text-label-md text-on-surface-variant mb-1">New Customers</p>
                <h3 class="text-headline-md text-primary">1,204</h3>
                <div class="flex items-center gap-1 mt-2 text-green-600 text-sm font-medium">
                    <span class="material-symbols-outlined text-sm" data-icon="person_add">person_add</span>
                    18% month over month
                </div>
            </div>
            <div class="bg-white p-6 rounded-xl shadow-[0_10px_30px_rgba(75,44,32,0.05)] border-l-4 border-outline">
                <p class="text-label-md text-on-surface-variant mb-1">Satisfaction Score</p>
                <h3 class="text-headline-md text-primary">4.8/5.0</h3>
                <div class="flex items-center gap-1 mt-2 text-amber-600 text-sm font-medium">
                    <span class="material-symbols-outlined text-sm" data-icon="stars">stars</span>
                    Top 5% in category
                </div>
            </div>
        </div>
        <!-- Main Charts Row -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-12">
            <!-- Sales Trend Area Chart Placeholder -->
            <div class="lg:col-span-2 bg-white p-8 rounded-xl shadow-[0_10px_30px_rgba(75,44,32,0.05)]">
                <div class="flex justify-between items-center mb-8">
                    <div>
                        <h4 class="text-headline-md text-primary">Revenue Trends</h4>
                        <p class="text-body-md text-on-surface-variant">Daily performance across all outlets</p>
                    </div>
                    <div class="flex gap-2">
<span class="flex items-center gap-1 text-xs font-semibold uppercase tracking-wider text-secondary">
<span class="w-3 h-3 rounded-full bg-secondary"></span> Online
                            </span>
                        <span class="flex items-center gap-1 text-xs font-semibold uppercase tracking-wider text-outline">
<span class="w-3 h-3 rounded-full bg-outline"></span> In-Store
                            </span>
                    </div>
                </div>
                <div class="h-64 relative flex items-end justify-between gap-2 border-b border-stone-100 pb-2">
                    <!-- Simulated Chart Bars with Tonal Layering -->
                    <div class="w-full flex items-end justify-between gap-1 px-4">
                        <div class="w-full bg-surface-container-highest/40 rounded-t-lg transition-all hover:bg-surface-container-highest" style="height: 40%;"></div>
                        <div class="w-full bg-surface-container-highest/40 rounded-t-lg transition-all hover:bg-surface-container-highest" style="height: 55%;"></div>
                        <div class="w-full bg-secondary/80 rounded-t-lg transition-all hover:bg-secondary chart-bar-glow" style="height: 75%;"></div>
                        <div class="w-full bg-surface-container-highest/40 rounded-t-lg transition-all hover:bg-surface-container-highest" style="height: 45%;"></div>
                        <div class="w-full bg-surface-container-highest/40 rounded-t-lg transition-all hover:bg-surface-container-highest" style="height: 60%;"></div>
                        <div class="w-full bg-secondary/80 rounded-t-lg transition-all hover:bg-secondary chart-bar-glow" style="height: 85%;"></div>
                        <div class="w-full bg-surface-container-highest/40 rounded-t-lg transition-all hover:bg-surface-container-highest" style="height: 50%;"></div>
                        <div class="w-full bg-surface-container-highest/40 rounded-t-lg transition-all hover:bg-surface-container-highest" style="height: 65%;"></div>
                        <div class="w-full bg-secondary/80 rounded-t-lg transition-all hover:bg-secondary chart-bar-glow" style="height: 95%;"></div>
                        <div class="w-full bg-surface-container-highest/40 rounded-t-lg transition-all hover:bg-surface-container-highest" style="height: 70%;"></div>
                        <div class="w-full bg-surface-container-highest/40 rounded-t-lg transition-all hover:bg-surface-container-highest" style="height: 55%;"></div>
                        <div class="w-full bg-secondary/80 rounded-t-lg transition-all hover:bg-secondary chart-bar-glow" style="height: 80%;"></div>
                    </div>
                    <!-- Axis Labels -->
                    <div class="absolute -bottom-6 w-full flex justify-between text-[10px] uppercase font-semibold text-stone-400">
                        <span>Mon</span><span>Tue</span><span>Wed</span><span>Thu</span><span>Fri</span><span>Sat</span><span>Sun</span>
                    </div>
                </div>
            </div>
            <!-- Popular Flavors -->
            <div class="bg-white p-8 rounded-xl shadow-[0_10px_30px_rgba(75,44,32,0.05)] flex flex-col">
                <h4 class="text-headline-md text-primary mb-1">Most Popular</h4>
                <p class="text-body-md text-on-surface-variant mb-8">Top flavor profiles this week</p>
                <div class="space-y-6 flex-1 overflow-y-auto custom-scrollbar pr-2">
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 rounded-full bg-secondary-container flex items-center justify-center text-secondary font-bold">#1</div>
                        <div class="flex-1">
                            <div class="flex justify-between items-center mb-1">
                                <span class="text-label-md text-primary">Royal Assam Milk Tea</span>
                                <span class="text-xs font-semibold text-secondary">32%</span>
                            </div>
                            <div class="w-full bg-stone-100 h-1.5 rounded-full overflow-hidden">
                                <div class="bg-secondary h-full rounded-full" style="width: 85%;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 rounded-full bg-surface-container flex items-center justify-center text-on-primary-container font-bold">#2</div>
                        <div class="flex-1">
                            <div class="flex justify-between items-center mb-1">
                                <span class="text-label-md text-primary">Honeydew Melon Burst</span>
                                <span class="text-xs font-semibold text-on-primary-container">24%</span>
                            </div>
                            <div class="w-full bg-stone-100 h-1.5 rounded-full overflow-hidden">
                                <div class="bg-on-primary-container h-full rounded-full" style="width: 65%;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 rounded-full bg-stone-100 flex items-center justify-center text-stone-400 font-bold">#3</div>
                        <div class="flex-1">
                            <div class="flex justify-between items-center mb-1">
                                <span class="text-label-md text-primary">Classic Taro Slush</span>
                                <span class="text-xs font-semibold text-stone-500">18%</span>
                            </div>
                            <div class="w-full bg-stone-100 h-1.5 rounded-full overflow-hidden">
                                <div class="bg-stone-300 h-full rounded-full" style="width: 45%;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="flex items-center gap-4 opacity-70">
                        <div class="w-12 h-12 rounded-full bg-stone-50 flex items-center justify-center text-stone-300 font-bold">#4</div>
                        <div class="flex-1">
                            <div class="flex justify-between items-center mb-1">
                                <span class="text-label-md text-primary">Brown Sugar Boba</span>
                                <span class="text-xs font-semibold text-stone-400">12%</span>
                            </div>
                            <div class="w-full bg-stone-50 h-1.5 rounded-full overflow-hidden">
                                <div class="bg-stone-200 h-full rounded-full" style="width: 30%;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="mt-8 text-secondary font-semibold text-sm flex items-center justify-center gap-1 hover:underline">
                    View full flavor audit <span class="material-symbols-outlined text-sm" data-icon="arrow_forward">arrow_forward</span>
                </button>
            </div>
        </div>
        <!-- Bottom Row: Customer Growth & Activity -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
            <!-- Customer Growth -->
            <div class="bg-white p-8 rounded-xl shadow-[0_10px_30px_rgba(75,44,32,0.05)] border border-stone-50 relative overflow-hidden">
                <div class="relative z-10">
                    <h4 class="text-headline-md text-primary mb-1">Customer Velocity</h4>
                    <p class="text-body-md text-on-surface-variant mb-6">Retention and acquisition rate</p>
                    <div class="flex items-center gap-12">
                        <div class="flex flex-col">
                            <span class="text-3xl font-bold text-primary">82%</span>
                            <span class="text-xs text-on-surface-variant uppercase tracking-tighter">Retention Rate</span>
                        </div>
                        <div class="flex flex-col border-l border-stone-200 pl-8">
                            <span class="text-3xl font-bold text-primary">+412</span>
                            <span class="text-xs text-on-surface-variant uppercase tracking-tighter">New This Week</span>
                        </div>
                    </div>
                    <div class="mt-10 pt-6 border-t border-stone-100">
                        <div class="flex justify-between items-center text-sm mb-4">
                            <span class="text-stone-500 italic">"The Loyalty program launched in Feb has increased repeat visits by 22%."</span>
                        </div>
                        <div class="flex -space-x-3">
                            <img class="w-10 h-10 rounded-full border-2 border-white" data-alt="Close-up face of a young woman with a genuine smile and natural outdoor lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDfm2VUDUWQqtZPRRO3n1v5zoIkUpoKjDuukpPtcj19P77yS58gBQZ3C1sJqfKjK26So5vcO2_fkH5walRLEUbVmHLVRcoKOUFrH-NY8CnPJZyDQzgBjuWTTHLXzM0V3l_0l7BQBLbgrvn4n-qjOhZ2XEsHptBi-veH7Qd8fkXG8BkVpEcaHC5WtQnwgY3NOM3TG7F3d6rEGjDQXhvPBN-W3vsG9_-lC0pI6PxRXtq567tYLGiCXN-bM9xhIB0HsfmYHnFSRk3KCJvC"/>
                            <img class="w-10 h-10 rounded-full border-2 border-white" data-alt="Portrait of a young man with glasses and trendy hairstyle in a soft-lit indoor setting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuANzqa5vncK63Ve9Zndyd2a0DpUMINXu8P6knf3FjlRU4BjEYzslcuAx48eJZcqqh5cyqgnU7Ze-TMksPEz5Pe1wJ0tJcYIblJ8GJItbQJfuMrffDgPmjZYCc0wuF2roHgZkcLldqvCeFcH8oukKjIMMX5Azx19YG_OFemG6pdZgN5P1jaH-GPoaiIc6XacKVNN7QMmuqsuXzqXy4u_KKqibbcVO0KZEJKI11rsOFCpNPwI703Sw1H4S74Dxip_p1Vdi6_Wcmu1KQyJ"/>
                            <img class="w-10 h-10 rounded-full border-2 border-white" data-alt="Close-up of a smiling woman with a creative background and natural soft focus" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD7oFLuZnfgwbdhQXqycDIdPoOyjIX7diuqwxH5yStFJMhNGpDbT1Qi4Fr7FMEDLdyUsXKus-qcXZkGpxM-AU7XAEtC-09IlnghYvGYBcy86vUGtcfppukdZtxIu_1NX31Pic5RY4idXEIH27EKa4afDiXUqZHwQHe2ayioub7speeZ_aszah0eOMj_DA-W880cS_yzBup2SZjmQaFuzufBg4ejTKqx0MjWQakrSFaq7u86o2wBbQj7kl_heGDm3H50iTdXszsPczq7"/>
                            <div class="w-10 h-10 rounded-full bg-secondary-container border-2 border-white flex items-center justify-center text-xs font-bold text-secondary">+1k</div>
                        </div>
                    </div>
                </div>
                <!-- Decorative Graphic -->
                <div class="absolute -right-10 -bottom-10 w-40 h-40 bg-secondary/5 rounded-full"></div>
            </div>
            <!-- Demographic Insights - Specialized Cards -->
            <div class="grid grid-cols-2 gap-4">
                <div class="bg-surface-container p-6 rounded-xl flex flex-col justify-between">
                    <span class="material-symbols-outlined text-secondary text-3xl" data-icon="schedule" data-weight="fill" style="font-variation-settings: 'FILL' 1;">schedule</span>
                    <div>
                        <p class="text-label-md text-on-secondary-container mb-1">Peak Hours</p>
                        <h5 class="text-headline-md text-primary">4 PM - 7 PM</h5>
                        <p class="text-xs text-on-surface-variant mt-2">65% of daily revenue generated</p>
                    </div>
                </div>
                <div class="bg-on-primary-container/10 p-6 rounded-xl flex flex-col justify-between">
                    <span class="material-symbols-outlined text-primary-container text-3xl" data-icon="map" data-weight="fill" style="font-variation-settings: 'FILL' 1;">map</span>
                    <div>
                        <p class="text-label-md text-on-primary-container mb-1">Top Region</p>
                        <h5 class="text-headline-md text-primary">Durbar Marg</h5>
                        <p class="text-xs text-on-surface-variant mt-2">Outperforming other stores by 14%</p>
                    </div>
                </div>
                <div class="bg-surface-container-highest p-6 rounded-xl col-span-2 flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 bg-white rounded-lg flex items-center justify-center shadow-sm">
                            <span class="material-symbols-outlined text-secondary" data-icon="coffee_maker">coffee_maker</span>
                        </div>
                        <div>
                            <h6 class="text-label-md text-primary">Brew Efficiency</h6>
                            <p class="text-xs text-on-surface-variant">Avg. preparation time: 3.2 min</p>
                        </div>
                    </div>
                    <div class="text-right">
                        <div class="text-green-600 font-bold">-18s</div>
                        <p class="text-[10px] uppercase text-on-surface-variant">vs last month</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- Floating Action Button (FAB) - Suppressed as per instructions for Analytics page -->
</body></html>