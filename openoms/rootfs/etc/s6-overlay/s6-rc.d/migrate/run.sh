#!/usr/bin/env bash
# Apply golang-migrate up-migrations. Idempotent — exits 0 when already current.
set -euo pipefail

# shellcheck disable=SC1091
source /run/openoms/env

echo "[migrate] applying database migrations…"
exec /usr/local/bin/openoms-migrate \
    -path=/opt/openoms/migrations \
    -database="${WORKER_DATABASE_URL}" \
    up
