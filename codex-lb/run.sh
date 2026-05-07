#!/usr/bin/env sh

if [ -d /var/lib/codex-lb ] && [ ! -L /var/lib/codex-lb ]; then
    if cp -a /var/lib/codex-lb/. /data/ 2>/dev/null; then
        rm -rf /var/lib/codex-lb
        ln -s /data /var/lib/codex-lb
    fi
elif [ ! -e /var/lib/codex-lb ]; then
    ln -s /data /var/lib/codex-lb
fi

_enc_key="$(jq -r '.encryption_key // empty' /data/options.json)"
if [ -n "$_enc_key" ]; then
    printf '%s' "$_enc_key" > /data/encryption_key.txt
    chmod 600 /data/encryption_key.txt
    export CODEX_LB_ENCRYPTION_KEY_FILE=/data/encryption_key.txt
fi
unset _enc_key

CODEX_LB_DATABASE_URL="$(jq -r '.database_url // empty' /data/options.json)"
export CODEX_LB_DATABASE_URL
CODEX_LB_DATABASE_POOL_SIZE="$(jq -r '.database_pool_size // empty' /data/options.json)"
export CODEX_LB_DATABASE_POOL_SIZE
CODEX_LB_DATABASE_MAX_OVERFLOW="$(jq -r '.database_max_overflow // empty' /data/options.json)"
export CODEX_LB_DATABASE_MAX_OVERFLOW
CODEX_LB_DATABASE_POOL_TIMEOUT_SECONDS="$(jq -r '.database_pool_timeout_seconds // empty' /data/options.json)"
export CODEX_LB_DATABASE_POOL_TIMEOUT_SECONDS
CODEX_LB_DATABASE_MIGRATE_ON_STARTUP="$(jq -r '.database_migrate_on_startup // empty' /data/options.json)"
export CODEX_LB_DATABASE_MIGRATE_ON_STARTUP
CODEX_LB_DATABASE_SQLITE_PRE_MIGRATE_BACKUP_ENABLED="$(jq -r '.database_sqlite_pre_migrate_backup_enabled // empty' /data/options.json)"
export CODEX_LB_DATABASE_SQLITE_PRE_MIGRATE_BACKUP_ENABLED
CODEX_LB_DATABASE_SQLITE_PRE_MIGRATE_BACKUP_MAX_FILES="$(jq -r '.database_sqlite_pre_migrate_backup_max_files // empty' /data/options.json)"
export CODEX_LB_DATABASE_SQLITE_PRE_MIGRATE_BACKUP_MAX_FILES
CODEX_LB_DATABASE_SQLITE_STARTUP_CHECK_MODE="$(jq -r '.database_sqlite_startup_check_mode // empty' /data/options.json)"
export CODEX_LB_DATABASE_SQLITE_STARTUP_CHECK_MODE
CODEX_LB_DATABASE_ALEMBIC_AUTO_REMAP_ENABLED="$(jq -r '.database_alembic_auto_remap_enabled // empty' /data/options.json)"
export CODEX_LB_DATABASE_ALEMBIC_AUTO_REMAP_ENABLED
CODEX_LB_UPSTREAM_BASE_URL="$(jq -r '.upstream_base_url // empty' /data/options.json)"
export CODEX_LB_UPSTREAM_BASE_URL
CODEX_LB_UPSTREAM_STREAM_TRANSPORT="$(jq -r '.upstream_stream_transport // empty' /data/options.json)"
export CODEX_LB_UPSTREAM_STREAM_TRANSPORT
CODEX_LB_UPSTREAM_CONNECT_TIMEOUT_SECONDS="$(jq -r '.upstream_connect_timeout_seconds // empty' /data/options.json)"
export CODEX_LB_UPSTREAM_CONNECT_TIMEOUT_SECONDS
CODEX_LB_UPSTREAM_WEBSOCKET_TRUST_ENV="$(jq -r '.upstream_websocket_trust_env // empty' /data/options.json)"
export CODEX_LB_UPSTREAM_WEBSOCKET_TRUST_ENV
CODEX_LB_PROXY_REQUEST_BUDGET_SECONDS="$(jq -r '.proxy_request_budget_seconds // empty' /data/options.json)"
export CODEX_LB_PROXY_REQUEST_BUDGET_SECONDS
CODEX_LB_COMPACT_REQUEST_BUDGET_SECONDS="$(jq -r '.compact_request_budget_seconds // empty' /data/options.json)"
export CODEX_LB_COMPACT_REQUEST_BUDGET_SECONDS
CODEX_LB_STREAM_IDLE_TIMEOUT_SECONDS="$(jq -r '.stream_idle_timeout_seconds // empty' /data/options.json)"
export CODEX_LB_STREAM_IDLE_TIMEOUT_SECONDS
CODEX_LB_PROXY_DOWNSTREAM_WEBSOCKET_IDLE_TIMEOUT_SECONDS="$(jq -r '.proxy_downstream_websocket_idle_timeout_seconds // empty' /data/options.json)"
export CODEX_LB_PROXY_DOWNSTREAM_WEBSOCKET_IDLE_TIMEOUT_SECONDS
CODEX_LB_MAX_SSE_EVENT_BYTES="$(jq -r '.max_sse_event_bytes // empty' /data/options.json)"
export CODEX_LB_MAX_SSE_EVENT_BYTES
CODEX_LB_UPSTREAM_RESPONSE_CREATE_MAX_BYTES="$(jq -r '.upstream_response_create_max_bytes // empty' /data/options.json)"
export CODEX_LB_UPSTREAM_RESPONSE_CREATE_MAX_BYTES
CODEX_LB_AUTH_BASE_URL="$(jq -r '.auth_base_url // empty' /data/options.json)"
export CODEX_LB_AUTH_BASE_URL
CODEX_LB_OAUTH_CLIENT_ID="$(jq -r '.oauth_client_id // empty' /data/options.json)"
export CODEX_LB_OAUTH_CLIENT_ID
CODEX_LB_OAUTH_ORIGINATOR="$(jq -r '.oauth_originator // empty' /data/options.json)"
export CODEX_LB_OAUTH_ORIGINATOR
CODEX_LB_OAUTH_SCOPE="$(jq -r '.oauth_scope // empty' /data/options.json)"
export CODEX_LB_OAUTH_SCOPE
CODEX_LB_OAUTH_TIMEOUT_SECONDS="$(jq -r '.oauth_timeout_seconds // empty' /data/options.json)"
export CODEX_LB_OAUTH_TIMEOUT_SECONDS
CODEX_LB_OAUTH_REDIRECT_URI="$(jq -r '.oauth_redirect_uri // empty' /data/options.json)"
export CODEX_LB_OAUTH_REDIRECT_URI
CODEX_LB_TOKEN_REFRESH_TIMEOUT_SECONDS="$(jq -r '.token_refresh_timeout_seconds // empty' /data/options.json)"
export CODEX_LB_TOKEN_REFRESH_TIMEOUT_SECONDS
CODEX_LB_TOKEN_REFRESH_INTERVAL_DAYS="$(jq -r '.token_refresh_interval_days // empty' /data/options.json)"
export CODEX_LB_TOKEN_REFRESH_INTERVAL_DAYS
CODEX_LB_USAGE_FETCH_TIMEOUT_SECONDS="$(jq -r '.usage_fetch_timeout_seconds // empty' /data/options.json)"
export CODEX_LB_USAGE_FETCH_TIMEOUT_SECONDS
CODEX_LB_USAGE_FETCH_MAX_RETRIES="$(jq -r '.usage_fetch_max_retries // empty' /data/options.json)"
export CODEX_LB_USAGE_FETCH_MAX_RETRIES
CODEX_LB_USAGE_REFRESH_ENABLED="$(jq -r '.usage_refresh_enabled // empty' /data/options.json)"
export CODEX_LB_USAGE_REFRESH_ENABLED
CODEX_LB_USAGE_REFRESH_INTERVAL_SECONDS="$(jq -r '.usage_refresh_interval_seconds // empty' /data/options.json)"
export CODEX_LB_USAGE_REFRESH_INTERVAL_SECONDS
CODEX_LB_OPENAI_CACHE_AFFINITY_MAX_AGE_SECONDS="$(jq -r '.openai_cache_affinity_max_age_seconds // empty' /data/options.json)"
export CODEX_LB_OPENAI_CACHE_AFFINITY_MAX_AGE_SECONDS
CODEX_LB_OPENAI_PROMPT_CACHE_KEY_DERIVATION_ENABLED="$(jq -r '.openai_prompt_cache_key_derivation_enabled // empty' /data/options.json)"
export CODEX_LB_OPENAI_PROMPT_CACHE_KEY_DERIVATION_ENABLED
CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_ENABLED="$(jq -r '.http_responses_session_bridge_enabled // empty' /data/options.json)"
export CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_ENABLED
CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_IDLE_TTL_SECONDS="$(jq -r '.http_responses_session_bridge_idle_ttl_seconds // empty' /data/options.json)"
export CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_IDLE_TTL_SECONDS
CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_CODEX_IDLE_TTL_SECONDS="$(jq -r '.http_responses_session_bridge_codex_idle_ttl_seconds // empty' /data/options.json)"
export CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_CODEX_IDLE_TTL_SECONDS
CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_CODEX_PREWARM_ENABLED="$(jq -r '.http_responses_session_bridge_codex_prewarm_enabled // empty' /data/options.json)"
export CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_CODEX_PREWARM_ENABLED
CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_MAX_SESSIONS="$(jq -r '.http_responses_session_bridge_max_sessions // empty' /data/options.json)"
export CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_MAX_SESSIONS
CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_QUEUE_LIMIT="$(jq -r '.http_responses_session_bridge_queue_limit // empty' /data/options.json)"
export CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_QUEUE_LIMIT
CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_GATEWAY_SAFE_MODE="$(jq -r '.http_responses_session_bridge_gateway_safe_mode // empty' /data/options.json)"
export CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_GATEWAY_SAFE_MODE
CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_INSTANCE_ID="$(jq -r '.http_responses_session_bridge_instance_id // empty' /data/options.json)"
export CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_INSTANCE_ID
CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_INSTANCE_RING="$(jq -r '.http_responses_session_bridge_instance_ring // empty' /data/options.json)"
export CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_INSTANCE_RING
CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_ADVERTISE_BASE_URL="$(jq -r '.http_responses_session_bridge_advertise_base_url // empty' /data/options.json)"
export CODEX_LB_HTTP_RESPONSES_SESSION_BRIDGE_ADVERTISE_BASE_URL
CODEX_LB_STICKY_SESSION_CLEANUP_ENABLED="$(jq -r '.sticky_session_cleanup_enabled // empty' /data/options.json)"
export CODEX_LB_STICKY_SESSION_CLEANUP_ENABLED
CODEX_LB_STICKY_SESSION_CLEANUP_INTERVAL_SECONDS="$(jq -r '.sticky_session_cleanup_interval_seconds // empty' /data/options.json)"
export CODEX_LB_STICKY_SESSION_CLEANUP_INTERVAL_SECONDS
CODEX_LB_FIREWALL_TRUST_PROXY_HEADERS="$(jq -r '.firewall_trust_proxy_headers // empty' /data/options.json)"
export CODEX_LB_FIREWALL_TRUST_PROXY_HEADERS
CODEX_LB_FIREWALL_TRUSTED_PROXY_CIDRS="$(jq -r '.firewall_trusted_proxy_cidrs // empty' /data/options.json)"
export CODEX_LB_FIREWALL_TRUSTED_PROXY_CIDRS
CODEX_LB_DASHBOARD_AUTH_MODE="$(jq -r '.dashboard_auth_mode // empty' /data/options.json)"
export CODEX_LB_DASHBOARD_AUTH_MODE
CODEX_LB_DASHBOARD_AUTH_PROXY_HEADER="$(jq -r '.dashboard_auth_proxy_header // empty' /data/options.json)"
export CODEX_LB_DASHBOARD_AUTH_PROXY_HEADER
CODEX_LB_DASHBOARD_BOOTSTRAP_TOKEN="$(jq -r '.dashboard_bootstrap_token // empty' /data/options.json)"
export CODEX_LB_DASHBOARD_BOOTSTRAP_TOKEN
CODEX_LB_LOG_FORMAT="$(jq -r '.log_format // empty' /data/options.json)"
export CODEX_LB_LOG_FORMAT
CODEX_LB_LOG_PROXY_REQUEST_SHAPE="$(jq -r '.log_proxy_request_shape // empty' /data/options.json)"
export CODEX_LB_LOG_PROXY_REQUEST_SHAPE
CODEX_LB_LOG_PROXY_REQUEST_SHAPE_RAW_CACHE_KEY="$(jq -r '.log_proxy_request_shape_raw_cache_key // empty' /data/options.json)"
export CODEX_LB_LOG_PROXY_REQUEST_SHAPE_RAW_CACHE_KEY
CODEX_LB_LOG_PROXY_REQUEST_PAYLOAD="$(jq -r '.log_proxy_request_payload // empty' /data/options.json)"
export CODEX_LB_LOG_PROXY_REQUEST_PAYLOAD
CODEX_LB_LOG_PROXY_SERVICE_TIER_TRACE="$(jq -r '.log_proxy_service_tier_trace // empty' /data/options.json)"
export CODEX_LB_LOG_PROXY_SERVICE_TIER_TRACE
CODEX_LB_LOG_UPSTREAM_REQUEST_SUMMARY="$(jq -r '.log_upstream_request_summary // empty' /data/options.json)"
export CODEX_LB_LOG_UPSTREAM_REQUEST_SUMMARY
CODEX_LB_LOG_UPSTREAM_REQUEST_PAYLOAD="$(jq -r '.log_upstream_request_payload // empty' /data/options.json)"
export CODEX_LB_LOG_UPSTREAM_REQUEST_PAYLOAD
CODEX_LB_MAX_DECOMPRESSED_BODY_BYTES="$(jq -r '.max_decompressed_body_bytes // empty' /data/options.json)"
export CODEX_LB_MAX_DECOMPRESSED_BODY_BYTES
CODEX_LB_IMAGE_INLINE_FETCH_ENABLED="$(jq -r '.image_inline_fetch_enabled // empty' /data/options.json)"
export CODEX_LB_IMAGE_INLINE_FETCH_ENABLED
CODEX_LB_IMAGE_INLINE_ALLOWED_HOSTS="$(jq -r '.image_inline_allowed_hosts // empty' /data/options.json)"
export CODEX_LB_IMAGE_INLINE_ALLOWED_HOSTS
CODEX_LB_IMAGES_HOST_MODEL="$(jq -r '.images_host_model // empty' /data/options.json)"
export CODEX_LB_IMAGES_HOST_MODEL
CODEX_LB_IMAGES_DEFAULT_MODEL="$(jq -r '.images_default_model // empty' /data/options.json)"
export CODEX_LB_IMAGES_DEFAULT_MODEL
CODEX_LB_IMAGES_MAX_PARTIAL_IMAGES="$(jq -r '.images_max_partial_images // empty' /data/options.json)"
export CODEX_LB_IMAGES_MAX_PARTIAL_IMAGES
CODEX_LB_MODEL_REGISTRY_ENABLED="$(jq -r '.model_registry_enabled // empty' /data/options.json)"
export CODEX_LB_MODEL_REGISTRY_ENABLED
CODEX_LB_MODEL_REGISTRY_REFRESH_INTERVAL_SECONDS="$(jq -r '.model_registry_refresh_interval_seconds // empty' /data/options.json)"
export CODEX_LB_MODEL_REGISTRY_REFRESH_INTERVAL_SECONDS
CODEX_LB_MODEL_REGISTRY_CLIENT_VERSION="$(jq -r '.model_registry_client_version // empty' /data/options.json)"
export CODEX_LB_MODEL_REGISTRY_CLIENT_VERSION
CODEX_LB_MODEL_CONTEXT_WINDOW_OVERRIDES="$(jq -r '.model_context_window_overrides // empty' /data/options.json)"
export CODEX_LB_MODEL_CONTEXT_WINDOW_OVERRIDES
CODEX_LB_PROXY_UNAUTHENTICATED_CLIENT_CIDRS="$(jq -r '.proxy_unauthenticated_client_cidrs // empty' /data/options.json)"
export CODEX_LB_PROXY_UNAUTHENTICATED_CLIENT_CIDRS
CODEX_LB_BULKHEAD_PROXY_LIMIT="$(jq -r '.bulkhead_proxy_limit // empty' /data/options.json)"
export CODEX_LB_BULKHEAD_PROXY_LIMIT
CODEX_LB_BULKHEAD_DASHBOARD_LIMIT="$(jq -r '.bulkhead_dashboard_limit // empty' /data/options.json)"
export CODEX_LB_BULKHEAD_DASHBOARD_LIMIT
CODEX_LB_PROXY_TOKEN_REFRESH_LIMIT="$(jq -r '.proxy_token_refresh_limit // empty' /data/options.json)"
export CODEX_LB_PROXY_TOKEN_REFRESH_LIMIT
CODEX_LB_PROXY_UPSTREAM_WEBSOCKET_CONNECT_LIMIT="$(jq -r '.proxy_upstream_websocket_connect_limit // empty' /data/options.json)"
export CODEX_LB_PROXY_UPSTREAM_WEBSOCKET_CONNECT_LIMIT
CODEX_LB_PROXY_RESPONSE_CREATE_LIMIT="$(jq -r '.proxy_response_create_limit // empty' /data/options.json)"
export CODEX_LB_PROXY_RESPONSE_CREATE_LIMIT
CODEX_LB_PROXY_COMPACT_RESPONSE_CREATE_LIMIT="$(jq -r '.proxy_compact_response_create_limit // empty' /data/options.json)"
export CODEX_LB_PROXY_COMPACT_RESPONSE_CREATE_LIMIT
CODEX_LB_PROXY_ADMISSION_WAIT_TIMEOUT_SECONDS="$(jq -r '.proxy_admission_wait_timeout_seconds // empty' /data/options.json)"
export CODEX_LB_PROXY_ADMISSION_WAIT_TIMEOUT_SECONDS
CODEX_LB_PROXY_REFRESH_FAILURE_COOLDOWN_SECONDS="$(jq -r '.proxy_refresh_failure_cooldown_seconds // empty' /data/options.json)"
export CODEX_LB_PROXY_REFRESH_FAILURE_COOLDOWN_SECONDS
CODEX_LB_USAGE_REFRESH_AUTH_FAILURE_COOLDOWN_SECONDS="$(jq -r '.usage_refresh_auth_failure_cooldown_seconds // empty' /data/options.json)"
export CODEX_LB_USAGE_REFRESH_AUTH_FAILURE_COOLDOWN_SECONDS
CODEX_LB_MEMORY_WARNING_THRESHOLD_MB="$(jq -r '.memory_warning_threshold_mb // empty' /data/options.json)"
export CODEX_LB_MEMORY_WARNING_THRESHOLD_MB
CODEX_LB_MEMORY_REJECT_THRESHOLD_MB="$(jq -r '.memory_reject_threshold_mb // empty' /data/options.json)"
export CODEX_LB_MEMORY_REJECT_THRESHOLD_MB
CODEX_LB_METRICS_ENABLED="$(jq -r '.metrics_enabled // empty' /data/options.json)"
export CODEX_LB_METRICS_ENABLED
CODEX_LB_METRICS_PORT="$(jq -r '.metrics_port // empty' /data/options.json)"
export CODEX_LB_METRICS_PORT
CODEX_LB_LEADER_ELECTION_ENABLED="$(jq -r '.leader_election_enabled // empty' /data/options.json)"
export CODEX_LB_LEADER_ELECTION_ENABLED
CODEX_LB_LEADER_ELECTION_TTL_SECONDS="$(jq -r '.leader_election_ttl_seconds // empty' /data/options.json)"
export CODEX_LB_LEADER_ELECTION_TTL_SECONDS
CODEX_LB_CIRCUIT_BREAKER_ENABLED="$(jq -r '.circuit_breaker_enabled // empty' /data/options.json)"
export CODEX_LB_CIRCUIT_BREAKER_ENABLED
CODEX_LB_CIRCUIT_BREAKER_FAILURE_THRESHOLD="$(jq -r '.circuit_breaker_failure_threshold // empty' /data/options.json)"
export CODEX_LB_CIRCUIT_BREAKER_FAILURE_THRESHOLD
CODEX_LB_CIRCUIT_BREAKER_RECOVERY_TIMEOUT_SECONDS="$(jq -r '.circuit_breaker_recovery_timeout_seconds // empty' /data/options.json)"
export CODEX_LB_CIRCUIT_BREAKER_RECOVERY_TIMEOUT_SECONDS
CODEX_LB_SOFT_DRAIN_ENABLED="$(jq -r '.soft_drain_enabled // empty' /data/options.json)"
export CODEX_LB_SOFT_DRAIN_ENABLED
CODEX_LB_DETERMINISTIC_FAILOVER_ENABLED="$(jq -r '.deterministic_failover_enabled // empty' /data/options.json)"
export CODEX_LB_DETERMINISTIC_FAILOVER_ENABLED
CODEX_LB_DRAIN_PRIMARY_THRESHOLD_PCT="$(jq -r '.drain_primary_threshold_pct // empty' /data/options.json)"
export CODEX_LB_DRAIN_PRIMARY_THRESHOLD_PCT
CODEX_LB_DRAIN_SECONDARY_THRESHOLD_PCT="$(jq -r '.drain_secondary_threshold_pct // empty' /data/options.json)"
export CODEX_LB_DRAIN_SECONDARY_THRESHOLD_PCT
CODEX_LB_DRAIN_ERROR_WINDOW_SECONDS="$(jq -r '.drain_error_window_seconds // empty' /data/options.json)"
export CODEX_LB_DRAIN_ERROR_WINDOW_SECONDS
CODEX_LB_DRAIN_ERROR_COUNT_THRESHOLD="$(jq -r '.drain_error_count_threshold // empty' /data/options.json)"
export CODEX_LB_DRAIN_ERROR_COUNT_THRESHOLD
CODEX_LB_PROBE_QUIET_SECONDS="$(jq -r '.probe_quiet_seconds // empty' /data/options.json)"
export CODEX_LB_PROBE_QUIET_SECONDS
CODEX_LB_PROBE_SUCCESS_STREAK_REQUIRED="$(jq -r '.probe_success_streak_required // empty' /data/options.json)"
export CODEX_LB_PROBE_SUCCESS_STREAK_REQUIRED
CODEX_LB_BACKPRESSURE_MAX_CONCURRENT_REQUESTS="$(jq -r '.backpressure_max_concurrent_requests // empty' /data/options.json)"
export CODEX_LB_BACKPRESSURE_MAX_CONCURRENT_REQUESTS
CODEX_LB_OTEL_ENABLED="$(jq -r '.otel_enabled // empty' /data/options.json)"
export CODEX_LB_OTEL_ENABLED
CODEX_LB_OTEL_EXPORTER_ENDPOINT="$(jq -r '.otel_exporter_endpoint // empty' /data/options.json)"
export CODEX_LB_OTEL_EXPORTER_ENDPOINT
CODEX_LB_SHUTDOWN_DRAIN_TIMEOUT_SECONDS="$(jq -r '.shutdown_drain_timeout_seconds // empty' /data/options.json)"
export CODEX_LB_SHUTDOWN_DRAIN_TIMEOUT_SECONDS
CODEX_LB_HTTP_CONNECTOR_LIMIT="$(jq -r '.http_connector_limit // empty' /data/options.json)"
export CODEX_LB_HTTP_CONNECTOR_LIMIT
CODEX_LB_HTTP_CONNECTOR_LIMIT_PER_HOST="$(jq -r '.http_connector_limit_per_host // empty' /data/options.json)"
export CODEX_LB_HTTP_CONNECTOR_LIMIT_PER_HOST
CODEX_LB_TRANSCRIPTION_REQUEST_BUDGET_SECONDS="$(jq -r '.transcription_request_budget_seconds // empty' /data/options.json)"
export CODEX_LB_TRANSCRIPTION_REQUEST_BUDGET_SECONDS
CODEX_LB_DATABASE_MIGRATIONS_FAIL_FAST="$(jq -r '.database_migrations_fail_fast // empty' /data/options.json)"
export CODEX_LB_DATABASE_MIGRATIONS_FAIL_FAST

export CODEX_LB_HOST="0.0.0.0"
export CODEX_LB_PORT="2455"
export CODEX_LB_OAUTH_CALLBACK_PORT="1455"

exec /app/scripts/docker-entrypoint.sh
