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
  <title>MithoCha Admin - Menu Management</title>
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
    body {
      background-color: #fff8f6;
    }
    .glass-card {
      background: rgba(255, 255, 255, 0.7);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255, 255, 255, 0.3);
    }
  </style>
</head>
<body class="font-body-md text-on-background">
<!-- SideNavBar (Mandatory Shell) -->
<aside class="h-screen w-64 border-r fixed left-0 top-0 z-50 bg-stone-50 dark:bg-stone-900 border-stone-200 dark:border-stone-800 flex flex-col h-full py-6">
  <div class="px-6 mb-10">
    <h1 class="text-lg font-bold text-stone-900 dark:text-stone-50 font-serif">MithoCha Admin</h1>
    <p class="text-stone-500 dark:text-stone-400 text-xs font-serif tracking-wide">Premium Bubble Tea</p>
  </div>
  <nav class="flex-1 space-y-1 px-3">
    <a class="flex items-center px-3 py-2 rounded-lg text-stone-600 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 hover:translate-x-1 transition-transform duration-200 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3" data-icon="dashboard">dashboard</span>
      Dashboard
    </a>
    <a class="flex items-center px-3 py-2 rounded-lg text-amber-800 dark:text-amber-200 bg-amber-50 dark:bg-amber-900/20 border-r-4 border-amber-600 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3" data-icon="bubble_chart">bubble_chart</span>
      Menu Management
    </a>
    <a class="flex items-center px-3 py-2 rounded-lg text-stone-600 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 hover:translate-x-1 transition-transform duration-200 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3" data-icon="shopping_bag">shopping_bag</span>
      Orders
    </a>
    <a class="flex items-center px-3 py-2 rounded-lg text-stone-600 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 hover:translate-x-1 transition-transform duration-200 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3" data-icon="group">group</span>
      Customers
    </a>
    <a class="flex items-center px-3 py-2 rounded-lg text-stone-600 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 hover:translate-x-1 transition-transform duration-200 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3" data-icon="inventory_2">inventory_2</span>
      Inventory
    </a>
    <a class="flex items-center px-3 py-2 rounded-lg text-stone-600 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 hover:translate-x-1 transition-transform duration-200 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3" data-icon="local_offer">local_offer</span>
      Offers &amp; Discounts
    </a>
    <a class="flex items-center px-3 py-2 rounded-lg text-stone-600 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 hover:translate-x-1 transition-transform duration-200 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3" data-icon="analytics">analytics</span>
      Analytics
    </a>
    <a class="flex items-center px-3 py-2 rounded-lg text-stone-600 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 hover:translate-x-1 transition-transform duration-200 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3" data-icon="receipt_long">receipt_long</span>
      Invoices
    </a>
  </nav>
  <div class="px-3 border-t border-stone-200 dark:border-stone-800 pt-6 space-y-1">
    <a class="flex items-center px-3 py-2 rounded-lg text-stone-600 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3" data-icon="help">help</span>
      Help Center
    </a>
    <a class="flex items-center px-3 py-2 rounded-lg text-stone-600 dark:text-stone-400 hover:bg-stone-100 dark:hover:bg-stone-800 font-serif text-sm tracking-wide" href="#">
      <span class="material-symbols-outlined mr-3" data-icon="logout">logout</span>
      Logout
    </a>
  </div>
</aside>
<!-- Main Content Area -->
<main class="ml-64 min-h-screen">
  <!-- TopAppBar (Mandatory Shell) -->
  <header class="bg-stone-50/80 dark:bg-stone-950/80 backdrop-blur-md text-stone-800 dark:text-stone-100 font-serif font-medium flex justify-between items-center px-6 py-3 w-full sticky top-0 z-40 border-b border-stone-200 dark:border-stone-800 shadow-sm">
    <div class="flex items-center gap-4">
      <div class="relative flex items-center">
        <span class="material-symbols-outlined absolute left-3 text-stone-400" data-icon="search">search</span>
        <input class="bg-surface-container-low border-none rounded-full py-1.5 pl-10 pr-4 text-sm w-64 focus:ring-1 focus:ring-secondary" placeholder="Search menu items..." type="text"/>
      </div>
    </div>
    <div class="flex items-center gap-4">
      <button class="p-2 rounded-full hover:bg-stone-100 dark:hover:bg-stone-800 transition-colors">
        <span class="material-symbols-outlined" data-icon="notifications">notifications</span>
      </button>
      <button class="p-2 rounded-full hover:bg-stone-100 dark:hover:bg-stone-800 transition-colors">
        <span class="material-symbols-outlined" data-icon="settings">settings</span>
      </button>
      <img alt="Admin profile" class="w-8 h-8 rounded-full border border-stone-200" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDS2g90PJC442g-xNv4a88rFGmg9OVYgLKvrZb1TFH0LEJTwHquHGFYAJV2gYhwthBJJU8Ivx-rcgQezof194G4pVrbh11m3Tm-fwbQWB5FfA9PxGTp_e2yJom-wt6Clyrv_yjBLiTurVK_yq8YEmlR-TyY_fA2vvZlVQK49BCJwe-l4zrG3YXB0_dmAbaGHU9gyvOOZJJsh3mwtF84NAYwgjjGHTJM9EseWhGjA09-A6jJ_Fg1znaNFkuGn6vSLv7n07UsO4kOQcZw"/>
    </div>
  </header>
  <section class="p-8 max-w-[1200px] mx-auto">
    <!-- Page Header -->
    <div class="flex justify-between items-end mb-10">
      <div>
        <h2 class="font-headline-lg text-primary mb-2">Menu Management</h2>
        <p class="text-on-surface-variant font-body-md">Curate your premium bubble tea offerings and seasonal specials.</p>
      </div>
      <button class="bg-secondary text-on-secondary px-6 py-2.5 rounded-xl font-label-md flex items-center gap-2 hover:bg-secondary/90 transition-all shadow-sm">
        <span class="material-symbols-outlined text-lg" data-icon="add">add</span>
        Add New Item
      </button>
    </div>
    <!-- Dashboard Stats Bento -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-12">
      <div class="bg-surface-container-low p-6 rounded-2xl border border-outline-variant/30 flex items-center gap-4">
        <div class="w-12 h-12 rounded-full bg-secondary-container flex items-center justify-center text-on-secondary-container">
          <span class="material-symbols-outlined" data-icon="bubble_chart">bubble_chart</span>
        </div>
        <div>
          <p class="text-xs font-label-md text-outline uppercase tracking-wider">Total Items</p>
          <p class="text-xl font-bold text-primary">24</p>
        </div>
      </div>
      <div class="bg-surface-container-low p-6 rounded-2xl border border-outline-variant/30 flex items-center gap-4">
        <div class="w-12 h-12 rounded-full bg-surface-container-highest flex items-center justify-center text-primary">
          <span class="material-symbols-outlined" data-icon="category">category</span>
        </div>
        <div>
          <p class="text-xs font-label-md text-outline uppercase tracking-wider">Categories</p>
          <p class="text-xl font-bold text-primary">6</p>
        </div>
      </div>
      <div class="bg-surface-container-low p-6 rounded-2xl border border-outline-variant/30 flex items-center gap-4">
        <div class="w-12 h-12 rounded-full bg-primary-fixed-dim/30 flex items-center justify-center text-primary">
          <span class="material-symbols-outlined" data-icon="inventory_2">inventory_2</span>
        </div>
        <div>
          <p class="text-xs font-label-md text-outline uppercase tracking-wider">In Stock</p>
          <p class="text-xl font-bold text-primary">21</p>
        </div>
      </div>
      <div class="bg-surface-container-low p-6 rounded-2xl border border-outline-variant/30 flex items-center gap-4">
        <div class="w-12 h-12 rounded-full bg-error-container/50 flex items-center justify-center text-error">
          <span class="material-symbols-outlined" data-icon="error">error</span>
        </div>
        <div>
          <p class="text-xs font-label-md text-outline uppercase tracking-wider">Out of Stock</p>
          <p class="text-xl font-bold text-error">3</p>
        </div>
      </div>
    </div>
    <!-- Menu Table Container -->
    <div class="bg-surface-container-lowest rounded-3xl shadow-sm border border-outline-variant/20 overflow-hidden">
      <div class="px-8 py-6 border-b border-outline-variant/10 flex justify-between items-center">
        <div class="flex gap-4">
          <span class="bg-secondary-container/30 text-on-secondary-container px-4 py-1.5 rounded-full text-xs font-label-md cursor-pointer">All Items</span>
          <span class="hover:bg-stone-100 px-4 py-1.5 rounded-full text-xs font-label-md text-on-surface-variant cursor-pointer transition-colors">Milk Teas</span>
          <span class="hover:bg-stone-100 px-4 py-1.5 rounded-full text-xs font-label-md text-on-surface-variant cursor-pointer transition-colors">Fruit Teas</span>
        </div>
        <button class="text-sm font-label-md text-secondary flex items-center gap-1 hover:underline">
          <span class="material-symbols-outlined text-lg" data-icon="filter_list">filter_list</span>
          Filter
        </button>
      </div>
      <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse">
          <thead>
          <tr class="bg-surface-container/50 text-on-surface-variant">
            <th class="px-8 py-4 font-label-md text-xs uppercase tracking-widest">Item Details</th>
            <th class="px-8 py-4 font-label-md text-xs uppercase tracking-widest">Category</th>
            <th class="px-8 py-4 font-label-md text-xs uppercase tracking-widest text-right">Price (Rs.)</th>
            <th class="px-8 py-4 font-label-md text-xs uppercase tracking-widest text-center">Stock Status</th>
            <th class="px-8 py-4 font-label-md text-xs uppercase tracking-widest text-right">Actions</th>
          </tr>
          </thead>
          <tbody class="divide-y divide-outline-variant/10">
          <!-- Item 1: Strawberry -->
          <tr class="hover:bg-surface-container-low transition-colors group">
            <td class="px-8 py-5">
              <div class="flex items-center gap-4">
                <div class="w-14 h-14 rounded-2xl overflow-hidden bg-stone-100">
                  <img alt="Strawberry Bubble Tea" class="w-full h-full object-cover" data-alt="Close-up of a pink strawberry bubble tea with fresh strawberry slices and dark tapioca pearls in a tall glass" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD177Ask8sOkU2qpX3GPUro6TSlxH2QYJ47nKwRQUJYq7ECj6yo5bdPeUi7NRtQaAHde5rW8_PWTyS7IYso5nuSOXs2t9ZhcS0OmtK9vL64JdZWcT37YmlA565fL9qmNyOLI0qhawdEfuEVnKD1T08k-EA-69WIEQVCcfZ8o3MoSkNnDWsK9CR0DH9GoCOKLAU_8rh91NIx7OjtFKgcwB_o5qpxVuPa76zu7K72PpoPUpbHx1BFrR7vZ6pGn5XHOIPfLISHYH9NGp_B"/>
                </div>
                <div>
                  <p class="font-headline-md text-base text-primary">Strawberry Bliss</p>
                  <p class="text-xs text-on-surface-variant italic">Floral, Velvety</p>
                </div>
              </div>
            </td>
            <td class="px-8 py-5">
              <span class="px-3 py-1 rounded-full bg-secondary-container/20 text-on-secondary-container text-xs font-label-md">Fruit Tea</span>
            </td>
            <td class="px-8 py-5 text-right font-bold text-primary">
              Rs. 450
            </td>
            <td class="px-8 py-5">
              <div class="flex justify-center">
                <span class="px-3 py-1 rounded-full bg-green-50 text-green-700 text-xs font-medium border border-green-200">In Stock</span>
              </div>
            </td>
            <td class="px-8 py-5 text-right">
              <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="p-2 hover:bg-secondary-container rounded-lg text-secondary">
                  <span class="material-symbols-outlined text-xl" data-icon="edit">edit</span>
                </button>
                <button class="p-2 hover:bg-error-container rounded-lg text-error">
                  <span class="material-symbols-outlined text-xl" data-icon="delete">delete</span>
                </button>
              </div>
            </td>
          </tr>
          <!-- Item 2: Blueberry -->
          <tr class="hover:bg-surface-container-low transition-colors group">
            <td class="px-8 py-5">
              <div class="flex items-center gap-4">
                <div class="w-14 h-14 rounded-2xl overflow-hidden bg-stone-100">
                  <img alt="Blueberry Bubble Tea" class="w-full h-full object-cover" data-alt="Deep purple blueberry bubble tea with visible fruit pulp and creamy top layer in a frosted cup" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDQMyOxSA56JuSkWZHd0YViuABFxxI9YIx0czMm6WwcQlDu_ubUF6Qs2j0gldky4s0Ezde04Zi3xynjHW0YmllUw_GojpR7DOuAPisIWzd4kItKPxK2VDg8ufq35DKOhlV-vkDQ1hKKS6zcxt43r6TAAcw048FOhw3JfUL8drvcxPtelAOYKi_ivtcmVB0GNerVI4rp_J6K7fSQZR0v2gXqAyd1jSBbVj34qF-DYq5TrEMZXfINqPbI-EEeUeqtASy9UE5WSrXQ6vbe"/>
                </div>
                <div>
                  <p class="font-headline-md text-base text-primary">Blueberry Mist</p>
                  <p class="text-xs text-on-surface-variant italic">Tart, Refreshing</p>
                </div>
              </div>
            </td>
            <td class="px-8 py-5">
              <span class="px-3 py-1 rounded-full bg-secondary-container/20 text-on-secondary-container text-xs font-label-md">Specialty</span>
            </td>
            <td class="px-8 py-5 text-right font-bold text-primary">
              Rs. 480
            </td>
            <td class="px-8 py-5">
              <div class="flex justify-center">
                <span class="px-3 py-1 rounded-full bg-green-50 text-green-700 text-xs font-medium border border-green-200">In Stock</span>
              </div>
            </td>
            <td class="px-8 py-5 text-right">
              <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="p-2 hover:bg-secondary-container rounded-lg text-secondary">
                  <span class="material-symbols-outlined text-xl" data-icon="edit">edit</span>
                </button>
                <button class="p-2 hover:bg-error-container rounded-lg text-error">
                  <span class="material-symbols-outlined text-xl" data-icon="delete">delete</span>
                </button>
              </div>
            </td>
          </tr>
          <!-- Item 3: Classic Oolong -->
          <tr class="hover:bg-surface-container-low transition-colors group">
            <td class="px-8 py-5">
              <div class="flex items-center gap-4">
                <div class="w-14 h-14 rounded-2xl overflow-hidden bg-stone-100">
                  <img alt="Oolong Milk Tea" class="w-full h-full object-cover" data-alt="Classic rich oolong milk tea with honey-colored liquid and thick brown sugar boba at the bottom" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDcnsc6rGkewMxd9Ym4e4ZBKWNRX0ZQw__zrFTRD6hXHGKJmk8CJzPGtTDe84-aXQJFcZ8SlsT1iZmCbJoovBWHGdcBZ6AZxeGZq0Me8MI4uELcieazVLE9gCT4f6kqxvxpXe51RpPsw4UuTfwwRtAvVGr8odMAlNGfondCWf0fiQYQ9cPIB-WxPlbNYwmMpPG9EhBF8aXidHe6GrF2Ev_HenyiXkgDA2HvX94hfbENz4yoXUcRrvPLoe0HdHis9M5FDCZq3_k9KZkY"/>
                </div>
                <div>
                  <p class="font-headline-md text-base text-primary">Classic Oolong</p>
                  <p class="text-xs text-on-surface-variant italic">Nutty, Earthy</p>
                </div>
              </div>
            </td>
            <td class="px-8 py-5">
              <span class="px-3 py-1 rounded-full bg-secondary-container/20 text-on-secondary-container text-xs font-label-md">Milk Tea</span>
            </td>
            <td class="px-8 py-5 text-right font-bold text-primary">
              Rs. 390
            </td>
            <td class="px-8 py-5">
              <div class="flex justify-center">
                <span class="px-3 py-1 rounded-full bg-error-container/20 text-error text-xs font-medium border border-error-container">Low Stock</span>
              </div>
            </td>
            <td class="px-8 py-5 text-right">
              <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="p-2 hover:bg-secondary-container rounded-lg text-secondary">
                  <span class="material-symbols-outlined text-xl" data-icon="edit">edit</span>
                </button>
                <button class="p-2 hover:bg-error-container rounded-lg text-error">
                  <span class="material-symbols-outlined text-xl" data-icon="delete">delete</span>
                </button>
              </div>
            </td>
          </tr>
          <!-- Item 4: Taro Velvet -->
          <tr class="hover:bg-surface-container-low transition-colors group">
            <td class="px-8 py-5">
              <div class="flex items-center gap-4">
                <div class="w-14 h-14 rounded-2xl overflow-hidden bg-stone-100">
                  <img alt="Taro Bubble Tea" class="w-full h-full object-cover" data-alt="Creamy pastel lavender colored taro milk tea in a decorative glass with a swirl of purple yam" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBR0eZjhwlxBgCcUoPnly3ZpcxHCRCdVP2bvOYAzJfQ5gcqhc0y5pfvoOdCRrZCkBhlNnmiUI3id2ZJD7NoH58Ib_ShckFA7j8rIkZ39IKZptDshogPVosNj7W1CycSxhYzXZQj82FhlXc0PnMVT8Ge5ES_vc4lduMYIPsyGN87WMeXQVn9AwxGpCddw98zQ7DuGaGnS8ii7fJEEmimTWubLzYNuFQghh433O57bltClolOjYbiUARp39FnbmQ9-kzpl2wxCNLVXrvc"/>
                </div>
                <div>
                  <p class="font-headline-md text-base text-primary">Taro Velvet</p>
                  <p class="text-xs text-on-surface-variant italic">Creamy, Sweet</p>
                </div>
              </div>
            </td>
            <td class="px-8 py-5">
              <span class="px-3 py-1 rounded-full bg-secondary-container/20 text-on-secondary-container text-xs font-label-md">Milk Tea</span>
            </td>
            <td class="px-8 py-5 text-right font-bold text-primary">
              Rs. 520
            </td>
            <td class="px-8 py-5">
              <div class="flex justify-center">
                <span class="px-3 py-1 rounded-full bg-stone-100 text-stone-500 text-xs font-medium border border-stone-200">Out of Stock</span>
              </div>
            </td>
            <td class="px-8 py-5 text-right">
              <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <button class="p-2 hover:bg-secondary-container rounded-lg text-secondary">
                  <span class="material-symbols-outlined text-xl" data-icon="edit">edit</span>
                </button>
                <button class="p-2 hover:bg-error-container rounded-lg text-error">
                  <span class="material-symbols-outlined text-xl" data-icon="delete">delete</span>
                </button>
              </div>
            </td>
          </tr>
          </tbody>
        </table>
      </div>
      <div class="px-8 py-4 bg-surface-container/20 border-t border-outline-variant/10 flex justify-between items-center text-on-surface-variant text-sm">
        <span>Showing 4 of 24 items</span>
        <div class="flex gap-2">
          <button class="w-8 h-8 flex items-center justify-center rounded-lg border border-outline-variant/30 hover:bg-white transition-colors">
            <span class="material-symbols-outlined text-sm" data-icon="chevron_left">chevron_left</span>
          </button>
          <button class="w-8 h-8 flex items-center justify-center rounded-lg bg-primary text-white font-label-md text-xs">1</button>
          <button class="w-8 h-8 flex items-center justify-center rounded-lg border border-outline-variant/30 hover:bg-white transition-colors font-label-md text-xs text-primary">2</button>
          <button class="w-8 h-8 flex items-center justify-center rounded-lg border border-outline-variant/30 hover:bg-white transition-colors font-label-md text-xs text-primary">3</button>
          <button class="w-8 h-8 flex items-center justify-center rounded-lg border border-outline-variant/30 hover:bg-white transition-colors">
            <span class="material-symbols-outlined text-sm" data-icon="chevron_right">chevron_right</span>
          </button>
        </div>
      </div>
    </div>
  </section>
</main>
<!-- Contextual FAB (Mandatory Suppression Check: Rendered as this is a Management Dashboard) -->
<div class="fixed bottom-8 right-8 z-50">
  <button class="w-14 h-14 bg-primary text-white rounded-full shadow-lg flex items-center justify-center hover:scale-105 active:scale-95 transition-all">
    <span class="material-symbols-outlined" data-icon="add_circle">add_circle</span>
  </button>
</div>
</body></html>