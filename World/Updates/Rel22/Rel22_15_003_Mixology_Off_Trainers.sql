-- ----------------------------------------------------------------
-- Alchemy trainers stop teaching Mixology, which patch 4.0.1 merged into Alchemy.
--
-- 34 trainers listed Mixology (53042). No retail trainer list of any build has it,
-- the 15595 client ties it to no skill (no SkillLineAbility row), and patch 4.0.1
-- merged it into the Alchemy tooltip instead of a passive to learn. The spell is a
-- dummy aura with no effect in the server, so no character loses anything.
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
    SET @cOldContent = '002';

    SET @cNewVersion = '22';
    SET @cNewStructure = '15';
    SET @cNewContent = '003';
    SET @cNewDescription = 'Mixology_Off_Trainers';
    SET @cNewComment = 'Alchemy trainers stop teaching Mixology, which patch 4.0.1 merged into Alchemy';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        DELETE FROM `npc_trainer` WHERE (`entry`, `spell`) IN (
            (1215, 53042),
            (1386, 53042),
            (1470, 53042),
            (2132, 53042),
            (2391, 53042),
            (2837, 53042),
            (3009, 53042),
            (3184, 53042),
            (3347, 53042),
            (3603, 53042),
            (4160, 53042),
            (4611, 53042),
            (4900, 53042),
            (5177, 53042),
            (5499, 53042),
            (7948, 53042),
            (16161, 53042),
            (16588, 53042),
            (16642, 53042),
            (16723, 53042),
            (17215, 53042),
            (18802, 53042),
            (19052, 53042),
            (26903, 53042),
            (26951, 53042),
            (26975, 53042),
            (26987, 53042),
            (27023, 53042),
            (27029, 53042),
            (28703, 53042),
            (33588, 53042),
            (33608, 53042),
            (33630, 53042),
            (33674, 53042));

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
