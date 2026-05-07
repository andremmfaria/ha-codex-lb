# HA Codex LB

Home Assistant add-on repository for [Codex LB](https://github.com/Soju06/codex-lb) — an OpenAI-compatible API proxy that routes requests through a standard ChatGPT subscription using OAuth token rotation.

## Why this exists

[OpenClaw](https://github.com/openclaw/openclaw) is an AI gateway that exposes a unified OpenAI-compatible API across multiple providers. [Its Home Assistant add-on](https://github.com/techartdev/OpenClawHomeAssistant) runs it as a conversation agent inside HA. By default it expects a paid OpenAI API key, which incurs per-token charges on top of any existing subscription.

If you already have a standard **ChatGPT subscription** (Plus, Team, or Pro), you can point OpenClaw at Codex LB instead. Codex LB authenticates with ChatGPT via OAuth, manages token rotation, and presents an OpenAI-compatible endpoint — so OpenClaw talks to your existing ChatGPT account with no separate API credits required.

```text
OpenClaw  →  Codex LB (this add-on)  →  ChatGPT subscription
```

## Installation

1. In Home Assistant, go to **Settings** → **Add-ons** → **Add-on Store**.
2. Click the three dots (⋮) → **Repositories**.
3. Add: `https://github.com/andremmfaria/ha-codex-lb`
4. Find **Codex LB** and install.

## Usage with OpenClaw

Once Codex LB is running, set OpenClaw's OpenAI base URL to the Codex LB ingress address (e.g. `http://homeassistant.local:2455`) and leave the API key field as any non-empty string. Codex LB handles authentication to ChatGPT transparently.

## Documentation

Full configuration details and setup warnings are available in [DOCS.md](codex-lb/DOCS.md).
