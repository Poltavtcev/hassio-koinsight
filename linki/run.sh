#!/bin/bash
set -e

CONFIG_FILE="/data/options.json"
if [ -f "$CONFIG_FILE" ]; then
  NEXTAUTH_URL=$(jq -r '.nextauth_url // empty' "$CONFIG_FILE")
  NEXTAUTH_SECRET=$(jq -r '.nextauth_secret // empty' "$CONFIG_FILE")
  AUTH_PASSWORD=$(jq -r '.auth_password // empty' "$CONFIG_FILE")
fi

if [ -z "$NEXTAUTH_URL" ] || [ "$NEXTAUTH_URL" == "null" ]; then
  echo "[ERROR] nextauth_url is required!"
  exit 1
fi
if [ -z "$NEXTAUTH_SECRET" ] || [ "$NEXTAUTH_SECRET" == "null" ] || [ "$NEXTAUTH_SECRET" == "generate_a_random_secret_here" ]; then
  echo "[ERROR] nextauth_secret is required and must be changed from default!"
  exit 1
fi
if [ -z "$AUTH_PASSWORD" ] || [ "$AUTH_PASSWORD" == "null" ] || [ "$AUTH_PASSWORD" == "change_me" ]; then
  echo "[ERROR] auth_password is required and must be changed from default!"
  exit 1
fi

export NEXTAUTH_URL
export NEXTAUTH_SECRET
export AUTH_PASSWORD
export LINKI_DB_PATH="/data/linki.db"

echo "[INFO] Starting Linki..."
echo "[INFO] URL: $NEXTAUTH_URL"
echo "[INFO] Database Path: $LINKI_DB_PATH"

cd /src
exec npm start
