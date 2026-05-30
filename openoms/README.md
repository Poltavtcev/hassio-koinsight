# OpenOMS — Home Assistant Add-on

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

**OpenOMS** — open-source order management system (Allegro, InPost, DHL, DPD,
GLS, WooCommerce, eBay, Amazon SP-API, Kaufland, OLX, Mirakl/Empik, Erli,
Shoper, PrestaShop, Shopify; 463 API endpoints, 141 dashboard pages).
Upstream: [openoms-org/openoms](https://github.com/openoms-org/openoms).

This add-on packs the **whole stack** into a single container — PostgreSQL 17,
Redis 7, the Go API server and the Next.js dashboard — supervised by
`s6-overlay`. Pre-built upstream images are pulled at build time, so HA
**Rebuild** is fast.

## Hardware

OpenOMS is heavier than the other add-ons in this repo. Plan for at least:

- **2 GB RAM** free for the add-on (Postgres + Redis + Node + Go)
- **2 vCPU** (Pi 5 / NUC class — Pi 4 works for evaluation but will be slow)
- **~2 GB disk** for the image + initial DB

## Ports

| Port | Purpose | Default |
|------|---------|---------|
| `3000/tcp` | Dashboard (Next.js)   | `3000` |
| `8080/tcp` | API server / Swagger  | `8080` (Swagger UI at `/swagger/`) |

The dashboard talks to the API in-container over `127.0.0.1:8080`. Both
external ports are exposed for direct access if you want to use the API from
Home Assistant / scripts.

## Storage

Everything persistent lives on the add-on `/data` volume:

```
/data/postgres   — PostgreSQL cluster (initdb on first boot)
/data/redis      — Redis RDB/AOF (RDB disabled by default)
/data/uploads    — order attachments, generated PDFs
/data/secrets.env — auto-generated passwords / keys
```

Take a **Home Assistant backup** before uninstalling.

## Configuration

All options are visible in the add-on Configuration tab. Leave **all four
secrets blank on first run** — strong values are generated automatically and
persisted to `/data/secrets.env`. Override only if you have to.

| Option | Required | Notes |
|--------|----------|-------|
| `postgres_password` / `postgres_app_password` | no | auto-generated when blank |
| `jwt_secret` (≥ 64 chars) | no | auto-generated when blank |
| `encryption_key` (64-char hex) | no | auto-generated when blank |
| `base_url` / `frontend_url` | recommended | set to your HA reverse-proxy URL once exposed |
| `trusted_proxy_cidrs` | optional | e.g. `192.168.1.0/24` when behind Nginx Proxy Manager |
| `allegro_client_id` / `allegro_client_secret` / `allegro_webhook_secret` | optional | Allegro REST integration; can also be configured later in the UI |
| `inpost_api_token` / `inpost_organization_id` / `inpost_webhook_secret` / `inpost_geowidget_token` | optional | InPost ShipX + GeoWidget on Order page |
| `openai_api_key` / `openai_model` | optional | enables AI product categorisation/descriptions |
| `feature_allegro` / `feature_inpost` | toggle | turn integration modules off without removing creds |
| `workers_enabled` | toggle | run background workers in this container |
| `log_level` | optional | `debug` / `info` / `warning` / `error` |

> Rotating secrets: change the value in the add-on UI and restart — the new
> value overwrites `/data/secrets.env`. The Postgres role password is updated
> on every start by the `postgres-init` step.

## First-run admin account

There is **no default production password** (unlike `task seed` in upstream
dev mode). After first start, complete the **guided onboarding wizard** at
the dashboard URL to create the first organisation + admin user, or use the
registration / invite / license-token flow described in upstream
[`CHANGELOG.md`](https://github.com/openoms-org/openoms/blob/main/CHANGELOG.md).

## Updating

The add-on is a thin wrapper around three upstream images:

- `ghcr.io/openoms-org/openoms-api:latest`
- `ghcr.io/openoms-org/openoms-dashboard:latest`
- `ghcr.io/openoms-org/openoms-migrate:latest`

To pull newer upstream images, hit **Rebuild** on the add-on page. To pin a
specific version, change `OPENOMS_VERSION` in [`build.yaml`](build.yaml) (e.g.
to a commit SHA published by the upstream release workflow).

## Using a fork

Set the three image args in [`build.yaml`](build.yaml) to your fork (e.g.
`ghcr.io/poltavtcev/openoms-api`) and publish those images via the included
`publish-openoms-fork.yml` GitHub Actions workflow. Then **Rebuild** the
add-on. The workflow lives in this repository and is triggered manually
(`workflow_dispatch`).

## Troubleshooting

**`postgres-init` keeps failing** — check the add-on log for the actual error.
The most common cause is a stale `/data/postgres` directory from a previous
incompatible Postgres version: remove the add-on, delete the add-on data on
the host, reinstall.

**Dashboard can't reach the API** — the dashboard proxies via
`DASHBOARD_API_PROXY_URL=http://127.0.0.1:8080`. If you've changed the API
port mapping in Configuration, also update `base_url`.

**Migration error** — `openoms-migrate` is idempotent; restart the add-on. If
the error persists, copy the log and open an issue.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
