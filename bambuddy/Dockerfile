# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# Thin HA wrapper — pulls pre-built BamBuddy image (see bambuddy/build.yaml).
# Supervisor passes BUILD_FROM from build.yaml build_from; default below is the fork.
# Upstream: cp bambuddy/build.upstream.yaml bambuddy/build.yaml
ARG BUILD_FROM=ghcr.io/poltavtcev/bambuddy:latest
FROM ${BUILD_FROM}

LABEL org.opencontainers.image.title="Home Assistant Add-on: Bambuddy"
LABEL org.opencontainers.image.description="BamBuddy wrapper — Rebuild pulls image from build.yaml (upstream or fork)."
LABEL org.opencontainers.image.source="https://github.com/Poltavtcev/hassio-koinsight"
LABEL org.opencontainers.image.licenses="AGPL-3.0"

RUN apt-get update \
  && apt-get install -y --no-install-recommends jq \
  && rm -rf /var/lib/apt/lists/*

ENV PORT=8480

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
