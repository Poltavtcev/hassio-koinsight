# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# Thin HA wrapper — pulls YOUR fork image (fast Rebuild on Home Assistant).
# Image is built from https://github.com/Poltavtcev/bambuddy (see publish workflow in this repo).
ARG BAMBUDDY_IMAGE=ghcr.io/poltavtcev/bambuddy
ARG BAMBUDDY_VERSION=latest

FROM ${BAMBUDDY_IMAGE}:${BAMBUDDY_VERSION}

LABEL org.opencontainers.image.title="Home Assistant Add-on: Bambuddy"
LABEL org.opencontainers.image.description="BamBuddy from Poltavtcev/bambuddy fork — Rebuild to pull newer image."
LABEL org.opencontainers.image.source="https://github.com/Poltavtcev/hassio-koinsight"
LABEL org.opencontainers.image.licenses="AGPL-3.0"

RUN apt-get update \
  && apt-get install -y --no-install-recommends jq \
  && rm -rf /var/lib/apt/lists/*

ENV PORT=8480

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
