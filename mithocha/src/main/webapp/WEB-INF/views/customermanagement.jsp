<%--
  Created by IntelliJ IDEA.
  User: timil
  Date: 4/25/2026
  Time: 11:46 AM
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
        }
      }
    }
  </script>
  <style>
    .material-symbols-outlined {
      font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
    }
    body {
      background-color: #fff8f6;
      color: #271814;
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
<body class="font-body-md antialiased">
<!-- Sidebar Navigation -->
<aside class="bg-stone-50 h-screen w-64 border-r fixed left-0 top-0 z-50 border-stone-200 flex flex-col py-6">
  <div class="px-6 mb-10">
    <h1 class="text-lg font-bold text-stone-900 font-serif">MithoCha Admin</h1>
    <p class="text-stone-500 font-serif text-sm tracking-wide">Premium Bubble Tea</p>
  </div>
  <nav class="flex-1 space-y-1 px-3 overflow-y-auto custom-scrollbar">
    <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined" data-icon="dashboard">dashboard</span>
      Dashboard
    </a>
    <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined" data-icon="bubble_chart">bubble_chart</span>
      Menu Management
    </a>
    <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined" data-icon="shopping_bag">shopping_bag</span>
      Orders
    </a>
    <!-- ACTIVE TAB: Customers -->
    <a class="flex items-center gap-3 px-3 py-2 text-amber-800 bg-amber-50 border-r-4 border-amber-600 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined" data-icon="group">group</span>
      Customers
    </a>
    <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined" data-icon="inventory_2">inventory_2</span>
      Inventory
    </a>
    <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined" data-icon="local_offer">local_offer</span>
      Offers &amp; Discounts
    </a>
    <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined" data-icon="analytics">analytics</span>
      Analytics
    </a>
    <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined" data-icon="receipt_long">receipt_long</span>
      Invoices
    </a>
  </nav>
  <div class="mt-auto px-3 py-4 space-y-1 border-t border-stone-200">
    <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined" data-icon="help">help</span>
      Help Center
    </a>
    <a class="flex items-center gap-3 px-3 py-2 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined" data-icon="logout">logout</span>
      Logout
    </a>
  </div>
</aside>
<!-- Main Content Area -->
<main class="ml-64 min-h-screen">
  <!-- Top Bar -->
  <header class="bg-stone-50/80 backdrop-blur-md sticky top-0 z-40 border-b border-stone-200 px-6 py-3 flex justify-between items-center shadow-sm">
    <div class="flex items-center gap-4">
      <div class="relative">
        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-stone-400" data-icon="search">search</span>
        <input class="pl-10 pr-4 py-1.5 bg-stone-100 border-none rounded-full text-sm focus:ring-1 focus:ring-amber-500 w-64" placeholder="Search customers..." type="text"/>
      </div>
    </div>
    <div class="flex items-center gap-4">
      <button class="p-2 text-stone-500 hover:bg-stone-100 rounded-full transition-colors">
        <span class="material-symbols-outlined" data-icon="notifications">notifications</span>
      </button>
      <button class="p-2 text-stone-500 hover:bg-stone-100 rounded-full transition-colors">
        <span class="material-symbols-outlined" data-icon="settings">settings</span>
      </button>
      <div class="h-8 w-8 rounded-full overflow-hidden border border-stone-200">
        <img alt="Admin profile" class="h-full w-full object-cover" data-alt="close-up portrait of a professional woman with soft lighting and minimalist background" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC3arvLIMEIAU8nIAR8q0xyGWczWbU08P17Q0JD0CCNVozx6-sR3DhKQTs5h6xkIMVif93YtcOmEROfJ6ZlefgP4KzYlN3hohx_eiidP94ScmUj6CtL8RUnMoWh32_9yKhXwwLO-tSHXl0U2ecz8vzsxFuP9F1rnPDWUpDIxC2xzMdmIMCGJ33OAt-uk9EZxBQ-8WViwuup8uig0DsiaS2vnFqSynETKkKnZG95WbpdV9xnzD_YctKZ9glV2CWTSmqvnMfK5USroUjy"/>
      </div>
    </div>
  </header>
  <div class="p-8 max-w-7xl mx-auto">
    <!-- Page Header -->
    <div class="flex justify-between items-end mb-10">
      <div>
        <span class="text-label-md font-label-md text-on-secondary-container bg-secondary-container px-3 py-1 rounded-full mb-4 inline-block">CRM Dashboard</span>
        <h2 class="text-headline-xl font-headline-xl text-primary">Customer Management</h2>
        <p class="text-body-lg font-body-lg text-on-surface-variant mt-2">Manage your high-value tea connoisseurs and their pearl rewards.</p>
      </div>
      <button class="bg-primary text-on-primary px-6 py-3 rounded-xl flex items-center gap-2 hover:bg-primary-container transition-all shadow-lg active:scale-95">
        <span class="material-symbols-outlined" data-icon="person_add">person_add</span>
        Register New User
      </button>
    </div>
    <!-- Stats Bento Grid -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-12">
      <div class="bg-surface-container-low p-6 rounded-2xl flex flex-col gap-2">
        <div class="text-on-secondary-container flex items-center gap-2">
          <span class="material-symbols-outlined" data-icon="person">person</span>
          <span class="text-label-md font-label-md uppercase tracking-wider">Total Users</span>
        </div>
        <div class="text-headline-lg font-headline-lg text-primary mt-2">2,840</div>
        <div class="text-sm text-green-700 flex items-center gap-1">
          <span class="material-symbols-outlined text-sm" data-icon="trending_up">trending_up</span>
          +12% this month
        </div>
      </div>
      <div class="bg-surface-container-low p-6 rounded-2xl flex flex-col gap-2">
        <div class="text-on-secondary-container flex items-center gap-2">
          <span class="material-symbols-outlined" data-icon="stars">stars</span>
          <span class="text-label-md font-label-md uppercase tracking-wider">Total Pearls Earned</span>
        </div>
        <div class="text-headline-lg font-headline-lg text-primary mt-2">145.2K</div>
        <div class="text-sm text-amber-700">12k Pearls redeemed</div>
      </div>
      <div class="bg-surface-container-low p-6 rounded-2xl flex flex-col gap-2">
        <div class="text-on-secondary-container flex items-center gap-2">
          <span class="material-symbols-outlined" data-icon="coffee">coffee</span>
          <span class="text-label-md font-label-md uppercase tracking-wider">Active Today</span>
        </div>
        <div class="text-headline-lg font-headline-lg text-primary mt-2">124</div>
        <div class="text-sm text-on-surface-variant">Avg. 3 cups per user</div>
      </div>
      <div class="bg-surface-container-low p-6 rounded-2xl flex flex-col gap-2 border border-secondary-container">
        <div class="text-secondary flex items-center gap-2">
          <span class="material-symbols-outlined" data-icon="loyalty">loyalty</span>
          <span class="text-label-md font-label-md uppercase tracking-wider">New Tier Promos</span>
        </div>
        <div class="text-headline-md font-headline-md text-primary mt-2">Gold Status</div>
        <div class="text-sm text-secondary font-medium">18 users eligible</div>
      </div>
    </div>
    <!-- Customer Management Interface -->
    <div class="bg-white rounded-3xl overflow-hidden shadow-sm border border-stone-100">
      <div class="p-6 border-b border-stone-100 flex flex-wrap items-center justify-between gap-4">
        <div class="flex gap-2">
          <button class="bg-secondary-container text-on-secondary-container px-4 py-2 rounded-full text-sm font-medium">All Customers</button>
          <button class="px-4 py-2 text-on-surface-variant hover:bg-stone-50 rounded-full text-sm font-medium transition-colors">VIP Members</button>
          <button class="px-4 py-2 text-on-surface-variant hover:bg-stone-50 rounded-full text-sm font-medium transition-colors">Recent Orders</button>
        </div>
        <div class="flex items-center gap-3">
          <button class="flex items-center gap-2 px-4 py-2 border border-outline-variant rounded-xl text-sm font-medium hover:bg-stone-50 transition-colors">
            <span class="material-symbols-outlined text-lg" data-icon="filter_list">filter_list</span>
            Filter
          </button>
          <button class="flex items-center gap-2 px-4 py-2 border border-outline-variant rounded-xl text-sm font-medium hover:bg-stone-50 transition-colors">
            <span class="material-symbols-outlined text-lg" data-icon="download">download</span>
            Export CSV
          </button>
        </div>
      </div>
      <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse">
          <thead>
          <tr class="bg-stone-50/50">
            <th class="px-6 py-4 text-label-md font-label-md text-on-surface-variant uppercase tracking-wider">Customer</th>
            <th class="px-6 py-4 text-label-md font-label-md text-on-surface-variant uppercase tracking-wider">Tier / Status</th>
            <th class="px-6 py-4 text-label-md font-label-md text-on-surface-variant uppercase tracking-wider">Pearls</th>
            <th class="px-6 py-4 text-label-md font-label-md text-on-surface-variant uppercase tracking-wider">Recent Orders</th>
            <th class="px-6 py-4 text-label-md font-label-md text-on-surface-variant uppercase tracking-wider text-right">Actions</th>
          </tr>
          </thead>
          <tbody class="divide-y divide-stone-100">
          <!-- User Row 1 -->
          <tr class="hover:bg-stone-50/40 transition-colors group">
            <td class="px-6 py-5">
              <div class="flex items-center gap-3">
                <div class="h-12 w-12 rounded-full overflow-hidden bg-surface-container-highest">
                  <img alt="Customer" class="h-full w-full object-cover" data-alt="portrait of a young man with a warm smile in soft daylight, close-up photography" src="https://lh3.googleusercontent.com/aida-public/AB6AXuChwk8gg8UhLPkSlb4MkBOWF9wfG8lp__htsr4RhCO12K1DF2Q7W9m_UK2vIiRp07DmQqvb3x-JjTV1pHTA5F344rUVg5J81Uj6NoSfTwWU4O6UTyE26oxnvoCPM5tKez8TRKifXiZjBqt9dwwNCHSVCF8fssOyTahI1DIAgtpAtFdVG9LhoxvpTLq-2NTMuy17MUxcAYrz-iWANBVm8JrgfuwHntVezYeaMqsQGOGkYaDXuXXUFH3iGQEXnbYPl-S4uBbqAcLH8Pab"/>
                </div>
                <div>
                  <div class="font-semibold text-primary">Arjun Sharma</div>
                  <div class="text-sm text-on-surface-variant">arjun.s@email.com</div>
                </div>
              </div>
            </td>
            <td class="px-6 py-5">
              <div class="flex flex-col gap-1">
<span class="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium bg-amber-100 text-amber-800">
<span class="material-symbols-outlined text-xs" data-icon="military_tech" data-weight="fill">military_tech</span>
                                            Gold Member
                                        </span>
                <span class="text-[10px] text-green-600 font-bold uppercase ml-1">Active</span>
              </div>
            </td>
            <td class="px-6 py-5">
              <div class="flex flex-col">
                <div class="flex items-center gap-1 text-primary font-bold">
                  <span class="material-symbols-outlined text-amber-600 text-sm" data-icon="circle" data-weight="fill">circle</span>
                  2,450
                </div>
                <div class="text-[10px] text-on-surface-variant uppercase">Pearls</div>
              </div>
            </td>
            <td class="px-6 py-5">
              <div class="flex -space-x-2">
                <div class="h-8 w-8 rounded-full border-2 border-white bg-stone-100 flex items-center justify-center" title="Classic Milk Tea">
                  <span class="material-symbols-outlined text-xs" data-icon="coffee">coffee</span>
                </div>
                <div class="h-8 w-8 rounded-full border-2 border-white bg-stone-100 flex items-center justify-center" title="Oolong Macchiato">
                  <span class="material-symbols-outlined text-xs" data-icon="coffee">coffee</span>
                </div>
                <div class="h-8 w-8 rounded-full border-2 border-white bg-stone-200 flex items-center justify-center text-[10px] font-bold">
                  +12
                </div>
              </div>
              <div class="text-[10px] text-on-surface-variant mt-1 italic">Last: Yesterday, 4:20 PM</div>
            </td>
            <td class="px-6 py-5 text-right">
              <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="p-2 hover:bg-secondary-container rounded-lg text-secondary transition-colors" title="Send Notification">
                  <span class="material-symbols-outlined" data-icon="chat_bubble">chat_bubble</span>
                </button>
                <button class="p-2 hover:bg-surface-container-highest rounded-lg text-primary transition-colors" title="Manage Status">
                  <span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
                </button>
              </div>
            </td>
          </tr>
          <!-- User Row 2 -->
          <tr class="hover:bg-stone-50/40 transition-colors group">
            <td class="px-6 py-5">
              <div class="flex items-center gap-3">
                <div class="h-12 w-12 rounded-full overflow-hidden bg-surface-container-highest">
                  <img alt="Customer" class="h-full w-full object-cover" data-alt="professional headshot of a woman with natural lighting and soft studio background" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBIfIzlD0tHnTp4LIzcZEjvFwIYkFedsGzRtkwd6PNy3j365n6knPbv-znWOYsMqr2RcWuynkMnYVAxezSmUims1wHPPaEyntxiZWlu-BRUtUyRR-fR8zya5jHjHWeeQUp9TSSX6t70D5TYeF2sLNT2BzTFHhMldn3JoQMn0TwN13lOxh6LYTUxVePFPNksjIQVK0rpwMPea77l8BAiJcOl5G0pxOWuXM26_RWBrF-c-_MIZizvnuiQJF2_LEvS2yHap0HiriT03r7y"/>
                </div>
                <div>
                  <div class="font-semibold text-primary">Maya Gurung</div>
                  <div class="text-sm text-on-surface-variant">m.gurung@mail.net</div>
                </div>
              </div>
            </td>
            <td class="px-6 py-5">
              <div class="flex flex-col gap-1">
<span class="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium bg-stone-100 text-stone-700">
<span class="material-symbols-outlined text-xs" data-icon="military_tech" data-weight="fill">military_tech</span>
                                            Silver Member
                                        </span>
                <span class="text-[10px] text-green-600 font-bold uppercase ml-1">Active</span>
              </div>
            </td>
            <td class="px-6 py-5">
              <div class="flex flex-col">
                <div class="flex items-center gap-1 text-primary font-bold">
                  <span class="material-symbols-outlined text-amber-600 text-sm" data-icon="circle" data-weight="fill">circle</span>
                  890
                </div>
                <div class="text-[10px] text-on-surface-variant uppercase">Pearls</div>
              </div>
            </td>
            <td class="px-6 py-5">
              <div class="flex -space-x-2">
                <div class="h-8 w-8 rounded-full border-2 border-white bg-stone-100 flex items-center justify-center">
                  <span class="material-symbols-outlined text-xs" data-icon="coffee">coffee</span>
                </div>
                <div class="h-8 w-8 rounded-full border-2 border-white bg-stone-200 flex items-center justify-center text-[10px] font-bold">
                  +4
                </div>
              </div>
              <div class="text-[10px] text-on-surface-variant mt-1 italic">Last: 3 days ago</div>
            </td>
            <td class="px-6 py-5 text-right">
              <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="p-2 hover:bg-secondary-container rounded-lg text-secondary transition-colors">
                  <span class="material-symbols-outlined" data-icon="chat_bubble">chat_bubble</span>
                </button>
                <button class="p-2 hover:bg-surface-container-highest rounded-lg text-primary transition-colors">
                  <span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
                </button>
              </div>
            </td>
          </tr>
          <!-- User Row 3 (Special State) -->
          <tr class="hover:bg-stone-50/40 transition-colors group">
            <td class="px-6 py-5">
              <div class="flex items-center gap-3">
                <div class="h-12 w-12 rounded-full overflow-hidden bg-surface-container-highest">
                  <img alt="Customer" class="h-full w-full object-cover" data-alt="artistic close-up portrait of a woman with moody lighting and warm highlights" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC4IGOzfNcmAWtpUnWNvvbU1MmdAdlh-De62nH_ly_P4ecoDVCQoeMB_dKLENdEnBo1ngYfeQACmeXOmV-3VCcImVxC9I-YtsVttYjd8NOfWgPWN75yMj0x41ACth5QNY9erGSR5lj3K0g53JUO6LUMpDGVlXxyUME1HAxUr9dZ-ETJgpvwN7RgHIylUeMmZINWdSokg2MgEDPZ-D6tCZD-Rd25dKiJYLw9X4lHxAQuyKiGBfcbmv41Sa2l2NRkQUwxCgJmNLZj7FEv"/>
                </div>
                <div>
                  <div class="font-semibold text-primary">Sita Adhikari</div>
                  <div class="text-sm text-on-surface-variant">sita.a@web.com</div>
                </div>
              </div>
            </td>
            <td class="px-6 py-5">
              <div class="flex flex-col gap-1">
<span class="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium bg-secondary-container text-on-secondary-container">
<span class="material-symbols-outlined text-xs" data-icon="stars" data-weight="fill">stars</span>
                                            Diamond VIP
                                        </span>
                <span class="text-[10px] text-error font-bold uppercase ml-1">Away (14d)</span>
              </div>
            </td>
            <td class="px-6 py-5">
              <div class="flex flex-col">
                <div class="flex items-center gap-1 text-primary font-bold">
                  <span class="material-symbols-outlined text-amber-600 text-sm" data-icon="circle" data-weight="fill">circle</span>
                  12,140
                </div>
                <div class="text-[10px] text-on-surface-variant uppercase">Pearls</div>
              </div>
            </td>
            <td class="px-6 py-5">
              <div class="flex -space-x-2">
                <div class="h-8 w-8 rounded-full border-2 border-white bg-stone-100 flex items-center justify-center">
                  <span class="material-symbols-outlined text-xs" data-icon="coffee">coffee</span>
                </div>
                <div class="h-8 w-8 rounded-full border-2 border-white bg-stone-200 flex items-center justify-center text-[10px] font-bold">
                  +48
                </div>
              </div>
              <div class="text-[10px] text-on-surface-variant mt-1 italic">Last: Nov 12, 2023</div>
            </td>
            <td class="px-6 py-5 text-right">
              <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="p-2 hover:bg-secondary-container rounded-lg text-secondary transition-colors">
                  <span class="material-symbols-outlined" data-icon="chat_bubble">chat_bubble</span>
                </button>
                <button class="p-2 hover:bg-surface-container-highest rounded-lg text-primary transition-colors">
                  <span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
                </button>
              </div>
            </td>
          </tr>
          </tbody>
        </table>
      </div>
      <!-- Pagination -->
      <div class="px-6 py-4 bg-stone-50 border-t border-stone-100 flex items-center justify-between">
        <span class="text-sm text-on-surface-variant">Showing 1 to 3 of 2,840 results</span>
        <div class="flex items-center gap-2">
          <button class="p-2 border border-outline-variant rounded-lg hover:bg-white transition-colors disabled:opacity-50" disabled="">
            <span class="material-symbols-outlined text-lg" data-icon="chevron_left">chevron_left</span>
          </button>
          <button class="px-4 py-1.5 bg-primary text-on-primary rounded-lg text-sm font-medium">1</button>
          <button class="px-4 py-1.5 hover:bg-white rounded-lg text-sm font-medium transition-colors">2</button>
          <button class="px-4 py-1.5 hover:bg-white rounded-lg text-sm font-medium transition-colors">3</button>
          <span class="text-stone-400">...</span>
          <button class="px-4 py-1.5 hover:bg-white rounded-lg text-sm font-medium transition-colors">947</button>
          <button class="p-2 border border-outline-variant rounded-lg hover:bg-white transition-colors">
            <span class="material-symbols-outlined text-lg" data-icon="chevron_right">chevron_right</span>
          </button>
        </div>
      </div>
    </div>
    <!-- Side Panels / Detail View (Asymmetric Layout) -->
    <div class="mt-12 grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- Loyalty Analytics -->
      <div class="lg:col-span-2 bg-surface-container-low rounded-3xl p-8 relative overflow-hidden border border-surface-container">
        <div class="relative z-10">
          <h3 class="text-headline-md font-headline-md text-primary mb-2">Pearl Redemption Trends</h3>
          <p class="text-body-md font-body-md text-on-surface-variant mb-6">Redemption rate is up by 8% this week compared to last.</p>
          <div class="h-64 w-full flex items-end gap-3 mt-8">
            <div class="flex-1 bg-secondary/20 rounded-t-xl relative group h-[40%]">
              <div class="absolute -top-8 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-opacity bg-primary text-white text-[10px] px-2 py-1 rounded">Mon: 1.2k</div>
            </div>
            <div class="flex-1 bg-secondary/40 rounded-t-xl relative group h-[55%]"></div>
            <div class="flex-1 bg-secondary/30 rounded-t-xl relative group h-[45%]"></div>
            <div class="flex-1 bg-secondary/60 rounded-t-xl relative group h-[70%]"></div>
            <div class="flex-1 bg-secondary rounded-t-xl relative group h-[90%]">
              <div class="absolute -top-8 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-opacity bg-primary text-white text-[10px] px-2 py-1 rounded">Fri: 2.8k</div>
            </div>
            <div class="flex-1 bg-secondary/50 rounded-t-xl relative group h-[60%]"></div>
            <div class="flex-1 bg-secondary/40 rounded-t-xl relative group h-[50%]"></div>
          </div>
          <div class="flex justify-between mt-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">
            <span>Mon</span><span>Tue</span><span>Wed</span><span>Thu</span><span>Fri</span><span>Sat</span><span>Sun</span>
          </div>
        </div>
      </div>
      <!-- Recent Activity Feed -->
      <div class="bg-primary-container text-on-primary-fixed rounded-3xl p-8 shadow-xl">
        <h3 class="text-headline-md font-headline-md text-surface-container-low mb-6">Recent Pearl Activity</h3>
        <div class="space-y-6">
          <div class="flex gap-4">
            <div class="mt-1 h-2 w-2 rounded-full bg-amber-400 shrink-0 shadow-[0_0_8px_rgba(251,191,36,0.8)]"></div>
            <div>
              <p class="text-sm font-medium text-surface-bright">Arjun Sharma earned 45 Pearls</p>
              <p class="text-[11px] text-on-primary-container">Purchase: Brown Sugar Boba XL</p>
              <p class="text-[10px] text-stone-500 mt-1 uppercase">2 minutes ago</p>
            </div>
          </div>
          <div class="flex gap-4">
            <div class="mt-1 h-2 w-2 rounded-full bg-stone-500 shrink-0"></div>
            <div>
              <p class="text-sm font-medium text-surface-bright">Maya Gurung redeemed a Free Cup</p>
              <p class="text-[11px] text-on-primary-container">Used: 500 Pearls</p>
              <p class="text-[10px] text-stone-500 mt-1 uppercase">1 hour ago</p>
            </div>
          </div>
          <div class="flex gap-4">
            <div class="mt-1 h-2 w-2 rounded-full bg-amber-400 shrink-0 shadow-[0_0_8px_rgba(251,191,36,0.8)]"></div>
            <div>
              <p class="text-sm font-medium text-surface-bright">New User Registered: Dipen K.</p>
              <p class="text-[11px] text-on-primary-container">Sign-up bonus: 50 Pearls</p>
              <p class="text-[10px] text-stone-500 mt-1 uppercase">3 hours ago</p>
            </div>
          </div>
        </div>
        <button class="w-full mt-8 py-3 border border-on-primary-container/30 rounded-xl text-sm font-medium hover:bg-white/5 transition-colors">
          View Detailed Log
        </button>
      </div>
    </div>
  </div>
</main>
<!-- FAB Action (Contextual) -->
<button class="fixed bottom-8 right-8 h-16 w-16 bg-secondary text-primary rounded-full shadow-2xl flex items-center justify-center hover:scale-105 active:scale-95 transition-all z-50">
  <span class="material-symbols-outlined text-2xl" data-icon="mail">mail</span>
</button>
</body></html>