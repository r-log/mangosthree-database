-- ----------------------------------------------------------------
-- Gossip menus take the options and boxes of the retail 15595 sniffs, keeping
-- our conditions and scripts.
--
-- From the Cataclysm Preservation Project's world database (rows verified on
-- build 15595): options of ours that match a sniffed option by text take its
-- icon and box; sniffed options a menu lacks are added after ours, on menus
-- whose options carry no conditions, where their type means the same in both
-- servers and they lead somewhere (a menu, a point of interest or a service).
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
    SET @cOldStructure = '12';
    SET @cOldContent = '001';

    SET @cNewVersion = '22';
    SET @cNewStructure = '12';
    SET @cNewContent = '002';
    SET @cNewDescription = 'Gossip_Option_Values';
    SET @cNewComment = 'Gossip menus take the options and boxes of the retail 15595 sniffs, keeping our conditions and scripts';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        UPDATE `gossip_menu_option` SET `option_icon` = 3 WHERE `menu_id` = 4463 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `box_coded` = 1 WHERE `menu_id` = 6565 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `box_coded` = 1 WHERE `menu_id` = 6565 AND `id` = 1;
        UPDATE `gossip_menu_option` SET `box_coded` = 1 WHERE `menu_id` = 6565 AND `id` = 2;
        UPDATE `gossip_menu_option` SET `box_text` = 'Are you sure you would like to purchase your second talent specialization?' WHERE `menu_id` = 10371 AND `id` = 0;
        UPDATE `gossip_menu_option` SET `box_money` = 25 WHERE `menu_id` = 13352 AND `id` = 0;
        INSERT IGNORE INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
            (435, 16, 0, '|cFF0008E8NEW|r: Reforging', 1, 1, 13029, 0, 0, 0, 0, NULL, 0),
            (435, 17, 0, '|cFF0008E8NEW|r: Transmogrification', 1, 1, 13029, 0, 0, 0, 0, NULL, 0),
            (435, 18, 0, '|cFF0008E8NEW|r: Void Storage', 1, 1, 13029, 0, 0, 0, 0, NULL, 0),
            (3283, 7, 0, 'Druid', 1, 1, 3261, 405, 0, 0, 0, NULL, 0),
            (3329, 4, 0, 'Paladin', 1, 1, 8192, 0, 0, 0, 0, NULL, 0),
            (3329, 5, 0, 'Priest', 1, 1, 8193, 0, 0, 0, 0, NULL, 0),
            (3354, 6, 0, 'Hunter', 1, 1, 12264, 0, 0, 0, 0, NULL, 0),
            (4106, 1, 2, 'I need a ride, fast!  I have an important message to deliver!', 4, 8192, 0, 0, 0, 0, 0, NULL, 0),
            (6575, 1, 0, 'Launch me! |cFF0008E8(Darkmoon Game Token)|r', 1, 1, 13064, 460, 0, 0, 0, NULL, 0),
            (7777, 11, 0, 'Reforging', 1, 1, 12635, 0, 0, 0, 0, NULL, 0),
            (7788, 14, 0, 'Archaeology', 1, 1, 7797, 206, 0, 0, 0, NULL, 0),
            (9586, 2, 0, 'Chromie, you and I both know what''s going to happen in this time stream. We''ve seen this all before.$B$BCan you just skip us ahead to all the real action?', 1, 1, 11277, 0, 0, 0, 0, NULL, 0),
            (10550, 0, 3, 'I am interested in warlock training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (10555, 0, 3, 'I require warrior training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (10662, 0, 19, 'Queue for Wintergrasp.', 12, 1, 0, 0, 0, 0, 0, NULL, 0),
            (10681, 0, 3, 'I am interested in warlock training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (10694, 0, 3, 'I require warrior training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (10767, 13, 0, 'Archaeology', 1, 1, 12255, 0, 0, 0, 0, NULL, 0),
            (10767, 14, 0, 'Jewelcrafting', 1, 1, 10756, 347, 0, 0, 0, NULL, 0),
            (10815, 0, 3, 'I am interested in warlock training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (10821, 0, 3, 'I require warrior training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (10836, 0, 3, 'I require warrior training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (10977, 0, 3, 'I require warrior training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (11169, 0, 3, 'I am interested in warlock training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (11266, 0, 3, 'I am interested in warlock training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (11764, 0, 5, 'Make this inn your home.', 8, 65536, 0, 0, 0, 0, 0, NULL, 0),
            (11764, 5, 1, 'Let me browse your goods.', 3, 128, 0, 0, 0, 0, 0, NULL, 0),
            (11779, 0, 1, 'Let me browse your goods.', 3, 128, 0, 0, 0, 0, 0, NULL, 0),
            (12284, 0, 0, 'Who could have done such a thing?', 1, 1, 12285, 0, 0, 0, 0, NULL, 0),
            (12576, 0, 3, 'I am interested in warlock training.', 5, 16, 0, 0, 0, 0, 0, NULL, 0),
            (13083, 0, 0, '<more>', 1, 1, 8848, 0, 0, 0, 0, NULL, 0);

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
