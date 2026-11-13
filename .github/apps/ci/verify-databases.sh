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
    check_rows mangos3 item_sparse 8000
fi

check_absent_tables() {   # check_absent_tables <db> <LIKE pattern> -- the removed playerbots objects must not come back
    local n
    n=$(query "$1" "SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = '$1' AND TABLE_NAME LIKE '$2'")
    if [ "$n" -eq 0 ]; then
        echo "ok   $1 has no table like $2"
    else
        fail "$1 still has $n table(s) like $2"
    fi
}
check_absent_column() {   # check_absent_column <db> <table> <column>
    local n
    n=$(query "$1" "SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '$1' AND TABLE_NAME = '$2' AND COLUMN_NAME = '$3'")
    if [ "$n" -eq 0 ]; then
        echo "ok   $1.$2 has no column $3"
    else
        fail "$1.$2 still has column $3"
    fi
}
check_absent_index() {   # check_absent_index <db> <LIKE pattern on the index name>
    local n
    n=$(query "$1" "SELECT COUNT(DISTINCT TABLE_NAME, INDEX_NAME) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = '$1' AND INDEX_NAME LIKE '$2'")
    if [ "$n" -eq 0 ]; then
        echo "ok   $1 has no index like $2"
    else
        fail "$1 still has $n index(es) like $2"
    fi
}
check_rows_where() {   # check_rows_where <db> <table> <where> <expected-count>
    local n
    n=$(query "$1" "SELECT COUNT(*) FROM \`$2\` WHERE $3")
    if [ "$n" -eq "$4" ]; then
        echo "ok   $1.$2 has $n row(s) where $3"
    else
        fail "$1.$2 has $n row(s) where $3, expected $4"
    fi
}

check_absent_tables character3 'ai_playerbot%'
check_absent_tables character3 'ahbot_%'
check_absent_index mangos3 'idx_%_loot_template_item'
check_absent_column realmd account playerBot
check_absent_column mangos3 item_template name
check_absent_column mangos3 item_template Unknown2
check_rows_where information_schema COLUMNS "TABLE_SCHEMA = 'mangos3' AND TABLE_NAME IN ('npc_vendor', 'npc_vendor_template') AND COLUMN_NAME = 'item' AND DATA_TYPE = 'mediumint' AND COLUMN_TYPE NOT LIKE '%unsigned%'" 2
check_rows_where information_schema COLUMNS "TABLE_SCHEMA = 'character3' AND TABLE_NAME = 'character_achievement_progress' AND COLUMN_NAME = 'started' AND DATA_TYPE = 'bigint' AND COLUMN_TYPE LIKE '%unsigned%' AND IS_NULLABLE = 'NO'" 1
check_rows_where mangos3 mangos_string "entry IN (61, 62, 1015)" 0
check_rows_where mangos3 mangos_string "entry IN (1202, 1203, 1204, 1205, 1206)" 0
check_rows_where mangos3 mangos_string "entry = 1029 AND content_default = 'This command needs a logged-in account and cannot be used from the server console.' AND source_enum_tag = 'LANG_COMMAND_NEEDS_ACCOUNT' AND COALESCE(content_loc1, content_loc2, content_loc3, content_loc4, content_loc5, content_loc6, content_loc7, content_loc8, content_loc9, content_loc10, content_loc11) IS NULL" 1

check_rows_where mangos3 hotfix_data "type = 2442913102" 164
check_rows_where mangos3 spell_template "id IN (37264, 37278, 37365)" 0
check_rows_where mangos3 spell_template "id IN (110158, 111533) AND attr = 2843738368 AND duration_index = 36 AND effect0 = 6 AND effect0_apply_aura_name = 4 AND effect0_radius_idx = 28" 2
check_rows_where mangos3 spell_template "id = 37814 AND attr = 256 AND attr_ex = 268435456 AND effect0 = 0 AND effect0_trigger_spell = 0" 1
if [ $populate = 1 ]; then
    check_rows_where mangos3 spell_bonus_data "ap_bonus <> 0 OR ap_dot_bonus <> 0" 32
    check_rows_where mangos3 spell_bonus_data "entry > 0" 46
    check_rows_where mangos3 item_sparse "entry = 71953 AND name = 'Fallen Adventurer''s Journal'" 1
    check_rows_where mangos3 creature_template "Entry = 6 AND CreatureType = 7 AND Family = 0" 1
    check_rows_where mangos3 creature_template "IconName = 'Directions'" 208
    check_rows_where mangos3 npc_text "ID = 562 AND em0_0_delay = 0 AND em0_0 = 1" 1
    check_rows_where mangos3 npc_text "ID IN (14606, 15258, 16242, 17703, 17705)" 5
    check_rows_where mangos3 gameobject_template "entry = 181247 AND type = 5" 1
    check_rows_where mangos3 gameobject_template "entry = 187559 AND data0 = 1964" 1
    check_rows_where mangos3 creature_template "Entry IN (46180, 46181, 47581, 47582, 47584, 47586, 47587, 47588, 47589) AND NpcFlags = 1 AND SubName IS NULL" 9
    check_rows_where mangos3 item_enchantment_template "entry BETWEEN -465 AND -456" 42
    check_rows_where mangos3 item_enchantment_template "entry = -457 AND ench BETWEEN 260 AND 264" 5
    check_rows_where mangos3 skill_discovery_template "spellId = 57013" 0
    check_rows_where mangos3 gameobject_template "entry = 181285 AND data3 = 28720" 1
    check_rows_where mangos3 instance_template "(map = 409 AND parent = 230) OR (map = 469 AND parent = 229)" 2
    check_rows_where mangos3 quest_template "entry = 9082 AND RequestItemsText = 'How do you expect me to get anything done without the items I requested?'" 1
    check_rows_where mangos3 quest_template "entry = 29304 AND RewMoneyMaxLevel = 165400" 1
    check_rows_where mangos3 page_text "entry = 3498 AND text LIKE 'BUR - An aggressively passionate mating call.%'" 1
    check_rows_where mangos3 points_of_interest "entry = 183 AND ROUND(x) = 1739 AND ROUND(y) = -4281" 1
    check_rows_where mangos3 reputation_spillover_template "faction = 72 AND rank_1 = 4" 1
    check_rows_where mangos3 player_xp_for_level "lvl = 70 AND xp_for_next_level = 813000" 1
    check_rows_where mangos3 creature_model_info "modelid = 2286 AND gender = 1" 1
    check_rows_where mangos3 npc_vendor "entry IN (54654, 54659, 54662) AND item IN (70217, 70220) AND ExtendedCost = 3549" 6
    check_rows_where mangos3 quest_template "entry = 6983 AND ReqCreatureOrGOId1 = 0 AND ReqCreatureOrGOId2 = 15664" 1
    check_rows_where mangos3 npc_trainer "spell = 750 AND spellcost = 0" 0
    check_rows_where mangos3 quest_template "QuestFlags > 16777215" 846
    check_rows_where mangos3 quest_template "MinimapTargetMark <> 0" 393
    check_rows_where mangos3 gossip_menu_option "menu_id = 435 AND id = 16 AND option_text = '|cFF0008E8NEW|r: Reforging'" 1
    check_rows_where mangos3 creature_template "CreatureTypeFlags2 <> 0" 36
    check_rows_where mangos3 creature_template "Entry = 10608 AND FemaleName = 'Scarlet Priestess'" 1
    check_rows_where mangos3 npc_trainer "reqability1 <> 0" 3714
    check_rows_where mangos3 npc_trainer "spell = 40120 AND reqability1 = 34091 AND reqability2 = 33943" 36
    check_rows_where mangos3 npc_trainer "spell = 97462" 57
    check_rows_where mangos3 npc_trainer "spell = 8895 AND reqability1 = 20222" 36
    check_rows_where mangos3 npc_trainer "entry = 328 AND spell IN (587, 5504, 42956)" 0
    check_rows_where mangos3 npc_trainer "entry = 1231 AND spell IN (3127, 3044)" 0
    check_rows_where mangos3 creature_template "Entry = 44125 AND GossipMenuId = 11794" 1
    check_rows_where mangos3 gossip_menu_option "menu_id = 12677 AND option_id = 8 AND npc_option_npcflag = 65536" 1
    check_rows_where mangos3 gossip_menu_option "menu_id = 5102 AND id = 0 AND action_menu_id = 5764 AND npc_option_npcflag = 1" 1
    check_rows_where mangos3 gossip_menu_option "action_trainer_id <> 0" 38
    check_rows_where mangos3 npc_trainer_template "entry = 122" 141
    check_rows_where mangos3 creature_template "Entry = 45286 AND GossipMenuId = 12180 AND TrainerType = 2" 1
    check_rows_where mangos3 npc_trainer "spell = 53042" 0
    check_rows_where mangos3 npc_trainer "entry = 11146" 245
    check_rows_where mangos3 npc_trainer "entry = 913 AND spell = 674" 0
    check_rows_where mangos3 creature_template "Expansion >= 0" 40563
    check_rows_where mangos3 creature_template_classlevelstats "Level BETWEEN 1 AND 90" 360
    check_rows_where mangos3 quest_relations "actor = 0 AND entry = 7875 AND role = 1 AND quest IN (25363, 25364, 25366, 25367, 25369)" 5
    check_rows_where mangos3 quest_relations "actor = 0 AND quest IN (495, 10985, 11595, 24912, 26951, 27984)" 12
    check_rows_where mangos3 npc_trainer "entry = 38243" 3
    check_rows_where mangos3 npc_trainer "(entry = 911 AND spell IN (772, 3127, 6343, 6673)) OR (entry = 3061 AND spell = 1978) OR (entry IN (987, 3033) AND spell IN (60192, 40123))" 0
fi
check_rows_where mangos3 areatrigger_teleport "id IN (2547, 2548, 2549) AND target_map = 0 AND ROUND(target_position_x) = 1399 AND ROUND(target_position_y) = -2575" 3

if [ $failures -gt 0 ]; then
    echo "$failures check(s) failed"
    exit 1
fi
echo "all checks passed"
