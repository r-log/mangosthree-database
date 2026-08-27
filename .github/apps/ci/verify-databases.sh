#!/usr/bin/env bash
# Asserts that an installation produced by install-databases.sh reached the state the
# repository describes: the top db_version row of each database equals the release,
# structure and content numbers encoded in the newest update file's name
# (RelVV_SS_CCC_*.sql), and a few representative tables are populated. Exit 1 on any
# mismatch. A successful SQL exit code alone proves nothing here: the updates are
# version-guarded and skip themselves silently when applied out of order.
#
#   .github/apps/ci/verify-databases.sh [-h host] [-P port] [-u user] [-p password] [--empty]
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
query() {
    "$client" -h "$host" -P "$port" -u "$user" --batch --skip-column-names "$1" -e "$2"
}

failures=0
fail() { echo "::error::$*"; failures=$((failures + 1)); }

expected_from_files() {   # newest RelVV_SS_CCC_*.sql under <dir>/Updates -> "VV SS CCC" as integers
    local newest
    newest=$(find "$1/Updates" -name 'Rel*_*_*_*.sql' -printf '%f\n' | sort | tail -n 1)
    [ -n "$newest" ] || { echo "no update files under $1/Updates" >&2; return 1; }
    local v s c
    IFS=_ read -r v s c _ <<< "$newest"
    printf '%d %d %d\n' "$((10#${v#Rel}))" "$((10#$s))" "$((10#$c))"
}

for pair in "realmd Realm" "character3 Character" "mangos3 World"; do
    set -- $pair
    db=$1 dir=$2
    expected=$(expected_from_files "$dir")
    actual=$(query "$db" "SELECT CONCAT(version, ' ', structure, ' ', content) FROM db_version ORDER BY version DESC, structure DESC, content DESC LIMIT 1")
    if [ "$expected" = "$actual" ]; then
        echo "ok   $db db_version = $actual (newest update file in $dir/Updates)"
    else
        fail "$db db_version is '$actual' but the newest update file in $dir/Updates says '$expected' -- an update was skipped or applied out of order"
    fi
done

check_rows() {   # check_rows <db> <table> <min-rows>
    local n
    n=$(query "$1" "SELECT COUNT(*) FROM \`$2\`")
    if [ "$n" -ge "$3" ]; then
        echo "ok   $1.$2 has $n rows"
    else
        fail "$1.$2 has $n rows, expected at least $3"
    fi
}
check_rows realmd realmlist 1
check_rows realmd account 0
check_rows character3 characters 0
if [ $populate = 1 ]; then
    check_rows mangos3 creature_template 1000
    check_rows mangos3 quest_template 1000
    check_rows mangos3 item_template 1000
fi

if [ $failures -gt 0 ]; then
    echo "$failures check(s) failed"
    exit 1
fi
echo "all checks passed"
