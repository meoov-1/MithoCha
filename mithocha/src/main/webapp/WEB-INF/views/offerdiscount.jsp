
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html class="light" lang="en"><head>
  <meta charset="utf-8"/>
  <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
  <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&amp;family=Be+Vietnam+Pro:wght@400;500;600&amp;display=swap" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
  <style>
    .material-symbols-outlined {
      font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
      display: inline-block;
      line-height: 1;
      text-transform: none;
      letter-spacing: normal;
      word-wrap: normal;
      white-space: nowrap;
      direction: ltr;
    }
    body {
      background-color: #fff8f6;
    }
    .glass-panel {
      background: rgba(255, 248, 246, 0.7);
      backdrop-filter: blur(12px);
    }
  </style>
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
            "primary-container": "#4b2c20",
            "primary": "#32170d"
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
</head>
<body class="bg-background text-on-background font-body-md">
<!-- Sidebar Navigation -->
<aside class="h-screen w-64 border-r fixed left-0 top-0 z-50 bg-stone-50 border-stone-200 flex flex-col py-6">
  <div class="px-6 mb-10">
    <h1 class="text-lg font-bold text-stone-900 font-serif">MithoCha Admin</h1>
    <p class="text-xs text-stone-500 font-serif tracking-wide uppercase">Premium Bubble Tea</p>
  </div>
  <nav class="flex-1 space-y-1">
    <a class="flex items-center px-6 py-3 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3">dashboard</span>
      Dashboard
    </a>
    <a class="flex items-center px-6 py-3 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3">bubble_chart</span>
      Menu Management
    </a>
    <a class="flex items-center px-6 py-3 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3">shopping_bag</span>
      Orders
    </a>
    <a class="flex items-center px-6 py-3 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3">group</span>
      Customers
    </a>
    <a class="flex items-center px-6 py-3 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3">inventory_2</span>
      Inventory
    </a>
    <a class="flex items-center px-6 py-3 text-amber-800 bg-amber-50 border-r-4 border-amber-600 font-serif text-sm tracking-wide font-semibold" href="#">
      <span class="material-symbols-outlined mr-3">local_offer</span>
      Offers &amp; Discounts
    </a>
    <a class="flex items-center px-6 py-3 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3">analytics</span>
      Analytics
    </a>
    <a class="flex items-center px-6 py-3 text-stone-600 hover:bg-stone-100 transition-transform duration-200 hover:translate-x-1 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3">receipt_long</span>
      Invoices
    </a>
  </nav>
  <div class="mt-auto border-t border-stone-200 pt-4 space-y-1">
    <a class="flex items-center px-6 py-3 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3">help</span>
      Help Center
    </a>
    <a class="flex items-center px-6 py-3 text-stone-600 hover:bg-stone-100 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3">logout</span>
      Logout
    </a>
  </div>
</aside>
<!-- Main Content Area -->
<main class="ml-64 min-h-screen">
  <!-- Top App Bar -->
  <header class="flex justify-between items-center px-8 py-4 w-full sticky top-0 bg-stone-50/80 backdrop-blur-md z-40 border-b border-stone-200 shadow-sm">
    <div class="flex items-center space-x-4">
      <h2 class="font-headline-md text-primary">Offers &amp; Discounts</h2>
    </div>
    <div class="flex items-center space-x-6">
      <div class="relative">
        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-stone-400">search</span>
        <input class="pl-10 pr-4 py-2 bg-white border border-stone-200 rounded-lg text-sm focus:ring-2 focus:ring-secondary-container focus:outline-none w-64" placeholder="Search promotions..." type="text"/>
      </div>
      <div class="flex items-center space-x-3">
        <button class="p-2 text-stone-500 hover:bg-stone-100 rounded-full transition-colors">
          <span class="material-symbols-outlined">notifications</span>
        </button>
        <button class="p-2 text-stone-500 hover:bg-stone-100 rounded-full transition-colors">
          <span class="material-symbols-outlined">settings</span>
        </button>
        <div class="h-8 w-8 rounded-full bg-surface-container-highest flex items-center justify-center overflow-hidden border border-stone-200">
          <img alt="Admin profile" class="h-full w-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCgdYoX6QWK2eXrz4t54IdoIbwoWhvQx5SBV26b08lBnMFNkdZ-V7dbw3eMTGYRCm_G6u-7fy1oxd5D9OKprIFciZaKBfitQ6RTCPLFfnk_qu5tmPqXeI-2d-3ne1jsqDpBMkg90tuCT5WraaIpUGXa6m9boNkufSbu14Z_9OG0lKyNaTWUWrkKrd2FbNPM5sSXvXA9vTi86tT5phBBL2ERauITk3BBar9zNkesqKslbVEQM1V7VB3B_OgPGRI7zCyU5bnz_D84-XXn"/>
        </div>
      </div>
    </div>
  </header>
  <div class="p-8 max-w-[1400px] mx-auto">
    <!-- Header Actions -->
    <div class="flex justify-between items-end mb-12">
      <div>
        <h3 class="font-headline-xl text-primary mb-2">Promotional Engine</h3>
        <p class="text-on-surface-variant font-body-lg">Design and manage high-conversion rewards for your customers.</p>
      </div>
      <button class="bg-secondary text-on-secondary px-8 py-3 rounded-xl font-label-md hover:opacity-90 transition-all flex items-center space-x-2 shadow-lg shadow-secondary/20">
        <span class="material-symbols-outlined">add</span>
        <span>CREATE NEW COUPON</span>
      </button>
    </div>
    <!-- Dashboard Grid -->
    <div class="grid grid-cols-12 gap-8">
      <!-- Create Coupon Section -->
      <section class="col-span-12 lg:col-span-5 space-y-8">
        <div class="bg-surface-container-low rounded-3xl p-8 border border-surface-container-highest shadow-sm">
          <h4 class="font-headline-lg text-primary mb-6">Coupon Configuration</h4>
          <div class="space-y-6">
            <div class="space-y-2">
              <label class="font-label-md text-on-surface-variant uppercase">Coupon Code</label>
              <input class="w-full bg-white border border-outline-variant rounded-xl px-4 py-3 focus:border-primary focus:ring-0 font-body-md uppercase tracking-widest text-lg font-bold" placeholder="e.g. SUMMERTEA20" type="text"/>
            </div>
            <div class="grid grid-cols-2 gap-4">
              <div class="space-y-2">
                <label class="font-label-md text-on-surface-variant uppercase">Discount Type</label>
                <select class="w-full bg-white border border-outline-variant rounded-xl px-4 py-3 focus:border-primary focus:ring-0 font-body-md">
                  <option>Percentage (%)</option>
                  <option>Flat Amount (Rs.)</option>
                  <option>Free Delivery</option>
                </select>
              </div>
              <div class="space-y-2">
                <label class="font-label-md text-on-surface-variant uppercase">Value</label>
                <input class="w-full bg-white border border-outline-variant rounded-xl px-4 py-3 focus:border-primary focus:ring-0 font-body-md" placeholder="20" type="number"/>
              </div>
            </div>
            <div class="grid grid-cols-2 gap-4">
              <div class="space-y-2">
                <label class="font-label-md text-on-surface-variant uppercase">Min. Order Value</label>
                <input class="w-full bg-white border border-outline-variant rounded-xl px-4 py-3 focus:border-primary focus:ring-0 font-body-md" placeholder="Rs. 500" type="number"/>
              </div>
              <div class="space-y-2">
                <label class="font-label-md text-on-surface-variant uppercase">Expiry Date</label>
                <input class="w-full bg-white border border-outline-variant rounded-xl px-4 py-3 focus:border-primary focus:ring-0 font-body-md" type="date"/>
              </div>
            </div>
            <div class="pt-4">
              <button class="w-full py-4 border-2 border-primary text-primary rounded-xl font-label-md hover:bg-primary hover:text-white transition-all">
                ACTIVATE COUPON
              </button>
            </div>
          </div>
        </div>
        <!-- Statistics Small Bento -->
        <div class="grid grid-cols-2 gap-4">
          <div class="bg-secondary-container rounded-3xl p-6 flex flex-col justify-between h-40">
            <span class="material-symbols-outlined text-on-secondary-container">trending_up</span>
            <div>
              <p class="font-label-md text-on-secondary-container uppercase">Active Users</p>
              <p class="font-headline-lg text-on-secondary-fixed">1,248</p>
            </div>
          </div>
          <div class="bg-surface-container-highest rounded-3xl p-6 flex flex-col justify-between h-40">
            <span class="material-symbols-outlined text-primary">payments</span>
            <div>
              <p class="font-label-md text-primary uppercase">Total Saved</p>
              <p class="font-headline-lg text-primary">Rs. 42k</p>
            </div>
          </div>
        </div>
      </section>
      <!-- Active Promotions Bento -->
      <section class="col-span-12 lg:col-span-7 space-y-8">
        <div class="bg-white rounded-3xl p-8 shadow-sm border border-stone-100">
          <div class="flex justify-between items-center mb-8">
            <h4 class="font-headline-lg text-primary">Active Promotions</h4>
            <div class="flex space-x-2">
              <span class="px-3 py-1 bg-amber-100 text-amber-800 rounded-full text-xs font-bold">5 LIVE</span>
              <span class="px-3 py-1 bg-stone-100 text-stone-500 rounded-full text-xs font-bold">2 SCHEDULED</span>
            </div>
          </div>
          <div class="space-y-4">
            <!-- Coupon Card 1 -->
            <div class="group relative flex items-center p-6 bg-surface-container-low rounded-2xl hover:bg-surface-container transition-colors border border-transparent hover:border-outline-variant">
              <div class="h-16 w-16 bg-white rounded-xl flex items-center justify-center shadow-sm mr-6">
                <span class="material-symbols-outlined text-3xl text-secondary">local_activity</span>
              </div>
              <div class="flex-1">
                <div class="flex items-center space-x-3 mb-1">
                  <h5 class="font-bold text-lg text-primary tracking-wider uppercase">MITHOFIRST50</h5>
                  <span class="px-2 py-0.5 bg-green-100 text-green-700 rounded text-[10px] font-bold uppercase">Public</span>
                </div>
                <p class="text-sm text-on-surface-variant italic">50% off on first bubble tea order • Min. Rs 200</p>
              </div>
              <div class="text-right">
                <p class="font-label-md text-primary">2.4k Uses</p>
                <p class="text-xs text-stone-400">Expires in 12 days</p>
              </div>
              <div class="ml-6 flex space-x-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="p-2 bg-white rounded-lg shadow-sm text-stone-600 hover:text-primary"><span class="material-symbols-outlined text-sm">edit</span></button>
                <button class="p-2 bg-white rounded-lg shadow-sm text-stone-600 hover:text-error"><span class="material-symbols-outlined text-sm">delete</span></button>
              </div>
            </div>
            <!-- Coupon Card 2 -->
            <div class="group relative flex items-center p-6 bg-surface-container-low rounded-2xl hover:bg-surface-container transition-colors border border-transparent hover:border-outline-variant">
              <div class="h-16 w-16 bg-white rounded-xl flex items-center justify-center shadow-sm mr-6">
                <span class="material-symbols-outlined text-3xl text-secondary">celebration</span>
              </div>
              <div class="flex-1">
                <div class="flex items-center space-x-3 mb-1">
                  <h5 class="font-bold text-lg text-primary tracking-wider uppercase">BOBAPARTY</h5>
                  <span class="px-2 py-0.5 bg-amber-100 text-amber-700 rounded text-[10px] font-bold uppercase">Tiered</span>
                </div>
                <p class="text-sm text-on-surface-variant italic">Buy 2 Get 1 Free on signature milk teas</p>
              </div>
              <div class="text-right">
                <p class="font-label-md text-primary">856 Uses</p>
                <p class="text-xs text-stone-400">Ends Tonight</p>
              </div>
              <div class="ml-6 flex space-x-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="p-2 bg-white rounded-lg shadow-sm text-stone-600 hover:text-primary"><span class="material-symbols-outlined text-sm">edit</span></button>
                <button class="p-2 bg-white rounded-lg shadow-sm text-stone-600 hover:text-error"><span class="material-symbols-outlined text-sm">delete</span></button>
              </div>
            </div>
          </div>
        </div>
        <!-- App Banner Management -->
        <div class="bg-surface-container-highest/30 rounded-3xl p-8 border border-surface-container-highest">
          <div class="flex justify-between items-center mb-6">
            <h4 class="font-headline-lg text-primary">Promotional Banners</h4>
            <button class="text-secondary font-label-md flex items-center space-x-1 hover:underline">
              <span class="material-symbols-outlined text-sm">upload</span>
              <span>UPLOAD ASSET</span>
            </button>
          </div>
          <div class="grid grid-cols-2 gap-6">
            <div class="relative group aspect-[16/7] rounded-2xl overflow-hidden shadow-md">
              <img class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700" data-alt="Modern minimalist aesthetic photo of bubble tea with brown sugar pearls and aesthetic ice swirls, bright soft sunlight" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAIsY-dZYK456qvBv2qNXaAAEq6GWobay1XgjYZK6B-84wB3_AK3gTceEeJO2TBQeLtjLGEzI2fCqPwhs3o338n35iQLTPDu2XjQ2Co_985_oQGjReGhXAAcqF2IMNkKLC9bYY1ezn_ided1MyJrtvMrjXX61Mj1PBK17umfJqa-K8fDTICNQ-u2Z0EHdCbJDbzp1c8SNttIN_bR8w6ijKqVSdPsWYhry88JlfJcd5l-sdIpXyf7mCNWDry7xSscWesMCWkSIa1taBm"/>
              <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex flex-col justify-end p-4">
                <p class="text-white font-bold text-sm">Home Screen Hero</p>
                <p class="text-white/80 text-[10px]">Summer Splash Series</p>
              </div>
              <div class="absolute top-2 right-2 flex space-x-1 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="w-8 h-8 bg-white/20 backdrop-blur-md rounded-full text-white flex items-center justify-center"><span class="material-symbols-outlined text-sm">visibility</span></button>
                <button class="w-8 h-8 bg-white/20 backdrop-blur-md rounded-full text-white flex items-center justify-center"><span class="material-symbols-outlined text-sm">settings</span></button>
              </div>
            </div>
            <div class="relative group aspect-[16/7] rounded-2xl overflow-hidden shadow-md">
              <img class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700" data-alt="Gourmet dessert drink with whipped cream and caramel drizzle in a glass cup on an elegant café table with warm lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAA2IufanIgLox7tjTYhT0kbBrgT5xXC8_szv3rx0uE4ZOat6rN79ePf8_l75hC0hixgrPR55gBbLG4di-wVqfqJtskKQAPM-8u3_rUAT1WLmFgz3ZmTNmKJQenvjPrFqHlROVC1WehuUEiB6awm5SDBkLmAO-MsWzR7tJu8GU5ev33mZPRsQwVv2KS4vDEUjuFheAd8YIgdhRSTykX4J5oT7kk49K2mH8E5GLJFI08av6IulwC3vafoeDnc_hlxrIhphwRV7-zXA7G"/>
              <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex flex-col justify-end p-4">
                <p class="text-white font-bold text-sm">Checkout Upsell</p>
                <p class="text-white/80 text-[10px]">Tea &amp; Cake Combo Deal</p>
              </div>
              <div class="absolute top-2 right-2 flex space-x-1 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="w-8 h-8 bg-white/20 backdrop-blur-md rounded-full text-white flex items-center justify-center"><span class="material-symbols-outlined text-sm">visibility</span></button>
                <button class="w-8 h-8 bg-white/20 backdrop-blur-md rounded-full text-white flex items-center justify-center"><span class="material-symbols-outlined text-sm">settings</span></button>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
    <!-- Footer Spacing -->
    <div class="h-20"></div>
  </div>
</main>
<!-- Contextual FAB -->
<div class="fixed bottom-10 right-10 z-50">
  <button class="w-16 h-16 bg-primary text-on-primary rounded-full shadow-2xl flex items-center justify-center hover:scale-110 active:scale-95 transition-all">
    <span class="material-symbols-outlined text-3xl">bolt</span>
  </button>
</div>
</body></html>