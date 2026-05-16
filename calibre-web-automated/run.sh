#!/bin/bash
set -euo pipefail

OPTIONS=/data/options.json
if [[ ! -f "${OPTIONS}" ]]; then
  echo "Missing ${OPTIONS} — is the add-on configured in Supervisor?"
  exit 1
fi

PUID=$(jq -r '.puid // 0' "${OPTIONS}")
PGID=$(jq -r '.pgid // 0' "${OPTIONS}")
TZ=$(jq -r '.timezone // "UTC"' "${OPTIONS}")
LIBRARY=$(jq -r '.library_path // "/data/calibre-library"' "${OPTIONS}")
INGEST=$(jq -r '.ingest_path // "/data/cwa-book-ingest"' "${OPTIONS}")
HARDCOVER=$(jq -r '.hardcover_token // ""' "${OPTIONS}")
NETWORK_SHARE=$(jq -r '.network_share_mode // false' "${OPTIONS}")

export PUID PGID TZ
export HARDCOVER_TOKEN="${HARDCOVER}"
export NETWORK_SHARE_MODE="${NETWORK_SHARE}"

mkdir -p /data/config
mkdir -p "$(dirname "${LIBRARY}")" "$(dirname "${INGEST}")" 2>/dev/null || true
mkdir -p "${LIBRARY}" "${INGEST}" 2>/dev/null || true

# CWA expects these mount points inside the container.
rm -rf /config /calibre-library /cwa-book-ingest 2>/dev/null || true
ln -sfn /data/config /config
ln -sfn "${LIBRARY}" /calibre-library
ln -sfn "${INGEST}" /cwa-book-ingest

echo "Calibre-Web Automated starting (library=${LIBRARY}, ingest=${INGEST}, TZ=${TZ})"
exec /init
