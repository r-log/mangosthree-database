-- ----------------------------------------------------------------
-- Creatures without a gossip menu take the menu the retail 15595 sniffs show them.
--
-- 11 creatures (the Cataclysm Preservation Project's world database, menus seen on
-- build 15595): each points at its sniffed menu, which gets its 15595 text (already
-- in npc_text) and options. Untyped sniffed options take their type only where the
-- icon and text settle it, with the NPC flag the server checks for that type. A
-- menu without options shows the default options, as before.
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
    SET @cOldContent = '003';

    SET @cNewVersion = '22';
    SET @cNewStructure = '14';
    SET @cNewContent = '004';
    SET @cNewDescription = 'Creature_Gossip_Menus';
    SET @cNewComment = 'Creatures without a gossip menu take the menu the retail 15595 sniffs show them';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        UPDATE `creature_template` SET `GossipMenuId` = 13045 WHERE `Entry` = 23736;
        UPDATE `creature_template` SET `GossipMenuId` = 11236 WHERE `Entry` = 39594;
        UPDATE `creature_template` SET `GossipMenuId` = 11371 WHERE `Entry` = 40344;
        UPDATE `creature_template` SET `GossipMenuId` = 11617 WHERE `Entry` = 42323;
        UPDATE `creature_template` SET `GossipMenuId` = 11794 WHERE `Entry` = 44125;
        UPDATE `creature_template` SET `GossipMenuId` = 12677 WHERE `Entry` = 48735;
        UPDATE `creature_template` SET `GossipMenuId` = 12882 WHERE `Entry` = 50502;
        UPDATE `creature_template` SET `GossipMenuId` = 12755 WHERE `Entry` = 52335;
        UPDATE `creature_template` SET `GossipMenuId` = 8517 WHERE `Entry` = 52636;
        UPDATE `creature_template` SET `GossipMenuId` = 13014 WHERE `Entry` = 52651;
        UPDATE `creature_template` SET `GossipMenuId` = 13111 WHERE `Entry` = 55285;

        INSERT IGNORE INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
            (13045, 18320, 0, 0),
            (11236, 15651, 0, 0),
            (11371, 15842, 0, 0),
            (11617, 16562, 0, 0),
            (11794, 16542, 0, 0),
            (11795, 16543, 0, 0),
            (12677, 17820, 0, 0),
            (12882, 14848, 0, 0),
            (12755, 17905, 0, 0),
            (8517, 10650, 0, 0),
            (13014, 10650, 0, 0),
            (13111, 18429, 0, 0);

        INSERT IGNORE INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
            (13045, 0, 2, 'I''d like to travel by air.', 4, 8192, 0, 0, 0, 0, 0, NULL, 0),
            (11794, 0, 1, 'Show me today''s selection of pies.', 3, 128, 0, 0, 0, 0, 0, NULL, 0),
            (11795, 0, 0, 'I''ll keep that in mind.', 1, 1, 11794, 0, 0, 0, 0, NULL, 0),
            (11794, 1, 0, 'Why pie over cake?', 1, 1, 11795, 0, 0, 0, 0, NULL, 0),
            (12677, 1, 5, 'Make this inn your home.', 8, 65536, 0, 0, 0, 0, 0, NULL, 0),
            (12677, 2, 1, 'Let me browse your goods.', 3, 128, 0, 0, 0, 0, 0, NULL, 0),
            (8517, 0, 3, 'Train me.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (13014, 0, 3, 'Train me.', 5, 16, 0, 0, 0, 0, 0, NULL, 0);

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
