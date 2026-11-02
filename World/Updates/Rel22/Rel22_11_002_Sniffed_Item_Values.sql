-- ----------------------------------------------------------------
-- 164 items the 15595 client's files do not hold take the values of
-- the retail 15595 sniffs.
--
-- The client asks the server for these items, so it shows their
-- `item_sparse` rows. The Cataclysm Preservation Project's hotfixes
-- database keeps 187 retail records of build 15595; 182 are rows of
-- `item_sparse`, and these differ from ours:
--   - descriptions: the texts of other items ("Turkey Shooter", "Petrified
--     Fungal Heart", "Sands of Time"), missing texts, and a backslash
--     before an apostrophe;
--   - the names of 56147 and 71953;
--   - flags, prices, item levels, race masks and stat allocations;
--   - the two price floats, which the client's files hold to four decimals.
-- The sniff's description "0" for 69108 is left out: no client text is "0".
--
-- Each item gets an Item-sparse row in `hotfix_data`, so a client that
-- cached the old record asks for it again.
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
    SET @cOldContent = '001';

    SET @cNewVersion = '22';
    SET @cNewStructure = '11';
    SET @cNewContent = '002';
    SET @cNewDescription = 'Sniffed_Item_Values';
    SET @cNewComment = '164 server-only items take the values of the retail 15595 sniffs';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        UPDATE `item_sparse` SET `Unknown` = 1.036, `Unknown1` = 1, `ItemLevel` = 1 WHERE `entry` = 8164;
        UPDATE `item_sparse` SET `Unknown` = 0.9512, `Unknown1` = 1, `ItemLevel` = 1 WHERE `entry` = 9311;
        UPDATE `item_sparse` SET `Unknown` = 0.9957, `Unknown1` = 1 WHERE `entry` = 9489;
        UPDATE `item_sparse` SET `Unknown` = 0.9959, `Unknown1` = 1 WHERE `entry` = 13065;
        UPDATE `item_sparse` SET `Unknown` = 1.0149, `Unknown1` = 1 WHERE `entry` = 14100;
        UPDATE `item_sparse` SET `Unknown` = 1.0296, `Unknown1` = 1 WHERE `entry` = 14104;
        UPDATE `item_sparse` SET `Unknown` = 0.9778, `Unknown1` = 1, `stat_unk1_1` = 8696, `stat_unk1_2` = 34783 WHERE `entry` = 15054;
        UPDATE `item_sparse` SET `Unknown` = 0.9556, `Unknown1` = 1 WHERE `entry` = 15068;
        UPDATE `item_sparse` SET `Unknown` = 0.9593, `Unknown1` = 1 WHERE `entry` = 15069;
        UPDATE `item_sparse` SET `Unknown` = 0.963, `Unknown1` = 1 WHERE `entry` = 15070;
        UPDATE `item_sparse` SET `Unknown` = 0.9667, `Unknown1` = 1 WHERE `entry` = 15071;
        UPDATE `item_sparse` SET `Unknown` = 0.9703, `Unknown1` = 1 WHERE `entry` = 15072;
        UPDATE `item_sparse` SET `Unknown` = 0.9814, `Unknown1` = 1 WHERE `entry` = 15075;
        UPDATE `item_sparse` SET `Unknown` = 0.9635, `Unknown1` = 1, `ItemLevel` = 1 WHERE `entry` = 18154;
        UPDATE `item_sparse` SET `Unknown` = 1.0234, `Unknown1` = 1, `ItemLevel` = 1 WHERE `entry` = 22058;
        UPDATE `item_sparse` SET `Unknown` = 0.9641, `Unknown1` = 1 WHERE `entry` = 24269;
        UPDATE `item_sparse` SET `name` = 'Fatcandle Bag' WHERE `entry` = 56147;
        UPDATE `item_sparse` SET `Unknown` = 1.0395 WHERE `entry` = 56836;
        UPDATE `item_sparse` SET `Unknown` = 1.0478, `Unknown1` = 1, `description` = '' WHERE `entry` = 66170;
        UPDATE `item_sparse` SET `Unknown` = 1.0144, `Unknown1` = 1 WHERE `entry` = 66540;
        UPDATE `item_sparse` SET `Unknown` = 0.9517, `Unknown1` = 1 WHERE `entry` = 68032;
        UPDATE `item_sparse` SET `Unknown` = 0.9816 WHERE `entry` = 68638;
        UPDATE `item_sparse` SET `Flags2` = 2, `Unknown` = 1.0037 WHERE `entry` = 68644;
        UPDATE `item_sparse` SET `Unknown` = 1.0073 WHERE `entry` = 68645;
        UPDATE `item_sparse` SET `Unknown` = 1.011 WHERE `entry` = 68646;
        UPDATE `item_sparse` SET `Unknown` = 1.0412, `Unknown1` = 1 WHERE `entry` = 68647;
        UPDATE `item_sparse` SET `Unknown` = 1.0449, `Unknown1` = 1 WHERE `entry` = 68648;
        UPDATE `item_sparse` SET `Unknown` = 0.9962 WHERE `entry` = 68662;
        UPDATE `item_sparse` SET `Unknown` = 1.0264 WHERE `entry` = 68663;
        UPDATE `item_sparse` SET `Unknown` = 1.0447 WHERE `entry` = 68668;
        UPDATE `item_sparse` SET `Unknown` = 1.0408, `Unknown1` = 1 WHERE `entry` = 68820;
        UPDATE `item_sparse` SET `Unknown` = 1.0296, `Unknown1` = 1 WHERE `entry` = 68837;
        UPDATE `item_sparse` SET `Unknown` = 1.03 WHERE `entry` = 68890;
        UPDATE `item_sparse` SET `Unknown` = 0.9819, `Unknown1` = 1 WHERE `entry` = 68937;
        UPDATE `item_sparse` SET `Unknown` = 0.9815, `Unknown1` = 1 WHERE `entry` = 68997;
        UPDATE `item_sparse` SET `Unknown` = 0.9741, `Unknown1` = 1 WHERE `entry` = 69108;
        UPDATE `item_sparse` SET `Unknown` = 1.0412, `Unknown1` = 1 WHERE `entry` = 69212;
        UPDATE `item_sparse` SET `Unknown` = 1.0485, `Unknown1` = 1 WHERE `entry` = 69214;
        UPDATE `item_sparse` SET `Unknown` = 0.9558, `Unknown1` = 1, `stat_unk1_1` = 6667, `stat_unk1_2` = 6666 WHERE `entry` = 69216;
        UPDATE `item_sparse` SET `Unknown` = 0.9595, `Unknown1` = 1, `stat_unk1_1` = 10000 WHERE `entry` = 69217;
        UPDATE `item_sparse` SET `Unknown` = 0.9631, `Unknown1` = 1, `stat_unk1_1` = 10000 WHERE `entry` = 69218;
        UPDATE `item_sparse` SET `Unknown` = 0.9668, `Unknown1` = 1 WHERE `entry` = 69219;
        UPDATE `item_sparse` SET `Unknown` = 0.9705, `Unknown1` = 1 WHERE `entry` = 69220;
        UPDATE `item_sparse` SET `Unknown` = 0.9741, `Unknown1` = 1, `stat_unk1_1` = 6666, `stat_unk1_2` = 6667 WHERE `entry` = 69221;
        UPDATE `item_sparse` SET `Unknown` = 0.9778, `Unknown1` = 1 WHERE `entry` = 69222;
        UPDATE `item_sparse` SET `Unknown` = 0.9815, `Unknown1` = 1 WHERE `entry` = 69223;
        UPDATE `item_sparse` SET `Unknown` = 1.0374 WHERE `entry` = 69231;
        UPDATE `item_sparse` SET `Unknown` = 0.9556, `Unknown1` = 1 WHERE `entry` = 69236;
        UPDATE `item_sparse` SET `Unknown` = 1.0041, `Unknown1` = 1 WHERE `entry` = 69262;
        UPDATE `item_sparse` SET `Unknown` = 1.0114 WHERE `entry` = 69264;
        UPDATE `item_sparse` SET `Unknown` = 0.956, `Unknown1` = 1 WHERE `entry` = 69628;
        UPDATE `item_sparse` SET `Unknown` = 1.045, `Unknown1` = 1 WHERE `entry` = 69645;
        UPDATE `item_sparse` SET `Unknown` = 0.9815, `Unknown1` = 1 WHERE `entry` = 69675;
        UPDATE `item_sparse` SET `Unknown` = 1.0153, `Unknown1` = 1 WHERE `entry` = 69677;
        UPDATE `item_sparse` SET `Unknown` = 1.019, `Unknown1` = 1 WHERE `entry` = 69678;
        UPDATE `item_sparse` SET `Unknown` = 1.0227, `Unknown1` = 1 WHERE `entry` = 69679;
        UPDATE `item_sparse` SET `Unknown` = 1.0334, `Unknown1` = 1 WHERE `entry` = 69722;
        UPDATE `item_sparse` SET `Unknown` = 0.9709, `Unknown1` = 1 WHERE `entry` = 69725;
        UPDATE `item_sparse` SET `Unknown` = 1.0487, `Unknown1` = 1 WHERE `entry` = 69759;
        UPDATE `item_sparse` SET `Unknown` = 0.9706, `Unknown1` = 1 WHERE `entry` = 69765;
        UPDATE `item_sparse` SET `Unknown` = 1.0302, `Unknown1` = 1 WHERE `entry` = 69774;
        UPDATE `item_sparse` SET `Unknown` = 1.0005, `Unknown1` = 1 WHERE `entry` = 69806;
        UPDATE `item_sparse` SET `Unknown` = 1.0042, `Unknown1` = 1 WHERE `entry` = 69807;
        UPDATE `item_sparse` SET `Unknown` = 1.0079, `Unknown1` = 1, `description` = 'Poison is bad enough when it''s NOT boiling hot.' WHERE `entry` = 69808;
        UPDATE `item_sparse` SET `Unknown` = 1.0115, `Unknown1` = 1 WHERE `entry` = 69809;
        UPDATE `item_sparse` SET `Unknown` = 1.0152, `Unknown1` = 1 WHERE `entry` = 69810;
        UPDATE `item_sparse` SET `Unknown` = 1.0189, `Unknown1` = 1 WHERE `entry` = 69811;
        UPDATE `item_sparse` SET `Unknown` = 1.0226, `Unknown1` = 1 WHERE `entry` = 69812;
        UPDATE `item_sparse` SET `Unknown` = 1.0262, `Unknown1` = 1 WHERE `entry` = 69813;
        UPDATE `item_sparse` SET `Unknown` = 1.0372, `Unknown1` = 1 WHERE `entry` = 69816;
        UPDATE `item_sparse` SET `Unknown` = 1.0483, `Unknown1` = 1 WHERE `entry` = 69819;
        UPDATE `item_sparse` SET `Unknown` = 0.9967 WHERE `entry` = 69825;
        UPDATE `item_sparse` SET `Unknown` = 1.0224, `Unknown1` = 1 WHERE `entry` = 69832;
        UPDATE `item_sparse` SET `Unknown` = 0.956, `Unknown1` = 1 WHERE `entry` = 69854;
        UPDATE `item_sparse` SET `Unknown` = 0.9597, `Unknown1` = 1 WHERE `entry` = 69855;
        UPDATE `item_sparse` SET `Unknown` = 0.9781, `Unknown1` = 1 WHERE `entry` = 69860;
        UPDATE `item_sparse` SET `Unknown` = 0.9705 WHERE `entry` = 69898;
        UPDATE `item_sparse` SET `Unknown` = 0.9778, `Unknown1` = 1 WHERE `entry` = 69900;
        UPDATE `item_sparse` SET `Unknown` = 1.019 WHERE `entry` = 69904;
        UPDATE `item_sparse` SET `Unknown` = 1.0264 WHERE `entry` = 69906;
        UPDATE `item_sparse` SET `Unknown` = 1.0484 WHERE `entry` = 69912;
        UPDATE `item_sparse` SET `Unknown` = 0.952 WHERE `entry` = 69913;
        UPDATE `item_sparse` SET `Unknown` = 0.9593 WHERE `entry` = 69915;
        UPDATE `item_sparse` SET `Unknown` = 1.0446, `Unknown1` = 1 WHERE `entry` = 69931;
        UPDATE `item_sparse` SET `Unknown` = 1.0483 WHERE `entry` = 69932;
        UPDATE `item_sparse` SET `Unknown` = 0.9783 WHERE `entry` = 69933;
        UPDATE `item_sparse` SET `Unknown` = 1.0041, `description` = 'A pile of ''fresh'' fish guts guaranteed to attract crayfish.' WHERE `entry` = 69940;
        UPDATE `item_sparse` SET `Unknown` = 0.9964 WHERE `entry` = 69978;
        UPDATE `item_sparse` SET `Unknown` = 1.0001 WHERE `entry` = 69979;
        UPDATE `item_sparse` SET `Unknown` = 1.0038 WHERE `entry` = 69980;
        UPDATE `item_sparse` SET `Unknown` = 1.034 WHERE `entry` = 69981;
        UPDATE `item_sparse` SET `Unknown` = 1.0376 WHERE `entry` = 69982;
        UPDATE `item_sparse` SET `Unknown` = 1.045 WHERE `entry` = 69984;
        UPDATE `item_sparse` SET `Unknown` = 1.0487 WHERE `entry` = 69985;
        UPDATE `item_sparse` SET `Unknown` = 0.9522 WHERE `entry` = 69986;
        UPDATE `item_sparse` SET `Unknown` = 0.9559 WHERE `entry` = 69987;
        UPDATE `item_sparse` SET `Unknown` = 0.9741, `Unknown1` = 1 WHERE `entry` = 70125;
        UPDATE `item_sparse` SET `Unknown` = 1.0227 WHERE `entry` = 71035;
        UPDATE `item_sparse` SET `Unknown` = 1.03, `Unknown1` = 1 WHERE `entry` = 71037;
        UPDATE `item_sparse` SET `Unknown` = 1.0299 WHERE `entry` = 71057;
        UPDATE `item_sparse` SET `Flags2` = 4194816, `Unknown` = 0.9819, `Unknown1` = 1, `BuyPrice` = 2215861, `SellPrice` = 443172 WHERE `entry` = 71084;
        UPDATE `item_sparse` SET `Flags2` = 4194816, `Unknown` = 0.9855, `Unknown1` = 1 WHERE `entry` = 71085;
        UPDATE `item_sparse` SET `Flags` = 192, `Flags2` = 6291968, `Unknown` = 0.9892, `Unknown1` = 1, `BuyPrice` = 3511821, `SellPrice` = 702364 WHERE `entry` = 71086;
        UPDATE `item_sparse` SET `Unknown` = 1, `Unknown1` = 1 WHERE `entry` = 71267;
        UPDATE `item_sparse` SET `Unknown` = 1, `Unknown1` = 1 WHERE `entry` = 71268;
        UPDATE `item_sparse` SET `Unknown` = 1, `Unknown1` = 1 WHERE `entry` = 71269;
        UPDATE `item_sparse` SET `Unknown` = 1, `Unknown1` = 1 WHERE `entry` = 71270;
        UPDATE `item_sparse` SET `Unknown` = 1.0004, `description` = 'Allows you to find Darkmoon Artifacts in appropriately-challenging dungeons, raids, and battlegrounds.' WHERE `entry` = 71634;
        UPDATE `item_sparse` SET `Unknown` = 1.004, `description` = 'Strange threads of power swirl within this rare crystal. Someone at the Darkmoon Faire would probably be interested in acquiring it.' WHERE `entry` = 71635;
        UPDATE `item_sparse` SET `Unknown` = 1.0077, `description` = 'Who knows what creature lurks inside this egg? It would make a great addition to the Darkmoon Faire''s collection of rare and amazing creatures.' WHERE `entry` = 71636;
        UPDATE `item_sparse` SET `Unknown` = 1.0379, `description` = 'The pages of this ancient book are written in a language you don''t recognize. Someone at the Darkmoon Faire would probably be interested in acquiring it.' WHERE `entry` = 71637;
        UPDATE `item_sparse` SET `Unknown` = 1.0416, `description` = 'This weapon seems as beautiful as it is deadly. Someone at the Darkmoon Faire would probably be interested in acquiring it.' WHERE `entry` = 71638;
        UPDATE `item_sparse` SET `Unknown` = 1.03, `description` = 'Anduin Lothar''s ultimate compendium of battle strategy. This tome would be of interest to someone at the Darkmoon Faire.' WHERE `entry` = 71715;
        UPDATE `item_sparse` SET `Unknown` = 1.0337, `description` = 'An old set of carved fortune-telling runes. Professor Thaddeus Paleo, of the Darkmoon Faire, would be most interested in these.' WHERE `entry` = 71716;
        UPDATE `item_sparse` SET `Unknown` = 0.9931, `Unknown1` = 1, `description` = 'Proof of your valor in combat. Someone at the Darkmoon Faire would be interested in this item.' WHERE `entry` = 71951;
        UPDATE `item_sparse` SET `Unknown` = 0.9968, `description` = 'Claimed from a defeated opponent. Someone at the Darkmoon Faire would be interested in this item.' WHERE `entry` = 71952;
        UPDATE `item_sparse` SET `Unknown` = 1.0005, `name` = 'Fallen Adventurer''s Journal', `description` = 'A journal containing stories of a fallen enemy''s epic exploits. Someone at the Darkmoon Faire would be interested in seeing this.' WHERE `entry` = 71953;
        UPDATE `item_sparse` SET `Unknown` = 0.9673 WHERE `entry` = 71964;
        UPDATE `item_sparse` SET `Unknown` = 0.9783 WHERE `entry` = 71967;
        UPDATE `item_sparse` SET `Unknown` = 0.982 WHERE `entry` = 71968;
        UPDATE `item_sparse` SET `Unknown` = 1.0452 WHERE `entry` = 71978;
        UPDATE `item_sparse` SET `Unknown` = 1.0153 WHERE `entry` = 72050;
        UPDATE `item_sparse` SET `Unknown` = 1.0227 WHERE `entry` = 72052;
        UPDATE `item_sparse` SET `Unknown` = 0.9638 WHERE `entry` = 72056;
        UPDATE `item_sparse` SET `Unknown` = 0.9674 WHERE `entry` = 72057;
        UPDATE `item_sparse` SET `Unknown` = 0.9711, `description` = 'A Darkmoon Faire-goer''s favorite.' WHERE `entry` = 72058;
        UPDATE `item_sparse` SET `Flags2` = 786432, `Unknown` = 1.0078, `Unknown1` = 1 WHERE `entry` = 72068;
        UPDATE `item_sparse` SET `Unknown` = 0.9707, `Unknown1` = 1, `description` = 'Far larger than any claw you''ve ever seen.' WHERE `entry` = 72118;
        UPDATE `item_sparse` SET `Unknown` = 1.0009, `Unknown1` = 1 WHERE `entry` = 72119;
        UPDATE `item_sparse` SET `Unknown` = 1.0266, `Unknown1` = 1 WHERE `entry` = 72126;
        UPDATE `item_sparse` SET `Unknown` = 1.0303, `Unknown1` = 1, `description` = 'Much lighter than you''d expect.' WHERE `entry` = 72127;
        UPDATE `item_sparse` SET `Unknown` = 1.0043, `Unknown1` = 1 WHERE `entry` = 72160;
        UPDATE `item_sparse` SET `Unknown` = 1.0081, `Unknown1` = 1 WHERE `entry` = 72480;
        UPDATE `item_sparse` SET `Unknown` = 1.0119, `Unknown1` = 1 WHERE `entry` = 72574;
        UPDATE `item_sparse` SET `Unknown` = 1.0228, `Unknown1` = 1 WHERE `entry` = 72597;
        UPDATE `item_sparse` SET `Unknown` = 0.9708, `Unknown1` = 1 WHERE `entry` = 72663;
        UPDATE `item_sparse` SET `Unknown` = 1.0081, `Unknown1` = 1 WHERE `entry` = 72706;
        UPDATE `item_sparse` SET `Unknown` = 1.0376, `Unknown1` = 1, `description` = '' WHERE `entry` = 72807;
        UPDATE `item_sparse` SET `Unknown` = 1.0307, `Unknown1` = 1, `description` = 'There''s no doubting the raw power contained in this sphere.' WHERE `entry` = 73084;
        UPDATE `item_sparse` SET `Unknown` = 1.0417, `Unknown1` = 1 WHERE `entry` = 73200;
        UPDATE `item_sparse` SET `Unknown` = 1.0007 WHERE `entry` = 73269;
        UPDATE `item_sparse` SET `Unknown` = 0.9677, `Unknown1` = 1 WHERE `entry` = 74616;
        UPDATE `item_sparse` SET `Unknown` = 1.0161, `Unknown1` = 1 WHERE `entry` = 74755;
        UPDATE `item_sparse` SET `Unknown` = 0.9972, `Unknown1` = 1, `description` = 'Holding this shard in your hands makes you remember every moment you''ve ever been sad.' WHERE `entry` = 74830;
        UPDATE `item_sparse` SET `Unknown` = 0.9603, `Unknown1` = 1, `AllowableRace` = 2147483647, `description` = '' WHERE `entry` = 77213;
        UPDATE `item_sparse` SET `Unknown` = 1.0424, `Unknown1` = 1 WHERE `entry` = 77939;
        UPDATE `item_sparse` SET `Unknown` = 1.0461, `Unknown1` = 1, `description` = 'A small fragment of the Echo of Jaina Proudmoore.' WHERE `entry` = 77940;
        UPDATE `item_sparse` SET `Unknown` = 1.0498, `Unknown1` = 1, `description` = 'A small fragment of the Echo of Baine Bloodhoof.' WHERE `entry` = 77941;
        UPDATE `item_sparse` SET `Unknown` = 0.9533, `Unknown1` = 1 WHERE `entry` = 77942;
        UPDATE `item_sparse` SET `Unknown` = 0.9644, `description` = '' WHERE `entry` = 77945;
        UPDATE `item_sparse` SET `Unknown` = 0.968, `description` = '' WHERE `entry` = 77946;
        UPDATE `item_sparse` SET `Unknown` = 0.9644 WHERE `entry` = 77947;
        UPDATE `item_sparse` SET `Unknown` = 0.968 WHERE `entry` = 77948;
        UPDATE `item_sparse` SET `Unknown` = 1.0276, `Unknown1` = 1, `description` = 'The vessel does not have any buttons, hinges, levers, or other visible controls.' WHERE `entry` = 77955;
        UPDATE `item_sparse` SET `Unknown` = 1.0195, `Unknown1` = 1 WHERE `entry` = 78294;
        UPDATE `item_sparse` SET `Unknown` = 1.0268, `Unknown1` = 1 WHERE `entry` = 78295;
        UPDATE `item_sparse` SET `Unknown` = 1.0121, `Unknown1` = 1 WHERE `entry` = 78296;
        UPDATE `item_sparse` SET `Unknown` = 1.0231, `Unknown1` = 1 WHERE `entry` = 78297;
        UPDATE `item_sparse` SET `Unknown` = 1.0158, `Unknown1` = 1 WHERE `entry` = 78298;
        UPDATE `item_sparse` SET `Unknown` = 0.9606, `Unknown1` = 1 WHERE `entry` = 78299;
        UPDATE `item_sparse` SET `Unknown` = 0.9642, `Unknown1` = 1 WHERE `entry` = 78300;
        UPDATE `item_sparse` SET `Unknown` = 0.9569, `Unknown1` = 1 WHERE `entry` = 78301;
        UPDATE `item_sparse` SET `Unknown` = 0.9603, `Unknown1` = 1, `AllowableRace` = 2147483647, `description` = '' WHERE `entry` = 78369;
        UPDATE `item_sparse` SET `Unknown` = 0.9603, `Unknown1` = 1, `AllowableRace` = 2147483647, `description` = '' WHERE `entry` = 78374;

        INSERT IGNORE INTO `hotfix_data` (`entry`, `type`, `hotfixDate`) VALUES
            (8164,2442913102,'2026-11-03 00:00:00'),(9311,2442913102,'2026-11-03 00:00:00'),(9489,2442913102,'2026-11-03 00:00:00'),(13065,2442913102,'2026-11-03 00:00:00'),
            (14100,2442913102,'2026-11-03 00:00:00'),(14104,2442913102,'2026-11-03 00:00:00'),(15054,2442913102,'2026-11-03 00:00:00'),(15068,2442913102,'2026-11-03 00:00:00'),
            (15069,2442913102,'2026-11-03 00:00:00'),(15070,2442913102,'2026-11-03 00:00:00'),(15071,2442913102,'2026-11-03 00:00:00'),(15072,2442913102,'2026-11-03 00:00:00'),
            (15075,2442913102,'2026-11-03 00:00:00'),(18154,2442913102,'2026-11-03 00:00:00'),(22058,2442913102,'2026-11-03 00:00:00'),(24269,2442913102,'2026-11-03 00:00:00'),
            (56147,2442913102,'2026-11-03 00:00:00'),(56836,2442913102,'2026-11-03 00:00:00'),(66170,2442913102,'2026-11-03 00:00:00'),(66540,2442913102,'2026-11-03 00:00:00'),
            (68032,2442913102,'2026-11-03 00:00:00'),(68638,2442913102,'2026-11-03 00:00:00'),(68644,2442913102,'2026-11-03 00:00:00'),(68645,2442913102,'2026-11-03 00:00:00'),
            (68646,2442913102,'2026-11-03 00:00:00'),(68647,2442913102,'2026-11-03 00:00:00'),(68648,2442913102,'2026-11-03 00:00:00'),(68662,2442913102,'2026-11-03 00:00:00'),
            (68663,2442913102,'2026-11-03 00:00:00'),(68668,2442913102,'2026-11-03 00:00:00'),(68820,2442913102,'2026-11-03 00:00:00'),(68837,2442913102,'2026-11-03 00:00:00'),
            (68890,2442913102,'2026-11-03 00:00:00'),(68937,2442913102,'2026-11-03 00:00:00'),(68997,2442913102,'2026-11-03 00:00:00'),(69108,2442913102,'2026-11-03 00:00:00'),
            (69212,2442913102,'2026-11-03 00:00:00'),(69214,2442913102,'2026-11-03 00:00:00'),(69216,2442913102,'2026-11-03 00:00:00'),(69217,2442913102,'2026-11-03 00:00:00'),
            (69218,2442913102,'2026-11-03 00:00:00'),(69219,2442913102,'2026-11-03 00:00:00'),(69220,2442913102,'2026-11-03 00:00:00'),(69221,2442913102,'2026-11-03 00:00:00'),
            (69222,2442913102,'2026-11-03 00:00:00'),(69223,2442913102,'2026-11-03 00:00:00'),(69231,2442913102,'2026-11-03 00:00:00'),(69236,2442913102,'2026-11-03 00:00:00'),
            (69262,2442913102,'2026-11-03 00:00:00'),(69264,2442913102,'2026-11-03 00:00:00'),(69628,2442913102,'2026-11-03 00:00:00'),(69645,2442913102,'2026-11-03 00:00:00'),
            (69675,2442913102,'2026-11-03 00:00:00'),(69677,2442913102,'2026-11-03 00:00:00'),(69678,2442913102,'2026-11-03 00:00:00'),(69679,2442913102,'2026-11-03 00:00:00'),
            (69722,2442913102,'2026-11-03 00:00:00'),(69725,2442913102,'2026-11-03 00:00:00'),(69759,2442913102,'2026-11-03 00:00:00'),(69765,2442913102,'2026-11-03 00:00:00'),
            (69774,2442913102,'2026-11-03 00:00:00'),(69806,2442913102,'2026-11-03 00:00:00'),(69807,2442913102,'2026-11-03 00:00:00'),(69808,2442913102,'2026-11-03 00:00:00'),
            (69809,2442913102,'2026-11-03 00:00:00'),(69810,2442913102,'2026-11-03 00:00:00'),(69811,2442913102,'2026-11-03 00:00:00'),(69812,2442913102,'2026-11-03 00:00:00'),
            (69813,2442913102,'2026-11-03 00:00:00'),(69816,2442913102,'2026-11-03 00:00:00'),(69819,2442913102,'2026-11-03 00:00:00'),(69825,2442913102,'2026-11-03 00:00:00'),
            (69832,2442913102,'2026-11-03 00:00:00'),(69854,2442913102,'2026-11-03 00:00:00'),(69855,2442913102,'2026-11-03 00:00:00'),(69860,2442913102,'2026-11-03 00:00:00'),
            (69898,2442913102,'2026-11-03 00:00:00'),(69900,2442913102,'2026-11-03 00:00:00'),(69904,2442913102,'2026-11-03 00:00:00'),(69906,2442913102,'2026-11-03 00:00:00'),
            (69912,2442913102,'2026-11-03 00:00:00'),(69913,2442913102,'2026-11-03 00:00:00'),(69915,2442913102,'2026-11-03 00:00:00'),(69931,2442913102,'2026-11-03 00:00:00'),
            (69932,2442913102,'2026-11-03 00:00:00'),(69933,2442913102,'2026-11-03 00:00:00'),(69940,2442913102,'2026-11-03 00:00:00'),(69978,2442913102,'2026-11-03 00:00:00'),
            (69979,2442913102,'2026-11-03 00:00:00'),(69980,2442913102,'2026-11-03 00:00:00'),(69981,2442913102,'2026-11-03 00:00:00'),(69982,2442913102,'2026-11-03 00:00:00'),
            (69984,2442913102,'2026-11-03 00:00:00'),(69985,2442913102,'2026-11-03 00:00:00'),(69986,2442913102,'2026-11-03 00:00:00'),(69987,2442913102,'2026-11-03 00:00:00'),
            (70125,2442913102,'2026-11-03 00:00:00'),(71035,2442913102,'2026-11-03 00:00:00'),(71037,2442913102,'2026-11-03 00:00:00'),(71057,2442913102,'2026-11-03 00:00:00'),
            (71084,2442913102,'2026-11-03 00:00:00'),(71085,2442913102,'2026-11-03 00:00:00'),(71086,2442913102,'2026-11-03 00:00:00'),(71267,2442913102,'2026-11-03 00:00:00'),
            (71268,2442913102,'2026-11-03 00:00:00'),(71269,2442913102,'2026-11-03 00:00:00'),(71270,2442913102,'2026-11-03 00:00:00'),(71634,2442913102,'2026-11-03 00:00:00'),
            (71635,2442913102,'2026-11-03 00:00:00'),(71636,2442913102,'2026-11-03 00:00:00'),(71637,2442913102,'2026-11-03 00:00:00'),(71638,2442913102,'2026-11-03 00:00:00'),
            (71715,2442913102,'2026-11-03 00:00:00'),(71716,2442913102,'2026-11-03 00:00:00'),(71951,2442913102,'2026-11-03 00:00:00'),(71952,2442913102,'2026-11-03 00:00:00'),
            (71953,2442913102,'2026-11-03 00:00:00'),(71964,2442913102,'2026-11-03 00:00:00'),(71967,2442913102,'2026-11-03 00:00:00'),(71968,2442913102,'2026-11-03 00:00:00'),
            (71978,2442913102,'2026-11-03 00:00:00'),(72050,2442913102,'2026-11-03 00:00:00'),(72052,2442913102,'2026-11-03 00:00:00'),(72056,2442913102,'2026-11-03 00:00:00'),
            (72057,2442913102,'2026-11-03 00:00:00'),(72058,2442913102,'2026-11-03 00:00:00'),(72068,2442913102,'2026-11-03 00:00:00'),(72118,2442913102,'2026-11-03 00:00:00'),
            (72119,2442913102,'2026-11-03 00:00:00'),(72126,2442913102,'2026-11-03 00:00:00'),(72127,2442913102,'2026-11-03 00:00:00'),(72160,2442913102,'2026-11-03 00:00:00'),
            (72480,2442913102,'2026-11-03 00:00:00'),(72574,2442913102,'2026-11-03 00:00:00'),(72597,2442913102,'2026-11-03 00:00:00'),(72663,2442913102,'2026-11-03 00:00:00'),
            (72706,2442913102,'2026-11-03 00:00:00'),(72807,2442913102,'2026-11-03 00:00:00'),(73084,2442913102,'2026-11-03 00:00:00'),(73200,2442913102,'2026-11-03 00:00:00'),
            (73269,2442913102,'2026-11-03 00:00:00'),(74616,2442913102,'2026-11-03 00:00:00'),(74755,2442913102,'2026-11-03 00:00:00'),(74830,2442913102,'2026-11-03 00:00:00'),
            (77213,2442913102,'2026-11-03 00:00:00'),(77939,2442913102,'2026-11-03 00:00:00'),(77940,2442913102,'2026-11-03 00:00:00'),(77941,2442913102,'2026-11-03 00:00:00'),
            (77942,2442913102,'2026-11-03 00:00:00'),(77945,2442913102,'2026-11-03 00:00:00'),(77946,2442913102,'2026-11-03 00:00:00'),(77947,2442913102,'2026-11-03 00:00:00'),
            (77948,2442913102,'2026-11-03 00:00:00'),(77955,2442913102,'2026-11-03 00:00:00'),(78294,2442913102,'2026-11-03 00:00:00'),(78295,2442913102,'2026-11-03 00:00:00'),
            (78296,2442913102,'2026-11-03 00:00:00'),(78297,2442913102,'2026-11-03 00:00:00'),(78298,2442913102,'2026-11-03 00:00:00'),(78299,2442913102,'2026-11-03 00:00:00'),
            (78300,2442913102,'2026-11-03 00:00:00'),(78301,2442913102,'2026-11-03 00:00:00'),(78369,2442913102,'2026-11-03 00:00:00'),(78374,2442913102,'2026-11-03 00:00:00');

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
