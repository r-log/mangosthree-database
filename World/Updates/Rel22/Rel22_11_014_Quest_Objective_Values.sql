-- ----------------------------------------------------------------
-- Quests whose new objectives our data can credit take the objectives of
-- the retail 15595 sniffs.
--
-- Rel22_11_010 left out the quests whose sniffed objectives differ from ours.
-- Where every new target can be credited from this database (a spawned
-- creature, a kill-credit link, a credit spell, an EventAI or db_scripts
-- credit; an item that drops, is sold or is made by a spell), the quest takes
-- all its sniffed query-reply fields. The quests with a target nothing here
-- can give keep theirs. Money on level -1 quests and ids the client files
-- lack stay as in Rel22_11_010.
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
    SET @cOldContent = '013';

    SET @cNewVersion = '22';
    SET @cNewStructure = '11';
    SET @cNewContent = '014';
    SET @cNewDescription = 'Quest_Objective_Values';
    SET @cNewComment = 'Quests whose new objectives our data can credit take the objectives of the retail 15595 sniffs';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        UPDATE `quest_template` SET `ObjectiveText2` = 'Convey orders to Mountaineer Lewin', `ObjectiveText3` = 'Convey orders to Mountaineer Valgrum' WHERE `entry` = 313;
        UPDATE `quest_template` SET `ReqItemCount2` = 0 WHERE `entry` = 994;
        UPDATE `quest_template` SET `MinLevel` = 80, `Details` = 'A creature called "The Abominable Greench" stole our shipment of treats, $N.  Be careful though!  He''s vicious and a bunch of those little green gnomes do his bidding!$B$BYou''re gonna need some help in facing him.  Rumor has it he''s holding our treats and our beloved Metzen the Reindeer at Growless Cave in the Hillsbrad Foothills!  Find the treats $N and bring them back before the celebration is ruined and all the children of Ogrimmar are disappointed!', `Objectives` = 'Recover the Stolen Treats and free Metzen the Reindeer after defeating the Abominable Greench, who is hiding out near Growless Cave in the Hillsbrad Foothills.', `ObjectiveText2` = 'Free Metzen the Reindeer', `ReqCreatureOrGOId1` = 0, `ReqCreatureOrGOId2` = 15664, `ReqCreatureOrGOCount1` = 0, `ReqCreatureOrGOCount2` = 1, `RewItemId1` = 73792, `RewItemCount1` = 1 WHERE `entry` = 6983;
        UPDATE `quest_template` SET `MinLevel` = 80, `Details` = 'A creature called "The Abominable Greench" stole our shipment of treats, $N.  Be careful though!  He''s vicious and a bunch of those little green gnomes do his bidding!$B$BYou''re gonna need some help in facing him.  Rumor has it he''s holding our treats and our beloved Metzen the Reindeer at Growless Cave in the Hillsbrad Foothills!  Find the treats $N and bring them back before the celebration is ruined and all the children of Stormwind are disappointed!', `Objectives` = 'Recover the Stolen Treats and free Metzen the Reindeer after defeating the Abominable Greench, who is hiding out near Growless Cave in the Hillsbrad Foothills.', `ObjectiveText2` = 'Free Metzen the Reindeer', `ReqCreatureOrGOId1` = 0, `ReqCreatureOrGOId2` = 15664, `ReqCreatureOrGOCount1` = 0, `ReqCreatureOrGOCount2` = 1, `RewItemId1` = 73792, `RewItemCount1` = 1 WHERE `entry` = 7043;
        UPDATE `quest_template` SET `ReqItemCount2` = 0 WHERE `entry` = 8232;
        UPDATE `quest_template` SET `SrcItemId` = 0, `SrcItemCount` = 0, `Details` = 'DISASTER has struck!  Metzen the Reindeer has been kidnapped!$B$BMetzen is one of Great-father Winter''s eight reindeer - and property of Smokywood Pastures.  We believe he was carried off by that dastardly Abominable Greench, hiding out in Hillsbrad Foothills.  With the holiday season well under way, we''re strapped to the coin box here!  Please - find Metzen, defeat his captors, and return him to us!', `Objectives` = 'Rescue Metzen the Reindeer from his captors near Growless Cave in the Hillsbrad Foothills.', `ReqItemId2` = 0, `ReqItemCount2` = 0 WHERE `entry` = 8746;
        UPDATE `quest_template` SET `SrcItemId` = 0, `SrcItemCount` = 0, `Details` = 'DISASTER has struck!  Metzen the Reindeer has been kidnapped!$B$BMetzen is one of Great-father Winter''s eight reindeer - and property of Smokywood Pastures.  We believe he was carried off by that dastardly Abominable Greench, hiding out in Hillsbrad Foothills.  With the holiday season well under way, we''re strapped to the coin box here!  Please - find Metzen, defeat his captors, and return him to us!', `Objectives` = 'Rescue Metzen the Reindeer from his captors near Growless Cave in Hillsbrad Foothills.', `ReqItemId2` = 0, `ReqItemCount2` = 0 WHERE `entry` = 8762;
        UPDATE `quest_template` SET `Type` = 0, `SuggestedPlayers` = 0, `ReqSourceId1` = 24278, `ReqSourceCount1` = 1, `RewMoneyMaxLevel` = 840 WHERE `entry` = 9711;
        UPDATE `quest_template` SET `ReqSourceId1` = 0, `ReqSourceId2` = 30425, `ReqSourceCount1` = 0, `ReqSourceCount2` = 12, `RewMoneyMaxLevel` = 5700 WHERE `entry` = 10538;
        UPDATE `quest_template` SET `ObjectiveText1` = 'Targets Hit', `ReqItemId1` = 0, `ReqItemId2` = 33442, `ReqItemCount1` = 0, `ReqItemCount2` = 1, `ReqCreatureOrGOId1` = 54231, `ReqCreatureOrGOCount1` = 30 WHERE `entry` = 11345;
        UPDATE `quest_template` SET `ReqItemId1` = 0, `ReqItemCount1` = 0, `RewMoneyMaxLevel` = 12000 WHERE `entry` = 11656;
        UPDATE `quest_template` SET `ReqItemId1` = 0, `ReqItemCount1` = 0, `RewMoneyMaxLevel` = 12000 WHERE `entry` = 11661;
        UPDATE `quest_template` SET `Objectives` = 'Rescue 5 Helpless Wintergarde Villagers and return to Gryphon Commander Urik at Wintergarde Keep.', `ReqCreatureOrGOCount1` = 5, `RewMoneyMaxLevel` = 12300 WHERE `entry` = 12237;
        UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 56891 WHERE `entry` = 12289;
        UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 53183 WHERE `entry` = 12592;
        UPDATE `quest_template` SET `ReqSourceId1` = 0, `ReqSourceId3` = 46316, `ReqSourceCount1` = 0, `ReqSourceCount3` = 1 WHERE `entry` = 13875;
        UPDATE `quest_template` SET `Details` = '<Halga grins disarmingly, holding up an enormous firearm.>$B$BHave you ever used one of these, $N? It''s a beast. Hell with a handgrip. Too heavy to use on foot, but perfect when riding at the head of a caravan. I call it my ''street sweeper.''$B$BWe need to get those supplies you''ve collected to the Crossroads, and I expect trouble. I''d like for you to ride shotgun. Literally! Say the word when you''re ready and I''ll put you at the head of our next caravan.', `ReqCreatureOrGOId1` = 53613, `ReqCreatureOrGOCount1` = 1 WHERE `entry` = 13949;
        UPDATE `quest_template` SET `ObjectiveText1` = 'Tonga''s Eyes Taken to Summit', `ReqItemId3` = 0, `ReqItemId5` = 46782, `ReqItemCount3` = 0, `ReqItemCount5` = 1, `ReqCreatureOrGOId1` = 34631, `ReqCreatureOrGOId2` = 0, `ReqCreatureOrGOCount1` = 1, `ReqCreatureOrGOCount2` = 0 WHERE `entry` = 13988;
        UPDATE `quest_template` SET `ReqItemId1` = 0, `ReqItemCount1` = 0 WHERE `entry` = 24549;
        UPDATE `quest_template` SET `SrcItemId` = 54345, `SrcItemCount` = 1, `RewMoneyMaxLevel` = 66000 WHERE `entry` = 25467;
        UPDATE `quest_template` SET `ReqSourceCount1` = 6 WHERE `entry` = 25867;
        UPDATE `quest_template` SET `Objectives` = 'Catch 6 Canal Crabs. Deliver them to Robby Flay in Stormwind City.', `CompletedText` = 'Return to Robby Flay in Stormwind City.', `ReqItemCount1` = 6 WHERE `entry` = 26177;
        UPDATE `quest_template` SET `ObjectiveText1` = 'Fight in the Battle for the Abyssal Breach', `RewMoneyMaxLevel` = 124750 WHERE `entry` = 26193;
        UPDATE `quest_template` SET `ObjectiveText1` = 'Fight in the Battle for the Abyssal Breach', `RewMoneyMaxLevel` = 124750 WHERE `entry` = 26194;
        UPDATE `quest_template` SET `ObjectiveText1` = 'Nuptials Completed' WHERE `entry` = 28655;
        UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 51380, `ReqCreatureOrGOId2` = 51379, `ReqCreatureOrGOCount1` = 10, `ReqCreatureOrGOCount2` = 1 WHERE `entry` = 28900;
        UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 51622, `ReqCreatureOrGOCount1` = 6 WHERE `entry` = 28936;
        UPDATE `quest_template` SET `MinLevel` = 1, `NextQuestInChain` = 0, `RewXPId` = 0, `Title` = 'Potion Master', `Details` = 'Potions, potions, potions.  Can I teach you about potions!$b$bYou''re going to have to bring me samples of your work, so I know you''re ready.$b$bRemember $N, you can only learn ONE specialization, so if you complete your potion training, then elixir and transmutation specialization will no longer be available.', `Objectives` = 'Bring a large supply of potions to an alchemy trainer in any capital city.', `CompletedText` = 'Return to an alchemy trainer in any capital city.', `ReqItemId1` = 57191, `ReqItemId2` = 57192, `ReqItemId3` = 58488, `ReqItemCount1` = 6, `ReqItemCount2` = 6, `ReqItemCount3` = 2, `ReqCreatureOrGOId1` = 0, `ReqCreatureOrGOCount1` = 0, `RewRepFaction1` = 0, `RewRepValueId1` = 0 WHERE `entry` = 29067;
        UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 52303, `ReqCreatureOrGOCount1` = 1 WHERE `entry` = 29096;
        UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 52911, `ReqCreatureOrGOCount1` = 1, `RewMoneyMaxLevel` = 165400 WHERE `entry` = 29116;
        UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 52911, `ReqCreatureOrGOCount1` = 1, `RewMoneyMaxLevel` = 165400 WHERE `entry` = 29228;
        UPDATE `quest_template` SET `ObjectiveText1` = 'Accompanied Kalecgos to Coldarra' WHERE `entry` = 29240;
        UPDATE `quest_template` SET `ObjectiveText1` = 'Witnessed Dragonwrath Ceremony in Orgrimmar' WHERE `entry` = 29309;
        UPDATE `quest_template` SET `ObjectiveText1` = 'Witnessed Dragonwrath Ceremony in Stormwind' WHERE `entry` = 29312;
        UPDATE `quest_template` SET `ReqSourceCount2` = 10 WHERE `entry` = 29455;
        UPDATE `quest_template` SET `SrcItemId` = 72110, `SrcItemCount` = 1, `ReqSourceId1` = 72110, `ReqSourceCount1` = 1 WHERE `entry` = 29467;
        UPDATE `quest_template` SET `ReqSourceCount1` = 4, `ReqSourceCount2` = 4 WHERE `entry` = 29468;
        UPDATE `quest_template` SET `ReqSourceCount1` = 1 WHERE `entry` = 29473;
        UPDATE `quest_template` SET `ReqItemId1` = 72046, `ReqItemCount1` = 6 WHERE `entry` = 29479;
        UPDATE `quest_template` SET `ReqSourceCount2` = 5 WHERE `entry` = 29483;
        UPDATE `quest_template` SET `ReqSourceCount2` = 1, `ReqSourceCount3` = 5 WHERE `entry` = 29484;
        UPDATE `quest_template` SET `ReqSourceId2` = 72043, `ReqSourceCount2` = 1 WHERE `entry` = 29506;
        UPDATE `quest_template` SET `ReqSourceCount1` = 4, `ReqSourceCount2` = 4 WHERE `entry` = 29508;
        UPDATE `quest_template` SET `ReqSourceCount2` = 1, `ReqSourceCount3` = 5 WHERE `entry` = 29509;
        UPDATE `quest_template` SET `ReqSourceId1` = 0, `ReqSourceId2` = 72018, `ReqSourceCount1` = 0, `ReqSourceCount2` = 6 WHERE `entry` = 29510;
        UPDATE `quest_template` SET `ReqSourceId1` = 72110, `ReqSourceCount1` = 1 WHERE `entry` = 29511;
        UPDATE `quest_template` SET `ReqSourceCount1` = 1 WHERE `entry` = 29512;
        UPDATE `quest_template` SET `ReqSourceId2` = 71971, `ReqSourceCount1` = 1, `ReqSourceCount2` = 1 WHERE `entry` = 29515;
        UPDATE `quest_template` SET `ReqSourceCount2` = 5 WHERE `entry` = 29516;
        UPDATE `quest_template` SET `ReqSourceId2` = 71977, `ReqSourceCount2` = 1 WHERE `entry` = 29517;
        UPDATE `quest_template` SET `ReqSourceCount2` = 1 WHERE `entry` = 29649;
        UPDATE `quest_template` SET `ReqSourceCount2` = 1, `RewMoneyMaxLevel` = 11400 WHERE `entry` = 29650;
        UPDATE `quest_template` SET `ReqItemId1` = 0, `ReqItemCount1` = 0 WHERE `entry` = 29672;
        UPDATE `quest_template` SET `ReqSourceCount3` = 1, `RewMoneyMaxLevel` = 165400 WHERE `entry` = 29802;
        UPDATE `quest_template` SET `ReqSourceCount1` = 1, `ReqSourceCount2` = 1, `ReqSourceCount3` = 1, `ReqSourceCount4` = 1, `RewMoneyMaxLevel` = 330750 WHERE `entry` = 30097;
        UPDATE `quest_template` SET `ReqSourceCount1` = 1, `RewMoneyMaxLevel` = 330750 WHERE `entry` = 30104;
        UPDATE `quest_template` SET `ReqSourceCount2` = 1, `RewMoneyMaxLevel` = 330750 WHERE `entry` = 30105;
        UPDATE `quest_template` SET `ReqSourceCount1` = 1, `RewMoneyMaxLevel` = 18900 WHERE `entry` = 30120;

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
