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

_BamBuddy — print archive and management for Bambu Lab printers. This add-on builds from **`ghcr.io/maziggy/bambuddy:latest`** with optional **Rebuild** in Supervisor to refresh upstream. Same **aarch64 / amd64** targets as KoInsight (HA multi-arch base images)._

[bambuddy-aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[bambuddy-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg

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
- 🔁 **Rebuild** pulls the current upstream **`latest`** image  

## Support

- [KoInsight (upstream)](https://github.com/GeorgeSG/KoInsight) · [BamBuddy (upstream)](https://github.com/maziggy/bambuddy)
- [Home Assistant Community Forum](https://community.home-assistant.io/)
- [Issues for this add-on repository](https://github.com/Poltavtcev/hassio-koinsight/issues)

## Contributing

Contributions are welcome — please open a Pull Request.

[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[arm64-shield]: https://img.shields.io/badge/arm64-yes-green.svg
