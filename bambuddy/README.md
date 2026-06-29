# Bambuddy (rolling)

Home Assistant add-on wrapper around pre-built BamBuddy images (fast **Rebuild** on HA).

**Default (active `build.yaml`):** upstream **[maziggy/bambuddy](https://github.com/maziggy/bambuddy)** → `ghcr.io/maziggy/bambuddy:latest`

**Fork preset:** [`build.fork.yaml`](./build.fork.yaml) → `ghcr.io/poltavtcev/bambuddy:latest`  
**Upstream preset:** [`build.upstream.yaml`](./build.upstream.yaml) (same as active `build.yaml`)

## Upstream (default)

1. Refresh add-on repository on HA
2. **Bambuddy → Rebuild**
3. **Start** — `http://<home-assistant-ip>:8480`

No GitHub Actions needed — Rebuild pulls the latest upstream image from GHCR.

## Switch to your fork

```bash
cp bambuddy/build.fork.yaml bambuddy/build.yaml
```

Commit, push, then:

1. Run [**Publish BamBuddy fork image**](https://github.com/Poltavtcev/hassio-koinsight/actions/workflows/publish-bambuddy-fork.yml) (if the fork image is stale)
2. Refresh repo on HA → **Rebuild**

To switch back to upstream:

```bash
cp bambuddy/build.upstream.yaml bambuddy/build.yaml
```
