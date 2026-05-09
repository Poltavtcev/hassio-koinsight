# KoInsight & BamBuddy — Home Assistant Add-ons

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A//github.com/Poltavtcev/hassio-koinsight)

## About

This repository bundles **two** optional Home Assistant add-ons:

| Add-on | Upstream | What it does |
|--------|----------|----------------|
| **[KoInsight](./koinsight/)** | [KoInsight](https://github.com/GeorgeSG/KoInsight) | Web dashboard for **KOReader** reading statistics and sync |
| **[Bambuddy](./bambuddy/)** | [BamBuddy](https://github.com/maziggy/bambuddy) | **Bambu Lab** print archive, management, and virtual printer (LAN) |

Install only what you need from the Add-on Store after adding this repository.

## Add-ons

### [KoInsight](./koinsight/)

![Supports amd64 Architecture][amd64-shield]
![Supports arm64 Architecture][arm64-shield]

_KoInsight brings your KOReader reading stats to life with a clean, web-based dashboard._

### [Bambuddy](./bambuddy/)

![Supports aarch64 Architecture][bambuddy-aarch64-shield]
![Supports amd64 Architecture][bambuddy-amd64-shield]
![Supports armhf Architecture][bambuddy-armhf-shield]
![Supports armv7 Architecture][bambuddy-armv7-shield]
![Supports i386 Architecture][bambuddy-i386-shield]

_BamBuddy — print archive and management for Bambu Lab printers. This add-on builds from **`ghcr.io/maziggy/bambuddy:latest`** with optional **Rebuild** in Supervisor to refresh upstream._

[bambuddy-aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[bambuddy-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[bambuddy-armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[bambuddy-armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[bambuddy-i386-shield]: https://img.shields.io/badge/i386-yes-green.svg

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
- 🔁 **Rebuild** pulls the current upstream **`latest`** image  

## Support

- [KoInsight (upstream)](https://github.com/GeorgeSG/KoInsight) · [BamBuddy (upstream)](https://github.com/maziggy/bambuddy)
- [Home Assistant Community Forum](https://community.home-assistant.io/)
- [Issues for this add-on repository](https://github.com/Poltavtcev/hassio-koinsight/issues)

## Contributing

Contributions are welcome — please open a Pull Request.

[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[arm64-shield]: https://img.shields.io/badge/arm64-yes-green.svg
