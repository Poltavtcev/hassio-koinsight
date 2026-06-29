# Bambuddy (rolling)

Home Assistant add-on wrapper around pre-built BamBuddy images (fast **Rebuild** on HA).

**Default (active `build.yaml`):** fork **[Poltavtcev/bambuddy](https://github.com/Poltavtcev/bambuddy)** → `ghcr.io/poltavtcev/bambuddy:latest`

**Upstream preset:** [`build.upstream.yaml`](./build.upstream.yaml) → `ghcr.io/maziggy/bambuddy:latest`  
**Fork preset:** [`build.fork.yaml`](./build.fork.yaml) (same as active `build.yaml`)

## Fork (default)

1. Run [**Publish BamBuddy fork image**](https://github.com/Poltavtcev/hassio-koinsight/actions/workflows/publish-bambuddy-fork.yml) with ref **`main`** when the fork code changes
2. Refresh add-on repository on HA
3. **Bambuddy → Rebuild** → **Start** — `http://<home-assistant-ip>:8480`

## Switch to upstream

```bash
cp bambuddy/build.upstream.yaml bambuddy/build.yaml
```

Commit, push, refresh repo on HA → **Rebuild** (no publish workflow needed).
