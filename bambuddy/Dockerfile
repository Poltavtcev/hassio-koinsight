# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# Thin HA wrapper around the upstream image (same model as calibre-web-automated).
# Updates on Home Assistant are mostly a docker pull + a small layer — no pip compile on the host.
ARG BAMBUDDY_VERSION=latest

FROM ghcr.io/maziggy/bambuddy:${BAMBUDDY_VERSION}

LABEL org.opencontainers.image.title="Home Assistant Add-on: Bambuddy"
LABEL org.opencontainers.image.description="BamBuddy from ghcr.io/maziggy/bambuddy — Rebuild to pull a newer upstream tag."
LABEL org.opencontainers.image.source="https://github.com/Poltavtcev/hassio-koinsight"
LABEL org.opencontainers.image.licenses="MIT License"

RUN apt-get update \
  && apt-get install -y --no-install-recommends jq \
  && rm -rf /var/lib/apt/lists/*

ENV PORT=8480

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
