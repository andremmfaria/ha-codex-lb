# User Guide: Codex LB for Home Assistant

## What is Codex LB?

Open-source load balancer for OpenAI/ChatGPT API. Handles OAuth token rotation, rate limiting, request routing, and sticky sessions for Codex agent workflows.

## Installation

1. In Home Assistant, navigate to **Settings** → **Add-ons** → **Add-on Store**.
2. Click the three dots (⋮) in the top-right corner → **Repositories**.
3. Add repository URL: `https://github.com/andremmfaria/ha-codex-lb`
4. Search for "Codex LB" and click **Install**.
5. Configure options before starting (see below).

## Critical Setup Warnings

- **encryption_key**: Strongly recommended to set before first start. If left empty, an ephemeral key is auto-generated on each restart — all encrypted token data will be lost on every restart. Generate a stable key with: `openssl rand -hex 32`
- **dashboard_bootstrap_token** creates the first admin account. Clear this field after your first login for security.
- **OAuth callback port 1455** is used for server-side callbacks. Your OAuth provider (GitHub, Google, etc.) must reach `http://<your-ha-host>:1455/auth/callback`. This port is NOT proxied through HA ingress. Ensure it is accessible from your provider. **You must also set `oauth_redirect_uri` to `http://<your-ha-host>:1455/auth/callback`** (replace `localhost` with your actual HA hostname/IP).
- **WebSocket support**: The dashboard uses WebSockets. HA ingress (nginx) handles this transparently.
- **latest tag risk**: This add-on uses `ghcr.io/soju06/codex-lb:latest`. Upstream updates might introduce breaking changes. To pin a version, update `build.yaml` with a specific image digest.

## Configuration Reference

| Option | Type | Default | Description |
| -------- | ----- | --------- | ------------- |
| `encryption_key` | string | | Strongly recommended. Key for encrypting sensitive data. Leave empty to auto-generate (ephemeral — data lost on restart). |
| `database_url` | string | `sqlite+aiosqlite:////data/codexlb.db` | Database connection string. |
| `upstream_base_url` | string | `https://chatgpt.com/backend-api` | Base URL for upstream API. |
| `firewall_trust_proxy_headers` | boolean | `true` | Trust X-Forwarded-* headers from HA proxy. |
| `dashboard_auth_mode` | string | `standard` | Authentication mode for the dashboard. |
| `dashboard_bootstrap_token` | string | | Token for initial admin setup. |
| `log_format` | string | `text` | Format for application logs. |
| `oauth_redirect_uri` | string | `http://localhost:1455/auth/callback` | Redirect URI for OAuth flows. |
| `metrics_enabled` | boolean | `false` | Enable metrics collection. |
| `otel_enabled` | boolean | `false` | Enable OpenTelemetry tracing. |

*Note: See `translations/en.yaml` in the repository for all 100+ configuration options.*

## Dashboard Access

- **HA Sidebar**: Accessible via "Codex LB" (uses HA ingress on port 2455).
- **Direct Access**: `http://<ha-host>:2455`

## Database

- **Default**: SQLite at `/data/codexlb.db`. Persists across restarts.
- **PostgreSQL**: Set `database_url` to `postgresql+asyncpg://user:pass@host:5432/dbname`.
- **CRITICAL**: Use async driver prefixes (`sqlite+aiosqlite:` or `postgresql+asyncpg:`). Synchronous drivers will cause startup failure.
