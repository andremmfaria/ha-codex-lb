/**
 * HA Ingress path-shim for single-page applications.
 *
 * Problem: HA Supervisor proxies the add-on under a dynamic token path
 * (/api/hassio_ingress/<TOKEN>/) but the React SPA's BrowserRouter has routes
 * anchored at "/". window.location.pathname therefore never matches any route
 * and the app renders nothing after navigation.
 *
 * Fix strategy (belt + suspenders):
 *
 *  1. Detect ingress base: <meta name="ingress-path"> injected by nginx, with
 *     URL-pattern fallback so a failed sub_filter inject doesn't kill us.
 *
 *  2. Strip prefix from the initial URL *before* React Router reads it.
 *     Belt: even if step 3 silently fails, React Router init sees "/" not the
 *     full prefixed path.
 *
 *  3. Override Location.prototype.pathname getter to always return the
 *     stripped path. Suspenders: keeps every subsequent read (popstate etc.)
 *     prefix-free without changing the actual browser URL HA needs for proxy.
 *
 *  4. Intercept pushState / replaceState to re-add the prefix so HA can route
 *     subsequent navigations. Guard arguments.length < 3: React Router init
 *     calls replaceState(state, "") with only 2 args — forwarding
 *     addBase(undefined) would write the string "undefined" as the URL.
 *
 *  5. Intercept location.href setter, assign(), and replace() as a safety net
 *     for any hard redirects (codex-lb uses React Router, but guard anyway).
 */
(function () {
  'use strict';

  /* ── 1. Detect ingress base ──────────────────────────────────────────── */

  var meta = document.querySelector('meta[name="ingress-path"]');
  var base = (meta && meta.getAttribute('content') || '').replace(/\/$/, '');

  // Fallback: derive base from current URL pattern (survives failed sub_filter).
  if (!base) {
    var m = window.location.pathname.match(/^(\/api\/hassio_ingress\/[^/]+)/);
    base = m ? m[1] : '';
  }

  if (!base) return; // Not running under HA ingress — no-op.

  /* ── helpers ─────────────────────────────────────────────────────────── */

  function strip(path) {
    if (!path || typeof path !== 'string') return path;
    if (path === base) return '/';
    if (path.startsWith(base + '/')) return path.slice(base.length);
    return path;
  }

  function addBase(url) {
    if (!url || typeof url !== 'string') return url;
    // Leave absolute URLs, hash-only refs, and already-prefixed paths alone.
    if (!url.startsWith('/') || url.startsWith(base + '/') || url === base) return url;
    return base + url;
  }

  /* ── 2. Strip prefix from initial URL (belt) ─────────────────────────── */
  // Rewrite the browser URL to the prefix-free path before React Router init.
  // Use raw _replace (original, pre-intercept) to avoid double-processing.

  var _push    = history.pushState.bind(history);
  var _replace = history.replaceState.bind(history);

  var initPath = window.location.pathname;
  if (initPath === base || initPath.startsWith(base + '/')) {
    _replace(
      history.state,
      '',
      strip(initPath) + window.location.search + window.location.hash
    );
  }

  /* ── 3. Override Location.prototype.pathname getter (suspenders) ─────── */
  // Keeps window.location.pathname prefix-free for every subsequent read
  // (popstate, React Router internals, etc.) without touching the real URL.

  var pathDesc = Object.getOwnPropertyDescriptor(Location.prototype, 'pathname');
  if (pathDesc && pathDesc.configurable && pathDesc.get) {
    var realGet = pathDesc.get;
    Object.defineProperty(Location.prototype, 'pathname', {
      get: function () {
        return strip(realGet.call(this));
      },
      configurable: true,
      enumerable: true
    });
  }

  /* ── 4. Intercept pushState / replaceState ───────────────────────────── */
  // Re-add the prefix on every navigation so HA proxy can route correctly.
  // CRITICAL: guard arguments.length < 3. React Router calls
  //   replaceState(state, "")  — two args, no URL.
  // Without the guard, url=undefined → addBase(undefined)=undefined →
  // _replace(state, "", undefined) → browser writes "undefined" as the URL.

  history.pushState = function (state, title, url) {
    if (arguments.length < 3) return _push(state, title);
    return _push(state, title, addBase(url));
  };

  history.replaceState = function (state, title, url) {
    if (arguments.length < 3) return _replace(state, title);
    return _replace(state, title, addBase(url));
  };

  /* ── 5. Intercept hard redirects ─────────────────────────────────────── */
  // Safety net: if any code does window.location.href = '/x', add prefix.

  var hrefDesc = Object.getOwnPropertyDescriptor(Location.prototype, 'href');
  if (hrefDesc && hrefDesc.configurable && hrefDesc.set) {
    Object.defineProperty(Location.prototype, 'href', {
      get: hrefDesc.get,
      set: function (url) {
        hrefDesc.set.call(this, addBase(url));
      },
      configurable: true,
      enumerable: true
    });
  }

  var _assign     = Location.prototype.assign;
  var _locreplace = Location.prototype.replace;

  Location.prototype.assign = function (url) {
    return _assign.call(this, addBase(url));
  };

  Location.prototype.replace = function (url) {
    return _locreplace.call(this, addBase(url));
  };

})();
