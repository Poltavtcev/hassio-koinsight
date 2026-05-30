# Changelog

All notable changes to the OpenOMS add-on are documented here.

## 0.1.1

- Add `registration_mode` option (`open` / `invite` / `closed`) exposed through
  the add-on Configuration tab and forwarded to the API as `REGISTRATION_MODE`.
  Default stays `open` so the first admin can be bootstrapped via
  `POST /v1/auth/register`; flip to `closed` afterwards to disable public
  signup (the upstream dashboard has no UI for open registration).
- README: replaced the "guided onboarding wizard" instructions with the actual
  one-shot `curl` bootstrap recipe + post-bootstrap lockdown step.

## 0.1.0 — Initial release

- First Home Assistant packaging of [OpenOMS](https://github.com/openoms-org/openoms).
- Single-container layout: PostgreSQL 17 + Redis 7 + Go API server + Next.js dashboard,
  supervised by `s6-overlay` v3.
- Pulls pre-built upstream images
  `ghcr.io/openoms-org/openoms-{api,dashboard,migrate}:latest` so HA **Rebuild**
  refreshes the stack in ~1 minute.
- Auto-generates strong `JWT_SECRET`, `ENCRYPTION_KEY`, Postgres superuser and
  app-role passwords on first boot; persists them to `/data/secrets.env` so
  they survive restarts / rebuilds.
- Database migrations applied on every start via the upstream `openoms-migrate`
  binary (idempotent).
- Ports exposed: `3000` (dashboard, set as `webui`) and `8080` (API; watchdog
  hits `/health`).
- Architectures: `aarch64`, `amd64`.
