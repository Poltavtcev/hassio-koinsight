# Home Assistant add-on: OpenOMS — single-container OMS stack.
#
# Strategy: pull pre-built upstream multi-arch images for the API, dashboard
# and migrate runner, then assemble them into one Alpine container together
# with PostgreSQL 17 + Redis 7. Services are supervised by s6-overlay v3.
# Rebuilding the add-on on HAOS re-pulls upstream :latest, so updates are fast.

ARG OPENOMS_API_IMAGE=ghcr.io/openoms-org/openoms-api
ARG OPENOMS_DASHBOARD_IMAGE=ghcr.io/openoms-org/openoms-dashboard
ARG OPENOMS_MIGRATE_IMAGE=ghcr.io/openoms-org/openoms-migrate
ARG OPENOMS_VERSION=latest
ARG BUILD_FROM=docker.io/library/alpine:3.21

FROM ${OPENOMS_API_IMAGE}:${OPENOMS_VERSION} AS api
FROM ${OPENOMS_DASHBOARD_IMAGE}:${OPENOMS_VERSION} AS dashboard
FROM ${OPENOMS_MIGRATE_IMAGE}:${OPENOMS_VERSION} AS migrate

FROM ${BUILD_FROM}

ARG TARGETARCH
ARG S6_OVERLAY_VERSION=3.2.0.2

LABEL org.opencontainers.image.title="Home Assistant Add-on: OpenOMS"
LABEL org.opencontainers.image.description="OpenOMS OMS — single-container HA add-on bundling PostgreSQL 17 + Redis 7 + Go API + Next.js dashboard."
LABEL org.opencontainers.image.source="https://github.com/Poltavtcev/hassio-koinsight"
LABEL org.opencontainers.image.licenses="ELv2"

# Runtime dependencies.
#   - postgresql17 + contrib for the embedded DB (data lives on /data/postgres)
#   - redis for the cache / queue
#   - nodejs to run the upstream Next.js standalone bundle (built against node22)
#   - su-exec for dropping to a non-root user inside service scripts
#   - openssl for generating persistent secrets on first boot
#   - libstdc++/libgcc are pulled in by nodejs; explicit for clarity
RUN apk add --no-cache \
        bash curl jq tzdata ca-certificates openssl \
        su-exec xz shadow \
        postgresql17 postgresql17-client postgresql17-contrib \
        redis \
        nodejs \
        libstdc++ libgcc

# Install s6-overlay v3 (process supervisor used by most HA add-ons).
# Detect arch from uname so this works under both buildx (TARGETARCH set) and
# the legacy HA builder (TARGETARCH unset).
RUN set -eu; \
    case "$(uname -m)" in \
        x86_64|amd64)   s6_arch=x86_64 ;; \
        aarch64|arm64)  s6_arch=aarch64 ;; \
        armv7l|armhf)   s6_arch=arm ;; \
        *) echo "unsupported arch $(uname -m)" >&2; exit 1 ;; \
    esac; \
    curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz" \
        | tar -C / -Jxpf -; \
    curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${s6_arch}.tar.xz" \
        | tar -C / -Jxpf -

# OpenOMS binaries / static assets from the upstream distroless images.
# api-server is built CGO_ENABLED=0 + static, so it runs on Alpine/musl unchanged.
COPY --from=api      /server      /usr/local/bin/openoms-api
COPY --from=api      /healthcheck /usr/local/bin/openoms-healthcheck
COPY --from=migrate  /migrate     /usr/local/bin/openoms-migrate
COPY --from=migrate  /migrations  /opt/openoms/migrations

# Dashboard: Next.js "standalone" output (server.js + .next + public). Portable JS.
COPY --from=dashboard /app /opt/openoms/dashboard

# rootfs overlays s6 service definitions, entrypoint and helpers.
COPY rootfs/ /

RUN chmod +x /entrypoint.sh \
 && find /etc/s6-overlay/s6-rc.d -type f \( -name run -o -name up -o -name finish \) -exec chmod +x {} + \
 && mkdir -p /opt/openoms /run/openoms /run/postgresql

# Environment defaults; per-install secrets are materialised by entrypoint.sh.
ENV S6_LOGGING=1 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=120000 \
    PGDATA=/data/postgres \
    REDIS_DIR=/data/redis \
    UPLOAD_DIR=/data/uploads \
    DASHBOARD_PORT=3000 \
    PORT=8080 \
    NODE_ENV=production \
    HOSTNAME=0.0.0.0 \
    ENV=production

EXPOSE 3000 8080

# entrypoint.sh reads /data/options.json, persists secrets, then exec's s6 /init.
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/init"]
