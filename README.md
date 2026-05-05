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
| `WEB_PORT`         | `8080`                | Port to expose the LWT web UI on |
| `DB_HOST`          | `localhost`           | DB hostname      |
| `DB_USER`          | `lwt`                 | DB username      |
| `DB_PASSWORD`      | `lwt_secret`          | DB user password |
| `DB_DATABASE`      | `learning_with_texts` | DB database name |
| `DB_ROOT_PASSWORD` | `root_secret`         | DB root password |

Example `.env`:

```env
WEB_PORT=9090
DB_PASSWORD=my_strong_password
DB_ROOT_PASSWORD=my_root_password
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
