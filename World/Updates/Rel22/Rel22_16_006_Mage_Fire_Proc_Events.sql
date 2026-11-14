-- ----------------------------------------------------------------
-- The Fire talents' proc rows follow the spells their 4.3.4 texts
-- name.
--
--   - Hot Streak 44445: the crits and hits of Fireball, Fire Blast,
--     Scorch, Pyroblast and Frostfire Bolt reach it; the end of a
--     cast does not.
--   - Hot Streak 48108, the buff the talent gives: its row goes. In
--     4.3.4 the buff has no charges and no proc flags.
--   - Critical Mass 11095: Pyroblast and Scorch reach it. The class
--     mask of its SpellEffect.dbc row holds Scorch alone.
--   - Master of Elements 29074: the crits of every magic school
--     reach it, where the row held Fire and Frost.
--   - Impact 64343: only Fire Blast uses its charge.
--   - Arcane Missiles! 79683: only Arcane Missiles uses its charge.
-- The class masks are those of the spells' SpellClassOptions.dbc
-- rows; Pyroblast! 92315 shares Pyroblast's bit. The two new rows
-- take their proc flags from Spell.dbc.
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
    SET @cOldContent = '005';

    SET @cNewVersion = '22';
    SET @cNewStructure = '16';
    SET @cNewContent = '006';
    SET @cNewDescription = 'Mage_Fire_Proc_Events';
    SET @cNewComment = 'The Fire talents'' proc rows follow the spells their 4.3.4 texts name';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- Hot Streak: Fireball (A 0x1), Fire Blast (A 0x2), Scorch (A 0x10), Pyroblast
        -- (A 0x400000) and Frostfire Bolt (B 0x1000), on a hit or a crit.
        UPDATE `spell_proc_event` SET `SpellFamilyMaskA0` = 4194323, `SpellFamilyMaskA1` = 4194323, `SpellFamilyMaskA2` = 4194323,
            `SpellFamilyMaskB0` = 4096, `SpellFamilyMaskB1` = 4096, `SpellFamilyMaskB2` = 4096, `procEx` = 3
            WHERE `entry` = 44445;

        -- Hot Streak's buff: no charges and no proc flags.
        DELETE FROM `spell_proc_event` WHERE `entry` = 48108;

        -- Critical Mass: Pyroblast (A 0x400000) and Scorch (A 0x10).
        UPDATE `spell_proc_event` SET `SpellFamilyMaskA0` = 4194320, `SpellFamilyMaskA1` = 4194320, `SpellFamilyMaskA2` = 4194320
            WHERE `entry` = 11095;

        -- Master of Elements: the six magic schools; the family stays the mage's.
        UPDATE `spell_proc_event` SET `SchoolMask` = 126 WHERE `entry` = 29074;

        -- Impact's charge: Fire Blast (A 0x2). Arcane Missiles!: Arcane Missiles (A 0x800) and
        -- the missile that lands (A 0x200000). Both on a hit or a crit.
        INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMaskA0`, `SpellFamilyMaskA1`, `SpellFamilyMaskA2`,
            `SpellFamilyMaskB0`, `SpellFamilyMaskB1`, `SpellFamilyMaskB2`, `SpellFamilyMaskC0`, `SpellFamilyMaskC1`, `SpellFamilyMaskC2`,
            `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
            (64343, 0, 3, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0),
            (79683, 0, 3, 2099200, 2099200, 2099200, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0)
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
