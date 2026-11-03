-- ----------------------------------------------------------------
-- The ten Flickering items roll the suffixes their retail tooltips show.
--
-- Each item's suffixes and roll chances are those wowhead lists for it; the client
-- holds several records per suffix name, one per stat budget, and each item takes
-- the record whose budget gives the Stamina, primary and secondary stats listed.
-- Two groups (-457, -459) held only 26% of a roll, one (-456) the wrong budget,
-- and all ten old leftover suffixes of other items.
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
    SET @cOldStructure = '15';
    SET @cOldContent = '001';

    SET @cNewVersion = '22';
    SET @cNewStructure = '15';
    SET @cNewContent = '002';
    SET @cNewDescription = 'Flickering_Item_Suffixes';
    SET @cNewComment = 'The ten Flickering items roll the suffixes their retail tooltips show';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        DELETE FROM `item_enchantment_template` WHERE (`entry`, `ench`) IN (
            (-465, 292),
            (-465, 293),
            (-465, 294),
            (-465, 295),
            (-464, 288),
            (-464, 289),
            (-464, 290),
            (-464, 291),
            (-463, 287),
            (-463, 292),
            (-463, 293),
            (-463, 294),
            (-463, 295),
            (-462, 5),
            (-462, 25),
            (-462, 26),
            (-462, 94),
            (-462, 112),
            (-462, 133),
            (-462, 152),
            (-462, 174),
            (-462, 175),
            (-462, 176),
            (-462, 177),
            (-462, 178),
            (-462, 213),
            (-462, 214),
            (-462, 215),
            (-462, 216),
            (-462, 217),
            (-462, 218),
            (-462, 288),
            (-462, 289),
            (-462, 290),
            (-462, 291),
            (-461, 178),
            (-461, 183),
            (-461, 188),
            (-461, 213),
            (-461, 215),
            (-461, 217),
            (-461, 284),
            (-461, 285),
            (-461, 286),
            (-461, 287),
            (-460, 176),
            (-460, 177),
            (-460, 181),
            (-460, 182),
            (-460, 186),
            (-460, 187),
            (-460, 280),
            (-460, 281),
            (-460, 282),
            (-460, 283),
            (-459, 175),
            (-459, 176),
            (-459, 180),
            (-459, 181),
            (-459, 185),
            (-459, 186),
            (-458, 31),
            (-458, 152),
            (-458, 153),
            (-458, 154),
            (-458, 174),
            (-458, 179),
            (-458, 184),
            (-458, 272),
            (-458, 273),
            (-458, 274),
            (-457, 14),
            (-457, 29),
            (-457, 133),
            (-457, 134),
            (-457, 135),
            (-457, 152),
            (-457, 153),
            (-457, 154),
            (-456, 15),
            (-456, 19),
            (-456, 22),
            (-456, 94),
            (-456, 95),
            (-456, 96),
            (-456, 112),
            (-456, 113),
            (-456, 114),
            (-456, 197),
            (-456, 278),
            (-456, 279),
            (-456, 280),
            (-456, 281),
            (-456, 282),
            (-456, 283));
        INSERT IGNORE INTO `item_enchantment_template` (`entry`, `ench`, `chance`) VALUES
            (-462, 137, 29.9),
            (-462, 136, 25.6),
            (-462, 135, 22.4),
            (-462, 133, 22.1),
            (-458, 273, 34.1),
            (-458, 274, 34.1),
            (-458, 272, 31.8),
            (-456, 266, 19.1),
            (-456, 269, 17.3),
            (-456, 267, 17.0),
            (-456, 265, 16.7),
            (-456, 268, 15.9),
            (-456, 270, 14.0),
            (-460, 280, 27.6),
            (-460, 281, 25.2),
            (-460, 283, 24.3),
            (-460, 282, 22.9),
            (-464, 289, 27.2),
            (-464, 288, 25.3),
            (-464, 290, 25.2),
            (-464, 291, 22.3),
            (-465, 292, 28.8),
            (-465, 294, 24.1),
            (-465, 295, 23.9),
            (-465, 293, 23.3),
            (-457, 263, 18.6),
            (-457, 262, 18.5),
            (-457, 271, 16.0),
            (-457, 261, 16.0),
            (-457, 260, 15.7),
            (-457, 264, 15.4),
            (-463, 135, 28.4),
            (-463, 137, 26.4),
            (-463, 133, 23.9),
            (-463, 136, 21.3),
            (-461, 285, 31.6),
            (-461, 287, 25.4),
            (-461, 286, 23.7),
            (-461, 284, 19.2),
            (-459, 276, 38.1),
            (-459, 277, 31.8),
            (-459, 275, 30.1);

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
