-- ----------------------------------------------------------------
-- Remove the loot-template indexes of the playerbots module.
-- The module's src/modules/Bots/sql/index_world.sql added a secondary index on
-- the item column of eight loot templates. This repository never created
-- them, so the update is a no-op on repository-managed databases and only
-- drops what an operator applied by hand.
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
    SET @cOldStructure = '09';
    SET @cOldContent = '001';

    SET @cNewVersion = '22';
    SET @cNewStructure = '10';
    SET @cNewContent = '001';
    SET @cNewDescription = 'Remove_Playerbot_Indexes';
    SET @cNewComment = 'Drop the loot-template indexes of the removed playerbots module';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- DDL implicitly commits; each existence check makes a retry safe.
        IF EXISTS (SELECT 1 FROM `information_schema`.`STATISTICS`
                   WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'creature_loot_template'
                     AND `INDEX_NAME` = 'idx_creature_loot_template_item') THEN
            ALTER TABLE `creature_loot_template` DROP INDEX `idx_creature_loot_template_item`;
        END IF;
        IF EXISTS (SELECT 1 FROM `information_schema`.`STATISTICS`
                   WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'disenchant_loot_template'
                     AND `INDEX_NAME` = 'idx_disenchant_loot_template_item') THEN
            ALTER TABLE `disenchant_loot_template` DROP INDEX `idx_disenchant_loot_template_item`;
        END IF;
        IF EXISTS (SELECT 1 FROM `information_schema`.`STATISTICS`
                   WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'fishing_loot_template'
                     AND `INDEX_NAME` = 'idx_fishing_loot_template_item') THEN
            ALTER TABLE `fishing_loot_template` DROP INDEX `idx_fishing_loot_template_item`;
        END IF;
        IF EXISTS (SELECT 1 FROM `information_schema`.`STATISTICS`
                   WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'gameobject_loot_template'
                     AND `INDEX_NAME` = 'idx_gameobject_loot_template_item') THEN
            ALTER TABLE `gameobject_loot_template` DROP INDEX `idx_gameobject_loot_template_item`;
        END IF;
        IF EXISTS (SELECT 1 FROM `information_schema`.`STATISTICS`
                   WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'item_loot_template'
                     AND `INDEX_NAME` = 'idx_item_loot_template_item') THEN
            ALTER TABLE `item_loot_template` DROP INDEX `idx_item_loot_template_item`;
        END IF;
        IF EXISTS (SELECT 1 FROM `information_schema`.`STATISTICS`
                   WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'pickpocketing_loot_template'
                     AND `INDEX_NAME` = 'idx_pickpocketing_loot_template_item') THEN
            ALTER TABLE `pickpocketing_loot_template` DROP INDEX `idx_pickpocketing_loot_template_item`;
        END IF;
        IF EXISTS (SELECT 1 FROM `information_schema`.`STATISTICS`
                   WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'reference_loot_template'
                     AND `INDEX_NAME` = 'idx_reference_loot_template_item') THEN
            ALTER TABLE `reference_loot_template` DROP INDEX `idx_reference_loot_template_item`;
        END IF;
        IF EXISTS (SELECT 1 FROM `information_schema`.`STATISTICS`
                   WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'skinning_loot_template'
                     AND `INDEX_NAME` = 'idx_skinning_loot_template_item') THEN
            ALTER TABLE `skinning_loot_template` DROP INDEX `idx_skinning_loot_template_item`;
        END IF;

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
END $$

DELIMITER ;

CALL update_mangos();

DROP PROCEDURE IF EXISTS `update_mangos`;
