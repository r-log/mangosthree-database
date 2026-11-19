-- ----------------------------------------------------------------
-- The Frostfire Orb creature carries its scan and Floating as addon
-- auras and cannot be selected.
--
-- With the Frostfire Orb talent, the mage's 92283 summons the
-- Frostfire Orb, creature 45322, through 84714. In the 4.3.4 client
-- data its own aura is 84717, which casts the orb's scan 84718 every
-- 500 ms. No row gave it to the creature. The row below casts it
-- with Floating 27985 (water walk, feather fall and hover, as the
-- Flaming Orb 44214 has it) on every orb when it is made. The
-- visual 84716 is left off: its state kit freezes the orb's birth
-- animation on its first frame, where the orb model draws nothing.
-- The creature also takes the Flaming Orb's unit flags (33554520:
-- not selectable). The update can run again after a failure.
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
    SET @cOldContent = '013';

    SET @cNewVersion = '22';
    SET @cNewStructure = '16';
    SET @cNewContent = '014';
    SET @cNewDescription = 'Mage_Frostfire_Orb_Creature';
    SET @cNewComment = 'The Frostfire Orb creature carries its scan and Floating and cannot be selected';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- Frostfire Orb 45322: its scan every 500 ms (84717) and Floating (27985).
        INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_pvp_state`, `emote`, `moveflags`, `auras`) VALUES
            (45322, 0, 0, 0, 0, 0, 0, '84717 27985')
        ON DUPLICATE KEY UPDATE `mount` = VALUES(`mount`), `bytes1` = VALUES(`bytes1`), `b2_0_sheath` = VALUES(`b2_0_sheath`),
            `b2_1_pvp_state` = VALUES(`b2_1_pvp_state`), `emote` = VALUES(`emote`), `moveflags` = VALUES(`moveflags`),
            `auras` = VALUES(`auras`);

        -- Frostfire Orb 45322: not selectable, as the Flaming Orb 44214.
        UPDATE `creature_template` SET `UnitFlags` = 33554520 WHERE `Entry` = 45322;

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
