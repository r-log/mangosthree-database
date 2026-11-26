-- ----------------------------------------------------------------
-- The Holy priest talents' proc rows follow their 4.3.4 texts, and
-- the Lightwell takes its click spell.
--
--   - Surge of Light 88687, a new row: the five spells its text
--     names reach the talent, Smite (A 0x80), Heal (A 0x400),
--     Flash Heal (A 0x800), Greater Heal (A 0x1000) and Binding
--     Heal (B 0x4), with or without a crit. The proc flags and the
--     3% chance stay the spell's own. Rank 88690 takes this row
--     with its own 6%. Without the row any spell the priest landed
--     could roll it.
--   - Inspiration 14892: Prayer of Mending's heal (B 0x20) joins
--     the heals whose critical heal reaches the talent, beside
--     Binding Heal and Penance's heal. Rank 15362 takes this row.
--   - Blessed Resilience 33142: a normal or a critical hit the
--     priest takes reaches the talent, from a critical hit alone;
--     the server's script gives the buff for a critical hit and for
--     a hit greater than 10% of his maximum health, the percent its
--     effect 1 holds, and refuses the rest. Rank 33145 takes this
--     row.
--   - Divine Touch 63534: a chance of 100, where the client's data
--     gives the talent none, so the priest's Renew heals at once
--     each time it lands. Rank 63542 takes this row.
--   - The Lightwell 31897: a click casts 60123, the Lightwell
--     casting it at the player who clicked (cast_flags 2). The
--     server marks the creature clickable from this row.
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
    SET @cOldContent = '020';

    SET @cNewVersion = '22';
    SET @cNewStructure = '16';
    SET @cNewContent = '021';
    SET @cNewDescription = 'Priest_Holy_Rows';
    SET @cNewComment = 'The Holy talents'' proc rows follow their 4.3.4 texts and the Lightwell takes its click spell';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- Surge of Light, Inspiration, Blessed Resilience and Divine Touch, as their 4.3.4 texts read.
        INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMaskA0`, `SpellFamilyMaskA1`, `SpellFamilyMaskA2`,
            `SpellFamilyMaskB0`, `SpellFamilyMaskB1`, `SpellFamilyMaskB2`, `SpellFamilyMaskC0`, `SpellFamilyMaskC1`, `SpellFamilyMaskC2`,
            `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
            (88687, 0, 6, 7296, 7296, 7296, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0),
            (14892, 0, 6, 268443136, 268443136, 268443136, 65572, 65572, 65572, 0, 0, 0, 0, 2, 0, 0, 0),
            (33142, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0),
            (63534, 0, 6, 64, 64, 64, 0, 0, 0, 0, 0, 0, 16384, 0, 0, 100, 0)
        ON DUPLICATE KEY UPDATE `SchoolMask` = VALUES(`SchoolMask`), `SpellFamilyName` = VALUES(`SpellFamilyName`),
            `SpellFamilyMaskA0` = VALUES(`SpellFamilyMaskA0`), `SpellFamilyMaskA1` = VALUES(`SpellFamilyMaskA1`),
            `SpellFamilyMaskA2` = VALUES(`SpellFamilyMaskA2`), `SpellFamilyMaskB0` = VALUES(`SpellFamilyMaskB0`),
            `SpellFamilyMaskB1` = VALUES(`SpellFamilyMaskB1`), `SpellFamilyMaskB2` = VALUES(`SpellFamilyMaskB2`),
            `SpellFamilyMaskC0` = VALUES(`SpellFamilyMaskC0`), `SpellFamilyMaskC1` = VALUES(`SpellFamilyMaskC1`),
            `SpellFamilyMaskC2` = VALUES(`SpellFamilyMaskC2`), `procFlags` = VALUES(`procFlags`), `procEx` = VALUES(`procEx`),
            `ppmRate` = VALUES(`ppmRate`), `CustomChance` = VALUES(`CustomChance`), `Cooldown` = VALUES(`Cooldown`);

        -- The Lightwell 31897: its click spell 60123, cast by the Lightwell at the player who clicked.
        DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 31897 AND `spell_id` = 60123;
        INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`,
            `cast_flags`, `condition_id`) VALUES
            (31897, 60123, 0, 0, 0, 2, 0);

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
