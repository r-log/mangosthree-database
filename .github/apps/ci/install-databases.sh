#!/usr/bin/env bash
# Unattended installation of the MaNGOS Three databases into a fresh MariaDB/MySQL server.
#
#   .github/apps/ci/install-databases.sh [-h host] [-P port] [-u admin-user] [-p admin-password] [--empty]
#
# Reproduces the fresh-install path of InstallDatabases.sh without a single prompt:
#   user.sql -> */Setup/*CreateDB.sql -> */Setup/*LoadDB.sql -> World/Setup/FullDB/*.sql
#   (skipped with --empty) -> every */Updates/Rel*/ *.sql in lexical order -> Tools/updateRealm.sql
# Every file is fed to the client on stdin, so the first SQL error aborts the run with a
# non-zero exit code -- there is no "continue on error" here on purpose. CI and the compose
# helper both use this; the interactive InstallDatabases.sh stays for humans.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

host=127.0.0.1
port=3306
user=root
pass=""
populate=1
while [ $# -gt 0 ]; do
    case "$1" in
        -h) host=$2; shift 2 ;;
        -P) port=$2; shift 2 ;;
        -u) user=$2; shift 2 ;;
        -p) pass=$2; shift 2 ;;
        --empty) populate=0; shift ;;
        *) echo "usage: $0 [-h host] [-P port] [-u user] [-p password] [--empty]" >&2; exit 2 ;;
    esac
done

client=$(command -v mariadb || command -v mysql || true)
[ -n "$client" ] || { echo "no mariadb/mysql client on PATH" >&2; exit 3; }
export MYSQL_PWD="$pass"
sql() {   # sql <database or ""> <file>   -- run one file, abort on the first error
    local db=$1 file=$2
    printf '%s -> %s\n' "$file" "${db:-(server)}"
    "$client" -h "$host" -P "$port" -u "$user" --default-character-set=utf8 --max_allowed_packet=128M \
        ${db:+"$db"} < "$file"
}
query() {  # query <database or ""> <statement>
    local db=$1 stmt=$2
    "$client" -h "$host" -P "$port" -u "$user" --batch --skip-column-names ${db:+"$db"} -e "$stmt"
}

echo "== Server: $host:$port as $user; world data: $([ $populate = 1 ] && echo populated || echo empty)"
query "" "SET GLOBAL max_allowed_packet = 134217728"
query "" "SELECT VERSION()"

echo "== Users and databases"
if [ "$(query "" "SELECT COUNT(*) FROM mysql.user WHERE user = 'mangos' AND host = '%'")" = "0" ]; then
    sql "" user.sql
fi
sql "" Realm/Setup/realmdCreateDB.sql
sql "" Character/Setup/characterCreateDB.sql
sql "" World/Setup/mangosdCreateDB.sql

echo "== Base structure and content"
sql realmd     Realm/Setup/realmdLoadDB.sql
sql character3 Character/Setup/characterLoadDB.sql
sql mangos3    World/Setup/mangosdLoadDB.sql
if [ $populate = 1 ]; then
    for f in World/Setup/FullDB/*.sql; do
        sql mangos3 "$f"
    done
fi

echo "== Updates (lexical order per release folder)"
shopt -s nullglob
for pair in "realmd Realm" "character3 Character" "mangos3 World"; do
    set -- $pair
    for rel in "$2"/Updates/Rel*/; do
        for f in "$rel"*.sql; do
            sql "$1" "$f"
        done
    done
done

echo "== Realm list entry"
sql realmd Tools/updateRealm.sql

echo "== Resulting db_version rows"
for db in realmd character3 mangos3; do
    printf '%-10s %s\n' "$db" "$(query "$db" "SELECT CONCAT(version, '.', structure, '.', content, ' ', description) FROM db_version ORDER BY version DESC, structure DESC, content DESC LIMIT 1")"
done
