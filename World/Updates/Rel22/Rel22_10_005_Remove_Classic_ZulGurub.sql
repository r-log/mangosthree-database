-- ----------------------------------------------------------------
-- The Classic Zul'Gurub raid has no scripts in the core: its bindings go.
--
-- Map 309, the twenty-player raid, cannot be entered in 4.3.4: the client
-- names it "Ancient Zul'Gurub" and gives it no Dungeon Finder entry, no
-- area trigger leads into it, and none of the creatures these names bind
-- is spawned. Zul'Gurub in 4.3.4 is the five-player dungeon on map 859,
-- which these names never bind. A bound name the core has no script for
-- is reported at every start, so the bindings leave with the scripts.
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
    SET @cOldStructure = '10';
    SET @cOldContent = '004';

    SET @cNewVersion = '22';
    SET @cNewStructure = '10';
    SET @cNewContent = '005';
    SET @cNewDescription = 'Remove_Classic_ZulGurub';
    SET @cNewComment = 'The bindings of the Classic ZulGurub raid scripts (map 309) are removed';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        DELETE FROM `script_binding`
         WHERE `ScriptName` IN (
            'at_zulgurub',
            'boss_arlokk',
            'boss_hakkar',
            'boss_hazzarah',
            'boss_jeklik',
            'boss_jindo',
            'boss_mandokir',
            'boss_marli',
            'boss_renataki',
            'boss_thekal',
            'boss_venoxis',
            'go_gong_of_bethekk',
            'instance_zulgurub',
            'mob_healing_ward',
            'mob_ohgan',
            'mob_zealot_lorkhan',
            'mob_zealot_zath',
            'npc_gurubashi_bat_rider',
            'spell_thekal_resurrection');

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
