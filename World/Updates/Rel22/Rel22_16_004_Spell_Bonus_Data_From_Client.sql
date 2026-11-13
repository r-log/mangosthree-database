-- ----------------------------------------------------------------
-- spell_bonus_data keeps only what the client's files do not hold.
--
-- The spell power share of a spell's effect is the effect's bonus
-- coefficient in SpellEffect.dbc. The table keeps:
--   - the attack-power shares, unchanged;
--   - the absorb shields, whose share is written only in their
--     4.3.4 tooltip text (direct_bonus of spell power, ap_bonus of
--     attack power for Sacred Shield);
--   - Haunt, Holy Wrath, Lightwell Renew and the demons' Firebolt,
--     Torment, Whiplash, Lash of Pain and Shadow Bite, whose
--     SpellEffect.dbc coefficient is 0 while their 4.3.4 tooltip
--     text gives a spell power share. A demon's share is of its own
--     spell power, which the text writes as $SP*0.5.
-- Every other row is removed. Each kept row's comment names the
-- spell and the reason it stays.
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
    SET @cOldContent = '003';

    SET @cNewVersion = '22';
    SET @cNewStructure = '16';
    SET @cNewContent = '004';
    SET @cNewDescription = 'Spell_Bonus_Data_From_Client';
    SET @cNewComment = 'spell_bonus_data keeps the attack-power and absorb-shield coefficients; the rest comes from SpellEffect.dbc';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- Rows whose spell power share SpellEffect.dbc holds, or that hold none.
        DELETE FROM `spell_bonus_data` WHERE `entry` IN (
            116, 133, 172, 348, 379, 585, 603, 635, 755, 974, 980, 1120, 1949, 2120, 2645, 2944,
            3606, 5176, 5570, 5672, 5707, 5857, 7268, 8034, 8042, 8050, 8056, 8129, 8188, 8921,
            8936, 10444, 11366, 11538, 14914, 15237, 15662, 17712, 17962, 18562, 18790, 19750,
            20424, 21179, 23455, 25997, 26364, 27243, 27813, 28176, 30294, 30455, 31024, 31117,
            31804, 33619, 33763, 34433, 34913, 34914, 38395, 40293, 42208, 42223, 42231, 43733,
            44203, 44425, 44614, 46567, 47666, 47750, 47897, 47960, 48438, 48743, 49821, 50288,
            50401, 50464, 53595, 53600, 53733, 54158, 54181, 54757, 56131, 56160, 56903, 59626,
            61295, 63106, 63544, 63675, 64085, 64569, 71824);

        -- Absorb shields: the share their 4.3.4 tooltip text writes.
        INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
            (17, 0.87, 0, 0, 0, 'Power Word: Shield - absorb 0.87*SP'),
            (543, 0.807, 0, 0, 0, 'Mage Ward - absorb 0.807*SPA'),
            (1463, 0.807, 0, 0, 0, 'Mana Shield - absorb 0.807*SPA'),
            (6229, 0.807, 0, 0, 0, 'Shadow Ward - absorb 0.807*SP'),
            (11426, 0.87, 0, 0, 0, 'Ice Barrier - absorb 0.87*SPFR'),
            (91711, 0.807, 0, 0, 0, 'Nether Ward - absorb 0.807*SP'),
            (96263, 0, 0, 2.8, 0, 'Sacred Shield - absorb 2.8*AP')
        ON DUPLICATE KEY UPDATE `direct_bonus` = VALUES(`direct_bonus`), `dot_bonus` = VALUES(`dot_bonus`),
            `ap_bonus` = VALUES(`ap_bonus`), `ap_dot_bonus` = VALUES(`ap_dot_bonus`), `comments` = VALUES(`comments`);

        -- Overrides: SpellEffect.dbc holds 0, the 4.3.4 tooltip text a spell power share.
        UPDATE `spell_bonus_data` SET `direct_bonus` = 0.61, `comments` = 'Holy Wrath - attack power; override 0.61*SPH' WHERE `entry` = 2812;
        UPDATE `spell_bonus_data` SET `direct_bonus` = 0.6971, `comments` = 'Haunt - override 0.5577*1.25*SP' WHERE `entry` = 48181;
        INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
            (3110, 0.657, 0, 0, 0, 'Firebolt - override 0.657*pet SP'),
            (3716, 0.512, 0, 0, 0, 'Torment - override 0.512*pet SP'),
            (6360, 0.85, 0, 0, 0, 'Whiplash - override 0.85*pet SP'),
            (7001, 0, 0.308, 0, 0, 'Lightwell Renew - override 0.308*SP per tick'),
            (7814, 0.612, 0, 0, 0, 'Lash of Pain - override 0.612*pet SP'),
            (54049, 1.228, 0, 0, 0, 'Shadow Bite - override 1.228*pet SP')
        ON DUPLICATE KEY UPDATE `direct_bonus` = VALUES(`direct_bonus`), `dot_bonus` = VALUES(`dot_bonus`),
            `ap_bonus` = VALUES(`ap_bonus`), `ap_dot_bonus` = VALUES(`ap_dot_bonus`), `comments` = VALUES(`comments`);

        -- Attack-power rows: values unchanged, the comment names the reason.
        UPDATE `spell_bonus_data` SET `comments` = 'Garrote - attack power' WHERE `entry` = 703;
        UPDATE `spell_bonus_data` SET `comments` = 'Exorcism - attack power' WHERE `entry` = 879;
        UPDATE `spell_bonus_data` SET `comments` = 'Gouge - attack power' WHERE `entry` = 1776;
        UPDATE `spell_bonus_data` SET `comments` = 'Rake - attack power' WHERE `entry` = 1822;
        UPDATE `spell_bonus_data` SET `comments` = 'Serpent Sting - attack power' WHERE `entry` = 1978;
        UPDATE `spell_bonus_data` SET `comments` = 'Deadly Poison - attack power' WHERE `entry` = 2818;
        UPDATE `spell_bonus_data` SET `comments` = 'Arcane Shot - attack power' WHERE `entry` = 3044;
        UPDATE `spell_bonus_data` SET `comments` = 'Black Arrow - attack power' WHERE `entry` = 3674;
        UPDATE `spell_bonus_data` SET `comments` = 'Instant Poison - attack power' WHERE `entry` = 8680;
        UPDATE `spell_bonus_data` SET `comments` = 'Pounce Bleed - attack power' WHERE `entry` = 9007;
        UPDATE `spell_bonus_data` SET `comments` = 'Wound Poison - attack power' WHERE `entry` = 13218;
        UPDATE `spell_bonus_data` SET `comments` = 'Immolation Trap - attack power' WHERE `entry` = 13797;
        UPDATE `spell_bonus_data` SET `comments` = 'Explosive Trap - attack power' WHERE `entry` = 13812;
        UPDATE `spell_bonus_data` SET `comments` = 'Counterattack - attack power' WHERE `entry` = 19306;
        UPDATE `spell_bonus_data` SET `comments` = 'Holy Shield - attack power' WHERE `entry` = 20925;
        UPDATE `spell_bonus_data` SET `comments` = 'Seal of Righteousness - attack power' WHERE `entry` = 25742;
        UPDATE `spell_bonus_data` SET `comments` = 'Lacerate - attack power' WHERE `entry` = 33745;
        UPDATE `spell_bonus_data` SET `comments` = 'Seal of Truth - attack power' WHERE `entry` = 42463;
        UPDATE `spell_bonus_data` SET `comments` = 'Icy Touch - attack power' WHERE `entry` = 45477;
        UPDATE `spell_bonus_data` SET `comments` = 'Strangulate - attack power' WHERE `entry` = 47476;
        UPDATE `spell_bonus_data` SET `comments` = 'Death Coil damage - attack power' WHERE `entry` = 47632;
        UPDATE `spell_bonus_data` SET `comments` = 'Death Coil heal - attack power' WHERE `entry` = 47633;
        UPDATE `spell_bonus_data` SET `comments` = 'Blood Boil - attack power' WHERE `entry` = 48721;
        UPDATE `spell_bonus_data` SET `comments` = 'Howling Blast - attack power' WHERE `entry` = 49184;
        UPDATE `spell_bonus_data` SET `comments` = 'Unholy Blight - attack power' WHERE `entry` = 50536;
        UPDATE `spell_bonus_data` SET `comments` = 'Pestilence - attack power' WHERE `entry` = 50842;
        UPDATE `spell_bonus_data` SET `comments` = 'Death and Decay - attack power' WHERE `entry` = 52212;
        UPDATE `spell_bonus_data` SET `comments` = 'Blood Plague - attack power' WHERE `entry` = 55078;
        UPDATE `spell_bonus_data` SET `comments` = 'Frost Fever - attack power' WHERE `entry` = 55095;
        UPDATE `spell_bonus_data` SET `comments` = 'Faerie Fire (Feral) - attack power' WHERE `entry` = 60089;

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
