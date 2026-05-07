ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN set -eu \
    && ARCH="$(uname -m)" \
    && case "${ARCH}" in \
         x86_64)  JQ_ARCH="amd64" ;; \
         aarch64) JQ_ARCH="arm64" ;; \
         *) echo "Unsupported arch: ${ARCH}" >&2; exit 1 ;; \
       esac \
    && curl -fsSL -o /usr/local/bin/jq \
         "https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-${JQ_ARCH}" \
    && chmod +x /usr/local/bin/jq

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
