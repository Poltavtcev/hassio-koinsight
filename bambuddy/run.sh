#!/bin/sh
set -e

mkdir -p /data/data /data/logs
rm -rf /app/data /app/logs
ln -sfn /data/data /app/data
ln -sfn /data/logs /app/logs
cd /app

if [ -f /data/options.json ]; then
  DEBUG=$(python3 -c "import json; print('true' if json.load(open('/data/options.json')).get('debug') else 'false')" 2>/dev/null || echo "false")
else
  DEBUG=false
fi
if [ "$DEBUG" = "true" ]; then
  export DEBUG=true
fi

export HA_URL="http://supervisor/core"
export HA_TOKEN="${SUPERVISOR_TOKEN}"

exec uvicorn backend.app.main:app --host 0.0.0.0 --port 8000 --loop asyncio
