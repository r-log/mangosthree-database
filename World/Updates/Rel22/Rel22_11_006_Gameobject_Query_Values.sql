-- ----------------------------------------------------------------
-- Gameobjects show what the 15595 client was sent: the fields of the
-- gameobject query reply take the values of retail 15595 sniffs.
--
-- Type, display, name, cursor icon, cast-bar caption and data words come from
-- the Cataclysm Preservation Project's world database (rows verified on build
-- 15595), whose values agree with retail client caches of builds 13623 and
-- 14480 on 99.95 per cent of these fields. Left as they are: the size (that
-- database rounds it to two decimals, and the caches hold ours), the loot ids
-- of chests and fishing holes (ours name the object's own loot rows) and door
-- data10 (the caches hold ours).
-- ----------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`;

DELIMITER $$

CREATE PROCEDURE `update_mangos`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SHOW ERRORS;
        SELECT '* UPDATE FAILED *' AS `===== Status =====`,
               @cCurResult AS `===== DB is on Version: =====`;
        RESIGNAL;
    END;

    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT `structure` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cCurContent := (SELECT `content` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);

    SET @cOldVersion = '22';
    SET @cOldStructure = '11';
    SET @cOldContent = '005';

    SET @cNewVersion = '22';
    SET @cNewStructure = '11';
    SET @cNewContent = '006';
    SET @cNewDescription = 'Gameobject_Query_Values';
    SET @cNewComment = 'Gameobjects take the query-reply values of the retail 15595 sniffs';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        UPDATE `gameobject_template` SET `castBarCaption` = 'Placing' WHERE `entry` = 1557;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Grabbing' WHERE `entry` = 1586;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Collecting', `data3` = 1 WHERE `entry` = 3524;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 6286;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 6287;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18047;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18048;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18049;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18050;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18051;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18052;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18053;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18054;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18055;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18056;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18057;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18058;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18059;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18060;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18061;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 18062;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 56809;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 56810;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 103773;
        UPDATE `gameobject_template` SET `data1` = 1852 WHERE `entry` = 104591;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 126337;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 126338;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 126339;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 126340;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 126341;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 126342;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 126345;
        UPDATE `gameobject_template` SET `data0` = 43 WHERE `entry` = 164958;
        UPDATE `gameobject_template` SET `data10` = 1 WHERE `entry` = 165554;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 174849;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 175432;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 175786;
        UPDATE `gameobject_template` SET `data6` = 0, `data8` = 0, `data10` = 0 WHERE `entry` = 176084;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 176157;
        UPDATE `gameobject_template` SET `data3` = 13369 WHERE `entry` = 177226;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 179874;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 179875;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 179876;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 179877;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 179878;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Collecting' WHERE `entry` = 180436;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Collecting' WHERE `entry` = 180501;
        UPDATE `gameobject_template` SET `data3` = 0 WHERE `entry` = 181095;
        UPDATE `gameobject_template` SET `type` = 5, `data2` = 0 WHERE `entry` = 181247;
        UPDATE `gameobject_template` SET `data7` = 0 WHERE `entry` = 181280;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 181332;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 181333;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 181334;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 181335;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 181336;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 181337;
        UPDATE `gameobject_template` SET `type` = 8, `name` = 'Midsummer Brazier', `data0` = 4, `data1` = 10 WHERE `entry` = 181355;
        UPDATE `gameobject_template` SET `name` = 'Uther''s Statue' WHERE `entry` = 181653;
        UPDATE `gameobject_template` SET `name` = 'Purple Firework Rocket' WHERE `entry` = 181886;
        UPDATE `gameobject_template` SET `data2` = 0 WHERE `entry` = 181928;
        UPDATE `gameobject_template` SET `name` = 'Aldor Altar Trap' WHERE `entry` = 182564;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 183164;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 183497;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 183498;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 183499;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 183500;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 183501;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 183502;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 183503;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 183504;
        UPDATE `gameobject_template` SET `name` = 'Enchanting & Inscription' WHERE `entry` = 183875;
        UPDATE `gameobject_template` SET `data3` = 13034 WHERE `entry` = 183877;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184093;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184094;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184095;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184096;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184103;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184104;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184105;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184114;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184294;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184331;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184416;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184507;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184508;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184509;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184510;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184516;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184563;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184564;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184565;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184579;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184580;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184581;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184582;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 184585;
        UPDATE `gameobject_template` SET `data2` = 0 WHERE `entry` = 184588;
        UPDATE `gameobject_template` SET `data5` = 1 WHERE `entry` = 184867;
        UPDATE `gameobject_template` SET `name` = 'Simon Game Base Green Smalll' WHERE `entry` = 185676;
        UPDATE `gameobject_template` SET `name` = 'Simon Game Base Green Smalll' WHERE `entry` = 185683;
        UPDATE `gameobject_template` SET `name` = 'Simon Game Base Green Smalll' WHERE `entry` = 185684;
        UPDATE `gameobject_template` SET `name` = 'Simon Game Base Green Smalll' WHERE `entry` = 185688;
        UPDATE `gameobject_template` SET `name` = 'Simon Game Base Green Smalll' WHERE `entry` = 185700;
        UPDATE `gameobject_template` SET `type` = 8, `data0` = 4, `data1` = 10, `data2` = 0 WHERE `entry` = 185903;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 186738;
        UPDATE `gameobject_template` SET `type` = 8, `data0` = 4, `data1` = 10 WHERE `entry` = 187457;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187559;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187564;
        UPDATE `gameobject_template` SET `data1` = 11681 WHERE `entry` = 187884;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187914;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187916;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187917;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187919;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187920;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187921;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187922;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187923;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187924;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187925;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187926;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187927;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187928;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187929;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187930;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187932;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187933;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187934;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187935;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187936;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187937;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187938;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187939;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187940;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187941;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187942;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187943;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187944;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187945;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187946;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187947;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187948;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187949;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187950;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187951;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187952;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187953;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187954;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187955;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187956;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187957;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187958;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187959;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187960;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187961;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187962;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187963;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187964;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187965;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187966;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187967;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187968;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187969;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187970;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187971;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187972;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187974;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 187975;
        UPDATE `gameobject_template` SET `data0` = 1505 WHERE `entry` = 188112;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 188128;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 188129;
        UPDATE `gameobject_template` SET `data3` = 46961, `data5` = 65000 WHERE `entry` = 188187;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 188352;
        UPDATE `gameobject_template` SET `name` = 'Artruis'' Phylactery' WHERE `entry` = 190777;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 192235;
        UPDATE `gameobject_template` SET `data1` = 29808 WHERE `entry` = 193051;
        UPDATE `gameobject_template` SET `name` = 'TOI Sigil 1' WHERE `entry` = 193590;
        UPDATE `gameobject_template` SET `name` = 'TOI Sigil 2' WHERE `entry` = 193591;
        UPDATE `gameobject_template` SET `name` = 'TOI Sigil 3' WHERE `entry` = 193592;
        UPDATE `gameobject_template` SET `name` = 'TOI Sigil 4' WHERE `entry` = 193593;
        UPDATE `gameobject_template` SET `name` = 'TOI Sigil 5' WHERE `entry` = 193594;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194032;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194033;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194034;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194035;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194036;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194037;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194038;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194039;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194040;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194042;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194043;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194044;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194045;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194046;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194048;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 194049;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 194618;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 194622;
        UPDATE `gameobject_template` SET `unk1` = 'Help help!  I''m being repressed!' WHERE `entry` = 194663;
        UPDATE `gameobject_template` SET `unk1` = 'Help help!  I''m being repressed!' WHERE `entry` = 194664;
        UPDATE `gameobject_template` SET `unk1` = 'Help help!  I''m being repressed!' WHERE `entry` = 194665;
        UPDATE `gameobject_template` SET `unk1` = 'Help help!  I''m being repressed!' WHERE `entry` = 194666;
        UPDATE `gameobject_template` SET `unk1` = 'Help help!  I''m being repressed!' WHERE `entry` = 194704;
        UPDATE `gameobject_template` SET `unk1` = 'Help help!  I''m being repressed!' WHERE `entry` = 194705;
        UPDATE `gameobject_template` SET `unk1` = 'Help help!  I''m being repressed!' WHERE `entry` = 194706;
        UPDATE `gameobject_template` SET `unk1` = 'Help help!  I''m being repressed!' WHERE `entry` = 194707;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 194908;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 194909;
        UPDATE `gameobject_template` SET `name` = 'Portcullis' WHERE `entry` = 194916;
        UPDATE `gameobject_template` SET `name` = 'Portcullis' WHERE `entry` = 194917;
        UPDATE `gameobject_template` SET `name` = 'Portcullis' WHERE `entry` = 194918;
        UPDATE `gameobject_template` SET `name` = 'Portcullis' WHERE `entry` = 194919;
        UPDATE `gameobject_template` SET `name` = 'Portcullis' WHERE `entry` = 194920;
        UPDATE `gameobject_template` SET `name` = 'Portcullis' WHERE `entry` = 194921;
        UPDATE `gameobject_template` SET `name` = 'Portcullis' WHERE `entry` = 194922;
        UPDATE `gameobject_template` SET `name` = 'Portcullis' WHERE `entry` = 194923;
        UPDATE `gameobject_template` SET `name` = 'Portcullis' WHERE `entry` = 194924;
        UPDATE `gameobject_template` SET `name` = 'Portcullis' WHERE `entry` = 194925;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 195024;
        UPDATE `gameobject_template` SET `name` = 'Karnum''s Glade' WHERE `entry` = 195098;
        UPDATE `gameobject_template` SET `name` = 'Feralas' WHERE `entry` = 195100;
        UPDATE `gameobject_template` SET `name` = 'Karnum''s Glade' WHERE `entry` = 195105;
        UPDATE `gameobject_template` SET `name` = 'Thargard''s Camp' WHERE `entry` = 195115;
        UPDATE `gameobject_template` SET `data1` = 0, `data5` = 0 WHERE `entry` = 195488;
        UPDATE `gameobject_template` SET `name` = 'Maldy''s Falcon' WHERE `entry` = 195522;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 196398;
        UPDATE `gameobject_template` SET `data0` = 2 WHERE `entry` = 197188;
        UPDATE `gameobject_template` SET `data0` = 2 WHERE `entry` = 197189;
        UPDATE `gameobject_template` SET `data0` = 2 WHERE `entry` = 197190;
        UPDATE `gameobject_template` SET `data20` = 80 WHERE `entry` = 201710;
        UPDATE `gameobject_template` SET `data3` = 0 WHERE `entry` = 201741;
        UPDATE `gameobject_template` SET `name` = 'Silver Covenant Banner' WHERE `entry` = 202193;
        UPDATE `gameobject_template` SET `name` = 'Chair' WHERE `entry` = 202304;
        UPDATE `gameobject_template` SET `name` = 'Scorched Gully and Points Unknown! Orcs?' WHERE `entry` = 202456;
        UPDATE `gameobject_template` SET `name` = 'Campfire' WHERE `entry` = 202575;
        UPDATE `gameobject_template` SET `name` = 'Mailbox' WHERE `entry` = 202577;
        UPDATE `gameobject_template` SET `name` = 'Anvil' WHERE `entry` = 202600;
        UPDATE `gameobject_template` SET `name` = 'Forge' WHERE `entry` = 202601;
        UPDATE `gameobject_template` SET `name` = 'Forge' WHERE `entry` = 202621;
        UPDATE `gameobject_template` SET `name` = 'Anvil' WHERE `entry` = 202622;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 202967;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Blowing' WHERE `entry` = 203248;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Searching' WHERE `entry` = 203403;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Grabbing' WHERE `entry` = 204091;
        UPDATE `gameobject_template` SET `name` = 'Mailbox' WHERE `entry` = 204233;
        UPDATE `gameobject_template` SET `name` = 'Fire Pit' WHERE `entry` = 205166;
        UPDATE `gameobject_template` SET `name` = 'Fire Pit' WHERE `entry` = 205167;
        UPDATE `gameobject_template` SET `name` = 'Fire Pit' WHERE `entry` = 205168;
        UPDATE `gameobject_template` SET `name` = 'Fire Pit' WHERE `entry` = 205169;
        UPDATE `gameobject_template` SET `name` = 'Fire Pit' WHERE `entry` = 205170;
        UPDATE `gameobject_template` SET `name` = 'Fire Pit' WHERE `entry` = 205171;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 205241;
        UPDATE `gameobject_template` SET `name` = 'Doodad_BonfireNorthrend_01' WHERE `entry` = 205351;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 205394;
        UPDATE `gameobject_template` SET `name` = 'Dynamit 01' WHERE `entry` = 205399;
        UPDATE `gameobject_template` SET `name` = 'Dynamit 06' WHERE `entry` = 205400;
        UPDATE `gameobject_template` SET `name` = 'Dynamit 05' WHERE `entry` = 205401;
        UPDATE `gameobject_template` SET `name` = 'Dynamit 02' WHERE `entry` = 205402;
        UPDATE `gameobject_template` SET `name` = 'Dynamit 00' WHERE `entry` = 205403;
        UPDATE `gameobject_template` SET `name` = 'Dynamit 04' WHERE `entry` = 205404;
        UPDATE `gameobject_template` SET `name` = 'Dynamit 03' WHERE `entry` = 205405;
        UPDATE `gameobject_template` SET `data0` = 3, `data2` = 0 WHERE `entry` = 205903;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205904;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205905;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205906;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205907;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205908;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205912;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205913;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205914;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205915;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205916;
        UPDATE `gameobject_template` SET `data1` = 2 WHERE `entry` = 205917;
        UPDATE `gameobject_template` SET `data8` = 1 WHERE `entry` = 206294;
        UPDATE `gameobject_template` SET `castBarCaption` = '' WHERE `entry` = 206395;
        UPDATE `gameobject_template` SET `castBarCaption` = '' WHERE `entry` = 206396;
        UPDATE `gameobject_template` SET `castBarCaption` = '' WHERE `entry` = 206397;
        UPDATE `gameobject_template` SET `data0` = 0 WHERE `entry` = 206602;
        UPDATE `gameobject_template` SET `data0` = 0 WHERE `entry` = 206603;
        UPDATE `gameobject_template` SET `name` = 'Dragonmaw Gate, Set 1, Gate 1' WHERE `entry` = 206657;
        UPDATE `gameobject_template` SET `IconName` = 'Interact' WHERE `entry` = 206831;
        UPDATE `gameobject_template` SET `name` = 'Mailbox' WHERE `entry` = 206842;
        UPDATE `gameobject_template` SET `data0` = 757 WHERE `entry` = 206968;
        UPDATE `gameobject_template` SET `data0` = 757 WHERE `entry` = 206969;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Inspecting' WHERE `entry` = 207125;
        UPDATE `gameobject_template` SET `data8` = 1 WHERE `entry` = 207320;
        UPDATE `gameobject_template` SET `data8` = 1 WHERE `entry` = 207321;
        UPDATE `gameobject_template` SET `data8` = 1 WHERE `entry` = 207322;
        UPDATE `gameobject_template` SET `data8` = 1 WHERE `entry` = 207323;
        UPDATE `gameobject_template` SET `data8` = 1 WHERE `entry` = 207324;
        UPDATE `gameobject_template` SET `data8` = 1 WHERE `entry` = 207325;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 207414;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 207416;
        UPDATE `gameobject_template` SET `data0` = 90245, `data5` = 11686 WHERE `entry` = 207691;
        UPDATE `gameobject_template` SET `name` = 'Doodad_Uldum_Titan_Micro_Sun_Beam03' WHERE `entry` = 207969;
        UPDATE `gameobject_template` SET `data0` = 757, `data1` = 2 WHERE `entry` = 207980;
        UPDATE `gameobject_template` SET `data0` = 757, `data1` = 3 WHERE `entry` = 207981;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207982;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207983;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207984;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207985;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207986;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207987;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207988;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207989;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207990;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207991;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207992;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 207993;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 208089;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 208090;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 208093;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 208094;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 208184;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 208187;
        UPDATE `gameobject_template` SET `data0` = 1964 WHERE `entry` = 208188;
        UPDATE `gameobject_template` SET `name` = 'Bush' WHERE `entry` = 208190;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Collecting' WHERE `entry` = 208201;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Collecting' WHERE `entry` = 208202;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Collecting' WHERE `entry` = 208203;
        UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 208248;
        UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 208249;
        UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 208250;
        UPDATE `gameobject_template` SET `name` = 'Dwarven Anvil' WHERE `entry` = 208251;
        UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 208252;
        UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 208253;
        UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 208254;
        UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 208255;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 208313;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 208314;
        UPDATE `gameobject_template` SET `data1` = 4294967295 WHERE `entry` = 208315;
        UPDATE `gameobject_template` SET `data8` = 1 WHERE `entry` = 208316;
        UPDATE `gameobject_template` SET `data8` = 1 WHERE `entry` = 208317;
        UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 208369;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Planting' WHERE `entry` = 208537;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Collecting' WHERE `entry` = 208576;
        UPDATE `gameobject_template` SET `castBarCaption` = 'Collecting' WHERE `entry` = 208587;
        UPDATE `gameobject_template` SET `name` = 'Stone Chair' WHERE `entry` = 208792;
        UPDATE `gameobject_template` SET `name` = 'Stone Chair' WHERE `entry` = 208793;
        UPDATE `gameobject_template` SET `name` = 'Stone Chair' WHERE `entry` = 208794;
        UPDATE `gameobject_template` SET `name` = 'Stone Chair' WHERE `entry` = 208795;
        UPDATE `gameobject_template` SET `name` = 'Stone Chair' WHERE `entry` = 208796;
        UPDATE `gameobject_template` SET `name` = 'Stone Chair' WHERE `entry` = 208797;
        UPDATE `gameobject_template` SET `name` = 'Stone Chair' WHERE `entry` = 208798;
        UPDATE `gameobject_template` SET `name` = 'Stone Chair' WHERE `entry` = 208799;
        UPDATE `gameobject_template` SET `displayId` = 10630 WHERE `entry` = 209251;
        UPDATE `gameobject_template` SET `data25` = 1291 WHERE `entry` = 209894;
        UPDATE `gameobject_template` SET `data25` = 1297 WHERE `entry` = 210160;
        UPDATE `gameobject_template` SET `data25` = 1299 WHERE `entry` = 210217;

        INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure,
            @cNewContent, @cNewDescription, @cNewComment);
        SET @cNewResult := (SELECT `description` FROM `db_version`
            WHERE `version` = @cNewVersion AND `structure` = @cNewStructure
              AND `content` = @cNewContent);
        COMMIT;
        SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,
               @cNewResult AS `===== DB is now on Version =====`;
    ELSE
        IF (@cCurResult = @cNewResult) THEN
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,
                   @cCurResult AS `===== DB is already on Version =====`;
        ELSE
            IF (@cCurResult IS NULL) THEN
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,
                       'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
                SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure,
                    '_', @cCurContent, ' - ', @cCurResult);
                SET @cOldOutput = CONCAT(@cOldVersion, '_', @cOldStructure,
                    '_', @cOldContent, ' - ',
                    COALESCE(@cOldResult, 'IS NOT APPLIED'));
                SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,
                       @cOldOutput AS `=== Expected ===`,
                       @cCurOutput AS `===== Found Version =====`;
            END IF;
        END IF;
    END IF;
END$$

DELIMITER ;

CALL `update_mangos`();
DROP PROCEDURE IF EXISTS `update_mangos`;
