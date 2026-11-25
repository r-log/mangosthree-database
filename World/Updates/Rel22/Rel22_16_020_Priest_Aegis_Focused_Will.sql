-- ----------------------------------------------------------------
-- Divine Aegis and Focused Will take a normal hit as well as a
-- critical one; the server's scripts of the two talents choose.
--
--   - Divine Aegis 47509: a normal or a critical heal of the
--     priest reaches the talent; its script makes a shield from a
--     critical heal and from every heal of Prayer of Healing, and
--     refuses the rest. Ranks 47511 and 47515 take this row.
--   - Focused Will 45234: a normal or a critical hit the priest
--     takes reaches the talent; its script gives Focused Will for a
--     critical hit and for a hit greater than 10% of his maximum
--     health, the percent its effect 1 holds, and refuses the
--     rest. Rank 45243 takes this row.
-- Both rows keep every school, no family and no class mask, and
-- the proc flags stay the spells' own from Spell.dbc.
-- The update can run again after a failure.
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
    SET @cOldStructure = '16';
    SET @cOldContent = '019';

    SET @cNewVersion = '22';
    SET @cNewStructure = '16';
    SET @cNewContent = '020';
    SET @cNewDescription = 'Priest_Aegis_Focused_Will';
    SET @cNewComment = 'Divine Aegis and Focused Will take a normal hit as well as a critical one';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- Divine Aegis and Focused Will on a normal or a critical hit.
        INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMaskA0`, `SpellFamilyMaskA1`, `SpellFamilyMaskA2`,
            `SpellFamilyMaskB0`, `SpellFamilyMaskB1`, `SpellFamilyMaskB2`, `SpellFamilyMaskC0`, `SpellFamilyMaskC1`, `SpellFamilyMaskC2`,
            `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
            (47509, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0),
            (45234, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0)
        ON DUPLICATE KEY UPDATE `SchoolMask` = VALUES(`SchoolMask`), `SpellFamilyName` = VALUES(`SpellFamilyName`),
            `SpellFamilyMaskA0` = VALUES(`SpellFamilyMaskA0`), `SpellFamilyMaskA1` = VALUES(`SpellFamilyMaskA1`),
            `SpellFamilyMaskA2` = VALUES(`SpellFamilyMaskA2`), `SpellFamilyMaskB0` = VALUES(`SpellFamilyMaskB0`),
            `SpellFamilyMaskB1` = VALUES(`SpellFamilyMaskB1`), `SpellFamilyMaskB2` = VALUES(`SpellFamilyMaskB2`),
            `SpellFamilyMaskC0` = VALUES(`SpellFamilyMaskC0`), `SpellFamilyMaskC1` = VALUES(`SpellFamilyMaskC1`),
            `SpellFamilyMaskC2` = VALUES(`SpellFamilyMaskC2`), `procFlags` = VALUES(`procFlags`), `procEx` = VALUES(`procEx`),
            `ppmRate` = VALUES(`ppmRate`), `CustomChance` = VALUES(`CustomChance`), `Cooldown` = VALUES(`Cooldown`);

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
