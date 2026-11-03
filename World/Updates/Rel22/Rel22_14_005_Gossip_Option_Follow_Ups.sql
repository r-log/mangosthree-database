-- ----------------------------------------------------------------
-- Gossip options lead to the menu the retail 15595 sniffs show after them.
--
-- 35 options of ours led nowhere, and most never showed: a creature shows an
-- option only when its NPC flag matches, and theirs was 0. The sniffed option
-- (same menu, slot and text) opens a menu we have; ours now does too, with the
-- plain-gossip flag. Only where no creature or gameobject that shows the menu,
-- directly or through other menus, has a script bound; three options retail
-- shows only to some players (a lost quest item, the trainer's class) are left.
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
    SET @cOldStructure = '14';
    SET @cOldContent = '004';

    SET @cNewVersion = '22';
    SET @cNewStructure = '14';
    SET @cNewContent = '005';
    SET @cNewDescription = 'Gossip_Option_Follow_Ups';
    SET @cNewComment = 'Gossip options lead to the menu the retail 15595 sniffs show after them';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 5764 WHERE `menu_id` = 5102 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 5765 WHERE `menu_id` = 5764 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 5769 WHERE `menu_id` = 5765 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 5767 WHERE `menu_id` = 5768 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 5768 WHERE `menu_id` = 5769 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 10619 WHERE `menu_id` = 10620 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 10621 WHERE `menu_id` = 10622 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 10623 WHERE `menu_id` = 10624 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 11183 WHERE `menu_id` = 11144 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 11351 WHERE `menu_id` = 11352 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 11544 WHERE `menu_id` = 11541 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 11545 WHERE `menu_id` = 11544 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 6944 WHERE `menu_id` = 11892 AND `id` = 1;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 11986 WHERE `menu_id` = 11976 AND `id` = 4;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 11987 WHERE `menu_id` = 11976 AND `id` = 5;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 11988 WHERE `menu_id` = 11976 AND `id` = 6;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 11981 WHERE `menu_id` = 11976 AND `id` = 7;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 11989 WHERE `menu_id` = 11977 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 11994 WHERE `menu_id` = 11978 AND `id` = 2;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12016 WHERE `menu_id` = 12015 AND `id` = 1;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12357 WHERE `menu_id` = 12356 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12359 WHERE `menu_id` = 12358 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12360 WHERE `menu_id` = 12361 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12983 WHERE `menu_id` = 12790 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12981 WHERE `menu_id` = 12795 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12904 WHERE `menu_id` = 12799 AND `id` = 2;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 13002 WHERE `menu_id` = 12799 AND `id` = 4;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12977 WHERE `menu_id` = 12833 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12979 WHERE `menu_id` = 12897 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12915 WHERE `menu_id` = 12914 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12951 WHERE `menu_id` = 12950 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12975 WHERE `menu_id` = 12974 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12976 WHERE `menu_id` = 12975 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12980 WHERE `menu_id` = 12979 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `npc_option_npcflag` = 1, `action_menu_id` = 12982 WHERE `menu_id` = 12981 AND `id` = 0;

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
