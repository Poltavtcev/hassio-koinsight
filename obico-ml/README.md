# Obico ML Home Assistant Add-on

This Add-on provides the ML API component for Obico, integrated directly into Home Assistant.
It automatically pulls and builds from the latest official Obico ML API image (`ghcr.io/gabe565/obico/ml-api:latest`), ensuring you have the most up-to-date analysis logic.

### Usage
This add-on exposes port 3333 by default. You can point your Obico server or Home Assistant integrations to `http://[YOUR_HA_IP]:3333`.

Based on the [official Obico project](https://github.com/TheSpaghettiDetective/obico-server) and the community Obico ML HA integration.
