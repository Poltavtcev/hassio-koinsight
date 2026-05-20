# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# Thin HA wrapper (fast Rebuild on Home Assistant — pull image, no pip compile on the host).
# Default: upstream image. For your fork image after you publish it, change BAMBUDDY_IMAGE below.
ARG BAMBUDDY_IMAGE=ghcr.io/maziggy/bambuddy
ARG BAMBUDDY_VERSION=latest

FROM ${BAMBUDDY_IMAGE}:${BAMBUDDY_VERSION}

LABEL org.opencontainers.image.title="Home Assistant Add-on: Bambuddy"
LABEL org.opencontainers.image.description="BamBuddy HA wrapper — Rebuild to pull a newer upstream image."
LABEL org.opencontainers.image.source="https://github.com/Poltavtcev/hassio-koinsight"
LABEL org.opencontainers.image.licenses="MIT License"

RUN apt-get update \
  && apt-get install -y --no-install-recommends jq \
  && rm -rf /var/lib/apt/lists/*

ENV PORT=8480

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
