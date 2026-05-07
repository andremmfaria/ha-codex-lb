ARG BUILD_FROM

FROM alpine:3.19 AS jq-downloader
RUN apk add --no-cache curl \
    && ARCH="$(uname -m)" \
    && case "${ARCH}" in \
         x86_64)  JQ_ARCH="amd64" ;; \
         aarch64) JQ_ARCH="arm64" ;; \
         *) echo "Unsupported arch: ${ARCH}" >&2; exit 1 ;; \
       esac \
    && curl -fsSL -o /usr/local/bin/jq \
         "https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-${JQ_ARCH}" \
    && chmod +x /usr/local/bin/jq

FROM ${BUILD_FROM}

COPY --from=jq-downloader /usr/local/bin/jq /usr/local/bin/jq
COPY --chmod=755 run.sh /run.sh

USER root
CMD ["/run.sh"]
