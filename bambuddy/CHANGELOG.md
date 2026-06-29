<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->

# Changelog

## [1.3.2] - 2026-06-29

- Active image: **`ghcr.io/poltavtcev/bambuddy:latest`** (fork with storage locations Phase 2).
- Workflow **Publish BamBuddy fork image** default branch → `main`.

## [1.3.1] - 2026-06-11

- Default image back to upstream **`ghcr.io/maziggy/bambuddy:latest`** (Rebuild only — no publish workflow).
- Add **`build.fork.yaml`** preset for **`ghcr.io/poltavtcev/bambuddy`** — copy over `build.yaml` to use the fork again.

## [1.3.0] - 2026-05-20

- Pull **`ghcr.io/poltavtcev/bambuddy`** (fork https://github.com/Poltavtcev/bambuddy), not maziggy.
- Workflow **Publish BamBuddy fork image** in this repo only (does not change the bambuddy fork).

## [1.2.2] - 2026-05-20

- Temporary revert to maziggy image (superseded by 1.3.0).

## [1.2.1] - 2026-05-19

- Fix **Permission denied** on `/app/logs/bambuddy.log` and `/app/data/.jwt_secret`: always `chown -R` on `/data/data` and `/data/logs` before start (upstream entrypoint skipped when the directory already looked owned by 1000:1000).

## [1.2.0] - 2026-05-19

- **Fast updates:** use upstream `ghcr.io/maziggy/bambuddy` directly (Calibre-Web-style wrapper). No more Alpine `pip install` / OpenCV compile on Home Assistant during Rebuild.
- Replace s6/`bashio` startup with `run.sh` + upstream `docker-entrypoint.sh` (PUID/PGID, data dirs unchanged under `/data/data` and `/data/logs`).

## [1.1.5] - 2026-05-11

- Mount Home Assistant **`/media`** into the add-on (`map: media:rw`) so paths like `/media/NAS_1/...` work for **Link External Folder** and other file features.

## [1.1.4] - 2026-05-10

- Web UI and health check moved from port **8000** to **8480** (`config.yaml`, `run`, translations) to avoid **EADDRINUSE** on hosts where 8000 is already taken while using **`host_network`**.

## [1.1.3] - 2026-05-09

- Fix Supervisor validation: **`webui` / `watchdog` must use `[PORT:8000]`**, not a literal `:8000` after `[HOST]` (regex in HA Supervisor). Restored **`ports`** so the placeholder resolves.

## [1.1.2] - 2026-05-09

- Align with KoInsight-style Docker: **explicit** `FROM ghcr.io/home-assistant/base-python:3.13-alpine3.23` (no `$BUILD_FROM`). New Supervisor builds no longer guarantee `BUILD_FROM`, which could drop the add-on from the store.
- **`arch`**: only **aarch64** and **amd64** — matches Home Assistant multi-arch base images (same as KoInsight). Removed armhf/armv7/i386 to avoid invalid platform combinations.
- Removed **`build.yaml`** (labels moved into Dockerfile `LABEL`; `BAMBUDDY_VERSION` stays as `ARG` default in Dockerfile).

## [1.1.1] - 2026-05-09

- Remove Docker BuildKit `RUN --mount=type=cache` from the Dockerfile. Home Assistant Supervisor may silently omit add-ons whose Dockerfile uses unsupported syntax, which hid Bambuddy when KoInsight still appeared in the same repository.

## [1.1.0] - 2026-05-09

- Version bump only — helps Home Assistant Supervisor pick up catalog changes if the add-on store was stuck showing an older git snapshot (see repository README troubleshooting).

## [1.0.6] - 2026-05-09

- Point add-on metadata (`url` / OCI source) at this repository (`Poltavtcev/hassio-koinsight`) so Supervisor changelog and store entries match the repo you add in the UI.

## [1.0.5] - 2026-05-09

- Restore Alpine `base-python` build + `pip install -r requirements.txt` (plate detection / OpenCV).
- Keep `host_network` for virtual printer LAN ports.

## [1.0.4] - 2026-05-09

- Run BamBuddy from upstream Debian image directly; `host_network` for virtual printer.

## [1.0.3] - 2026-05-08

- Python 3.13 base; optional OpenCV / plate-detection build fixes.

## [1.0.0] - 2026-05-07

- Initial add-on in this repository: build from `ghcr.io/maziggy/bambuddy:latest`.
