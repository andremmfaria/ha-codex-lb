/**
 * HA Ingress path-shim for single-page applications.
 *
 * Problem: HA Supervisor proxies the add-on under a dynamic token path
 * (/api/hassio_ingress/<TOKEN>/) but the React SPA's router has routes
 * anchored at "/".  window.location.pathname therefore never matches any
 * route and the app renders nothing.
 *
 * Fix (runs *before* any app JS):
 *  1. Strip the ingress prefix from the current history entry so React
 *     Router initialises with pathname "/" (or the real sub-path).
 *  2. Intercept pushState / replaceState so React Router navigation
 *     re-adds the prefix, keeping the browser URL valid for HA.
 *  3. Intercept popstate so back/forward navigation strips the prefix
 *     before React Router sees it.
 *
 * The ingress prefix is read from <meta name="ingress-path">, injected by
 * nginx sub_filter.  When the app is accessed directly (no ingress) that
 * meta tag is absent or empty and this script is a no-op.
 */
(function () {
  'use strict';

  var meta = document.querySelector('meta[name="ingress-path"]');
  var base = (meta && meta.getAttribute('content') || '').replace(/\/$/, '');
  if (!base) return;

  /* ── helpers ─────────────────────────────────────────────────────────── */

  function strip(path) {
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

  /* ── 1. Fix initial pathname ─────────────────────────────────────────── */

  var initPath = window.location.pathname;
  if (initPath === base || initPath.startsWith(base + '/')) {
    var stripped = strip(initPath) + window.location.search + window.location.hash;
    history.replaceState(history.state, '', stripped);
  }

  /* ── 2. Intercept pushState / replaceState ───────────────────────────── */

  var _push    = history.pushState.bind(history);
  var _replace = history.replaceState.bind(history);

  history.pushState = function (state, title, url) {
    return _push(state, title, addBase(url));
  };

  history.replaceState = function (state, title, url) {
    return _replace(state, title, addBase(url));
  };

  /* ── 3. Intercept popstate ───────────────────────────────────────────── */

  window.addEventListener('popstate', function onpop(e) {
    var p = window.location.pathname;
    if (p === base || p.startsWith(base + '/')) {
      var s = strip(p) + window.location.search + window.location.hash;
      // Temporarily remove listener to avoid recursion.
      window.removeEventListener('popstate', onpop, true);
      _replace(e.state, '', s);
      window.dispatchEvent(new PopStateEvent('popstate', { state: e.state }));
      window.addEventListener('popstate', onpop, true);
    }
  }, true /* capture – runs before React Router's listener */);

})();
