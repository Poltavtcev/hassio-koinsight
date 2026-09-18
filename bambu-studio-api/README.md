# Bambu Studio Sidecar for BamBuddy

This is a Home Assistant Add-on that provides the **Bambu Studio API** for server-side slicing in BamBuddy.

## Usage

1. Install this add-on and start it.
2. In your BamBuddy add-on, configure the Slicer API URL to point to this add-on's host and port.
   * If you mapped the port to `8481`, you can use `http://<your-home-assistant-ip>:8481` or simply `http://bambu_studio_api:8080` (if networking permits).
3. Start slicing STL and 3MF files directly from BamBuddy!

## Configuration

* **port**: The internal port the API listens on (default is 8080).

For more details, visit the [BamBuddy Slicer API Docs](https://wiki.bambuddy.cool/features/slicer-api/).
