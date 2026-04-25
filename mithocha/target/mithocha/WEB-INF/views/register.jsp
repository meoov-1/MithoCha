<%@page contentType="text/html" pageEncoding="UTF-8"%><!DOCTYPE html>

<html class="light" lang="en"><head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&amp;family=Be+Vietnam+Pro:wght@400;500;600&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            -webkit-font-smoothing: antialiased;
        }
    </style>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-tint": "#7b5647",
                        "secondary-fixed-dim": "#f0bd8b",
                        "secondary-fixed": "#ffdcbd",
                        "on-primary-container": "#bf9282",
                        "on-error-container": "#93000a",
                        "outline": "#83746f",
                        "inverse-surface": "#3e2c28",
                        "surface-container-high": "#ffe2db",
                        "surface-container": "#ffe9e4",
                        "surface": "#fff8f6",
                        "surface-bright": "#fff8f6",
                        "tertiary": "#1e2019",
                        "on-surface": "#271814",
                        "error-container": "#ffdad6",
                        "on-primary-fixed-variant": "#613e31",
                        "on-background": "#271814",
                        "tertiary-container": "#34352d",
                        "secondary": "#7d562d",
                        "on-secondary-fixed": "#2c1600",
                        "on-secondary": "#ffffff",
                        "primary-fixed": "#ffdbce",
                        "background": "#fff8f6",
                        "primary-fixed-dim": "#ecbcaa",
                        "tertiary-fixed-dim": "#c7c7bc",
                        "on-tertiary-container": "#9d9d93",
                        "on-secondary-fixed-variant": "#623f18",
                        "surface-variant": "#fadcd5",
                        "inverse-primary": "#ecbcaa",
                        "error": "#ba1a1a",
                        "surface-dim": "#f1d4cd",
                        "on-secondary-container": "#7a532a",
                        "tertiary-fixed": "#e4e3d7",
                        "on-surface-variant": "#504440",
                        "on-primary-fixed": "#2e140a",
                        "on-tertiary-fixed-variant": "#46473f",
                        "surface-container-low": "#fff1ed",
                        "on-primary": "#ffffff",
                        "inverse-on-surface": "#ffede9",
                        "on-tertiary-fixed": "#1b1c15",
                        "outline-variant": "#d5c3bd",
                        "surface-container-highest": "#fadcd5",
                        "secondary-container": "#ffca98",
                        "primary-container": "#4b2c20",
                        "on-error": "#ffffff",
                        "on-tertiary": "#ffffff",
                        "surface-container-lowest": "#ffffff",
                        "primary": "#32170d"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "gutter": "24px",
                        "margin-mobile": "20px",
                        "container-max": "1200px",
                        "margin-desktop": "64px",
                        "unit": "8px"
                    },
                    "fontFamily": {
                        "label-md": ["Be Vietnam Pro"],
                        "headline-xl": ["Noto Serif"],
                        "headline-lg": ["Noto Serif"],
                        "body-md": ["Be Vietnam Pro"],
                        "body-lg": ["Be Vietnam Pro"],
                        "headline-md": ["Noto Serif"]
                    },
                    "fontSize": {
                        "label-md": ["14px", {"lineHeight": "1.2", "letterSpacing": "0.05em", "fontWeight": "600"}],
                        "headline-xl": ["48px", {"lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                        "headline-lg": ["32px", {"lineHeight": "1.2", "fontWeight": "600"}],
                        "body-md": ["16px", {"lineHeight": "1.5", "fontWeight": "400"}],
                        "body-lg": ["18px", {"lineHeight": "1.6", "fontWeight": "400"}],
                        "headline-md": ["24px", {"lineHeight": "1.3", "fontWeight": "600"}]
                    }
                },
            },
        }
    </script>
</head>
<body class="bg-background text-on-background selection:bg-secondary-fixed selection:text-on-secondary-fixed">
<main class="min-h-screen flex flex-col md:flex-row">
    <!-- Left Side: Visual Experience -->
    <section class="relative w-full md:w-1/2 lg:w-3/5 h-64 md:h-screen overflow-hidden">
        <img alt="Premium bubble tea" class="absolute inset-0 w-full h-full object-cover" data-alt="Close-up of a premium bubble tea with brown sugar boba pearls and rich cream foam in a glass vessel with soft cinematic lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuACGxO8xr0nyMb65vac8rXshEy74n8NXLgzH1WhC4z37UKePJS7CwUxDz5DCbTL3wvukoMYezjU_RcKkViyCcSOScg-rODKf1DB1OziEjE96dwUligoPxR0bTMwwfde3a4VJGl_lBoTKjMM3AtwoYv-fVn_LNuRrAshJXetlR6v70okFw4FkpsaMHqdXg8Az-8JmE0B8b3fWFec_7qsjsh3OO2gYjg5OP2Fe-LUwU4YN4fbd8qxxLTlifJznG3_MvRyXRWz2k-YB7YY"/>
        <div class="absolute inset-0 bg-gradient-to-t from-primary/80 via-primary/20 to-transparent"></div>
        <div class="absolute inset-0 flex flex-col justify-end p-8 md:p-16 space-y-4">
            <div class="flex items-center gap-3">
                <span class="material-symbols-outlined text-secondary-fixed-dim text-4xl" data-icon="coffee">coffee</span>
                <h1 class="font-headline-md text-headline-md text-surface tracking-tight">MithoCha</h1>
            </div>
            <div class="max-w-xl">
                <h2 class="font-headline-xl text-headline-xl text-surface mb-4">Join the Brewmaster Team</h2>
                <p class="font-body-lg text-body-lg text-surface-container/90 max-w-md">
                    Step into our digital tea house. Manage your craft, refine your brews, and elevate the MithoCha experience for every guest.
                </p>
            </div>
        </div>
        <!-- Flavor Profile Tags for Premium Feel -->
        <div class="absolute top-8 left-8 hidden md:flex gap-2">
            <span class="px-3 py-1 bg-surface/10 backdrop-blur-md rounded-full font-label-md text-label-md text-surface border border-surface/20">Floral</span>
            <span class="px-3 py-1 bg-surface/10 backdrop-blur-md rounded-full font-label-md text-label-md text-surface border border-surface/20">Nutty</span>
            <span class="px-3 py-1 bg-surface/10 backdrop-blur-md rounded-full font-label-md text-label-md text-surface border border-surface/20">Velvety</span>
        </div>
    </section>
    <!-- Right Side: Registration Form -->
    <section class="w-full md:w-1/2 lg:w-2/5 bg-surface flex flex-col justify-center px-6 py-12 md:px-16 lg:px-24">
        <div class="w-full max-w-md mx-auto space-y-10">
            <div class="space-y-2">
                <h3 class="font-headline-lg text-headline-lg text-primary">Create Account</h3>
                <p class="font-body-md text-body-md text-on-surface-variant">Start your journey as an admin partner today.</p>
            </div>
            <form class="space-y-6">
                <!-- Full Name -->
                <div class="space-y-2">
                    <label class="font-label-md text-label-md text-on-surface-variant uppercase tracking-widest block" for="fullname">Full Name</label>
                    <div class="relative">
                        <input class="w-full bg-surface-container-low border border-outline-variant rounded-lg px-4 py-3 font-body-md text-body-md focus:ring-2 focus:ring-secondary/20 focus:border-secondary transition-all outline-none" id="fullname" name="fullname" placeholder="Arthur Morgan" type="text"/>
                    </div>
                </div>
                <!-- Email Address -->
                <div class="space-y-2">
                    <label class="font-label-md text-label-md text-on-surface-variant uppercase tracking-widest block" for="email">Email Address</label>
                    <div class="relative">
                        <input class="w-full bg-surface-container-low border border-outline-variant rounded-lg px-4 py-3 font-body-md text-body-md focus:ring-2 focus:ring-secondary/20 focus:border-secondary transition-all outline-none" id="email" name="email" placeholder="admin@mithocha.com" type="email"/>
                    </div>
                </div>
                <!-- Password -->
                <div class="space-y-2">
                    <label class="font-label-md text-label-md text-on-surface-variant uppercase tracking-widest block" for="password">Password</label>
                    <div class="relative">
                        <input class="w-full bg-surface-container-low border border-outline-variant rounded-lg px-4 py-3 font-body-md text-body-md focus:ring-2 focus:ring-secondary/20 focus:border-secondary transition-all outline-none" id="password" name="password" placeholder="••••••••" type="password"/>
                        <button class="absolute right-3 top-1/2 -translate-y-1/2 text-on-surface-variant/60 hover:text-secondary transition-colors" type="button">
                            <span class="material-symbols-outlined text-xl" data-icon="visibility">visibility</span>
                        </button>
                    </div>
                </div>
                <!-- Confirm Password -->
                <div class="space-y-2">
                    <label class="font-label-md text-label-md text-on-surface-variant uppercase tracking-widest block" for="confirm-password">Confirm Password</label>
                    <div class="relative">
                        <input class="w-full bg-surface-container-low border border-outline-variant rounded-lg px-4 py-3 font-body-md text-body-md focus:ring-2 focus:ring-secondary/20 focus:border-secondary transition-all outline-none" id="confirm-password" name="confirm-password" placeholder="••••••••" type="password"/>
                    </div>
                </div>
                <!-- Terms & Conditions -->
                <div class="flex items-start gap-3">
                    <input class="mt-1 h-4 w-4 rounded border-outline-variant text-secondary focus:ring-secondary/20 bg-surface-container-low" id="terms" name="terms" type="checkbox"/>
                    <label class="font-body-md text-body-md text-on-surface-variant" for="terms">
                        I agree to the <a class="text-secondary hover:underline" href="#">Terms of Service</a> and <a class="text-secondary hover:underline" href="#">Privacy Policy</a>.
                    </label>
                </div>
                <!-- Register Button -->
                <button class="w-full bg-secondary text-on-secondary font-label-md text-label-md py-4 rounded-lg shadow-lg shadow-secondary/10 hover:bg-secondary/90 active:scale-[0.98] transition-all flex items-center justify-center gap-2 group" type="submit">
                    Register
                    <span class="material-symbols-outlined transition-transform group-hover:translate-x-1" data-icon="arrow_forward">arrow_forward</span>
                </button>
            </form>
            <div class="pt-6 border-t border-outline-variant/30 text-center">
                <p class="font-body-md text-body-md text-on-surface-variant">
                    Already have an account?
                    <a class="text-secondary font-bold hover:underline ml-1 inline-flex items-center gap-1 group" href="#">
                        Back to Login
                        <span class="material-symbols-outlined text-sm opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all" data-icon="login">login</span>
                    </a>
                </p>
            </div>
        </div>
        <!-- Footer-like text for transactional context -->
        <div class="mt-auto pt-12">
            <p class="font-label-md text-label-md text-on-surface-variant/50 text-center uppercase tracking-[0.2em] text-[10px]">
                © 2024 MithoCha Beverages. All rights reserved.
            </p>
        </div>
    </section>
</main>
<!-- Aesthetic Decorative Element -->
<div class="fixed bottom-10 right-10 pointer-events-none opacity-5 hidden lg:block">
    <span class="material-symbols-outlined text-[200px]" data-icon="eco">eco</span>
</div>
</body></html>