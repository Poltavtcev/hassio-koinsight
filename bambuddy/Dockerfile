# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# Thin HA wrapper — pulls pre-built BamBuddy image (see bambuddy/build.yaml).
# Default: upstream ghcr.io/maziggy/bambuddy. Fork: cp build.fork.yaml → build.yaml.
ARG BAMBUDDY_IMAGE=ghcr.io/maziggy/bambuddy
ARG BAMBUDDY_VERSION=latest

FROM ${BAMBUDDY_IMAGE}:${BAMBUDDY_VERSION}

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
