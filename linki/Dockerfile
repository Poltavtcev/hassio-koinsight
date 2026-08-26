# Build Linki from source.
# Base image PINNED to a digest. The browser fingerprint LinkedIn sees is derived
# from the Chromium build below, which depends on this base.
FROM node:22-slim@sha256:d9f850096136edbc402debdd8729579a288aac64574ada0ff4db26b6ae58b0b2

RUN echo "deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/20260620T000000Z/ bookworm main" > /etc/apt/sources.list \
  && echo "deb [check-valid-until=no] http://snapshot.debian.org/archive/debian-security/20260620T000000Z/ bookworm-security main" >> /etc/apt/sources.list \
  && echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99snapshot \
  && apt-get -o Acquire::Retries=3 update && apt-get install -y --no-install-recommends \
  chromium=149.0.7827.155-1~deb12u1 \
  chromium-common=149.0.7827.155-1~deb12u1 \
  chromium-sandbox=149.0.7827.155-1~deb12u1 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libdbus-1-3 \
  libdrm2 \
  libgbm1 \
  libgtk-3-0 \
  libnss3 \
  libxcomposite1 \
  libxdamage1 \
  libxfixes3 \
  libxkbcommon0 \
  libxrandr2 \
  xdg-utils \
  git \
  ca-certificates \
  jq \
  bash \
  && rm -rf /var/lib/apt/lists/*

ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/usr/bin/chromium

ARG LINKI_REPO=https://github.com/moaljumaa/linki.git
ARG LINKI_REF=main

WORKDIR /src
RUN git clone -- "${LINKI_REPO}" . \
  && git checkout "${LINKI_REF}"

RUN npm ci
RUN npm run build

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
