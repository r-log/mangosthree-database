-- ----------------------------------------------------------------
-- Class trainers stop teaching spells their 4.3.4 lists do not have.
--
-- Starting-zone class trainers still taught spells from before Cataclysm moved them to
-- later levels or other trainers (Healing Touch at level 78 on Zen'tabra, Rend and Thunder
-- Clap on the starting warriors, every hunter spell on the starting hunters), hunter
-- trainers taught Freezing Trap 60192 and druid trainers a second Swift Flight Form (40123).
-- Each list was checked against TrinityCore's 15595 sniffed list and Wowhead as of 2012
-- (Zen'tabra, Gart Mistrunner, Llane Beshere, Khelden Bremen, Drusilla La Salle, Lanka
-- Farshot, Pathstalker Kariel, Ogromm, Turak Runetotem): neither has these spells.
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
    SET @cOldContent = '008';

    SET @cNewVersion = '22';
    SET @cNewStructure = '15';
    SET @cNewContent = '009';
    SET @cNewDescription = 'Trainer_Pre_Cataclysm_Spells';
    SET @cNewComment = 'Class trainers stop teaching spells their 4.3.4 lists do not have';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        DELETE FROM `npc_trainer` WHERE (`entry`, `spell`) IN (
            (198, 116),
            (198, 1459),
            (459, 702),
            (460, 702),
            (895, 1130),
            (895, 1978),
            (911, 772),
            (911, 3127),
            (911, 6343),
            (911, 6673),
            (912, 772),
            (912, 3127),
            (912, 6343),
            (912, 6673),
            (915, 53),
            (915, 921),
            (915, 1776),
            (916, 53),
            (916, 921),
            (916, 1776),
            (987, 60192),
            (1231, 60192),
            (1404, 60192),
            (2119, 772),
            (2119, 3127),
            (2119, 6343),
            (2119, 6673),
            (2122, 53),
            (2122, 921),
            (2122, 1776),
            (2124, 116),
            (2124, 1459),
            (2126, 702),
            (3033, 40123),
            (3034, 40123),
            (3036, 40123),
            (3038, 60192),
            (3039, 60192),
            (3040, 60192),
            (3059, 772),
            (3059, 3127),
            (3059, 6343),
            (3059, 6673),
            (3060, 1126),
            (3060, 5185),
            (3061, 1130),
            (3061, 1978),
            (3064, 40123),
            (3065, 60192),
            (3153, 772),
            (3153, 3127),
            (3153, 6343),
            (3153, 6673),
            (3155, 53),
            (3155, 921),
            (3155, 1776),
            (3156, 702),
            (3171, 60192),
            (3352, 60192),
            (3593, 772),
            (3593, 3127),
            (3593, 6343),
            (3593, 6673),
            (3594, 53),
            (3594, 921),
            (3594, 1776),
            (3596, 1130),
            (3596, 1978),
            (3597, 1126),
            (3597, 5185),
            (3601, 60192),
            (3602, 40123),
            (4138, 60192),
            (4146, 60192),
            (4205, 60192),
            (4217, 40123),
            (4218, 40123),
            (4219, 40123),
            (5115, 60192),
            (5116, 60192),
            (5117, 60192),
            (5501, 60192),
            (5504, 40123),
            (5515, 60192),
            (5516, 60192),
            (5517, 60192),
            (8142, 40123),
            (8308, 60192),
            (10930, 60192),
            (12042, 40123),
            (15279, 116),
            (15283, 702),
            (15285, 53),
            (15285, 921),
            (15285, 1776),
            (15513, 1130),
            (15513, 1978),
            (16270, 60192),
            (16499, 1130),
            (16499, 1978),
            (16500, 116),
            (16500, 1459),
            (16503, 772),
            (16503, 3127),
            (16503, 6343),
            (16503, 6673),
            (16655, 40123),
            (16672, 60192),
            (16673, 60192),
            (16674, 60192),
            (16721, 40123),
            (16738, 60192),
            (17110, 60192),
            (17122, 60192),
            (17505, 60192),
            (35873, 5185),
            (38243, 5185),
            (39214, 136),
            (39214, 674),
            (39214, 781),
            (39214, 1130),
            (39214, 1462),
            (39214, 1499),
            (39214, 1513),
            (39214, 1515),
            (39214, 1543),
            (39214, 1978),
            (39214, 2641),
            (39214, 2643),
            (39214, 2973),
            (39214, 2974),
            (39214, 3045),
            (39214, 5116),
            (39214, 5118),
            (39214, 5384),
            (39214, 6197),
            (39214, 6991),
            (39214, 8737),
            (39214, 13159),
            (39214, 13165),
            (39214, 13795),
            (39214, 13809),
            (39214, 13813),
            (39214, 19263),
            (39214, 19503),
            (39214, 19801),
            (39214, 19878),
            (39214, 19879),
            (39214, 19880),
            (39214, 19882),
            (39214, 19883),
            (39214, 19884),
            (39214, 19885),
            (39214, 20043),
            (39214, 20736),
            (39214, 34026),
            (39214, 34477),
            (39214, 34600),
            (39214, 51753),
            (39214, 53271),
            (39214, 53351),
            (39214, 77767),
            (39214, 77769),
            (39214, 79682),
            (39214, 82243),
            (39214, 82654),
            (39214, 82661),
            (39214, 83242),
            (39214, 83243),
            (39214, 83244),
            (39214, 83245),
            (39214, 87493),
            (39214, 87506));

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
