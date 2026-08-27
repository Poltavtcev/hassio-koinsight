# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# Thin HA wrapper — extends the pre-built BamBuddy image (no compile on HA).
# Active default: fork with storage locations Phase 2.
# For upstream maziggy: cp bambuddy/build.upstream.yaml bambuddy/build.yaml
#   and change the FROM line below to ghcr.io/maziggy/bambuddy:latest
FROM ghcr.io/maziggy/bambuddy:latest

LABEL org.opencontainers.image.title="Home Assistant Add-on: Bambuddy"
LABEL org.opencontainers.image.description="BamBuddy wrapper — Rebuild pulls image from Dockerfile FROM (upstream)."
LABEL org.opencontainers.image.source="https://github.com/Poltavtcev/hassio-koinsight"
LABEL org.opencontainers.image.licenses="AGPL-3.0"

RUN apt-get update \
  && apt-get install -y --no-install-recommends jq \
  && rm -rf /var/lib/apt/lists/*

ENV PORT=8480

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
