# KoInsight Home Assistant Add-ons

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A//github.com/Poltavtcev/hassio-koinsight)

## About

This repository contains Home Assistant add-ons for [KoInsight](https://github.com/GeorgeSG/KoInsight) and [BamBuddy](https://github.com/maziggy/bambuddy).

## Add-ons

This repository contains the following add-ons:

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

_BamBuddy — print archive and management for Bambu Lab printers. This add-on is built from **`ghcr.io/maziggy/bambuddy:latest`**. After upstream releases a new image, open the add-on in Supervisor and click **Rebuild** to pull the current `latest`._

[bambuddy-aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[bambuddy-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[bambuddy-armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[bambuddy-armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[bambuddy-i386-shield]: https://img.shields.io/badge/i386-yes-green.svg

## Version 0.4.0 (KoInsight from source)

The add-on **builds KoInsight from Git** on your Home Assistant machine (no `ghcr.io` image pin).

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
6. Find **KoInsight** or **Bambuddy (rolling)** in the add-on store and install it

## Features

- 📈 Interactive dashboard with reading statistics and charts
- 🔄 KOReader plugin for automatic syncing
- 📱 Multi-device support
- 📤 Manual SQLite database upload
- ♻️ Acts as a KOReader sync server
- 🏠 Fully self-hosted in Home Assistant

## Support

- [KoInsight GitHub Repository](https://github.com/GeorgeSG/KoInsight)
- [Home Assistant Community Forum](https://community.home-assistant.io/)
- [Report Issues](https://github.com/schwarztrinker/hassio-koinsight/issues)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.