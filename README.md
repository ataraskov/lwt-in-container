# lwt-in-container

[Learning With Texts](https://sourceforge.net/projects/learning-with-texts/) (LWT) packaged as a Docker image with a MariaDB backend.

## Quick start

```bash
docker compose up -d
```

Open http://localhost:8080 in your browser.

## Configuration

All settings are controlled via environment variables. Create a `.env` file next to `docker-compose.yml` to override the defaults:

| Variable | Default | Description |
|---|---|---|
| `WEB_PORT` | `8080` | Host port to expose the LWT web UI on |
| `DB_USER` | `lwt` | MariaDB username |
| `DB_PASSWORD` | `lwt_secret` | MariaDB user password |
| `DB_DATABASE` | `learning_with_texts` | MariaDB database name |
| `DB_ROOT_PASSWORD` | `root_secret` | MariaDB root password |

Example `.env`:

```env
WEB_PORT=9090
DB_PASSWORD=my_strong_password
DB_ROOT_PASSWORD=my_root_password
```

## Using the published image

The CI pipeline publishes a multi-arch image (amd64 + arm64) to the GitHub Container Registry on every push to `main` and on version tags. To use it instead of building locally, edit `docker-compose.yml`:

```yaml
services:
  lwt:
    image: ghcr.io/ataraskov/lwt-in-container:latest
```

## Data persistence

Two named volumes are created automatically:

- `lwt_media` — uploaded media files
- `lwt_db_data` — MariaDB data directory

Both survive `docker compose down`. To wipe all data, run:

```bash
docker compose down -v
```

## Building a specific LWT version

The `LWT_VERSION` build argument controls which release is downloaded from SourceForge (default: `25.10.0`):

```bash
docker build --build-arg LWT_VERSION=25.10.0 -t lwt-in-container .
```
