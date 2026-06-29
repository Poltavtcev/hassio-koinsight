# KoInsight, BamBuddy, Calibre-Web & OpenOMS — Home Assistant Add-ons

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A//github.com/Poltavtcev/hassio-koinsight)

## About

This repository bundles **four** optional Home Assistant add-ons:

| Add-on | Upstream | What it does |
|--------|----------|----------------|
| **[KoInsight](./koinsight/)** | [KoInsight](https://github.com/GeorgeSG/KoInsight) | Web dashboard for **KOReader** reading statistics and sync |
| **[Bambuddy](./bambuddy/)** | [BamBuddy](https://github.com/maziggy/bambuddy) | **Bambu Lab** print archive, management, and virtual printer (LAN) |
| **[Calibre-Web Automated](./calibre-web-automated/)** | [Calibre-Web-Automated](https://github.com/crocodilestick/Calibre-Web-Automated) | **Calibre** library web UI with automatic book ingest |
| **[OpenOMS](./openoms/)** | [OpenOMS](https://github.com/openoms-org/openoms) | Open-source **Order Management System** (Allegro, InPost, DHL/DPD/GLS, WooCommerce, eBay, Amazon SP-API…); bundles PostgreSQL 17 + Redis 7 + Go API + Next.js dashboard |

Install only what you need from the Add-on Store after adding this repository.

## Add-ons

### [KoInsight](./koinsight/)

![Supports amd64 Architecture][amd64-shield]
![Supports arm64 Architecture][arm64-shield]

_KoInsight brings your KOReader reading stats to life with a clean, web-based dashboard._

### [Bambuddy](./bambuddy/)

![Supports aarch64 Architecture][bambuddy-aarch64-shield]
![Supports amd64 Architecture][bambuddy-amd64-shield]

_BamBuddy — HA add-on pulls **`ghcr.io/poltavtcev/bambuddy`** from fork **[Poltavtcev/bambuddy](https://github.com/Poltavtcev/bambuddy)**. Run workflow **Publish BamBuddy fork image** in this repo, then **Rebuild** on HA. **aarch64 / amd64**._

[bambuddy-aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[bambuddy-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg

### [Calibre-Web Automated](./calibre-web-automated/)

![Supports aarch64 Architecture][cwa-aarch64-shield]
![Supports amd64 Architecture][cwa-amd64-shield]

_Calibre-Web Automated — browse and manage your eBook library. Built from **`crocodilestick/calibre-web-automated:latest`**; **Rebuild** to refresh upstream._

[cwa-aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[cwa-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg

### [OpenOMS](./openoms/)

![Supports aarch64 Architecture][openoms-aarch64-shield]
![Supports amd64 Architecture][openoms-amd64-shield]

_OpenOMS — Open-source Order Management System with 463 API endpoints,
141 dashboard pages and integrations for Allegro, InPost, DHL/DPD/GLS, UPS,
Poczta Polska, Orlen Paczka, FedEx, WooCommerce, eBay, Amazon SP-API,
Kaufland, OLX, Mirakl/Empik, Erli, Shoper, PrestaShop, Shopify. Packed as a
**single container** with embedded PostgreSQL 17, Redis 7, the Go API server
and the Next.js dashboard supervised by `s6-overlay`. Pulls upstream
`ghcr.io/openoms-org/openoms-{api,dashboard,migrate}:latest` — **Rebuild** to
refresh. **Plan for ≥ 2 GB free RAM** (Postgres + Redis + Node + Go in one
container). To use a fork, repoint the three image args in
[`openoms/build.yaml`](openoms/build.yaml) and publish with the
[`Publish OpenOMS fork images`](.github/workflows/publish-openoms-fork.yml)
workflow._

[openoms-aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[openoms-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg

## KoInsight: build from source (rolling)

The KoInsight add-on **builds from Git** on your Home Assistant host (no pinned `ghcr.io` image).

- Default source: **[Poltavtcev/KoInsight](https://github.com/Poltavtcev/KoInsight)** @ **`master`** (see [`koinsight/build.yaml`](koinsight/build.yaml)).
- To use another fork or branch, edit `KOINSIGHT_REPO` / `KOINSIGHT_REF` there, then **Rebuild** the add-on in Supervisor.
- The first install can take several minutes (clone + `npm install` + build).

## Installation

Click the badge above or manually add this repository to your Home Assistant add-on store:

1. Go to **Supervisor** → **Add-on Store**
2. Click the **⋮** menu in the top right
3. Select **Repositories**
4. Add repository URL: `https://github.com/Poltavtcev/hassio-koinsight`
5. Close the dialog and refresh the page
6. Install **KoInsight** and/or **Bambuddy (rolling)** as needed

**No updates or Changelog shows `does not exist in the store`?** In **Settings → Add-ons → ⋮ → Repositories**, the URL must match the repo you actually use — this one:  
`https://github.com/Poltavtcev/hassio-koinsight`  
Each URL gets its own store id in Supervisor; a mismatch breaks changelog / update detection. Remove the repo entry, reload the page (or **Check for updates**), add the URL again, restart **Home Assistant Supervisor** if needed.

**Store still shows an old version (e.g. 1.0.3) while GitHub `main` is newer?** Supervisor sometimes serves a stale clone of community repositories.

1. **Settings → Add-ons → ⋮ → Repositories** — remove **KoInsight & BamBuddy Add-ons**, confirm, refresh the browser.
2. Add it again: `https://github.com/Poltavtcev/hassio-koinsight`.
3. **Developer tools → YAML → Restart Home Assistant Supervisor** (or **Settings → System → Restart** → restart Supervisor only, if your install exposes it).
4. Open the **Add-on Store**, find **Bambuddy (rolling)** — check the version line on the card (not only the installed instance).
5. If there is still no **Update**, open the add-on → **Rebuild** (builds from the freshly pulled git tree).

GitHub `main` is the source of truth:  
`https://raw.githubusercontent.com/Poltavtcev/hassio-koinsight/main/bambuddy/config.yaml`

**Bambuddy Rebuild but still upstream / no Phase 2 UI?** In **Supervisor** logs, search the `docker buildx build` line for BamBuddy. If you see `--build-arg BUILD_FROM=ghcr.io/maziggy/bambuddy:latest`, Supervisor’s deprecated `build.yaml` path overrode the fork (common on Supervisor 2026.04+). **Bambuddy 1.3.5+** removes `build.yaml` and hardcodes `FROM ghcr.io/poltavtcev/bambuddy:latest` in the Dockerfile — after updating the repo, **Rebuild** again and check the add-on **Log** tab for `fork image detected (storage locations Phase 2 API present)`.

**`Failed to rebuild app` / `App …_bambuddy is not available inside store`?**  
Supervisor stores each installed add-on against an internal store id (`<repo-hash>_<slug>`). If you **removed and re-added** this repository, **switched forks**, or Supervisor refreshed its git index, the **installed** Bambuddy entry can still point at an **old** store id — then **Rebuild**, **Update**, and **Changelog** fail even though the add-on appears in the UI.

**Recovery (recommended):**

1. Optional: create a **full backup** (Settings → System → Backups) if you care about BamBuddy data.
2. **Settings → Add-ons → Bambuddy (rolling) → ⋮ → Uninstall** (remove the broken install).
3. **Settings → Add-ons → ⋮ → Repositories** — remove `https://github.com/Poltavtcev/hassio-koinsight`, save, refresh the page.
4. **Developer tools → YAML → Restart Home Assistant Supervisor** (or restart Supervisor from **Settings → System** if available).
5. Add the repository again: `https://github.com/Poltavtcev/hassio-koinsight`.
6. **Add-on Store** → install **Bambuddy (rolling)** again — this binds to the **current** store entry.

After a fresh install, **Rebuild** should work. Your BamBuddy database/files normally live in the add-on’s data volume and are often kept across uninstall depending on platform — when unsure, rely on step 1.

**Only KoInsight appears from this repo, not Bambuddy?** See Supervisor logs (**Settings → System → Logs** → choose **Supervisor**). If you see **`Can't read …/bambuddy/config.yaml`** with **`webui`**, use **`http://[HOST]:[PORT:8480]`** (not a literal port after `[HOST]` without `[PORT:…]`) — see **Bambuddy 1.1.3+**. Other causes: invalid `schema`, unsupported **Dockerfile** syntax, bad **`FROM`**, or wrong **`arch`** list. Refresh the repo after updating.

## Features

**KoInsight**

- 📈 Interactive dashboard with reading statistics and charts  
- 🔄 KOReader plugin for automatic syncing  
- 📱 Multi-device support  
- 📤 Manual SQLite database upload  
- ♻️ Acts as a KOReader sync server  
- 🏠 Fully self-hosted in Home Assistant  

**Bambuddy**

- 🖨️ Bambu Lab workflow helpers (archive, virtual printer on host network where configured)  
- 🔁 **Rebuild** pulls **`ghcr.io/poltavtcev/bambuddy:latest`** (fork; run **Publish BamBuddy fork image** when the fork code changes)  

**OpenOMS**

- 🛒 Multi-marketplace orders (Allegro, eBay, Amazon SP-API, WooCommerce, Kaufland, OLX, Erli, Shoper, PrestaShop, Shopify, Mirakl/Empik)  
- 📦 Carrier label generation + rate shopping (InPost, DHL, DPD, GLS, UPS, Poczta Polska, Orlen Paczka, FedEx)  
- 🧾 Invoicing (Fakturownia, inFakt, wFirma) and Polish KSeF e-invoicing  
- 📊 Kanban board, automation rules engine, packing station with barcode scanner  
- 🔐 2FA/TOTP, RBAC with custom roles, audit log  
- 🧱 All-in-one container: PostgreSQL 17 + Redis 7 + Go API + Next.js dashboard supervised by `s6-overlay`  
- 🔁 **Rebuild** repulls the upstream `ghcr.io/openoms-org/openoms-*:latest` image set  

## Support

- [KoInsight (upstream)](https://github.com/GeorgeSG/KoInsight) · [BamBuddy (upstream)](https://github.com/maziggy/bambuddy)
- [Home Assistant Community Forum](https://community.home-assistant.io/)
- [Issues for this add-on repository](https://github.com/Poltavtcev/hassio-koinsight/issues)

## Contributing

Contributions are welcome — please open a Pull Request.

[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[arm64-shield]: https://img.shields.io/badge/arm64-yes-green.svg
