#!/usr/bin/env sh

if [ -d /var/lib/codex-lb ] && [ ! -L /var/lib/codex-lb ]; then
    if cp -a /var/lib/codex-lb/. /data/ 2>/dev/null; then
        rm -rf /var/lib/codex-lb
        ln -s /data /var/lib/codex-lb
    fi
elif [ ! -e /var/lib/codex-lb ]; then
    ln -s /data /var/lib/codex-lb
fi

_opts="$(python3 /opt/options_to_env.py)" || exit 1
eval "$_opts"
unset _opts

export CODEX_LB_HOST="0.0.0.0"
export CODEX_LB_PORT="2455"
export CODEX_LB_OAUTH_CALLBACK_PORT="1455"

nginx -c /etc/nginx/nginx.conf

exec /app/scripts/docker-entrypoint.sh
