# Bambuddy (rolling)

[BamBuddy](https://github.com/Poltavtcev/bambuddy) fork for Home Assistant — thin wrapper around **`ghcr.io/poltavtcev/bambuddy:latest`**.

Upstream fork: **https://github.com/Poltavtcev/bambuddy** (not `maziggy/bambuddy`).

## Docker image

The image is built in GitHub Actions (workflow **Publish BamBuddy image** in this repo) from the fork’s `main` branch and pushed to **GitHub Container Registry**.

After you push changes to **Poltavtcev/bambuddy**:

1. Run **Actions → Publish BamBuddy image (Poltavtcev fork) → Run workflow** (or wait for the weekly schedule).
2. In Home Assistant: refresh the add-on repo → **Rebuild** BamBuddy.

First-time setup: run that workflow once so `ghcr.io/poltavtcev/bambuddy:latest` exists before the HA add-on Rebuild.

Make the package **public** in GitHub: **Packages → bambuddy → Package settings → Change visibility**.

## Updates on Home Assistant

**Rebuild** pulls the new `latest` image and applies the small HA layer (`run.sh`). No `pip install` on the host.

## Networking

**`host_network: true`** — virtual printer ports on the Home Assistant host. Web UI: `http://<home-assistant-ip>:8480`

## Data

Persistent state: add-on **`/data/data`** and **`/data/logs`**.

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
