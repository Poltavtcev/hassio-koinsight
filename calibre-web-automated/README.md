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

## Changing `library_path`

Options are read **only when the add-on starts**. After you change `library_path`, click **Restart** on the add-on.

CWA needs a **Calibre library** (`metadata.db` plus author folders), not just loose ebook files:

| You have | Point `library_path` to | Put new files in |
|----------|-------------------------|------------------|
| Existing Calibre library | Folder containing `metadata.db` (e.g. `/share/Books`) | `ingest_path` for auto-import |
| Only `.epub` / `.mobi` files | Create or pick a folder; CWA can create an empty library | `ingest_path` |

If the add-on already created an empty library at the **default** path, change the path in options **and** either:

- In CWA: **Administration → Edit Calibre database → Library location**, or  
- Stop the add-on, delete **`/data/config/app.db`** (add-on data), set `library_path`, start again.

Check the add-on log for lines starting with `library_path option:` and `Found existing Calibre library`.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
