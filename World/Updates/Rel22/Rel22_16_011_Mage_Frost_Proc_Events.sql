-- ----------------------------------------------------------------
-- The Frost talents' proc rows follow the spells their 4.3.4 texts
-- name. Fingers of Frost and Brain Freeze roll when the spell is
-- cast.
--
--   - Fingers of Frost 44543: the chills the mage applies reach it:
--     Frostbolt, Cone of Cold, Chilled (Blizzard with Ice Shards),
--     Frostfire Bolt and the hits of the Frostfire Orb. It rolls
--     once, at the end of the cast.
--   - Brain Freeze 44546: the same spells less Frostfire Bolt, also
--     at the end of the cast. Blizzard's own damage and Frost Armor
--     leave its row.
--   - Enduring Winter 44561: Frostbolt's hits and crits reach it.
--   - Permafrost 11175: the hits and crits of the chill spells its
--     own effect names reach it; the end of a cast does not.
-- The class masks are those of the spells' SpellClassOptions.dbc
-- rows; Piercing Chill shares Frostbolt's bit. The higher ranks
-- take the row of rank 1. The chances and proc flags stay the
-- spells' own from Spell.dbc.
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
    SET @cOldContent = '010';

    SET @cNewVersion = '22';
    SET @cNewStructure = '16';
    SET @cNewContent = '011';
    SET @cNewDescription = 'Mage_Frost_Proc_Events';
    SET @cNewComment = 'The Frost talents'' proc rows follow the spells their 4.3.4 texts name';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- Fingers of Frost, Brain Freeze, Enduring Winter and Permafrost: the spells their texts name.
        INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMaskA0`, `SpellFamilyMaskA1`, `SpellFamilyMaskA2`,
            `SpellFamilyMaskB0`, `SpellFamilyMaskB1`, `SpellFamilyMaskB2`, `SpellFamilyMaskC0`, `SpellFamilyMaskC1`, `SpellFamilyMaskC2`,
            `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
            (44543, 0, 3, 1049120, 1049120, 1049120, 4096, 4096, 4096, 16512, 16512, 16512, 0, 524288, 0, 0, 0),
            (44546, 0, 3, 1049120, 1049120, 1049120, 0, 0, 0, 16512, 16512, 16512, 0, 524288, 0, 0, 0),
            (44561, 0, 3, 32, 32, 32, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0),
            (11175, 0, 3, 1049120, 1049120, 1049120, 4096, 4096, 4096, 0, 0, 0, 0, 3, 0, 0, 0)
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
