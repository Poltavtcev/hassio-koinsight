# Build KoInsight from source. Defaults match koinsight/build.yaml (fork + default branch).
# Override via build.yaml args in this folder.
FROM node:22-alpine AS builder

ARG KOINSIGHT_REPO=https://github.com/Poltavtcev/KoInsight.git
ARG KOINSIGHT_REF=master

RUN apk add --no-cache git python3 make g++

ARG BUILD_VERSION=0.4.3
WORKDIR /src
RUN git clone -- "${KOINSIGHT_REPO}" . \
  && git checkout "${KOINSIGHT_REF}"

RUN npm install
RUN npm run build

# Runtime image (no bashio: use jq + /data/options.json like other minimal HA add-ons)
FROM node:22-alpine

WORKDIR /app
RUN mkdir -p /app/data

COPY --from=builder /src/node_modules /app/node_modules
COPY --from=builder /src/apps/server/dist /app/apps/server/dist
COPY --from=builder /src/apps/web/dist /app/apps/web/dist
COPY --from=builder /src/plugins /app/plugins

RUN apk add --no-cache bash curl jq

ENV NODE_ENV="production"
ENV DATA_PATH="/app/data"
ENV MAX_FILE_SIZE_MB="100"

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
