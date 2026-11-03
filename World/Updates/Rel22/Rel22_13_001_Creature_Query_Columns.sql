-- ----------------------------------------------------------------
-- The creature query reply's columns: female name, second type-flags word and
-- required expansion, with the values of the retail 15595 sniffs.
--
-- The client reads a female name, two type-flags words and an expansion with
-- each creature (CreatureStats::Unpack); the server sent them empty or 0.
-- From the Cataclysm Preservation Project's world database (rows verified on
-- build 15595): 1 female name, 36 second type-flags words, 22 expansions.
-- The columns are added only where missing, so the update can run again
-- after a failure.
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
    SET @cOldStructure = '12';
    SET @cOldContent = '002';

    SET @cNewVersion = '22';
    SET @cNewStructure = '13';
    SET @cNewContent = '001';
    SET @cNewDescription = 'Creature_Query_Columns';
    SET @cNewComment = 'The creature query reply columns hold the female name, second type flags and expansion, as sniffed on 15595';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM `information_schema`.`COLUMNS`
                    WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'creature_template'
                      AND `COLUMN_NAME` = 'FemaleName') THEN
            ALTER TABLE `creature_template`
                ADD COLUMN `FemaleName` CHAR(100) DEFAULT NULL
                    COMMENT 'The name the client shows for a female creature.' AFTER `Name`,
                ADD COLUMN `CreatureTypeFlags2` INT(10) UNSIGNED NOT NULL DEFAULT '0'
                    COMMENT 'The second word of the type flags the client reads.' AFTER `CreatureTypeFlags`,
                ADD COLUMN `RequiredExpansion` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0'
                    COMMENT 'The expansion the client reads with the creature.' AFTER `Expansion`;
        END IF;

        UPDATE `creature_template` SET `FemaleName` = 'Scarlet Priestess' WHERE `Entry` = 10608;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 31883;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 16 WHERE `Entry` = 41807;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 16 WHERE `Entry` = 41849;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 16 WHERE `Entry` = 41850;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 16 WHERE `Entry` = 41851;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 45191;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 45344;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 46473;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 46517;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 46536;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 48283;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 48546;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 49564;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 50409;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 50410;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 50411;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 51157;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 51865;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 52057;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 52070;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 1 WHERE `Entry` = 52571;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 52785;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 53149;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 53164;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 53210;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 53215;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 53227;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 53356;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 53357;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 53402;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 53417;
        UPDATE `creature_template` SET `RequiredExpansion` = 3 WHERE `Entry` = 53531;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 1 WHERE `Entry` = 53856;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 1 WHERE `Entry` = 53857;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 1 WHERE `Entry` = 53858;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 8 WHERE `Entry` = 53879;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 55837;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 55838;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 56087;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 56097;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 56129;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 56130;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 56131;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 56165;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 56668;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 56694;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 57328;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 57377;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 57378;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 57379;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 57443;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 57882;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 58039;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 58150;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 6 WHERE `Entry` = 58613;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 8 WHERE `Entry` = 58862;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 8 WHERE `Entry` = 58863;
        UPDATE `creature_template` SET `CreatureTypeFlags2` = 8 WHERE `Entry` = 58864;

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
