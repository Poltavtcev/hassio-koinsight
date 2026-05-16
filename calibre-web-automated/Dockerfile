# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# Upstream: https://github.com/crocodilestick/Calibre-Web-Automated
# Image publishes linux/amd64 + linux/arm64 (matches HA aarch64 / amd64).
ARG CWA_VERSION=latest

FROM crocodilestick/calibre-web-automated:${CWA_VERSION}

LABEL org.opencontainers.image.title="Home Assistant Add-on: Calibre-Web Automated"
LABEL org.opencontainers.image.description="Calibre-Web Automated from Docker Hub — Rebuild the add-on to pull a newer upstream tag."
LABEL org.opencontainers.image.source="https://github.com/Poltavtcev/hassio-koinsight"
LABEL org.opencontainers.image.licenses="GPL-3.0"

RUN apt-get update \
  && apt-get install -y --no-install-recommends jq sqlite3 \
  && rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
