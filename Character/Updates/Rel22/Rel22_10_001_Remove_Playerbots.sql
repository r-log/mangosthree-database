-- ----------------------------------------------------------------
-- Remove the tables of the playerbots module.
-- The module (src/modules/Bots) was removed from the server, so nothing reads
-- these tables any more. The three ahbot_* tables belonged to the module's own
-- auction bot; the core AuctionHouseBot has no tables of its own.
-- IMPORTANT: this update is intentionally destructive. Export any bot data you
-- want to keep before applying it, and deploy a server built without the
-- module first -- a server built with PLAYERBOTS=1 reads
-- ai_playerbot_random_bots every world tick.
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
    SET @cNewDescription = 'Remove_Playerbots';
    SET @cNewComment = 'Drop the tables of the removed playerbots module (ai_playerbot_*, ahbot_*)';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- DDL implicitly commits. IF EXISTS makes a retry safe if some tables
        -- were dropped but the version row could not be recorded, and covers
        -- the tables that only exist where the module's own SQL was applied by
        -- hand (db_store, custom_strategy, speech, speech_probability,
        -- tele_cache) as well as the module's auction-bot tables.
        DROP TABLE IF EXISTS `ahbot_category`;
        DROP TABLE IF EXISTS `ahbot_history`;
        DROP TABLE IF EXISTS `ahbot_price`;
        DROP TABLE IF EXISTS `ai_playerbot_names`;
        DROP TABLE IF EXISTS `ai_playerbot_random_bots`;
        DROP TABLE IF EXISTS `ai_playerbot_gear`;
        DROP TABLE IF EXISTS `ai_playerbot_guild_names`;
        DROP TABLE IF EXISTS `ai_playerbot_guild_tasks`;
        DROP TABLE IF EXISTS `ai_playerbot_gear_enchant`;
        DROP TABLE IF EXISTS `ai_playerbot_gem`;
        DROP TABLE IF EXISTS `ai_playerbot_glyph`;
        DROP TABLE IF EXISTS `ai_playerbot_db_store`;
        DROP TABLE IF EXISTS `ai_playerbot_custom_strategy`;
        DROP TABLE IF EXISTS `ai_playerbot_speech`;
        DROP TABLE IF EXISTS `ai_playerbot_speech_probability`;
        DROP TABLE IF EXISTS `ai_playerbot_tele_cache`;

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
