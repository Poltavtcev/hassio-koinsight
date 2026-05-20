# Bambuddy (rolling)

Home Assistant add-on — thin wrapper around **`ghcr.io/maziggy/bambuddy:latest`** (fast **Rebuild**, no pip on the host).

Fork with your changes: **https://github.com/Poltavtcev/bambuddy**

## Update on Home Assistant

1. Refresh the add-on repository in HA
2. **Bambuddy → Rebuild** (or Update)
3. **Start** — Web UI: `http://<home-assistant-ip>:8480`

## Your fork image (optional, later)

After you publish `ghcr.io/poltavtcev/bambuddy:latest` from your fork, change `BAMBUDDY_IMAGE` in `Dockerfile` / `build.yaml` and push this repo again.
