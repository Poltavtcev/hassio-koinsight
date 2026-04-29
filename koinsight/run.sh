#!/bin/bash
set -e

CONFIG_FILE="/data/options.json"
if [ -f "$CONFIG_FILE" ]; then
  DATA_PATH=$(jq -r '.data_path // empty' "$CONFIG_FILE")
  LOG_LEVEL=$(jq -r '.log_level // "info"' "$CONFIG_FILE")
else
  DATA_PATH=""
  LOG_LEVEL="info"
fi

if [ -z "$DATA_PATH" ]; then
  DATA_PATH="/share/koinsight"
fi

mkdir -p "$DATA_PATH"

export DATA_PATH
export LOG_LEVEL

echo "[INFO] Starting KoInsight..."
echo "[INFO] Data path: $DATA_PATH"
echo "[INFO] Log level: $LOG_LEVEL"

if [ ! -L "/app/data" ]; then
  rm -rf /app/data 2>/dev/null || true
  ln -sf "$DATA_PATH" /app/data
fi

cd /app
exec node apps/server/dist/app.js
