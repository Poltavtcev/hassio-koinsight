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

# Replace only symlinks / image stubs — never "rm -rf" through a symlink into /share or /media.
replace_link() {
  local target="$1"
  local dest="$2"
  if [[ -L "${target}" ]]; then
    rm -f "${target}"
  elif [[ -d "${target}" ]] && [[ -z "$(ls -A "${target}" 2>/dev/null || true)" ]]; then
    rmdir "${target}" 2>/dev/null || rm -rf "${target}"
  elif [[ -e "${target}" ]]; then
    echo "WARNING: ${target} exists and is not a symlink; leaving it in place (expected link to ${dest})"
    return 1
  fi
  ln -sfn "${dest}" "${target}"
  return 0
}

replace_link /config /data/config || true
replace_link /calibre-library "${LIBRARY}"
replace_link /cwa-book-ingest "${INGEST}"

echo "=== Calibre-Web Automated (Home Assistant add-on) ==="
echo "library_path option: ${LIBRARY}"
echo "ingest_path option:  ${INGEST}"
echo "container links:     /calibre-library -> $(readlink -f /calibre-library 2>/dev/null || echo '?')"
echo "                     /cwa-book-ingest -> $(readlink -f /cwa-book-ingest 2>/dev/null || echo '?')"

if [[ ! -d "${LIBRARY}" ]]; then
  echo "ERROR: library_path '${LIBRARY}' is not a directory inside the container."
  echo "       Check Supervisor maps (share/media) and the folder name (Linux is case-sensitive: Books vs books)."
  exit 1
fi

if [[ -f "${LIBRARY}/metadata.db" ]]; then
  echo "Found existing Calibre library: ${LIBRARY}/metadata.db"
else
  echo "No metadata.db in ${LIBRARY} — CWA will create a new empty library there on first start."
  echo "If you already use Calibre elsewhere, point library_path at the folder that contains metadata.db."
  echo "Plain ebook files (no Calibre library) go in ingest_path: ${INGEST}"
fi

if [[ -f /data/config/app.db ]]; then
  stored=$(sqlite3 /data/config/app.db "SELECT config_calibre_dir FROM settings LIMIT 1;" 2>/dev/null || true)
  if [[ -n "${stored}" ]] && [[ "${stored}" != "${LIBRARY}" ]] && [[ "${stored}" != "/calibre-library" ]]; then
    echo "NOTE: app.db still lists library '${stored}'. After changing library_path, use CWA Admin ->"
    echo "      Edit Calibre database -> Library location, or stop the add-on and remove /data/config/app.db to re-detect."
  fi
fi

exec /init
