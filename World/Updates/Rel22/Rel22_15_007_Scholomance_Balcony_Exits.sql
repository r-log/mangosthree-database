-- ----------------------------------------------------------------
-- The Scholomance balcony exits lead out of the keep instead of onto themselves.
--
-- Area triggers 2547-2549 lie on Kirtonos' balcony inside Scholomance (the 15595
-- client's AreaTrigger.dbc); ours sent a player to the trigger's own position. Retail
-- put a player who left the balcony outside, in Western Plaguelands (Blizzard forums,
-- 2019). The target is the porch outside the keep (map 0, 1399.42, -2574.59, 107.786),
-- as TrinityCore's 4.3.4 branch set it in 2013 and VMaNGOS corrected it in 2019.
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
    SET @cOldContent = '006';

    SET @cNewVersion = '22';
    SET @cNewStructure = '15';
    SET @cNewContent = '007';
    SET @cNewDescription = 'Scholomance_Balcony_Exits';
    SET @cNewComment = 'The Scholomance balcony exits lead out of the keep instead of onto themselves';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        UPDATE `areatrigger_teleport` SET `name` = 'Scholomance - Exit Porch Target 001', `target_map` = 0, `target_position_x` = 1399.42, `target_position_y` = -2574.59, `target_position_z` = 107.786, `target_orientation` = 6.28319 WHERE `id` = 2547;
        UPDATE `areatrigger_teleport` SET `name` = 'Scholomance - Exit Porch Target 001', `target_map` = 0, `target_position_x` = 1399.42, `target_position_y` = -2574.59, `target_position_z` = 107.786, `target_orientation` = 6.28319 WHERE `id` = 2548;
        UPDATE `areatrigger_teleport` SET `name` = 'Scholomance - Exit Porch Target 001', `target_map` = 0, `target_position_x` = 1399.42, `target_position_y` = -2574.59, `target_position_z` = 107.786, `target_orientation` = 6.28319 WHERE `id` = 2549;

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
