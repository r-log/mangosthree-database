-- ----------------------------------------------------------------
-- Warrior trainers stop teaching Dual Wield, which 4.3.4 gives Fury warriors with
-- their talent tree.
--
-- 30 warrior trainers listed Dual Wield (674). Patch 4.0.1 made it the Fury tree's:
-- Dual Wield Specialization (23588) is a Fury primary spell in the client's
-- TalentTreePrimarySpells.dbc and grants dual wielding, the server teaches it
-- when the tree is chosen, and Arms and Protection warriors no longer dual wield.
-- No retail warrior trainer list has 674 (the hunter list does).
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
    SET @cOldContent = '004';

    SET @cNewVersion = '22';
    SET @cNewStructure = '15';
    SET @cNewContent = '005';
    SET @cNewDescription = 'Warrior_Dual_Wield';
    SET @cNewComment = 'Warrior trainers stop teaching Dual Wield, which 4.3.4 gives Fury warriors with their talent tree';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        DELETE FROM `npc_trainer` WHERE (`entry`, `spell`) IN (
            (913, 674),
            (914, 674),
            (985, 674),
            (1229, 674),
            (1901, 674),
            (2131, 674),
            (3041, 674),
            (3042, 674),
            (3043, 674),
            (3063, 674),
            (3169, 674),
            (3353, 674),
            (3354, 674),
            (3408, 674),
            (3598, 674),
            (4087, 674),
            (4089, 674),
            (4593, 674),
            (4594, 674),
            (4595, 674),
            (5113, 674),
            (5114, 674),
            (5479, 674),
            (5480, 674),
            (7315, 674),
            (8141, 674),
            (16771, 674),
            (17120, 674),
            (17480, 674),
            (17504, 674));

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
