# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# KoInsight builds work because every FROM is explicit (node:22-alpine). This add-on used
# FROM $BUILD_FROM + build.yaml; Supervisor 2026+ may not inject BUILD_FROM, which breaks
# validation and can hide the add-on in the store. Use the published multi-arch base-python
# image (amd64 + aarch64 only — matches HA base images).
#
ARG BAMBUDDY_VERSION=latest

FROM ghcr.io/maziggy/bambuddy:${BAMBUDDY_VERSION} AS builder

FROM ghcr.io/home-assistant/base-python:3.13-alpine3.23

LABEL org.opencontainers.image.title="Home Assistant Add-on: Bambuddy (rolling)"
LABEL org.opencontainers.image.description="BamBuddy from ghcr.io/maziggy/bambuddy:latest — rebuild the add-on to pick up new upstream releases."
LABEL org.opencontainers.image.source="https://github.com/Poltavtcev/hassio-koinsight"
LABEL org.opencontainers.image.licenses="MIT License"

WORKDIR /app

RUN apk add --no-cache \
  build-base \
  linux-headers \
  py3-opencv \
  curl \
  ffmpeg

COPY --from=builder /app/requirements.txt ./
RUN pip install --root-user-action=ignore -r requirements.txt

COPY --from=builder /app /app

ENV PYTHONUNBUFFERED=1
ENV DATA_DIR=/app/data
ENV LOG_DIR=/app/logs

COPY rootfs /
