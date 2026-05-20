/**
 * logout-popup.js
 * Injects the MithoCha logout confirmation popup into any page.
 * Include this script, then call showLogoutPopup() from any logout trigger.
 */
(function () {
    var LOGOUT_URL = null; // resolved at runtime from the trigger's href

    function inject() {
        if (document.getElementById('mcLogoutOverlay')) return;

        var overlay = document.createElement('div');
        overlay.id = 'mcLogoutOverlay';
        overlay.style.cssText = [
            'display:none',
            'position:fixed',
            'inset:0',
            'background:rgba(39,24,20,0.55)',
            'backdrop-filter:blur(6px)',
            '-webkit-backdrop-filter:blur(6px)',
            'z-index:99999',
            'align-items:center',
            'justify-content:center',
            'padding:20px'
        ].join(';');

        overlay.innerHTML = [
            '<div id="mcLogoutBox" style="',
                'background:#fff;',
                'border-radius:20px;',
                'width:min(460px,100%);',
                'overflow:hidden;',
                'box-shadow:0 32px 80px rgba(39,24,20,0.28);',
                'animation:mcPopIn .22s cubic-bezier(.34,1.56,.64,1)',
            '">',
                /* ── Dark header ── */
                '<div style="',
                    'background:linear-gradient(135deg,#4b2c20,#7d562d);',
                    'padding:32px 28px 24px;',
                    'text-align:center;',
                    'color:#fff8f6',
                '">',
                    '<div style="',
                        'width:52px;height:52px;border-radius:50%;',
                        'background:rgba(255,248,246,0.15);',
                        'display:flex;align-items:center;justify-content:center;',
                        'margin:0 auto 14px;',
                    '">',
                        '<span class="material-symbols-outlined" style="font-size:28px;color:#fff8f6;">logout</span>',
                    '</div>',
                    '<h3 style="font-family:\'Noto Serif\',serif;font-size:22px;font-weight:700;margin:0 0 6px;">Logging Out</h3>',
                    '<p style="font-size:13px;opacity:.8;margin:0;">You\'re about to leave MithoCha.</p>',
                '</div>',
                /* ── White body ── */
                '<div style="padding:28px 28px 24px;text-align:center;">',
                    '<p style="font-size:14px;color:#504440;line-height:1.65;margin:0 0 24px;">',
                        'Are you sure you want to log out? Your cart will be cleared and you\'ll need to sign in again to place an order.',
                    '</p>',
                    '<div style="display:flex;gap:12px;">',
                        '<button id="mcLogoutStay" style="',
                            'flex:1;padding:13px;',
                            'border:1.5px solid #d5c3bd;border-radius:12px;',
                            'background:transparent;color:#32170d;',
                            'font-size:14px;font-weight:700;cursor:pointer;',
                            'font-family:inherit;transition:background .15s',
                        '">Stay</button>',
                        '<a id="mcLogoutConfirm" href="#" style="',
                            'flex:1;padding:13px;',
                            'border:none;border-radius:12px;',
                            'background:#ba1a1a;color:#fff;',
                            'font-size:14px;font-weight:700;cursor:pointer;',
                            'font-family:inherit;text-decoration:none;',
                            'display:flex;align-items:center;justify-content:center;gap:7px;',
                            'transition:filter .15s',
                        '">',
                            '<span class="material-symbols-outlined" style="font-size:17px;">logout</span>',
                            'Yes, Log Out',
                        '</a>',
                    '</div>',
                '</div>',
            '</div>'
        ].join('');

        document.body.appendChild(overlay);

        // Close on overlay click
        overlay.addEventListener('click', function (e) {
            if (e.target === overlay) hide();
        });

        // Stay button
        document.getElementById('mcLogoutStay').addEventListener('click', hide);

        // Confirm button — navigate to logout URL
        document.getElementById('mcLogoutConfirm').addEventListener('click', function (e) {
            e.preventDefault();
            if (LOGOUT_URL) window.location.href = LOGOUT_URL;
        });

        // Escape key
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') hide();
        });

        // Inject keyframe animation once
        if (!document.getElementById('mcLogoutStyle')) {
            var style = document.createElement('style');
            style.id = 'mcLogoutStyle';
            style.textContent = '@keyframes mcPopIn{from{transform:scale(.88);opacity:0}to{transform:scale(1);opacity:1}}';
            document.head.appendChild(style);
        }
    }

    function show(logoutUrl) {
        inject();
        LOGOUT_URL = logoutUrl;
        var overlay = document.getElementById('mcLogoutOverlay');
        overlay.style.display = 'flex';
        // Re-trigger animation
        var box = document.getElementById('mcLogoutBox');
        box.style.animation = 'none';
        box.offsetHeight; // reflow
        box.style.animation = 'mcPopIn .22s cubic-bezier(.34,1.56,.64,1)';
    }

    function hide() {
        var overlay = document.getElementById('mcLogoutOverlay');
        if (overlay) overlay.style.display = 'none';
    }

    // Expose globally
    window.showLogoutPopup = function (logoutUrl) {
        show(logoutUrl || '/logout');
    };

    // Auto-wire: any element with data-logout-trigger="true" or class "logout-trigger"
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('[data-logout-trigger], .logout-trigger').forEach(function (el) {
            el.addEventListener('click', function (e) {
                e.preventDefault();
                var url = el.getAttribute('href') || el.dataset.logoutUrl || '/logout';
                show(url);
            });
        });
    });
})();
