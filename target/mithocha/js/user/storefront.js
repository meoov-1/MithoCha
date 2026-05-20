(function (window, document) {
  var STORAGE_KEY  = "mithocha_cart";
  var COOKIE_KEY   = "mithocha_cart";   // legacy cookie name — kept for reading old data
  var CART_MAX_AGE = 60 * 60 * 24 * 7; // 7 days (cookie fallback)

  /* ── Storage: localStorage with cookie fallback ─────────────────────── */

  function storageAvailable(type) {
    try {
      var storage = window[type];
      var testKey = "__mithocha_storage_test__";
      storage.setItem(testKey, testKey);
      storage.removeItem(testKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  function saveToStorage(data) {
    var json = JSON.stringify(data);
    try {
      if (storageAvailable("localStorage")) {
        localStorage.setItem(STORAGE_KEY, json);
        try { console.debug && console.debug('MithoChaStorefront: saved cart to localStorage', { key: STORAGE_KEY, items: data.length }); } catch(e){}
        return;
      }
    } catch (e) {}

    try {
      if (storageAvailable("sessionStorage")) {
        sessionStorage.setItem(STORAGE_KEY, json);
        try { console.debug && console.debug('MithoChaStorefront: saved cart to sessionStorage', { key: STORAGE_KEY, items: data.length }); } catch(e){}
        return;
      }
    } catch (e) {}

    // localStorage unavailable — fall back to cookie (trim image URLs)
    var trimmed = data.map(function(item) {
      return Object.assign({}, item, { imageUrl: "" });
    });
    setCookie(COOKIE_KEY, JSON.stringify(trimmed), CART_MAX_AGE);
  }

  function loadFromStorage() {
    try {
      if (storageAvailable("localStorage")) {
        var raw = localStorage.getItem(STORAGE_KEY);
        if (raw) {
          var parsed = JSON.parse(raw);
          try { console.debug && console.debug('MithoChaStorefront: loaded cart from localStorage', { key: STORAGE_KEY, items: Array.isArray(parsed) ? parsed.length : 0 }); } catch(e){}
          return Array.isArray(parsed) ? parsed : [];
        }
      }
    } catch (e) { /* fall through to sessionStorage */ }

    try {
      if (storageAvailable("sessionStorage")) {
        var raw = sessionStorage.getItem(STORAGE_KEY);
        if (raw) {
          var parsed = JSON.parse(raw);
          try { console.debug && console.debug('MithoChaStorefront: loaded cart from sessionStorage', { key: STORAGE_KEY, items: Array.isArray(parsed) ? parsed.length : 0 }); } catch(e){}
          return Array.isArray(parsed) ? parsed : [];
        }
      }
    } catch (e) { /* fall through to cookie */ }

    // Migrate from old cookie if present
    try {
      var cookieRaw = getCookie(COOKIE_KEY);
      if (cookieRaw) {
        var cookieParsed = JSON.parse(cookieRaw);
        if (Array.isArray(cookieParsed) && cookieParsed.length > 0) {
          saveToStorage(cookieParsed);          // migrate to storage
          deleteCookie(COOKIE_KEY);             // remove old cookie
          return cookieParsed;
        }
      }
    } catch (e) { /* ignore */ }

    return [];
  }

  function clearStorage() {
    try { localStorage.removeItem(STORAGE_KEY); } catch (e) {}
    try { sessionStorage.removeItem(STORAGE_KEY); } catch (e) {}
    deleteCookie(COOKIE_KEY);
  }

  /* ── Cookie helpers (fallback only) ─────────────────────────────────── */

  function setCookie(name, value, maxAgeSeconds) {
    try {
      var encoded = encodeURIComponent(value);
      var expires = maxAgeSeconds ? "; max-age=" + maxAgeSeconds : "";
      document.cookie = name + "=" + encoded + expires + "; path=/; SameSite=Lax";
    } catch (e) {}
  }

  function getCookie(name) {
    var prefix = name + "=";
    var cookies = document.cookie.split(";");
    for (var i = 0; i < cookies.length; i++) {
      var c = cookies[i].trim();
      if (c.indexOf(prefix) === 0) {
        try { return decodeURIComponent(c.substring(prefix.length)); }
        catch (e) { return ""; }
      }
    }
    return "";
  }

  function deleteCookie(name) {
    document.cookie = name + "=; max-age=0; path=/; SameSite=Lax";
  }

  /* ── Cart read / write ──────────────────────────────────────────────── */

  function readCart() {
    return loadFromStorage();
  }

  function writeCart(items) {
    var normalised = Array.isArray(items) ? items : [];
    saveToStorage(normalised);
    updateCartCount();
    try {
      window.dispatchEvent(new CustomEvent("mithocha:cart-updated", { detail: normalised }));
    } catch (e) {}
    return normalised;
  }

  function clearCartCookie() {
    clearStorage();
    updateCartCount();
  }

  /* ── Line key — use productId + options to deduplicate ─────────────── */

  function lineKey(item) {
    return [
      String(item.productId != null ? item.productId : ""),
      item.size    || "",
      item.flavour || "",
      item.topping || "",
      item.iceLevel   || "",
      item.sugarLevel || ""
    ].join("::");
  }

  /* ── Helpers ─────────────────────────────────────────────────────────── */

  function toNumber(value) {
    var n = Number(value);
    return isFinite(n) ? n : 0;
  }

  function formatCurrency(value) {
    var amount = Math.round(toNumber(value) * 100) / 100;
    return "Rs. " + (Number.isInteger(amount) ? amount.toFixed(0) : amount.toFixed(2));
  }

  function itemCount(cart) {
    return (cart || readCart()).reduce(function (total, item) {
      return total + Math.max(1, toNumber(item.quantity || 1));
    }, 0);
  }

  function updateCartCount() {
    var total = itemCount();
    document.querySelectorAll(".cart-count").forEach(function (badge) {
      badge.textContent = total > 0 ? total : "";
      badge.classList.toggle("visible", total > 0);
    });
  }

  /* ── addCartItem ─────────────────────────────────────────────────────── */

  function addCartItem(item) {
    var cart = readCart();
    var key  = lineKey(item);

    var existing = null;
    for (var i = 0; i < cart.length; i++) {
      if (lineKey(cart[i]) === key) { existing = cart[i]; break; }
    }

    if (existing) {
      existing.quantity   = toNumber(existing.quantity) + toNumber(item.quantity || 1);
      existing.totalPrice = toNumber(existing.unitPrice) * existing.quantity;
    } else {
      var qty       = Math.max(1, toNumber(item.quantity || 1));
      var unitPrice = toNumber(item.unitPrice != null ? item.unitPrice : item.basePrice);
      cart.push(Object.assign({}, item, {
        quantity:   qty,
        unitPrice:  unitPrice,
        totalPrice: unitPrice * qty
      }));
    }

    return writeCart(cart);
  }

  /* ── parseProductOptions ─────────────────────────────────────────────── */

  function normaliseOption(option) {
    if (!option) return null;
    if (typeof option === "string") {
      return { label: option, value: option, extra: 0, meta: "Included" };
    }
    if (typeof option === "object") {
      var label = option.label || option.name || option.value || option.size || option.flavour || option.topping;
      if (!label) return null;
      var extra = toNumber(option.extra || option.price || option.addOn);
      var meta  = option.meta || option.volume || option.description || (extra > 0 ? "Add " + formatCurrency(extra) : "Included");
      return { label: label, value: label, extra: extra, meta: meta };
    }
    return null;
  }

  function parseProductOptions(raw, fallback) {
    if (!raw) return fallback || [];
    try {
      var parsed = JSON.parse(raw);
      if (Array.isArray(parsed) && parsed.length) {
        return parsed.map(normaliseOption).filter(Boolean);
      }
    } catch (e) {
      if (typeof raw === "string" && raw.trim()) {
        return raw.split(",").map(function(v) { return normaliseOption(v.trim()); }).filter(Boolean);
      }
    }
    return fallback || [];
  }

  /* ── Public API ──────────────────────────────────────────────────────── */

  window.MithoChaStorefront = {
    CART_KEY:            STORAGE_KEY,
    getCart:             readCart,
    saveCart:            writeCart,
    clearCart:           clearCartCookie,
    addCartItem:         addCartItem,
    updateCartCount:     updateCartCount,
    itemCount:           itemCount,
    formatCurrency:      formatCurrency,
    toNumber:            toNumber,
    parseProductOptions: parseProductOptions
  };

  window.addEventListener("storage", function (event) {
    if (event && event.key === STORAGE_KEY) {
      updateCartCount();
    }
  });

  document.addEventListener("DOMContentLoaded", updateCartCount);

})(window, document);
