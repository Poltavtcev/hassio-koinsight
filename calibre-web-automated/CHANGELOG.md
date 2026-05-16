# Changelog

## [1.0.2] - 2026-05-16

- Fix run.sh: do not `rm -rf` through symlinks into `/share` or `/media`.
- Log resolved `library_path` / `ingest_path` and detect existing `metadata.db` at startup.

## [1.0.1] - 2026-05-16

- Add `icon.png` and `logo.png` for the Supervisor add-on store.

## [1.0.0] - 2026-05-16

- Initial Home Assistant add-on wrapping `crocodilestick/calibre-web-automated:latest`.
- Configurable library and ingest paths (`share` / `media` maps).
- Persistent CWA config under add-on `/data/config`.
