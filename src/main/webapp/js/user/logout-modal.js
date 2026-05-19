/* ================================================================
   MithoCha — Logout Confirmation Modal
   Inject once via <script src=".../logout-modal.js"></script>
   Usage: onclick="return openLogoutModal(event, '/logout')"
   ================================================================ */
(function () {

    var _logoutUrl = '';

    /* ── Inject modal HTML + CSS on first call ── */
    function ensureModal() {
        if (document.getElementById('mcLogoutModal')) return;

        /* CSS */
        var style = document.createElement('style');
        style.textContent = [
            '#mcLogoutOverlay{display:none;position:fixed;inset:0;background:rgba(39,24,20,.48);z-index:9000;backdrop-filter:blur(4px);-webkit-backdrop-filter:blur(4px);}',
            '#mcLogoutOverlay.open{display:flex;align-items:center;justify-content:center;padding:20px;}',
            '#mcLogoutModal{',
            '  background:#fff;border-radius:24px;width:min(420px,100%);',
            '  box-shadow:0 32px 80px rgba(39,24,20,.22);overflow:hidden;',
            '  transform:translateY(16px) scale(.96);opacity:0;',
            '  transition:transform .28s cubic-bezier(.34,1.56,.64,1),opacity .22s;',
            '}',
            '#mcLogoutOverlay.open #mcLogoutModal{transform:translateY(0) scale(1);opacity:1;}',
            '.mc-lm-head{background:linear-gradient(135deg,#4b2c20,#7d562d);padding:28px 28px 22px;text-align:center;color:#fff8f6;}',
            '.mc-lm-icon{font-size:44px;display:block;margin-bottom:10px;color:#ffdcbd;}',
            '.mc-lm-head h2{font-family:"Noto Serif",serif;font-size:22px;font-weight:700;margin:0 0 6px;color:#fff8f6;}',
            '.mc-lm-head p{margin:0;font-size:14px;color:rgba(255,233,228,.85);}',
            '.mc-lm-body{padding:24px 28px 8px;text-align:center;}',
            '.mc-lm-body p{font-size:15px;color:#504440;line-height:1.65;margin:0;}',
            '.mc-lm-foot{display:flex;gap:12px;padding:20px 28px 28px;}',
            '.mc-lm-cancel{flex:1;padding:13px;border:1.5px solid #d5c3bd;border-radius:12px;background:transparent;color:#504440;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:background .2s;}',
            '.mc-lm-cancel:hover{background:#fff1ed;}',
            '.mc-lm-confirm{flex:1;display:inline-flex;align-items:center;justify-content:center;gap:8px;padding:13px;border:none;border-radius:12px;background:#ba1a1a;color:#fff;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:filter .2s;}',
            '.mc-lm-confirm:hover{filter:brightness(1.1);}',
            '.mc-lm-confirm .material-symbols-outlined{font-size:18px;}'
        ].join('');
        document.head.appendChild(style);

        /* HTML */
        var overlay = document.createElement('div');
        overlay.id = 'mcLogoutOverlay';
        overlay.innerHTML = [
            '<div id="mcLogoutModal" role="dialog" aria-modal="true" aria-labelledby="mcLmTitle">',
            '  <div class="mc-lm-head">',
            '    <span class="material-symbols-outlined mc-lm-icon">logout</span>',
            '    <h2 id="mcLmTitle">Logging Out</h2>',
            '    <p>You\'re about to leave MithoCha.</p>',
            '  </div>',
            '  <div class="mc-lm-body">',
            '    <p>Are you sure you want to log out? Your cart will be cleared and you\'ll need to sign in again to place an order.</p>',
            '  </div>',
            '  <div class="mc-lm-foot">',
            '    <button class="mc-lm-cancel" id="mcLmCancel" type="button">Stay</button>',
            '    <button class="mc-lm-confirm" id="mcLmConfirm" type="button">',
            '      <span class="material-symbols-outlined">logout</span>',
            '      Yes, Log Out',
            '    </button>',
            '  </div>',
            '</div>'
        ].join('');
        document.body.appendChild(overlay);

        /* Events */
        document.getElementById('mcLmCancel').addEventListener('click', closeLogoutModal);
        overlay.addEventListener('click', function (e) {
            if (e.target === overlay) closeLogoutModal();
        });
        document.getElementById('mcLmConfirm').addEventListener('click', function () {
            window.location.href = _logoutUrl;
        });
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeLogoutModal();
        });
    }

    function closeLogoutModal() {
        var overlay = document.getElementById('mcLogoutOverlay');
        if (overlay) overlay.classList.remove('open');
        document.body.style.overflow = '';
    }

    /* ── Public function called by onclick ── */
    window.openLogoutModal = function (event, url) {
        if (event) event.preventDefault();
        _logoutUrl = url || '/logout';
        ensureModal();
        var overlay = document.getElementById('mcLogoutOverlay');
        overlay.classList.add('open');
        document.body.style.overflow = 'hidden';
        setTimeout(function () {
            var btn = document.getElementById('mcLmCancel');
            if (btn) btn.focus();
        }, 80);
        return false; /* prevent default link navigation */
    };

})();
