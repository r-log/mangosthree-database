-- ----------------------------------------------------------------
-- The Shadow priest talents' proc rows follow their 4.3.4 texts.
--
--   - Harnessed Shadows 33191: a critical hit the priest takes
--     reaches the talent, whatever dealt it. The row named the
--     priest family and no hit kind, so a spell of any other
--     family never reached the talent and a normal hit reached
--     it as often as a critical one. The row now has every
--     school, no family, no mask and a critical hit; the
--     client's proc flags (the hits the priest takes) stay. A
--     normal hit and a damage tick do not reach the talent.
--     Rank 78228 takes this row with its own 100% chance.
--   - Mind Melt 14910, a new row: Mind Spike (C 0x10000) on the
--     effect that gives the cast-time buff, its second effect, a
--     normal or a critical hit. The client's mask for that effect
--     is the damage-over-time mask, which no Mind Spike fits, so
--     the buff never came. Rank 33371 takes this row.
--   - Paralysis 87192, a new row: Mind Blast (A 0x2000) on its
--     effect, a critical hit. The client's mask is the one only
--     Shadow Orb Power 77486 carries, so the root never came.
--     Rank 87195 takes this row.
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
    SET @cOldContent = '021';

    SET @cNewVersion = '22';
    SET @cNewStructure = '16';
    SET @cNewContent = '022';
    SET @cNewDescription = 'Priest_Shadow_Rows';
    SET @cNewComment = 'The Shadow talents'' proc rows follow their 4.3.4 texts';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- Harnessed Shadows (a critical hit taken), Mind Melt (Mind Spike's hit) and Paralysis (Mind Blast's critical hit), as their 4.3.4 texts read.
        INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMaskA0`, `SpellFamilyMaskA1`, `SpellFamilyMaskA2`,
            `SpellFamilyMaskB0`, `SpellFamilyMaskB1`, `SpellFamilyMaskB2`, `SpellFamilyMaskC0`, `SpellFamilyMaskC1`, `SpellFamilyMaskC2`,
            `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
            (33191, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0),
            (14910, 0, 6, 0, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0, 0, 0, 0),
            (87192, 0, 6, 8192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0)
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
