#!/bin/bash
set -euo pipefail

OPTIONS=/data/options.json
DEBUG=false
if [[ -f "${OPTIONS}" ]]; then
  DEBUG=$(jq -r '.debug // false' "${OPTIONS}")
fi

export PUID="${PUID:-1000}"
export PGID="${PGID:-1000}"

mkdir -p /data/data /data/logs

# Keep BamBuddy state on the HA add-on /data volume across image updates.
setup_data_link() {
  local name="$1"
  local target="/data/${name}"
  local app_path="/app/${name}"

  mkdir -p "${target}"

  if [[ -L "${app_path}" ]]; then
    return 0
  fi

  if [[ -d "${app_path}" ]] && [[ ! -L "${app_path}" ]]; then
    if [[ -z "$(ls -A "${target}" 2>/dev/null)" ]]; then
      cp -a "${app_path}/." "${target}/" 2>/dev/null || true
    fi
    rm -rf "${app_path}"
  fi

  ln -sfn "${target}" "${app_path}"
}

setup_data_link data
setup_data_link logs

# Upstream entrypoint only chowns when the directory uid differs; files inside can
# stay root-owned (e.g. after HA/supervisor created them). Always fix real paths.
fix_data_permissions() {
  touch /data/data/.bambuddy /data/logs/.bambuddy 2>/dev/null || true

  if chown -R "${PUID}:${PGID}" /data/data /data/logs; then
    echo "INFO: ownership ${PUID}:${PGID} on /data/data and /data/logs"
    return 0
  fi

  echo "WARN: chown to ${PUID}:${PGID} failed (read-only or NFS mount); using root for BamBuddy"
  export PUID=0
  export PGID=0
  chown -R 0:0 /data/data /data/logs 2>/dev/null || true
}

fix_data_permissions

export PORT=8480
export HA_URL="http://supervisor/core"
export HA_TOKEN="${SUPERVISOR_TOKEN:-}"

if [[ "${DEBUG}" == "true" ]]; then
  export DEBUG=true
fi

echo "=== BamBuddy (Home Assistant add-on) ==="
echo "data: $(readlink -f /app/data 2>/dev/null || echo /app/data)"
echo "logs: $(readlink -f /app/logs 2>/dev/null || echo /app/logs)"
echo "PORT=${PORT}  PUID=${PUID}  PGID=${PGID}"

exec /usr/local/bin/docker-entrypoint.sh \
  sh -c 'uvicorn backend.app.main:app --host 0.0.0.0 --port ${PORT:-8480} --loop asyncio'
