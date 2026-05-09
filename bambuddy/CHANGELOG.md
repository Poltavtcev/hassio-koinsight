<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->

# Changelog

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
