(function (window, document) {
  const CART_KEY = "mithocha-cart";

  function readCart() {
    try {
      const raw = window.localStorage.getItem(CART_KEY);
      if (!raw) {
        return [];
      }
      const parsed = JSON.parse(raw);
      return Array.isArray(parsed) ? parsed : [];
    } catch (error) {
      return [];
    }
  }

  function writeCart(items) {
    const normalised = Array.isArray(items) ? items : [];
    window.localStorage.setItem(CART_KEY, JSON.stringify(normalised));
    updateCartCount();
    window.dispatchEvent(new CustomEvent("mithocha:cart-updated", { detail: normalised }));
    return normalised;
  }

  function lineKey(item) {
    return [
      item.productId || "",
      item.size || "",
      item.flavour || "",
      item.topping || "",
      item.iceLevel || "",
      item.sugarLevel || ""
    ].join("::");
  }

  function toNumber(value) {
    const number = Number(value);
    return Number.isFinite(number) ? number : 0;
  }

  function formatCurrency(value) {
    const amount = Math.round(toNumber(value) * 100) / 100;
    if (Number.isInteger(amount)) {
      return "Rs. " + amount.toFixed(0);
    }
    return "Rs. " + amount.toFixed(2);
  }

  function itemCount(cart) {
    return (cart || readCart()).reduce(function (total, item) {
      return total + Math.max(1, toNumber(item.quantity || 1));
    }, 0);
  }

  function updateCartCount() {
    const total = itemCount();
    document.querySelectorAll(".cart-count").forEach(function (badge) {
      badge.textContent = total;
      badge.classList.toggle("visible", total > 0);
    });
  }

  function addCartItem(item) {
    const cart = readCart();
    const mergedKey = lineKey(item);
    const existing = cart.find(function (entry) {
      return lineKey(entry) === mergedKey;
    });

    if (existing) {
      existing.quantity = toNumber(existing.quantity) + toNumber(item.quantity || 1);
      existing.totalPrice = toNumber(existing.unitPrice || item.unitPrice) * existing.quantity;
    } else {
      const quantity = Math.max(1, toNumber(item.quantity || 1));
      const unitPrice = toNumber(item.unitPrice || item.basePrice);
      cart.push(Object.assign({}, item, {
        quantity: quantity,
        unitPrice: unitPrice,
        totalPrice: unitPrice * quantity
      }));
    }

    return writeCart(cart);
  }

  function parseProductOptions(raw, fallback) {
    if (!raw) {
      return fallback || [];
    }

    try {
      const parsed = JSON.parse(raw);
      if (Array.isArray(parsed) && parsed.length) {
        return parsed.map(normaliseOption).filter(Boolean);
      }
    } catch (error) {
      if (typeof raw === "string" && raw.trim()) {
        return raw.split(",").map(function (value) {
          return normaliseOption(value.trim());
        }).filter(Boolean);
      }
    }

    return fallback || [];
  }

  function normaliseOption(option) {
    if (!option) {
      return null;
    }

    if (typeof option === "string") {
      return { label: option, value: option, extra: 0, meta: "Included" };
    }

    if (typeof option === "object") {
      const label = option.label || option.name || option.value || option.size || option.flavour || option.topping;
      if (!label) {
        return null;
      }
      const extra = toNumber(option.extra || option.price || option.addOn);
      const meta = option.meta || option.volume || option.description || (extra > 0 ? "Add " + formatCurrency(extra) : "Included");
      return { label: label, value: label, extra: extra, meta: meta };
    }

    return null;
  }

  window.MithoChaStorefront = {
    CART_KEY: CART_KEY,
    getCart: readCart,
    saveCart: writeCart,
    addCartItem: addCartItem,
    updateCartCount: updateCartCount,
    itemCount: itemCount,
    formatCurrency: formatCurrency,
    toNumber: toNumber,
    parseProductOptions: parseProductOptions
  };

  document.addEventListener("DOMContentLoaded", updateCartCount);
})(window, document);
