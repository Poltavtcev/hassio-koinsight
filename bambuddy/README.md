# Bambuddy (rolling)

Home Assistant add-on for **[Poltavtcev/bambuddy](https://github.com/Poltavtcev/bambuddy)** (your fork).

Pulls **`ghcr.io/poltavtcev/bambuddy:latest`** — fast **Rebuild** on HA (no pip compile on the host).

## First time (or after you change the fork)

1. Open **https://github.com/Poltavtcev/hassio-koinsight/actions**
2. Run workflow **Publish BamBuddy fork image** (default branch: `feature/printer-temperature-fan-controls`)
3. Wait until it finishes (green). If HA cannot pull the image, set the package **public**: GitHub → Packages → bambuddy → Public

## On Home Assistant

1. Refresh add-on repository
2. **Bambuddy → Rebuild** (version **1.3.0**+)
3. **Start** — `http://<home-assistant-ip>:8480`

## After you push changes to the fork

1. Run **Publish BamBuddy fork image** again (same workflow)
2. **Rebuild** the add-on on HA
