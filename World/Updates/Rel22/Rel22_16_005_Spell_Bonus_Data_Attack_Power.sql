-- ----------------------------------------------------------------
-- spell_bonus_data keeps the attack-power shares Spell.dbc does not
-- hold.
--
-- Spell.dbc field 30 is the attack-power coefficient the client adds
-- to a spell's damage effects. A row's attack-power part counts only
-- where that field is 0. The update:
--   - removes the rows whose share field 30 holds, the rows the
--     server never applies, and the rows whose share the 4.3.4
--     tooltip text does not give;
--   - removes Holy Wrath's attack-power part (its text gives spell
--     power only);
--   - sets nine rows to the share their 4.3.4 tooltip text writes;
--   - adds ten rows whose 4.3.4 tooltip text writes a plain
--     attack-power share while field 30 is 0;
--   - adds Earthquake's spell power term: 61882's 4.3.4 tooltip
--     text adds 0.11 of the spell power by hand to the physical
--     damage of 77478, whose SpellEffect.dbc share is taken of
--     the flat physical damage-done auras alone.
-- The help of .debug spellcoefs names the attack-power lines and
-- the spell power the share multiplies.
-- Each written row's comment names the spell, the text's formula
-- and the date of the archived Wowhead page that shows it.
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
    SET @cOldContent = '004';

    SET @cNewVersion = '22';
    SET @cNewStructure = '16';
    SET @cNewContent = '005';
    SET @cNewDescription = 'Spell_Bonus_Data_Attack_Power';
    SET @cNewComment = 'spell_bonus_data keeps the attack-power shares Spell.dbc does not hold';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- Rows whose attack-power share Spell.dbc field 30 holds.
        DELETE FROM `spell_bonus_data` WHERE `entry` IN (1776, 2818, 3674, 8680, 13218, 13812, 52212, 60089);

        -- Rows the server never applies: the spell has no damage effect a row reaches.
        DELETE FROM `spell_bonus_data` WHERE `entry` IN (20925, 42463, 47476, 50842);

        -- Rows whose share the 4.3.4 text does not give: Pounce Bleed's text names no attack
        -- power, Seal of Righteousness's proc builds its damage from the seal's own text, and
        -- Unholy Blight deals a part of Death Coil's damage.
        DELETE FROM `spell_bonus_data` WHERE `entry` IN (9007, 25742, 50536);

        -- Holy Wrath: the 4.3.4 text gives a spell power share only.
        UPDATE `spell_bonus_data` SET `ap_bonus` = 0, `comments` = 'Holy Wrath - 0.61*SPH; Wowhead 2012-05-12' WHERE `entry` = 2812;

        -- The attack-power share the 4.3.4 tooltip text writes; a share over a duration is
        -- given per tick.
        UPDATE `spell_bonus_data` SET `ap_bonus` = 0.147, `ap_dot_bonus` = 0.147,
            `comments` = 'Rake - AP*0.147, AP*0.441 over 3 ticks; Wowhead 2012-03-03' WHERE `entry` = 1822;
        UPDATE `spell_bonus_data` SET `ap_bonus` = 0, `ap_dot_bonus` = 0.08,
            `comments` = 'Serpent Sting - RAP*0.4 over 5 ticks; Wowhead 2012-03-05' WHERE `entry` = 1978;
        UPDATE `spell_bonus_data` SET `ap_bonus` = 0.0483, `ap_dot_bonus` = 0,
            `comments` = 'Arcane Shot - RAP*0.0483; Wowhead 2012-02-26' WHERE `entry` = 3044;
        UPDATE `spell_bonus_data` SET `ap_bonus` = 0.0552, `ap_dot_bonus` = 0.00369,
            `comments` = 'Lacerate - AP*0.0552, 5*(m1+AP*0.00369) over 5 ticks; Wowhead 2012-05-03' WHERE `entry` = 33745;
        UPDATE `spell_bonus_data` SET `ap_bonus` = 0.2, `ap_dot_bonus` = 0,
            `comments` = 'Icy Touch - AP*0.2; Wowhead 2012-05-11' WHERE `entry` = 45477;
        UPDATE `spell_bonus_data` SET `ap_bonus` = 0.23, `ap_dot_bonus` = 0,
            `comments` = 'Death Coil damage - m1+0.23*AP; Wowhead 2012-01-28' WHERE `entry` = 47632;
        UPDATE `spell_bonus_data` SET `ap_bonus` = 0.805, `ap_dot_bonus` = 0,
            `comments` = 'Death Coil heal - (m1+0.23*AP)*3.5; Wowhead 2012-01-28' WHERE `entry` = 47633;
        UPDATE `spell_bonus_data` SET `ap_bonus` = 0.08, `ap_dot_bonus` = 0,
            `comments` = 'Blood Boil - m1+0.08*AP; Wowhead 2012-03-20' WHERE `entry` = 48721;
        UPDATE `spell_bonus_data` SET `ap_bonus` = 0.44, `ap_dot_bonus` = 0,
            `comments` = 'Howling Blast - AP*0.44; Wowhead 2012-02-28' WHERE `entry` = 49184;

        -- Spell.dbc field 30 is 0, the 4.3.4 tooltip text a plain attack-power share; a share
        -- over a duration is given per tick.
        INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
            (6807, 0, 0, 0.19, 0, 'Maul - AP*0.19; Wowhead 2012-05-12'),
            (19434, 0, 0, 0.724, 0, 'Aimed Shot - RAP*0.724; Wowhead 2012-05-12'),
            (20187, 0, 0, 0.2, 0, 'Judgement of Righteousness - 1+0.2*AP+0.32*SPH; Wowhead 2011-01-28'),
            (45524, 0, 0, 0.08, 0, 'Chains of Ice - glyph: m3+0.08*AP; Wowhead 2012-05-09'),
            (53209, 0, 0, 0.732, 0, 'Chimera Shot - RAP*0.732; Wowhead 2012-05-03'),
            (53301, 0, 0, 0, 0.273, 'Explosive Shot - RAP*0.273 per blast; Wowhead 2012-05-12'),
            (56641, 0, 0, 0.021, 0, 'Steady Shot - RAP*0.021; Wowhead 2012-05-12'),
            (77758, 0, 0, 0.0982, 0.0167, 'Thrash - AP*0.0982, (AP*0.0167+m2)*3 over 3 ticks; Wowhead 2012-05-12'),
            (77767, 0, 0, 0.017, 0, 'Cobra Shot - RAP*0.017; Wowhead 2012-05-12'),
            (82928, 0, 0, 0.724, 0, 'Aimed Shot! - RAP*0.724; Wowhead 2012-05-22')
        ON DUPLICATE KEY UPDATE `direct_bonus` = VALUES(`direct_bonus`), `dot_bonus` = VALUES(`dot_bonus`),
            `ap_bonus` = VALUES(`ap_bonus`), `ap_dot_bonus` = VALUES(`ap_dot_bonus`), `comments` = VALUES(`comments`);

        -- Earthquake: the 4.3.4 text of 61882 writes 0.11 of the spell power on top of the
        -- share SpellEffect.dbc holds for the physical damage of 77478.
        INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
            (77478, 0.11, 0, 0, 0, 'Earthquake - 0.11*SPN per hit, 61882''s text; Wowhead 2012-05-12')
        ON DUPLICATE KEY UPDATE `direct_bonus` = VALUES(`direct_bonus`), `dot_bonus` = VALUES(`dot_bonus`),
            `ap_bonus` = VALUES(`ap_bonus`), `ap_dot_bonus` = VALUES(`ap_dot_bonus`), `comments` = VALUES(`comments`);

        -- .debug spellcoefs prints the attack-power lines and the spell power the share multiplies.
        REPLACE INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES
            (143, 'debug spellcoefs', 3, 'Syntax: .debug spellcoefs #spellid\r\n\r\nShow the spell_bonus_data row of spell #spellid and, for each effect, the kind of amount it adds spell power to (damage, heal or absorb; direct or periodic), its SpellEffect.dbc coefficient, the coefficient of the first effect of that kind scaled at your level (the default max level from the console), the part of the row for it and the coefficient that applies. Each such effect also shows the coefficient a pet casting the spell takes: the row, then the SpellEffect.dbc value, then the cast-time default. A damage effect of a spell with SPELL_ATTR_EX3_NO_DONE_BONUS is marked; an effect of no kind takes no spell power share. Then Spell.dbc''s attack-power coefficient and, for a direct hit and a tick, whether the spell''s damage takes it, the row''s attack-power part, the coefficient a player''s damage takes and the one a heal, an absorb or a pet''s spell takes. Then which spell power the share multiplies: the spell power of the spell''s school, or for a physical spell the flat physical damage-done auras alone, a row''s spell-power part then standing for the tooltip''s term on the spell power.');

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
