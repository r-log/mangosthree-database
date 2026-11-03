-- ----------------------------------------------------------------
-- Ten quests nobody could start or hand in get their quest giver or ender.
--
-- The giver and ender are TrinityCore's 4.3.4 rows (from 15595 sniffs), each checked on
-- Wowhead: the 2012 page, or for 25363, 25366, 27984 and 495 Twinhead and today's
-- Wowhead. Quests the same sources call removed in Cataclysm (249, 1361, 3763, 3789,
-- 3790, 3803, 9617, 14351) keep no giver.
--
--   Hadoken Swiftstrider (Feralas) takes back War on the Woodpaw, Alpha Strike,
--     The Battle Plans, Zukk'ash Infestation and Stinglasher
--   Zamael Lunthistle takes back Lunthistle's Tale
--   Sharlindra gives and Melisara takes The Crown of Will
--   Master Gadrin gives and takes Cleanup on Isle E.
--   High Overlord Saurfang gives and Overlord Razgor takes The Defense of Warsong Hold
--   Highlord Darion Mograine gives and takes Empowerment
--   Xi'ri gives A Distraction for Akama
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
    SET @cOldStructure = '15';
    SET @cOldContent = '007';

    SET @cNewVersion = '22';
    SET @cNewStructure = '15';
    SET @cNewContent = '008';
    SET @cNewDescription = 'Quest_Givers_And_Enders';
    SET @cNewComment = 'Ten quests nobody could start or hand in get their quest giver or ender';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        INSERT IGNORE INTO `quest_relations` (`actor`, `entry`, `quest`, `role`) VALUES
            (0, 7875, 25363, 1),
            (0, 7875, 25364, 1),
            (0, 7875, 25366, 1),
            (0, 7875, 25367, 1),
            (0, 7875, 25369, 1),
            (0, 8436, 27984, 1),
            (0, 2227, 495, 0),
            (0, 2278, 495, 1),
            (0, 3188, 26951, 0),
            (0, 3188, 26951, 1),
            (0, 25256, 11595, 0),
            (0, 25279, 11595, 1),
            (0, 37120, 24912, 0),
            (0, 37120, 24912, 1),
            (0, 18528, 10985, 0);

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
