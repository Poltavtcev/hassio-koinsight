ARG BUILD_FROM=ghcr.io/maziggy/bambu-studio-api:latest
FROM $BUILD_FROM

LABEL org.opencontainers.image.title="Home Assistant Add-on: Bambu Studio Sidecar"
LABEL org.opencontainers.image.description="Bambu Studio Slicer API for BamBuddy"
LABEL org.opencontainers.image.source="https://github.com/Poltavtcev/hassio-koinsight"
LABEL org.opencontainers.image.licenses="AGPL-3.0"

# Install jq to parse HA options.json
RUN apt-get update \
  && apt-get install -y --no-install-recommends jq \
  && rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
