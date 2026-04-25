<%--
  Created by IntelliJ IDEA.
  User: timil
  Date: 4/25/2026
  Time: 11:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html class="light" lang="en"><head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@600;700&amp;family=Be+Vietnam+Pro:wght@400;600&amp;display=swap" rel="stylesheet"/>
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
                    "spacing": {
                        "unit": "8px",
                        "gutter": "24px",
                        "margin-desktop": "64px",
                        "container-max": "1200px",
                        "margin-mobile": "20px"
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
        }
        .brew-progress {
            background: linear-gradient(90deg, #ffca98 0%, #7d562d 100%);
        }
        .glass-card {
            background: rgba(255, 248, 246, 0.6);
            backdrop-filter: blur(12px);
        }
    </style>
</head>
<body class="bg-surface text-on-surface font-body-md selection:bg-secondary-container selection:text-on-secondary-container">
<!-- SideNavBar Shell -->
<aside class="h-screen w-64 border-r fixed left-0 top-0 z-50 bg-stone-50 border-stone-200 flex flex-col py-6">
    <div class="px-6 mb-10">
        <h1 class="text-lg font-bold text-stone-900 font-serif">MithoCha Admin</h1>
        <p class="text-stone-500 text-xs font-serif uppercase tracking-widest mt-1">Premium Bubble Tea</p>
    </div>
    <nav class="flex-1 space-y-1 px-3">
        <!-- 1. Dashboard -->
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide transition-transform duration-200 hover:translate-x-1" href="#">
            <span class="material-symbols-outlined" data-icon="dashboard">dashboard</span>
            <span>Dashboard</span>
        </a>
        <!-- 2. Menu Management -->
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide transition-transform duration-200 hover:translate-x-1" href="#">
            <span class="material-symbols-outlined" data-icon="bubble_chart">bubble_chart</span>
            <span>Menu Management</span>
        </a>
        <!-- 3. Orders -->
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide transition-transform duration-200 hover:translate-x-1" href="#">
            <span class="material-symbols-outlined" data-icon="shopping_bag">shopping_bag</span>
            <span>Orders</span>
        </a>
        <!-- 4. Customers -->
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide transition-transform duration-200 hover:translate-x-1" href="#">
            <span class="material-symbols-outlined" data-icon="group">group</span>
            <span>Customers</span>
        </a>
        <!-- 5. Inventory (Active Tab) -->
        <a class="flex items-center gap-3 px-3 py-2 text-amber-800 bg-amber-50 border-r-4 border-amber-600 font-serif text-sm tracking-wide transition-transform duration-200 hover:translate-x-1" href="#">
            <span class="material-symbols-outlined" data-icon="inventory_2" style="font-variation-settings: 'FILL' 1;">inventory_2</span>
            <span class="font-semibold">Inventory</span>
        </a>
        <!-- 6. Offers & Discounts -->
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide transition-transform duration-200 hover:translate-x-1" href="#">
            <span class="material-symbols-outlined" data-icon="local_offer">local_offer</span>
            <span>Offers &amp; Discounts</span>
        </a>
        <!-- 7. Analytics -->
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide transition-transform duration-200 hover:translate-x-1" href="#">
            <span class="material-symbols-outlined" data-icon="analytics">analytics</span>
            <span>Analytics</span>
        </a>
        <!-- 8. Invoices -->
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide transition-transform duration-200 hover:translate-x-1" href="#">
            <span class="material-symbols-outlined" data-icon="receipt_long">receipt_long</span>
            <span>Invoices</span>
        </a>
    </nav>
    <div class="px-3 border-t border-stone-200 pt-6 space-y-1">
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide transition-transform duration-200 hover:translate-x-1" href="#">
            <span class="material-symbols-outlined" data-icon="help">help</span>
            <span>Help Center</span>
        </a>
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide transition-transform duration-200 hover:translate-x-1" href="#">
            <span class="material-symbols-outlined" data-icon="logout">logout</span>
            <span>Logout</span>
        </a>
    </div>
</aside>
<!-- TopAppBar Shell -->
<header class="ml-64 flex justify-between items-center px-6 py-3 w-[calc(100%-256px)] sticky top-0 bg-stone-50/80 backdrop-blur-md z-40 border-b border-stone-200 shadow-sm">
    <div class="flex items-center flex-1 max-w-md">
        <div class="relative w-full">
            <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-stone-400">search</span>
            <input class="w-full bg-stone-100/50 border-none rounded-full py-2 pl-10 pr-4 focus:ring-2 focus:ring-amber-200 text-sm font-body-md" placeholder="Search inventory..." type="text"/>
        </div>
    </div>
    <div class="flex items-center gap-4">
        <button class="p-2 text-stone-500 hover:bg-stone-100 rounded-full transition-colors">
            <span class="material-symbols-outlined" data-icon="notifications">notifications</span>
        </button>
        <button class="p-2 text-stone-500 hover:bg-stone-100 rounded-full transition-colors">
            <span class="material-symbols-outlined" data-icon="settings">settings</span>
        </button>
        <div class="h-8 w-8 rounded-full overflow-hidden border border-stone-200 ml-2">
            <img alt="Admin profile" class="h-full w-full object-cover" data-alt="Close up portrait of a professional manager with a kind expression in a bright modern office environment" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB1746_rAC9ujTeA31-8S-16sshHQejOb78jG46MazMq9r2kUojtPS7oaH5v5vE-qbm_QhfhVq6Y7WvDyftuyWW1j1LFIDM3t2z9F-9eumh40pYR14kt3wflI1E2KKzztUMpJBKo_84Rz1K5ocn8qDXRVU5p4MIeR68h3chX94q4P9UL0Hk3aeA8YWZFJOYwF2163OddpLjRwL1N6d5eNWpUXEeFKBm8UTfjTMjdI_pP5IrqbytAkk0J3fU5_8sPGTbMasjCozrmlSG"/>
        </div>
    </div>
</header>
<!-- Main Content -->
<main class="ml-64 p-10 max-w-[1400px] mx-auto">
    <!-- Page Header -->
    <header class="mb-12 flex justify-between items-end">
        <div>
            <h2 class="font-headline-xl text-primary mb-2">Inventory &amp; Stock</h2>
            <p class="text-on-surface-variant font-body-lg">Manage your premium raw materials and track brewing essentials.</p>
        </div>
        <button class="bg-secondary text-on-secondary px-6 py-3 rounded-xl font-label-md flex items-center gap-2 hover:opacity-90 transition-all active:scale-95 shadow-lg shadow-secondary/10">
            <span class="material-symbols-outlined" data-icon="add">add</span>
            Add New Batch
        </button>
    </header>
    <!-- Summary Bento Grid -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-12">
        <!-- Alert Card -->
        <div class="md:col-span-2 bg-error-container/30 border border-error-container p-6 rounded-2xl flex flex-col justify-between">
            <div>
                <div class="flex items-center gap-2 text-error mb-4">
                    <span class="material-symbols-outlined" data-icon="warning">warning</span>
                    <span class="font-label-md">CRITICAL ALERTS</span>
                </div>
                <p class="text-on-error-container text-headline-md font-headline-md mb-2">3 Items Below Threshold</p>
                <p class="text-on-error-container/80 text-body-md">Black Tapioca Pearls and Oat Milk are running low. Order replenishment soon to avoid stockouts.</p>
            </div>
            <div class="mt-6 flex gap-3">
                <button class="bg-error text-on-error px-4 py-2 rounded-lg text-sm font-label-md">Reorder Now</button>
                <button class="text-on-error-container px-4 py-2 text-sm font-label-md hover:underline">Dismiss</button>
            </div>
        </div>
        <!-- Stats Card 1 -->
        <div class="bg-surface-container-high p-6 rounded-2xl border border-outline-variant flex flex-col justify-center">
            <span class="text-on-primary-container/60 font-label-md uppercase tracking-widest mb-2">Total Materials</span>
            <span class="text-primary text-headline-xl font-headline-xl">124</span>
            <div class="mt-2 flex items-center text-green-700 text-xs font-label-md">
                <span class="material-symbols-outlined text-sm mr-1" data-icon="arrow_upward">arrow_upward</span>
                12% from last month
            </div>
        </div>
        <!-- Stats Card 2 -->
        <div class="bg-surface-container p-6 rounded-2xl border border-outline-variant flex flex-col justify-center">
            <span class="text-on-primary-container/60 font-label-md uppercase tracking-widest mb-2">Stock Value</span>
            <span class="text-primary text-headline-xl font-headline-xl">$4,290</span>
            <div class="mt-2 text-on-primary-container/50 text-xs font-label-md">Updated 2 hours ago</div>
        </div>
    </div>
    <!-- Filter Tabs -->
    <div class="flex gap-4 mb-8 overflow-x-auto pb-2 scrollbar-hide">
        <button class="px-6 py-2 rounded-full bg-secondary text-on-secondary font-label-md whitespace-nowrap">All Materials</button>
        <button class="px-6 py-2 rounded-full bg-surface-container-low text-on-surface-variant font-label-md whitespace-nowrap hover:bg-surface-container-high">Tea Leaves</button>
        <button class="px-6 py-2 rounded-full bg-surface-container-low text-on-surface-variant font-label-md whitespace-nowrap hover:bg-surface-container-high">Pearls &amp; Toppings</button>
        <button class="px-6 py-2 rounded-full bg-surface-container-low text-on-surface-variant font-label-md whitespace-nowrap hover:bg-surface-container-high">Milk &amp; Dairy</button>
        <button class="px-6 py-2 rounded-full bg-surface-container-low text-on-surface-variant font-label-md whitespace-nowrap hover:bg-surface-container-high">Syrups &amp; Honey</button>
    </div>
    <!-- Inventory List -->
    <div class="grid grid-cols-1 gap-4">
        <!-- Item Row: Black Pearls -->
        <div class="group bg-surface-container-low border border-transparent hover:border-outline-variant hover:bg-surface-container-high transition-all p-4 rounded-2xl flex items-center gap-6">
            <div class="h-16 w-16 rounded-xl overflow-hidden flex-shrink-0 bg-primary-container/10">
                <img alt="Tapioca Pearls" class="h-full w-full object-cover" data-alt="Macro photography of shiny black tapioca pearls in a glass bowl with soft cinematic lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuADiHHTHf0ERRmCmKKi-l6T47LNMskai-tMm6QqjkruaNLlqqd1ziqFTY0mbucIXoG2XnB2LmXkdqKUq5STeb3fj1VqsQDtT4F_tm-4htpC6zcXE_oFIf5pL-tSPCHVrh9RYYG6uha_ULfIH9WHKtayr_tM9Yb0stZAZq5rPYOksFIWxbPz3k-PLNYccrTNhtjHuWkKY8hJGkvrKtqxzEMCNQUXUELYCW_aZ75TewQVH0dsDuCKae7OsSRQCVz9hiOBLV4mwCP6_S5J"/>
            </div>
            <div class="flex-1">
                <div class="flex items-center gap-3 mb-1">
                    <h4 class="font-headline-md text-primary">Black Tapioca Pearls</h4>
                    <span class="bg-error/10 text-error px-2 py-0.5 rounded text-[10px] font-label-md border border-error/20">LOW STOCK</span>
                </div>
                <div class="flex items-center gap-4">
                    <span class="text-xs italic text-on-surface-variant font-serif">Nutty, Chewy, Sweet</span>
                    <div class="h-1 w-1 rounded-full bg-outline-variant"></div>
                    <span class="text-xs font-label-md text-on-surface-variant">Batch #442-B</span>
                </div>
            </div>
            <div class="w-64 px-4">
                <div class="flex justify-between text-xs font-label-md text-on-surface-variant mb-2">
                    <span>STOCK LEVEL</span>
                    <span>12 / 100 kg</span>
                </div>
                <div class="w-full bg-surface-container-highest h-2 rounded-full overflow-hidden">
                    <div class="bg-error h-full rounded-full" style="width: 12%"></div>
                </div>
            </div>
            <div class="text-right pr-4">
                <div class="text-xs font-label-md text-on-surface-variant">SUPPLIER</div>
                <div class="text-sm font-body-md text-primary">Formosa Exports</div>
            </div>
            <button class="p-2 text-on-surface-variant hover:bg-white rounded-lg transition-colors group-hover:shadow-sm">
                <span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
            </button>
        </div>
        <!-- Item Row: Oolong Tea -->
        <div class="group bg-surface-container-low border border-transparent hover:border-outline-variant hover:bg-surface-container-high transition-all p-4 rounded-2xl flex items-center gap-6">
            <div class="h-16 w-16 rounded-xl overflow-hidden flex-shrink-0 bg-primary-container/10">
                <img alt="Oolong Tea" class="h-full w-full object-cover" data-alt="Dried oolong tea leaves on a bamboo mat with elegant morning sunlight" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD-Vqaw0TB2zFqiSsuTd2UTVBWtNkja7nlBhP1yfJeNlrnq1VmxmfkCYU0RugvVaCM1b4QB-FFEpfLFq4PAJPfUv36tak9DzZgGG7KxavKRmbBbIelvESAGLxN293OkCQg_005QOnPD-nH5iptXzLRjxfcubDugVvrHGAf4DCGvaZ7DA7klrFN9hTSBQZ34F6fZ5IWXD-oz0Iex4-tBX5Yva6iC4dC75EIugcfwIfqidt_Ik6Pkfku6QLrQEuAn5zKW9w8lqAQ2LTOn"/>
            </div>
            <div class="flex-1">
                <div class="flex items-center gap-3 mb-1">
                    <h4 class="font-headline-md text-primary">Premium Oolong Leaves</h4>
                    <span class="bg-secondary-container text-on-secondary-container px-2 py-0.5 rounded text-[10px] font-label-md">IN STOCK</span>
                </div>
                <div class="flex items-center gap-4">
                    <span class="text-xs italic text-on-surface-variant font-serif">Floral, Woody, Smooth</span>
                    <div class="h-1 w-1 rounded-full bg-outline-variant"></div>
                    <span class="text-xs font-label-md text-on-surface-variant">Batch #O-982</span>
                </div>
            </div>
            <div class="w-64 px-4">
                <div class="flex justify-between text-xs font-label-md text-on-surface-variant mb-2">
                    <span>STOCK LEVEL</span>
                    <span>45 / 50 kg</span>
                </div>
                <div class="w-full bg-surface-container-highest h-2 rounded-full overflow-hidden">
                    <div class="brew-progress h-full rounded-full" style="width: 90%"></div>
                </div>
            </div>
            <div class="text-right pr-4">
                <div class="text-xs font-label-md text-on-surface-variant">SUPPLIER</div>
                <div class="text-sm font-body-md text-primary">Alishan Highlands</div>
            </div>
            <button class="p-2 text-on-surface-variant hover:bg-white rounded-lg transition-colors group-hover:shadow-sm">
                <span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
            </button>
        </div>
        <!-- Item Row: Oat Milk -->
        <div class="group bg-surface-container-low border border-transparent hover:border-outline-variant hover:bg-surface-container-high transition-all p-4 rounded-2xl flex items-center gap-6">
            <div class="h-16 w-16 rounded-xl overflow-hidden flex-shrink-0 bg-primary-container/10">
                <img alt="Oat Milk" class="h-full w-full object-cover" data-alt="A minimalist white carton of oat milk on a warm cream surface with soft shadows" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDbhx8Nu1EvYbnqMGQ7EgsjxsBFHcKXanfDw5OQtCG0L0nRsk0J_nhjBwZzyotkJvFQdF9QOZF_9ql69AvRdP9IRLdQhgjAtYwXSwLl0vylSJgmoYdsJ5Q_CBRoCQxBA7Ri1hw7mL0CmCyNkAGaYuv-P-j8va7V-N1pEMH0vEOj9l_O8KfQHchNPiXmZ9c1xtkx2GcmqHQD0wD-txpCCUO0w1L2ODiXeqh7e0N78RJJ5PdkDR7BpPC56L1bMbxdcQb_bmcQNWm9GMcs"/>
            </div>
            <div class="flex-1">
                <div class="flex items-center gap-3 mb-1">
                    <h4 class="font-headline-md text-primary">Barista Oat Milk</h4>
                    <span class="bg-error/10 text-error px-2 py-0.5 rounded text-[10px] font-label-md border border-error/20">LOW STOCK</span>
                </div>
                <div class="flex items-center gap-4">
                    <span class="text-xs italic text-on-surface-variant font-serif">Creamy, Neutral, Sustainable</span>
                    <div class="h-1 w-1 rounded-full bg-outline-variant"></div>
                    <span class="text-xs font-label-md text-on-surface-variant">Batch #OM-221</span>
                </div>
            </div>
            <div class="w-64 px-4">
                <div class="flex justify-between text-xs font-label-md text-on-surface-variant mb-2">
                    <span>STOCK LEVEL</span>
                    <span>42 / 200 L</span>
                </div>
                <div class="w-full bg-surface-container-highest h-2 rounded-full overflow-hidden">
                    <div class="bg-error h-full rounded-full" style="width: 21%"></div>
                </div>
            </div>
            <div class="text-right pr-4">
                <div class="text-xs font-label-md text-on-surface-variant">SUPPLIER</div>
                <div class="text-sm font-body-md text-primary">OatLy Distribution</div>
            </div>
            <button class="p-2 text-on-surface-variant hover:bg-white rounded-lg transition-colors group-hover:shadow-sm">
                <span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
            </button>
        </div>
        <!-- Item Row: Wildflower Honey -->
        <div class="group bg-surface-container-low border border-transparent hover:border-outline-variant hover:bg-surface-container-high transition-all p-4 rounded-2xl flex items-center gap-6">
            <div class="h-16 w-16 rounded-xl overflow-hidden flex-shrink-0 bg-primary-container/10">
                <img alt="Honey" class="h-full w-full object-cover" data-alt="Golden honey dripping from a wooden dipper into a crystal jar with warm backlit glow" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCST44nVGGPKgkSLsSBq4KeEMskG1qopTBVDEX2zpvAzVrJUK2aS-sUTGXVf4Sr33dXHQJcGvFGIHtAdJVCYChoW9zbJyLGObBHsi2SpBPxfdQVXYDGByGnXUwTdvo9_3Ibdm-L1brkosSYsXRxR6DvUnmSdI3YUmHjPeQtN29kGX-99A0stanbpslm2kpsa9rv_W75nxItT3yDx0kBhZRW_l7JPYHFELxSCChQFG7fAXaxka6tp3Pu_seHhc-qkXDAWh43T3EH9eDn"/>
            </div>
            <div class="flex-1">
                <div class="flex items-center gap-3 mb-1">
                    <h4 class="font-headline-md text-primary">Organic Wildflower Honey</h4>
                    <span class="bg-secondary-container text-on-secondary-container px-2 py-0.5 rounded text-[10px] font-label-md">IN STOCK</span>
                </div>
                <div class="flex items-center gap-4">
                    <span class="text-xs italic text-on-surface-variant font-serif">Intense, Sweet, Golden</span>
                    <div class="h-1 w-1 rounded-full bg-outline-variant"></div>
                    <span class="text-xs font-label-md text-on-surface-variant">Batch #H-11</span>
                </div>
            </div>
            <div class="w-64 px-4">
                <div class="flex justify-between text-xs font-label-md text-on-surface-variant mb-2">
                    <span>STOCK LEVEL</span>
                    <span>18 / 25 kg</span>
                </div>
                <div class="w-full bg-surface-container-highest h-2 rounded-full overflow-hidden">
                    <div class="brew-progress h-full rounded-full" style="width: 72%"></div>
                </div>
            </div>
            <div class="text-right pr-4">
                <div class="text-xs font-label-md text-on-surface-variant">SUPPLIER</div>
                <div class="text-sm font-body-md text-primary">Valley Apiaries</div>
            </div>
            <button class="p-2 text-on-surface-variant hover:bg-white rounded-lg transition-colors group-hover:shadow-sm">
                <span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
            </button>
        </div>
    </div>
    <!-- Inventory Movement Chart Area (Static Visual Representation) -->
    <div class="mt-12 grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div class="lg:col-span-2 bg-surface-container-high border border-outline-variant rounded-3xl p-8 relative overflow-hidden">
            <div class="flex justify-between items-start mb-8">
                <div>
                    <h3 class="font-headline-md text-primary">Stock Forecast</h3>
                    <p class="text-on-surface-variant text-sm">Predicted usage based on seasonal trends.</p>
                </div>
                <select class="bg-white/50 border-outline-variant rounded-lg text-xs font-label-md px-3 py-1">
                    <option>Next 7 Days</option>
                    <option>Next 30 Days</option>
                </select>
            </div>
            <!-- Stylized Placeholder for a Chart -->
            <div class="h-48 w-full flex items-end gap-3 px-4">
                <div class="flex-1 bg-secondary-container/40 h-[60%] rounded-t-lg"></div>
                <div class="flex-1 bg-secondary-container/60 h-[85%] rounded-t-lg"></div>
                <div class="flex-1 bg-secondary h-[40%] rounded-t-lg"></div>
                <div class="flex-1 bg-secondary-container/40 h-[65%] rounded-t-lg"></div>
                <div class="flex-1 bg-secondary h-[95%] rounded-t-lg relative">
                    <div class="absolute -top-10 left-1/2 -translate-x-1/2 bg-primary text-white text-[10px] px-2 py-1 rounded">Peak Peak</div>
                </div>
                <div class="flex-1 bg-secondary-container/60 h-[75%] rounded-t-lg"></div>
                <div class="flex-1 bg-secondary-container/40 h-[55%] rounded-t-lg"></div>
            </div>
            <div class="flex justify-between mt-4 px-4 text-[10px] font-label-md text-on-surface-variant uppercase tracking-widest">
                <span>Mon</span><span>Tue</span><span>Wed</span><span>Thu</span><span>Fri</span><span>Sat</span><span>Sun</span>
            </div>
        </div>
        <!-- Recent Activity Panel -->
        <div class="bg-surface-container-low border border-outline-variant rounded-3xl p-8">
            <h3 class="font-headline-md text-primary mb-6">Recent Activity</h3>
            <div class="space-y-6">
                <div class="flex gap-4">
                    <div class="h-2 w-2 rounded-full bg-green-500 mt-2"></div>
                    <div>
                        <p class="text-sm text-primary font-semibold">Matcha Powder Replenished</p>
                        <p class="text-xs text-on-surface-variant">+15.0 kg • 2 hours ago</p>
                    </div>
                </div>
                <div class="flex gap-4">
                    <div class="h-2 w-2 rounded-full bg-amber-500 mt-2"></div>
                    <div>
                        <p class="text-sm text-primary font-semibold">Low Stock: Tapioca Pearls</p>
                        <p class="text-xs text-on-surface-variant">Threshold reached • 5 hours ago</p>
                    </div>
                </div>
                <div class="flex gap-4">
                    <div class="h-2 w-2 rounded-full bg-primary mt-2"></div>
                    <div>
                        <p class="text-sm text-primary font-semibold">Inventory Reconciliation</p>
                        <p class="text-xs text-on-surface-variant">By Admin • Yesterday</p>
                    </div>
                </div>
            </div>
            <button class="w-full mt-8 py-3 border border-outline text-primary font-label-md rounded-xl hover:bg-surface-container-high transition-colors">
                View Full Audit Log
            </button>
        </div>
    </div>
</main>
<!-- Floating Action for Quick Scanning (Specialized Component) -->
<button class="fixed bottom-10 right-10 h-16 w-16 bg-primary text-on-primary rounded-full shadow-2xl flex items-center justify-center hover:scale-105 active:scale-95 transition-all z-50">
    <span class="material-symbols-outlined text-3xl" data-icon="qr_code_scanner">qr_code_scanner</span>
</button>
</body></html>
