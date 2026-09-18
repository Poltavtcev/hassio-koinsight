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

# Slicer API natively looks at the PORT variable.
# Navigate to the app directory.
if [ -d "/app" ]; then
  cd /app
elif [ -d "/usr/src/app" ]; then
  cd /usr/src/app
fi

if [ -f "src/index.js" ]; then
  exec node src/index.js
elif [ -f "server.js" ]; then
  exec node server.js
else
  echo "WARN: Could not find node app entry point. Attempting npm start."
  exec npm start
fi
