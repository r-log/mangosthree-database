-- ----------------------------------------------------------------
-- The Love Boats could not be boarded: their click spell is the wrong one.
--
-- Clicking a vehicle sends CMSG_SPELLCLICK and the server casts whatever
-- `npc_spellclick_spells` names for that creature. Seating is done by a spell
-- carrying SPELL_AURA_CONTROL_VEHICLE (236), which the core turns into a
-- VehicleInfo::Board. The three Love Boats named spell 69341 "Love Boat",
-- which is a hidden PERIODIC DUMMY aura -- the boat's own ambience, not a
-- ride. Casting it does nothing at all, which is exactly what the live test
-- of 2026-09-20 saw: seven clicks at the Darnassus boat and total silence
-- from the server.
--
-- The seating spell is 69342 "Ride Vehicle" (Control Vehicle on its first
-- effect, a scripted dummy on its second), and it is what the boats are meant
-- to carry. The three entries are the Stormwind (36812), Undercity (37966)
-- and Darnassus (37980) boats of the Love is in the Air event; all three have
-- two seats that VehicleSeat.dbc marks usable by a player and exitable.
--
-- Deliberately NOT touched: the Burning Debris (39238), whose click spell
-- 73677 "Burning Debris Aura" is also a dummy. That one is correct as data --
-- the debris is the rubble of quest 25153 "Bael'dun Rescue", and clicking it
-- frees a trapped survivor rather than seating the player in it. It needs a
-- script, not a ride spell.
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
    SET @cOldStructure = '10';
    SET @cOldContent = '003';

    SET @cNewVersion = '22';
    SET @cNewStructure = '10';
    SET @cNewContent = '004';
    SET @cNewDescription = 'Love_Boat_Ride_Spell';
    SET @cNewComment = 'The Love Boats seat their passenger with 69342, not the ambience dummy 69341';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- Keyed on the old spell as well as the entries, so a database that
        -- already carries the right spell is left alone rather than churned.
        UPDATE `npc_spellclick_spells`
           SET `spell_id` = 69342
         WHERE `npc_entry` IN (36812, 37966, 37980)
           AND `spell_id` = 69341;

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
