# KoInsight, BamBuddy, Calibre-Web, OpenOMS & Linki — Home Assistant Add-ons

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A//github.com/Poltavtcev/hassio-koinsight)

## About

This repository bundles **five** optional Home Assistant add-ons:

| Add-on | Upstream | What it does |
|--------|----------|----------------|
| **[KoInsight](./koinsight/)** | [KoInsight](https://github.com/GeorgeSG/KoInsight) | Web dashboard for **KOReader** reading statistics and sync |
| **[BamBuddy](./bambuddy/)** | [BamBuddy](https://github.com/maziggy/bambuddy) | **Bambu Lab** print archive, management, and virtual printer (LAN) |
| **[Calibre-Web Automated](./calibre-web-automated/)** | [Calibre-Web-Automated](https://github.com/crocodilestick/Calibre-Web-Automated) | **Calibre** library web UI with automatic book ingest |
| **[OpenOMS](./openoms/)** | [OpenOMS](https://github.com/openoms-org/openoms) | Open-source **Order Management System** (Allegro, InPost, DHL/DPD/GLS, WooCommerce, eBay, Amazon SP-API…); bundles PostgreSQL 17 + Redis 7 + Go API + Next.js dashboard |
| **[Linki](./linki/)** | [Linki](https://github.com/moaljumaa/linki) | Open-source **AI SDR for B2B outreach** (LinkedIn sequences, cold email, lead enrichment) |

Install only what you need from the Add-on Store after adding this repository.

## Add-ons

### [KoInsight](./koinsight/)

![Supports amd64 Architecture][amd64-shield]
![Supports arm64 Architecture][arm64-shield]

_KoInsight brings your KOReader reading stats to life with a clean, web-based dashboard._

### [BamBuddy](./bambuddy/)

![Supports aarch64 Architecture][bambuddy-aarch64-shield]
![Supports amd64 Architecture][bambuddy-amd64-shield]

_BamBuddy — HA add-on pulls official **`ghcr.io/maziggy/bambuddy`** from upstream **[maziggy/bambuddy](https://github.com/maziggy/bambuddy)**. **Rebuild** on HA to fetch the latest changes. **aarch64 / amd64**._

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

### [Linki](./linki/)

![Supports aarch64 Architecture][linki-aarch64-shield]
![Supports amd64 Architecture][linki-amd64-shield]

_Linki — Open-source AI SDR for B2B outreach. Automates LinkedIn sequences and cold emails. Self-hosted on your Home Assistant OS directly from your fork or upstream. Uses a stable pinned browser fingerprint to prevent LinkedIn logouts._

[linki-aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[linki-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg


## Building from source (rolling)

The KoInsight and Linki add-ons **build from Git** on your Home Assistant host (no pinned `ghcr.io` image).

- To use another fork or branch, edit the repository URL/Ref in the `Dockerfile` or `build.yaml` within the add-on folder, then **Rebuild** the add-on in Supervisor.
- The first install can take several minutes (clone + `npm install` + build).

## Installation

Click the badge above or manually add this repository to your Home Assistant add-on store:

1. Go to **Supervisor** → **Add-on Store**
2. Click the **⋮** menu in the top right
3. Select **Repositories**
4. Add repository URL: `https://github.com/Poltavtcev/hassio-koinsight`
5. Close the dialog and refresh the page
6. Install **KoInsight**, **BamBuddy**, **Linki**, etc., as needed

**No updates or Changelog shows `does not exist in the store`?** In **Settings → Add-ons → ⋮ → Repositories**, the URL must match the repo you actually use — this one:  
`https://github.com/Poltavtcev/hassio-koinsight`  
Each URL gets its own store id in Supervisor; a mismatch breaks changelog / update detection. Remove the repo entry, reload the page (or **Check for updates**), add the URL again, restart **Home Assistant Supervisor** if needed.

## Features

**KoInsight**
- 📈 Interactive dashboard with reading statistics and charts  
- 🔄 KOReader plugin for automatic syncing  
- 🏠 Fully self-hosted in Home Assistant  

**BamBuddy**
- 🖨️ Bambu Lab workflow helpers (archive, virtual printer on host network where configured)  
- 🔁 **Rebuild** pulls official **`ghcr.io/maziggy/bambuddy:latest`**

**OpenOMS**
- 🛒 Multi-marketplace orders (Allegro, eBay, Amazon SP-API, WooCommerce, Kaufland, OLX, Erli, Shoper, PrestaShop, Shopify, Mirakl/Empik)  
- 📦 Carrier label generation + rate shopping (InPost, DHL, DPD, GLS, UPS, Poczta Polska, Orlen Paczka, FedEx)  
- 🧾 Invoicing (Fakturownia, inFakt, wFirma) and Polish KSeF e-invoicing  

**Linki**
- 📬 **Multichannel Campaigns**: run LinkedIn actions (visit, connect, message) and email actions in parallel
- 🔐 **Server-Side LinkedIn Login**: headless server-side authentication captures full session avoiding logouts
- ⚡ **Reliability & Safety**: Pinned Chromium fingerprint prevents forced logouts, built directly into the Docker image

## Support

- [KoInsight (upstream)](https://github.com/GeorgeSG/KoInsight) · [BamBuddy (upstream)](https://github.com/maziggy/bambuddy) · [Linki (upstream)](https://github.com/moaljumaa/linki)
- [Home Assistant Community Forum](https://community.home-assistant.io/)
- [Issues for this add-on repository](https://github.com/Poltavtcev/hassio-koinsight/issues)

## Contributing

Contributions are welcome — please open a Pull Request.

[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[arm64-shield]: https://img.shields.io/badge/arm64-yes-green.svg
