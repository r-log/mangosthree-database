-- ----------------------------------------------------------------
-- Mirror Image's images run their own AI and cannot swing.
--
-- The three images, 31216 (without the glyph), 47243 (Arcane) and
-- 47244 (Fire), take the server's MirrorImageAI, which casts their
-- spells at the mage's target, and the no-melee flag. Their unit
-- flags go to 0: the sniffed values held states (31216 stunned and
-- fleeing, 47243 silenced and fleeing) the summon copied onto the
-- image. Their stats come from the class level table (expansion
-- 3); the multipliers keep the 77490 health, 19394 mana and 8980
-- armor 47243 and 47244 held at level 85, and 31216 takes 47243's
-- level-85 stats. Initialize Images (58836) names the Arcane and
-- Fire images too, as it names 31216.
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
    SET @cOldContent = '015';

    SET @cNewVersion = '22';
    SET @cNewStructure = '16';
    SET @cNewContent = '016';
    SET @cNewDescription = 'Mage_Mirror_Images';
    SET @cNewComment = 'Mirror Image''s images run their own AI and cannot swing';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- The images 31216, 47243 and 47244: their AI, no melee, no state flags, the class level stats.
        UPDATE `creature_template` SET `AIName` = 'MirrorImageAI', `UnitFlags` = 0, `ExtraFlags` = `ExtraFlags` | 131072,
            `Expansion` = 3, `HealthMultiplier` = 1.25, `PowerMultiplier` = 2, `ArmorMultiplier` = 0.926
            WHERE `Entry` IN (31216, 47243, 47244);
        UPDATE `creature_template` SET `DamageMultiplier` = 7, `MinLevelHealth` = 77490, `MaxLevelHealth` = 77490,
            `MinLevelMana` = 19394, `MaxLevelMana` = 19394, `MinMeleeDmg` = 550, `MaxMeleeDmg` = 950, `MinRangedDmg` = 292,
            `MaxRangedDmg` = 438, `Armor` = 8980, `MeleeAttackPower` = 36, `RangedAttackPower` = 110
            WHERE `Entry` = 31216;

        -- Initialize Images 58836: the Arcane and Fire images.
        DELETE FROM `spell_script_target` WHERE `entry` = 58836 AND `type` = 1 AND `targetEntry` IN (47243, 47244);
        INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES
            (58836, 1, 47243, 0),
            (58836, 1, 47244, 0);

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
