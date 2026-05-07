ARG BUILD_FROM

FROM ${BUILD_FROM}

RUN rm -rf /var/lib/apt/lists/* \
    && apt-get update \
    && apt-get install -y --no-install-recommends nginx \
    && rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY options_to_env.py /opt/options_to_env.py
COPY --chmod=755 run.sh /run.sh

USER root
CMD ["/run.sh"]
