-- ----------------------------------------------------------------
-- The nine Highborne Arcane Reforgers retired in patch 4.3.0 no longer reforge.
--
-- Patch 4.3.0 replaced them with the ethereals of the Three Winds and the Drag
-- (Thaumaturge Vashreen and Zajir). In 4.3.4 the old ones carry no subname and
-- no reforge flag, and their gossip sends a player to the ethereals: menu
-- 13329 in Alliance cities, 13330 in Horde cities and 13331 in Dalaran, which
-- the database already holds.
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
    SET @cOldContent = '006';

    SET @cNewVersion = '22';
    SET @cNewStructure = '11';
    SET @cNewContent = '007';
    SET @cNewDescription = 'Retired_Arcane_Reforgers';
    SET @cNewComment = 'The nine Arcane Reforgers retired in patch 4.3.0 no longer reforge';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        UPDATE `creature_template` SET `SubName` = NULL, `NpcFlags` = 1, `GossipMenuId` = 13329 WHERE `Entry` = 46180;
        UPDATE `creature_template` SET `SubName` = NULL, `NpcFlags` = 1, `GossipMenuId` = 13330 WHERE `Entry` = 46181;
        UPDATE `creature_template` SET `SubName` = NULL, `NpcFlags` = 1, `GossipMenuId` = 13331 WHERE `Entry` = 47581;
        UPDATE `creature_template` SET `SubName` = NULL, `NpcFlags` = 1, `GossipMenuId` = 13329 WHERE `Entry` = 47582;
        UPDATE `creature_template` SET `SubName` = NULL, `NpcFlags` = 1, `GossipMenuId` = 13329 WHERE `Entry` = 47584;
        UPDATE `creature_template` SET `SubName` = NULL, `NpcFlags` = 1, `GossipMenuId` = 13329 WHERE `Entry` = 47586;
        UPDATE `creature_template` SET `SubName` = NULL, `NpcFlags` = 1, `GossipMenuId` = 13330 WHERE `Entry` = 47587;
        UPDATE `creature_template` SET `SubName` = NULL, `NpcFlags` = 1, `GossipMenuId` = 13330 WHERE `Entry` = 47588;
        UPDATE `creature_template` SET `SubName` = NULL, `NpcFlags` = 1, `GossipMenuId` = 13330 WHERE `Entry` = 47589;

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
