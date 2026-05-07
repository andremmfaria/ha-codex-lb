ARG BUILD_FROM

FROM ${BUILD_FROM}

COPY options_to_env.py /opt/options_to_env.py
COPY --chmod=755 run.sh /run.sh

USER root
CMD ["/run.sh"]
