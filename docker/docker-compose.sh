#!/usr/bin/env bash
# Starts the MariaDB container from docker-compose.yml and installs the three MaNGOS Three
# databases into it, unattended. Needs a mariadb/mysql client on the host.
#
#   ./docker-compose.sh            # populated world database
#   ./docker-compose.sh --empty    # structure only
#
# Passwords and the host port come from ../.env-style variables DB_ROOT_PASSWORD and
# DB_PORT (defaults: mangos, 3306), the same names the server repository's stack uses.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"
DB_ROOT_PASSWORD="${DB_ROOT_PASSWORD:-mangos}"
DB_PORT="${DB_PORT:-3306}"

docker compose up -d db

printf 'Waiting for the database to become healthy'
for _ in $(seq 1 60); do
    if [ "$(docker compose ps --format '{{.Health}}' db 2>/dev/null)" = "healthy" ]; then
        break
    fi
    printf '.'
    sleep 2
done
echo
[ "$(docker compose ps --format '{{.Health}}' db 2>/dev/null)" = "healthy" ] || { echo "database did not become healthy" >&2; exit 1; }

../.github/apps/ci/install-databases.sh -h 127.0.0.1 -P "$DB_PORT" -u root -p "$DB_ROOT_PASSWORD" "$@"
../.github/apps/ci/verify-databases.sh  -h 127.0.0.1 -P "$DB_PORT" -u root -p "$DB_ROOT_PASSWORD" "$@"
