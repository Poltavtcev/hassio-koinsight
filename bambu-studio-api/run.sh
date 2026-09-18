#!/bin/bash
set -euo pipefail

OPTIONS=/data/options.json
PORT=8080
if [[ -f "${OPTIONS}" ]]; then
  PORT=$(jq -r '.port // 8080' "${OPTIONS}")
fi

export PORT

echo "=== Bambu Studio Sidecar (Home Assistant add-on) ==="
echo "PORT=${PORT}"

# Run the API
exec node /app/dist/index.js
