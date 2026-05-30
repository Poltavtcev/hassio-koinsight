#!/usr/bin/env bash
# One-shot DB bootstrap. Runs after the postgres longrun is up.
#   1. Waits for the cluster to accept connections.
#   2. Creates the "openoms" database (owned by the openoms superuser).
#   3. Creates the least-privilege "openoms_app" role used by the API server.
# Idempotent: safe to re-run on every container start.
set -euo pipefail

# shellcheck disable=SC1091
source /run/openoms/env

# initdb was run with --username=openoms, so the cluster has no "postgres"
# role — every psql/pg_isready call must specify -U openoms explicitly.
echo "[postgres-init] waiting for cluster on 127.0.0.1:5432…"
for _ in $(seq 1 60); do
    if su-exec postgres pg_isready -h 127.0.0.1 -p 5432 -U openoms -d postgres -q; then
        break
    fi
    sleep 1
done

if ! su-exec postgres pg_isready -h 127.0.0.1 -p 5432 -U openoms -d postgres -q; then
    echo "[postgres-init] FATAL: postgres did not become ready in time" >&2
    exit 1
fi

# Ensure the application database exists. Use the local Unix socket + the
# "local all all trust" line installed by initdb, so no password is needed.
db_exists=$(su-exec postgres psql -U openoms -d postgres -tAXc "SELECT 1 FROM pg_database WHERE datname='openoms'")
if [[ -z "${db_exists}" ]]; then
    echo "[postgres-init] creating database 'openoms'"
    su-exec postgres psql -U openoms -v ON_ERROR_STOP=1 -d postgres -c "CREATE DATABASE openoms OWNER openoms;"
fi

# Ensure the least-privilege application role exists, and (re)set its password.
su-exec postgres psql -U openoms -v ON_ERROR_STOP=1 -d openoms \
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
