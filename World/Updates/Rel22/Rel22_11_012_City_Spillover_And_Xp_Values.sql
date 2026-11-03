-- ----------------------------------------------------------------
-- Capital-city reputation spills over as far as the client's Faction.dbc
-- allows, and levels 70 to 79 need the experience patch 4.3 set.
--
-- A gain with a capital city gives each other capital of the faction a
-- quarter of it until that capital reaches its Faction.dbc cap: Friendly,
-- or Honored for Thunder Bluff. Ours gave it up to Exalted, and two rows
-- gave 0.27. Patch 4.3.0 cut the experience for levels 70 to 80 by about a
-- third; ours still held the earlier values for 70 to 79.
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
    SET @cOldStructure = '11';
    SET @cOldContent = '011';

    SET @cNewVersion = '22';
    SET @cNewStructure = '11';
    SET @cNewContent = '012';
    SET @cNewDescription = 'City_Spillover_And_Xp_Values';
    SET @cNewComment = 'Capital-city spillover stops where Faction.dbc caps it, and levels 70-79 need the 4.3 experience';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rank_2` = 4, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 47;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rank_2` = 4, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 54;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rank_2` = 5, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 68;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rank_2` = 4, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 69;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rank_2` = 4, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 72;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rank_2` = 5, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 76;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rank_2` = 4, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 81;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rank_2` = 5, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 530;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rank_2` = 5, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 911;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rank_2` = 4, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 930;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rate_2` = 0.25, `rank_2` = 4, `rank_3` = 4, `rank_4` = 5, `rank_5` = 4 WHERE `faction` = 1133;
        UPDATE `reputation_spillover_template` SET `rank_1` = 4, `rate_2` = 0.25, `rank_2` = 4, `rank_3` = 4, `rank_4` = 4, `rank_5` = 4 WHERE `faction` = 1134;

        UPDATE `player_xp_for_level` SET `xp_for_next_level` = 813000 WHERE `lvl` = 70;
        UPDATE `player_xp_for_level` SET `xp_for_next_level` = 821000 WHERE `lvl` = 71;
        UPDATE `player_xp_for_level` SET `xp_for_next_level` = 830000 WHERE `lvl` = 72;
        UPDATE `player_xp_for_level` SET `xp_for_next_level` = 838000 WHERE `lvl` = 73;
        UPDATE `player_xp_for_level` SET `xp_for_next_level` = 847000 WHERE `lvl` = 74;
        UPDATE `player_xp_for_level` SET `xp_for_next_level` = 855000 WHERE `lvl` = 75;
        UPDATE `player_xp_for_level` SET `xp_for_next_level` = 865000 WHERE `lvl` = 76;
        UPDATE `player_xp_for_level` SET `xp_for_next_level` = 873000 WHERE `lvl` = 77;
        UPDATE `player_xp_for_level` SET `xp_for_next_level` = 882000 WHERE `lvl` = 78;
        UPDATE `player_xp_for_level` SET `xp_for_next_level` = 891000 WHERE `lvl` = 79;

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
