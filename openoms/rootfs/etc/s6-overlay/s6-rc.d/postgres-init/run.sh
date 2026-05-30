#!/usr/bin/env bash
# One-shot DB bootstrap. Runs after the postgres longrun is up.
#   1. Waits for the cluster to accept connections.
#   2. Creates the "openoms" database (owned by the openoms superuser).
#   3. Creates the least-privilege "openoms_app" role used by the API server.
# Idempotent: safe to re-run on every container start.
set -euo pipefail

# shellcheck disable=SC1091
source /run/openoms/env

echo "[postgres-init] waiting for cluster on 127.0.0.1:5432…"
for _ in $(seq 1 60); do
    if su-exec postgres pg_isready -h 127.0.0.1 -p 5432 -d postgres -q; then
        break
    fi
    sleep 1
done

if ! su-exec postgres pg_isready -h 127.0.0.1 -p 5432 -d postgres -q; then
    echo "[postgres-init] FATAL: postgres did not become ready in time" >&2
    exit 1
fi

# Ensure the application database exists.
db_exists=$(su-exec postgres psql -tAXc "SELECT 1 FROM pg_database WHERE datname='openoms'" postgres)
if [[ -z "${db_exists}" ]]; then
    echo "[postgres-init] creating database 'openoms'"
    su-exec postgres psql -v ON_ERROR_STOP=1 -d postgres -c "CREATE DATABASE openoms OWNER openoms;"
fi

# Ensure the least-privilege application role exists, and (re)set its password.
PGPASSWORD="${POSTGRES_PASSWORD}" \
    psql -v ON_ERROR_STOP=1 -h 127.0.0.1 -U openoms -d openoms \
         -v app_password="${POSTGRES_APP_PASSWORD}" <<'EOSQL'
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'openoms_app') THEN
        CREATE ROLE openoms_app LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOBYPASSRLS;
    END IF;
END
$$;

ALTER ROLE openoms_app WITH PASSWORD :'app_password';
EOSQL

echo "[postgres-init] ready"
