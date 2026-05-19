# Bambuddy (rolling)

[BamBuddy](https://github.com/maziggy/bambuddy) for Home Assistant, wrapped around **`ghcr.io/maziggy/bambuddy:latest`**.

## Updates

Each **Rebuild** in Supervisor pulls the upstream image and applies a thin HA layer (`run.sh`, `jq`). There is **no** `pip install` on your Home Assistant host — updates are much faster than the old Alpine rebuild.

**Restart** keeps the same image; use **Rebuild** when you want a newer `latest` from GitHub Container Registry.

## Networking

**`host_network: true`** so BamBuddy’s virtual printer ports (MQTT, FTP, etc.) bind on the Home Assistant host — same idea as upstream’s Linux `network_mode: host`.

Web UI: `http://<home-assistant-ip>:8480`

## Data

BamBuddy data and logs persist under the add-on **`/data`** volume (`/data/data`, `/data/logs` inside the container).

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
