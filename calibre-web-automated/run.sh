#!/bin/bash
# Do not use set -e during path setup — busy mount points must not abort startup.
set -uo pipefail

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

mkdir -p /data/config "${LIBRARY}" "${INGEST}" 2>/dev/null || true

# Point CWA's fixed paths at HA options. Never rm -rf (mount points raise "Device or resource busy").
link_to() {
  local link="$1"
  local dest="$2"
  local dest_resolved

  dest_resolved=$(readlink -f "${dest}")

  if [[ -L "${link}" ]]; then
    if [[ "$(readlink -f "${link}")" == "${dest_resolved}" ]]; then
      return 0
    fi
    rm -f "${link}" 2>/dev/null || true
  fi

  if [[ -e "${link}" ]] && [[ ! -L "${link}" ]]; then
    if mountpoint -q "${link}" 2>/dev/null; then
      umount "${link}" 2>/dev/null || true
    fi
    if [[ -d "${link}" ]] && ! mountpoint -q "${link}" 2>/dev/null; then
      rmdir "${link}" 2>/dev/null || true
    fi
  fi

  if [[ ! -e "${link}" ]]; then
    ln -sfn "${dest_resolved}" "${link}"
    echo "INFO: ${link} -> ${dest_resolved} (symlink)"
    return 0
  fi

  if mount --bind "${dest_resolved}" "${link}" 2>/dev/null; then
    echo "INFO: ${link} bind-mounted to ${dest_resolved}"
    return 0
  fi

  echo "ERROR: Could not redirect ${link} to ${dest_resolved} (path busy). Restart the add-on after a full stop, or reinstall."
  return 1
}

link_to /config /data/config || true
link_to /calibre-library "${LIBRARY}" || true
link_to /cwa-book-ingest "${INGEST}" || true

echo "=== Calibre-Web Automated (Home Assistant add-on) ==="
echo "library_path option: ${LIBRARY}"
echo "ingest_path option:  ${INGEST}"
echo "resolved library:  $(readlink -f /calibre-library 2>/dev/null || echo 'n/a')"
echo "resolved ingest:     $(readlink -f /cwa-book-ingest 2>/dev/null || echo 'n/a')"

if [[ ! -d "${LIBRARY}" ]]; then
  echo "ERROR: library_path '${LIBRARY}' is not a directory (check share/media map and spelling)."
  exit 1
fi

if [[ -f "${LIBRARY}/metadata.db" ]]; then
  echo "Found existing Calibre library: ${LIBRARY}/metadata.db"
else
  echo "No metadata.db in ${LIBRARY} — CWA will create a new library there unless you change library_path."
fi

set -e
exec /init
