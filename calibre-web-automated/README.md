# Calibre-Web Automated

[Calibre-Web Automated](https://github.com/crocodilestick/Calibre-Web-Automated) for Home Assistant OS, built from **`crocodilestick/calibre-web-automated:latest`**.

Each **Rebuild** in Supervisor pulls whatever `latest` points to on Docker Hub at that moment.

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield]

## Paths

| Add-on option | Default | Maps to in container |
|---------------|---------|----------------------|
| `library_path` | `/share/calibre-library` | `/calibre-library` |
| `ingest_path` | `/share/cwa-book-ingest` | `/cwa-book-ingest` |
| (persistent) | `/data/config` | `/config` (settings DB) |

Use **`/share/...`** or **`/media/...`** (NAS) if the library lives on mounted storage. Enable **network_share_mode** when the library is on NFS/SMB.

## Web UI

`http://<home-assistant-ip>:8083` (or open from the add-on **Open Web UI** button).

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
