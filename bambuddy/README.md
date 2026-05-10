# Bambuddy (rolling)

[BamBuddy](https://github.com/maziggy/bambuddy) for Home Assistant, built from **`ghcr.io/maziggy/bambuddy:latest`**.

Each **Rebuild** in Supervisor pulls whatever `latest` points to on GitHub Container Registry at that moment.

The add-on rebuilds BamBuddy’s Python dependencies on the Home Assistant Alpine/Python base (`pip install -r requirements.txt`, plus `py3-opencv`) so optional plate detection keeps working.

It also uses **`host_network: true`** so BamBuddy’s virtual printer ports (MQTT, FTP, etc.) bind on the Home Assistant host — same idea as upstream’s Linux `network_mode: host`. Web UI: `http://<home-assistant-ip>:8480`.

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
