-- ----------------------------------------------------------------
-- .pinfo reports one latency; the client measures two.
-- The client holds two world streams, times each separately and shows both
-- behind its latency meter. LANG_PINFO_ACCOUNT had room for a single figure,
-- so the command could only ever report half of what the server knows.
-- Stream 0 is the client's "home" reading and stream 1 its "world" one.
-- The conversion is appended, so a database that misses this update keeps
-- working: the extra argument is simply ignored.
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
    SET @cOldContent = '002';

    SET @cNewVersion = '22';
    SET @cNewStructure = '10';
    SET @cNewContent = '003';
    SET @cNewDescription = 'Pinfo_Both_Latencies';
    SET @cNewComment = 'Report the home and world latencies separately in .pinfo';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- UPDATE, not REPLACE: the translation is worth keeping and only its
        -- tail changes.
        --
        -- The REPLACE() keys on '%ums', not on the word before it. That word is
        -- Cyrillic, and a database imported under the wrong client charset holds
        -- question marks where it should be -- which is common enough to have
        -- happened on the realm this was written against. Anchoring on the
        -- conversion instead updates those rows too, and '%ums' appears exactly
        -- once: it is the only figure in the line measured in milliseconds.
        --
        -- A row this still does not match keeps its single conversion and stays
        -- safe: a surplus argument is discarded, where a missing one would be
        -- undefined behaviour.
        UPDATE `mangos_string`
           SET `content_default` = 'Player%s %s (guid: %u) Account: %s (id: %u) GMLevel: %u Last IP: %s Last login: %s Latency: home %ums, world %ums',
               `content_loc8` = REPLACE(`content_loc8`, '%ums', 'дом %ums, мир %ums')
         WHERE `entry` = 548;

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
