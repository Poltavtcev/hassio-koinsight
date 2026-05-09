# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
# Runtime matches upstream BamBuddy (python:3.13-slim / Debian) — no Alpine pip rebuild.
ARG BAMBUDDY_VERSION=latest
FROM ghcr.io/maziggy/bambuddy:${BAMBUDDY_VERSION}

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
