-- ----------------------------------------------------------------
-- Trainer spells name the abilities a player must know to learn them, as the
-- retail 15595 trainer lists do.
--
-- The client reads three required abilities with each trainer spell and keeps
-- a spell unavailable until all are known. npc_trainer and npc_trainer_template
-- get reqability1-3, added only where missing so the update can run again
-- after a failure. 95 spells on 2,492 rows take the abilities of the trainer
-- lists sniffed on build 15595 (the Cataclysm Preservation Project's world
-- database).
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
    SET @cOldStructure = '13';
    SET @cOldContent = '001';

    SET @cNewVersion = '22';
    SET @cNewStructure = '14';
    SET @cNewContent = '001';
    SET @cNewDescription = 'Trainer_Required_Abilities';
    SET @cNewComment = 'Trainer spells name the abilities a player must know to learn them, as sniffed on 15595';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM `information_schema`.`COLUMNS`
                    WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'npc_trainer'
                      AND `COLUMN_NAME` = 'reqability1') THEN
            ALTER TABLE `npc_trainer`
                ADD COLUMN `reqability1` INT(10) UNSIGNED NOT NULL DEFAULT '0'
                    COMMENT 'A spell the player must know to learn this one.' AFTER `reqlevel`,
                ADD COLUMN `reqability2` INT(10) UNSIGNED NOT NULL DEFAULT '0'
                    COMMENT 'A spell the player must know to learn this one.' AFTER `reqability1`,
                ADD COLUMN `reqability3` INT(10) UNSIGNED NOT NULL DEFAULT '0'
                    COMMENT 'A spell the player must know to learn this one.' AFTER `reqability2`;
        END IF;

        IF NOT EXISTS (SELECT 1 FROM `information_schema`.`COLUMNS`
                    WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'npc_trainer_template'
                      AND `COLUMN_NAME` = 'reqability1') THEN
            ALTER TABLE `npc_trainer_template`
                ADD COLUMN `reqability1` INT(10) UNSIGNED NOT NULL DEFAULT '0'
                    COMMENT 'A spell the player must know to learn this one.' AFTER `reqlevel`,
                ADD COLUMN `reqability2` INT(10) UNSIGNED NOT NULL DEFAULT '0'
                    COMMENT 'A spell the player must know to learn this one.' AFTER `reqability1`,
                ADD COLUMN `reqability3` INT(10) UNSIGNED NOT NULL DEFAULT '0'
                    COMMENT 'A spell the player must know to learn this one.' AFTER `reqability2`;
        END IF;

        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 99;
        UPDATE `npc_trainer` SET `reqability1` = 1515, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 136;
        UPDATE `npc_trainer` SET `reqability1` = 71, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 676;
        UPDATE `npc_trainer` SET `reqability1` = 1120, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 693;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 779;
        UPDATE `npc_trainer` SET `reqability1` = 71, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 871;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 1079;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 1082;
        UPDATE `npc_trainer` SET `reqability1` = 1120, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 1122;
        UPDATE `npc_trainer` SET `reqability1` = 2458, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 1680;
        UPDATE `npc_trainer` SET `reqability1` = 2458, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 1719;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 1822;
        UPDATE `npc_trainer` SET `reqability1` = 2836, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 1842;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 1850;
        UPDATE `npc_trainer` SET `reqability1` = 1784, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 1856;
        UPDATE `npc_trainer` SET `reqability1` = 71, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 2565;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 5209;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 5211;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 5215;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 5217;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 5221;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 5225;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 5229;
        UPDATE `npc_trainer` SET `reqability1` = 71, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 6572;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 6785;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 6795;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 6807;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 8895;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 8998;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 9005;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12715;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12716;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12717;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12718;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12754;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12755;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12758;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12759;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12760;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12895;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12897;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12899;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12902;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12903;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12905;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12906;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12907;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 12908;
        UPDATE `npc_trainer` SET `reqability1` = 339, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 16689;
        UPDATE `npc_trainer` SET `reqability1` = 1120, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 18540;
        UPDATE `npc_trainer` SET `reqability1` = 2458, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 20252;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 20719;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 22568;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 22570;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 22842;
        UPDATE `npc_trainer` SET `reqability1` = 33391, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 23214;
        UPDATE `npc_trainer` SET `reqability1` = 1120, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 29858;
        UPDATE `npc_trainer` SET `reqability1` = 1120, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 29893;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 30558;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 30560;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 30563;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 30565;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 30566;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 30568;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 30569;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 30570;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 30574;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 30575;
        UPDATE `npc_trainer` SET `reqability1` = 527, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 32375;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 33745;
        UPDATE `npc_trainer` SET `reqability1` = 33391, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 34767;
        UPDATE `npc_trainer` SET `reqability1` = 34091, `reqability2` = 33943, `reqability3` = 0 WHERE `spell` = 40120;
        UPDATE `npc_trainer` SET `reqability1` = 42955, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 43987;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 52610;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 56473;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 56514;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 62078;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 62600;
        UPDATE `npc_trainer` SET `reqability1` = 33391, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 69826;
        UPDATE `npc_trainer` SET `reqability1` = 33391, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 73630;
        UPDATE `npc_trainer` SET `reqability1` = 56034, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 75154;
        UPDATE `npc_trainer` SET `reqability1` = 56039, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 75155;
        UPDATE `npc_trainer` SET `reqability1` = 55642, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 75172;
        UPDATE `npc_trainer` SET `reqability1` = 55769, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 75175;
        UPDATE `npc_trainer` SET `reqability1` = 55777, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 75178;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 77758;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 77761;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 77764;
        UPDATE `npc_trainer` SET `reqability1` = 5487, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 80964;
        UPDATE `npc_trainer` SET `reqability1` = 768, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 80965;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 84412;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 84413;
        UPDATE `npc_trainer` SET `reqability1` = 74558, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 88893;
        UPDATE `npc_trainer` SET `reqability1` = 20219, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 95705;
        UPDATE `npc_trainer` SET `reqability1` = 20222, `reqability2` = 0, `reqability3` = 0 WHERE `spell` = 95707;

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
