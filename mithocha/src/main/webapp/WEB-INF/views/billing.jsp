<%--
  Created by IntelliJ IDEA.
  User: timil
  Date: 4/25/2026
  Time: 11:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html class="light" lang="en"><head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&amp;family=Be+Vietnam+Pro:wght@400;500;600&amp;display=swap" rel="stylesheet"/>
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
        .bento-grid {
            display: grid;
            grid-template-columns: repeat(12, 1fr);
            gap: 24px;
        }
    </style>
</head>
<body class="bg-background text-on-surface font-body-md min-h-screen">
<!-- SideNavBar -->
<aside class="hidden md:flex flex-col h-full py-6 bg-stone-50 h-screen w-64 border-r border-stone-200 fixed left-0 top-0 z-50 font-serif text-sm tracking-wide">
    <div class="px-6 mb-10">
        <h1 class="text-lg font-bold text-stone-900 tracking-tight">MithoCha Admin</h1>
        <p class="text-stone-500 text-xs">Premium Bubble Tea</p>
    </div>
    <nav class="flex-1 space-y-1 px-3">
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined" data-icon="dashboard">dashboard</span>
            <span>Dashboard</span>
        </a>
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined" data-icon="bubble_chart">bubble_chart</span>
            <span>Menu Management</span>
        </a>
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined" data-icon="shopping_bag">shopping_bag</span>
            <span>Orders</span>
        </a>
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined" data-icon="group">group</span>
            <span>Customers</span>
        </a>
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined" data-icon="inventory_2">inventory_2</span>
            <span>Inventory</span>
        </a>
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined" data-icon="loyalty">loyalty</span>
            <span>Offers &amp; Discounts</span>
        </a>
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined" data-icon="analytics">analytics</span>
            <span>Analytics</span>
        </a>
        <a class="flex items-center gap-3 px-3 py-2 text-amber-800 bg-amber-50 border-r-4 border-amber-600 font-semibold hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined" data-icon="receipt_long">receipt_long</span>
            <span>Invoices</span>
        </a>
    </nav>
    <div class="px-3 pt-6 border-t border-stone-200 space-y-1">
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined" data-icon="help">help</span>
            <span>Help Center</span>
        </a>
        <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 hover:translate-x-1 transition-transform duration-200" href="#">
            <span class="material-symbols-outlined" data-icon="logout">logout</span>
            <span>Logout</span>
        </a>
    </div>
</aside>
<!-- TopAppBar -->
<header class="flex justify-between items-center px-6 py-3 w-full sticky top-0 bg-stone-50/80 backdrop-blur-md z-40 border-b border-stone-200 shadow-sm md:pl-72">
    <div class="flex items-center gap-4">
        <h2 class="font-serif font-medium text-stone-800 text-lg">Billing Center</h2>
    </div>
    <div class="flex items-center gap-4">
        <button class="p-2 text-stone-500 hover:bg-stone-100 transition-colors rounded-full scale-95 duration-150">
            <span class="material-symbols-outlined" data-icon="notifications">notifications</span>
        </button>
        <button class="p-2 text-stone-500 hover:bg-stone-100 transition-colors rounded-full scale-95 duration-150">
            <span class="material-symbols-outlined" data-icon="settings">settings</span>
        </button>
        <div class="w-8 h-8 rounded-full overflow-hidden bg-stone-200">
            <img alt="Admin profile" class="w-full h-full object-cover" data-alt="Portrait of a professional administrator in a clean minimalist studio setting with warm lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDHmRlPk1G3z25pyaqGe9RSoCXGCzlJ9elEMeiRnUlTki6Y2HrjgNwdqwk00yYDPJQtJIlp8Wvigh7J3s80gLLmjVeHdGoOuTHnAAcDITqJDE9xn9DxCLybTeCAU60UWxa5xAbuHJX3v8cWagGOrdIVVkMbmNYaMQpPcYDMimrUK11h8YFSnzJU9Diu1lNJ7vf429DcnebzimonPUUowpNXYsJhPmU_DDLK8Lk9co1lcuTI4kJokNeRmx7h9aPTJr4G5EQP6GwR6Ujk"/>
        </div>
    </div>
</header>
<main class="md:ml-64 p-gutter max-w-container-max mx-auto py-12">
    <div class="bento-grid">
        <!-- Invoice Configuration Panel -->
        <section class="col-span-12 lg:col-span-4 space-y-6">
            <div class="bg-surface-container-low p-8 rounded-xl shadow-sm border border-outline-variant">
                <h3 class="font-headline-md text-primary mb-6">Order Details</h3>
                <div class="space-y-4">
                    <div>
                        <label class="block text-label-md text-on-surface-variant uppercase mb-2">Customer Name</label>
                        <input class="w-full bg-surface border-outline rounded-lg px-4 py-3 focus:ring-2 focus:ring-secondary-container focus:border-secondary transition-all outline-none" type="text" value="Aarav Sharma"/>
                    </div>
                    <div>
                        <label class="block text-label-md text-on-surface-variant uppercase mb-2">Order ID</label>
                        <div class="flex items-center bg-surface border border-outline-variant rounded-lg px-4 py-3">
                            <span class="text-primary font-medium">#MC-88291</span>
                        </div>
                    </div>
                    <div>
                        <label class="block text-label-md text-on-surface-variant uppercase mb-2">Date</label>
                        <input class="w-full bg-surface border-outline rounded-lg px-4 py-3 focus:ring-2 focus:ring-secondary-container focus:border-secondary transition-all outline-none" type="date" value="2023-11-24"/>
                    </div>
                    <div>
                        <label class="block text-label-md text-on-surface-variant uppercase mb-2">Notes (Internal)</label>
                        <textarea class="w-full bg-surface border-outline rounded-lg px-4 py-3 focus:ring-2 focus:ring-secondary-container focus:border-secondary transition-all outline-none text-sm" rows="3">Customer requested less ice for the Jasmine Milk Tea. VIP regular.</textarea>
                    </div>
                </div>
            </div>
            <div class="bg-primary-container text-on-primary-fixed p-6 rounded-xl space-y-4">
                <h4 class="font-label-md text-primary-fixed-dim uppercase tracking-widest">Quick Actions</h4>
                <button class="w-full flex items-center justify-center gap-2 bg-secondary text-on-secondary py-4 rounded-lg font-semibold hover:bg-on-secondary-container transition-colors shadow-lg">
                    <span class="material-symbols-outlined" data-icon="print">print</span>
                    Print Receipt
                </button>
                <button class="w-full flex items-center justify-center gap-2 border border-outline-variant text-surface-container-lowest py-4 rounded-lg font-semibold hover:bg-primary/50 transition-colors">
                    <span class="material-symbols-outlined" data-icon="mail">mail</span>
                    Email Invoice
                </button>
                <button class="w-full flex items-center justify-center gap-2 text-surface-container-highest py-2 text-sm hover:underline">
                    <span class="material-symbols-outlined text-sm" data-icon="download">download</span>
                    Download PDF
                </button>
            </div>
        </section>
        <!-- Professional Invoice Generation Canvas -->
        <section class="col-span-12 lg:col-span-8">
            <div class="bg-white rounded-xl shadow-2xl p-12 min-h-[800px] flex flex-col border border-stone-100">
                <!-- Invoice Header -->
                <div class="flex justify-between items-start border-b border-stone-100 pb-10 mb-10">
                    <div>
                        <h2 class="font-headline-xl text-primary mb-1">MithoCha</h2>
                        <p class="text-on-surface-variant text-sm font-medium">Bishalnagar, Kathmandu, Nepal</p>
                        <p class="text-on-surface-variant text-sm">+977 1 4423XXX | hello@mithocha.com</p>
                    </div>
                    <div class="text-right">
                        <h3 class="font-headline-md text-primary uppercase tracking-tighter mb-2">Invoice</h3>
                        <div class="space-y-1">
                            <p class="text-xs text-on-surface-variant uppercase font-bold">Number</p>
                            <p class="text-body-md font-semibold">INV-2023-0882</p>
                        </div>
                    </div>
                </div>
                <!-- Bill To -->
                <div class="mb-10">
                    <p class="text-xs text-on-surface-variant uppercase font-bold mb-3 tracking-widest">Bill To</p>
                    <h4 class="font-headline-md text-stone-900">Aarav Sharma</h4>
                    <p class="text-stone-500">Premium Member #8821</p>
                </div>
                <!-- Itemized List -->
                <div class="flex-grow">
                    <table class="w-full border-collapse">
                        <thead>
                        <tr class="text-left border-b-2 border-primary/10">
                            <th class="py-4 text-xs uppercase font-bold text-on-surface-variant tracking-widest">Description</th>
                            <th class="py-4 text-xs uppercase font-bold text-on-surface-variant tracking-widest text-center">Qty</th>
                            <th class="py-4 text-xs uppercase font-bold text-on-surface-variant tracking-widest text-right">Price</th>
                            <th class="py-4 text-xs uppercase font-bold text-on-surface-variant tracking-widest text-right">Amount</th>
                        </tr>
                        </thead>
                        <tbody class="divide-y divide-stone-50">
                        <tr>
                            <td class="py-6">
                                <p class="font-semibold text-primary">Signature Brown Sugar Deerioca</p>
                                <p class="text-xs text-stone-400 italic">Large, Soy Milk, Extra Pearls</p>
                            </td>
                            <td class="py-6 text-center text-body-md">2</td>
                            <td class="py-6 text-right text-body-md">Rs. 450</td>
                            <td class="py-6 text-right font-semibold text-body-md">Rs. 900</td>
                        </tr>
                        <tr>
                            <td class="py-6">
                                <p class="font-semibold text-primary">Jasmine Green Milk Tea</p>
                                <p class="text-xs text-stone-400 italic">Regular, 50% Sugar, Less Ice</p>
                            </td>
                            <td class="py-6 text-center text-body-md">1</td>
                            <td class="py-6 text-right text-body-md">Rs. 380</td>
                            <td class="py-6 text-right font-semibold text-body-md">Rs. 380</td>
                        </tr>
                        <tr>
                            <td class="py-6">
                                <p class="font-semibold text-primary">Matcha Mochi Donut</p>
                                <p class="text-xs text-stone-400 italic">Seasonal Glaze</p>
                            </td>
                            <td class="py-6 text-center text-body-md">3</td>
                            <td class="py-6 text-right text-body-md">Rs. 120</td>
                            <td class="py-6 text-right font-semibold text-body-md">Rs. 360</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <!-- Summary & Totals -->
                <div class="mt-10 pt-10 border-t border-stone-100 flex flex-col md:flex-row justify-between gap-10">
                    <div class="max-w-xs">
                        <p class="text-xs text-on-surface-variant uppercase font-bold mb-3">Payment Info</p>
                        <div class="flex items-center gap-3 p-3 bg-surface-container-low rounded-lg border border-outline-variant">
                            <span class="material-symbols-outlined text-secondary" data-icon="account_balance_wallet">account_balance_wallet</span>
                            <div>
                                <p class="text-xs font-bold text-primary">Digital Wallet</p>
                                <p class="text-xs text-on-surface-variant">eSewa Transaction ID: #98321</p>
                            </div>
                        </div>
                    </div>
                    <div class="w-full md:w-64 space-y-3">
                        <div class="flex justify-between items-center text-on-surface-variant">
                            <span class="text-sm">Subtotal</span>
                            <span class="font-medium">Rs. 1,640</span>
                        </div>
                        <div class="flex justify-between items-center text-on-surface-variant">
                            <span class="text-sm">VAT (13%)</span>
                            <span class="font-medium">Rs. 213.20</span>
                        </div>
                        <div class="flex justify-between items-center text-on-surface-variant">
                            <span class="text-sm">Service Charge (10%)</span>
                            <span class="font-medium">Rs. 164</span>
                        </div>
                        <div class="flex justify-between items-center pt-4 border-t border-stone-200">
                            <span class="font-bold text-primary">Total Amount</span>
                            <span class="font-headline-md text-primary">Rs. 2,017.20</span>
                        </div>
                    </div>
                </div>
                <!-- Footer -->
                <div class="mt-20 text-center">
                    <p class="text-stone-400 text-xs italic mb-4">Thank you for visiting MithoCha. We hope to see you again soon!</p>
                    <div class="flex justify-center gap-2">
                        <div class="h-1 w-8 bg-amber-200 rounded-full"></div>
                        <div class="h-1 w-24 bg-amber-600 rounded-full"></div>
                        <div class="h-1 w-8 bg-amber-200 rounded-full"></div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <!-- Secondary Information Section -->
    <section class="mt-16 grid grid-cols-1 md:grid-cols-3 gap-8">
        <div class="bg-surface-container-high p-8 rounded-xl border border-outline-variant">
            <span class="material-symbols-outlined text-secondary mb-4 text-3xl" data-icon="inventory_2">inventory_2</span>
            <h4 class="font-headline-md text-primary mb-2">Inventory Sync</h4>
            <p class="text-sm text-on-surface-variant">Items have been automatically deducted from stock counts. Re-order alerts triggered for Matcha powder.</p>
        </div>
        <div class="bg-surface-container-high p-8 rounded-xl border border-outline-variant">
            <span class="material-symbols-outlined text-secondary mb-4 text-3xl" data-icon="loyalty">loyalty</span>
            <h4 class="font-headline-md text-primary mb-2">Loyalty Points</h4>
            <p class="text-sm text-on-surface-variant">Aarav earned 200 points from this transaction. Current balance: 1,420 points (Gold Tier).</p>
        </div>
        <div class="bg-surface-container-high p-8 rounded-xl border border-outline-variant">
            <span class="material-symbols-outlined text-secondary mb-4 text-3xl" data-icon="security">security</span>
            <h4 class="font-headline-md text-primary mb-2">Compliance</h4>
            <p class="text-sm text-on-surface-variant">Invoice archived in secure storage for tax reporting. Verified for FY 2023-24 regulation standards.</p>
        </div>
    </section>
</main>
<!-- FAB for mobile contexts -->
<button class="fixed bottom-8 right-8 bg-primary text-on-primary w-14 h-14 rounded-full flex items-center justify-center shadow-2xl md:hidden">
    <span class="material-symbols-outlined" data-icon="add">add</span>
</button>
</body></html>