-- ----------------------------------------------------------------
-- Page texts and points of interest take the values of retail sniffs.
--
-- Pages sniffed on build 15595 (the Cataclysm Preservation Project's world
-- database) take the sniffed text and next page; pages no 15595 sniff covers
-- take the text of the newest retail page cache (builds 13623 and 14480)
-- where it differs from ours by more than line endings. Points of interest
-- whose sniffed id and name are ours take the sniffed position.
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
    SET @cOldContent = '010';

    SET @cNewVersion = '22';
    SET @cNewStructure = '11';
    SET @cNewContent = '011';
    SET @cNewDescription = 'Page_And_Poi_Values';
    SET @cNewComment = 'Page texts and points of interest take the values of retail 15595 sniffs and caches';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        UPDATE `page_text` SET `text` = 'Day 1\r\n\r\nMy tank is broken, but I know the chiron ore is in these hills somewhere.  I told Hammerfoot to stay and watch our tanks.\r\n\r\nI''m continuing the search alone.  If I don''t make it back, then this journal is my last testament.\r\n\r\n--Buron Hildelve, Pilot\r\nIronforge Steam Brigade' WHERE `entry` = 229;
        UPDATE `page_text` SET `text` = 'Day 2\r\n\r\nMy search continues, and no ore.  I''m wondering if Stonegear was just making up the rumor of that ore as a joke.  Well if he did then he''s getting a cracked skull when I get back to Steelgrill''s Depot!\r\n\r\nTonight as I prepared my camp, I heard a growl echoing through the canyons.  \r\n\r\nIt isn''t a wolf.  It may be a bear.' WHERE `entry` = 230;
        UPDATE `page_text` SET `text` = 'Day 3\r\n\r\nThat growling continued throughout the night, and followed me all today, distracting me from my hunt for ore.  I think there''s a bear following me!\r\n\r\nI hope he comes close.  I''ll bury my pick into his head!' WHERE `entry` = 231;
        UPDATE `page_text` SET `text` = 'Day 4\r\n\r\nMy supplies are running low.  I still have plenty of food, but I didn''t plan for such a long stay in the wilds outside my tank and I only brought two kegs of ale with me.\r\n\r\nI''ve been up all night the past two nights, listening to that cursed growling, and I''ve nearly drained my kegs dry!\r\n\r\nI''ll have to head back to Hammerfoot and our Steam Tanks tomorrow.  I don''t want to get lost out here, booze-less.' WHERE `entry` = 232;
        UPDATE `page_text` SET `text` = 'Day 5\r\n\r\nThe cursed bear did me in!  It attacked me at midday, roaring and charging at me from behind.\r\n\r\nI would have smelled it coming had it charged from upwind - its stench was something awful!  The reek of its mangy coat and rotted breath alone nearly sent me spinning!\r\n\r\nI fought the thing off but it chewed my leg up good.  Now I can''t move, my ale''s gone, and I never did find that ore.  Curses!' WHERE `entry` = 233;
        UPDATE `page_text` SET `text` = 'Day 6\r\n\r\nThe bear hasn''t yet returned - I must have given him a good beating!  But I can still hear his growling.  I think he''s waiting for me to die!\r\n\r\nTo whomever finds this book, I have a task for you.  Kill that mangy bear.  Kill it, and take this book back to my friend Hammerfoot.  He''ll want to know what happened.\r\n\r\nAnd take my armor.  You''ll need it against old Mangeclaw!' WHERE `entry` = 234;
        UPDATE `page_text` SET `text` = 'Here lies Uther the Lightbringer\nFirst Paladin - Founder of the Order of the Silver Hand\n\nUther lived and died to defend the kingdom of Lordaeron. Though he was betrayed by his most beloved student, we believe that his spirit lives on. He continues to watch over us, even as the shadows close in around our ruined land. His light is the light of all humanity - and so long as we honor his example, it shall never fade. \n									- Anonymous' WHERE `entry` = 292;
        UPDATE `page_text` SET `text` = 'The Mallet of Zul''Farrak\r\n\r\nTo create the Mallet of Zul''Farrak, one must first travel to the Altar of Zul and obtain the sacred mallet from a troll Keeper.\r\n\r\nNext, one must bring the sacred mallet to the altar atop of the troll city of Jintha''alor.\r\n\r\nUsing the sacred mallet at the altar will infuse it with power, and transform it into the Mallet of Zul''Farrak.\r\n' WHERE `entry` = 1091;
        UPDATE `page_text` SET `text` = 'This anvil is the property of Jordan Stilwell - Please do NOT use!\r\n\r\n- Jordan' WHERE `entry` = 1591;
        UPDATE `page_text` SET `text` = 'The remains of the gargantuan red dragon were found in the Wetlands shortly after the Battle of Grim Batol. Tyrannistrasz was rumored to have been the elder consort of the Dragonqueen, Alexstrasza.' WHERE `entry` = 1751;
        UPDATE `page_text` SET `text` = 'The orcs'' failure to conquer the world for the Burning Legion forced Kil''jaeden to create a new army to sow chaos throughout the kingdoms of Azeroth. This new army could not be allowed to fall prey to the same petty rivalries and infighting that had plagued the Horde. It would have to be merciless and single-minded in its mission. This time, Kil''jaeden could not afford to fail. ' WHERE `entry` = 2004;
        UPDATE `page_text` SET `text` = 'Stranglethorn Fishing Tournament!\r\nSunday Afternoon - 2pm to 4pm.\r\n\r\nFish anywhere along the coast of Stranglethorn (except for Booty Bay) and look for the schools of Tastyfish that will appear along the coast!  Make sure your fishing bobber lands in the school and you will be catching special fish instead of the normal Stranglethorn variety.  The first person to catch forty Tastyfish can turn them into Fishmaster Bassbait in Booty Bay for a prize!   \r\n\r\nEven if you are not the first person to catch forty tastyfish you can still turn them in for cash and there are special fish to be caught as well that will reward special prizes!\r\n' WHERE `entry` = 2786;
        UPDATE `page_text` SET `text` = 'You have discovered the location of the shrine!  Upon further examination, you sense a stronger pulse of the strange power that has gripped the Isle.  You feel a bit uncomfortable standing by the shrine... and perhaps a little disturbed.\n\nThe bronze placard along the side of the shrine reads:\n\n"Here stands the Shrine of Dath''Remar, a fitting tribute to a noble elf.  Let all who gaze on this monument remember his sacrifices for our people and his dedication to the cause of our continued survival.  All who prosper in Quel''Thalas do so thanks to him."' WHERE `entry` = 2936;
        UPDATE `page_text` SET `text` = 'Lok''tar ogar! Victory or death - it is these words that bind me to the Horde. For they are the most sacred and fundamental of truths to any warrior of the Horde.\n\nI give my flesh and blood freely to the Warchief. I am the instrument of my Warchief''s desire. I am a weapon of my Warchief''s command.\n\nFrom this moment until the end of days I live and die - For the Horde!' WHERE `entry` = 3068;
        UPDATE `page_text` SET `text` = '$N,\n\nIf you are reading this letter then you are alive and in one piece - or at least you still have your eyes.\n\nI must apologize for the secrecy. Agmar demands that all mail is read before delivery - too many traitors and thieves there, as the wanted poster no doubt displays. There are delicate matters herein that could easily be misconstrued by the new guard.\n\nFor a soldier of the Horde, loss is absolute. Loss means death and there is no negotiation or interpretation with death. One can only hope that the manner of their death was honorable.' WHERE `entry` = 3069;
        UPDATE `page_text` SET `text` = 'In tribute to King Varian Wrynn \r\nknown to some as LO''GOSH the "Ghost Wolf"\r\n\r\nHis miraculous return from long years of exile and hardship has ignited a new fire of spirit and courage within the Alliance.\r\n\r\nWe shall march boldly into these perilous lands holding his valor and his tenacity in our hearts.\r\n\r\n\r\n- Highlord Bolvar Fordragon\r\n' WHERE `entry` = 3102;
        UPDATE `page_text` SET `text` = 'Long ago, when the North Wind ruled these peaks alone, a powerful taunka chieftain''s brother coveted these lands for himself.' WHERE `entry` = 3280;
        UPDATE `page_text` SET `text` = 'The chieftain''s brother, Stormhoof, gathered all his strength and set out to conquer the Storm Peaks from its rightful ruler, the North Wind.' WHERE `entry` = 3281;
        UPDATE `page_text` SET `text` = 'Stormhoof ambushed the North Wind in the heart of its domain, and nearly succeeded in his plot. But the North Wind survived Stormhoof''s treachery and executed the taunka as punishment for his invasion.' WHERE `entry` = 3282;
        UPDATE `page_text` SET `text` = 'BUR - An aggressively passionate mating call.\r\nWhat can I do fer ye? - Beer sold here.\r\nHi - A threatening war cry, especially when accompanied by a wave or bow.\r\nHow are you? - Was your mother really a reptile?\r\nKing''s Honor, friend! - I''m starving!' WHERE `entry` = 3498;
        UPDATE `page_text` SET `text` = '<HTML>\r\n<BODY>\r\n<P>Detailed herein are all of the locations used to secret our information within Loch Modan while awaiting pickup. Should you manage to obtain any documents from the Explorers'' League or their allies, place them in one of these locations and one of our messengers will pick the package up within the week for delivery to our base of operations.</P>\r\n<BR/>\r\n<P>Once you have memorized all of the locations within this book, burn it so that it cannot be obtained by our enemies. Should you suspect for any reason that our enemies might be suspicious of your activities, burn the book immediately. By no means should this ever fall into enemy hands, lest our routes of communication be compromised.</P>\r\n<BR/>\r\n<P>For Ragnaros!</P>\r\n</BODY>\r\n</HTML>\r\n' WHERE `entry` = 3550;
        UPDATE `page_text` SET `text` = '<HTML>\r\n<BODY>\r\n<H1 align="center">Location 1: Western Loch Dock</H1>\r\n<BR/>\r\n<P>Northeast of Thelsamar, there is a small dwelling and a dock that are utilized by dwarves on occasion during fishing season. Store the package in a watertight container under the dock, out of sight.</P>\r\n<BR/>\r\n<P>Drop offs and pickups from this location should occur only at night as to reduce risk of being witnessed by fishermen in the area. This dropoff point will recieve reduced priority during the fishing season for obvious reasons.</P>\r\n</BODY>\r\n</HTML>' WHERE `entry` = 3551;
        UPDATE `page_text` SET `text` = '<HTML>\r\n<BODY>\r\n<H1 align="center">Location 2: Grizzlepaw Den</H1>\r\n<BR/>\r\n<P>South of Thelsamar, there is a large hill. On the south side of the hill, there is a path leading to the cave at the top. Store packges behind the rocks in the back of the cave.</P>\r\n<BR/>\r\n<P>Please refrain from continued use of this cave as a shelter and/or hideout. Utilizing this cave for such compromises the security of our packages and our messenger routes.</P>\r\n</BODY>\r\n</HTML>' WHERE `entry` = 3552;
        UPDATE `page_text` SET `text` = '<HTML>\r\n<BODY>\r\n<H1 align="center">Location 3: Shanda''s Lair</H1>\r\n<BR/>\r\n<P>There is a small hovel to the southwest of the excavation site that once belonged to a reclusive hermit.  Shanda''s residence in this cave, however, has driven all potential inhabitants away. Just outside the mouth of the cave serves as a perfect drop point.</P>\r\n<BR/>\r\n<P>As a reminder, Shanda is an enormous murderous spider the size of two dwarves. Do not drop documents IN the cave, even if Shanda is not currently present; she will be, given time.</P>\r\n</BODY>\r\n</HTML>' WHERE `entry` = 3553;
        UPDATE `page_text` SET `text` = '<HTML>\r\n<BODY>\r\n<H1 align="center">Location 4: Ironband''s Cubby</H1>\r\n<BR/>\r\n<P>A side passage in the heart of Ironband''s Excavation Site leads up to a well-hidden and disused alcove. Hidden right under the noses of the Explorer''s league, this is a prime dropoff spot,</P>\r\n<BR/>\r\n<P>The Troggs have distracted the Explorer''s League, but do not forget they are still hostile to us. Take care when accessing the site at night, Troggs may be waiting in ambush.</P>\r\n</BODY>\r\n</HTML>' WHERE `entry` = 3554;
        UPDATE `page_text` SET `text` = '<HTML>\r\n<BODY>\r\n<H1 align="center">Location 5: Mo''grash Skull Idol</H1>\r\n<BR/>\r\n<P>This stone skull idol seems like part of the ogre grounds, but is further south than the ogres actually roam. Place documents at the base of it.</P>\r\n<BR/>\r\n<P>Do NOT place documents IN the mouth of the skull idol. Several documents have been permanently lost this way, as well as one hand, mysteriously.</P>\r\n</BODY>\r\n</HTML>' WHERE `entry` = 3555;
        UPDATE `page_text` SET `text` = '<HTML>\r\n<BODY>\r\n<H1 align="center">Location 6: The Grove in the Loch</H1>\r\n<BR/>\r\n<P>A small grove of three saplings in the center of the Loch serves as a well-isolated drop off point.</P>\r\n<BR/>\r\n<P>Draining of the Loch has left this space slightly less isolated. The crocolisks have helped to mitigate this.</P>\r\n</BODY>\r\n</HTML>' WHERE `entry` = 3556;

        UPDATE `points_of_interest` SET `x` = 1572.3, `y` = -4436.33 WHERE `entry` = 179;
        UPDATE `points_of_interest` SET `x` = 1617.56, `y` = -4425.31 WHERE `entry` = 181;
        UPDATE `points_of_interest` SET `x` = 1843.63, `y` = -4394.62 WHERE `entry` = 182;
        UPDATE `points_of_interest` SET `x` = 1738.83, `y` = -4280.79 WHERE `entry` = 183;
        UPDATE `points_of_interest` SET `x` = 1782.49, `y` = -4212.75 WHERE `entry` = 188;
        UPDATE `points_of_interest` SET `x` = 2077.39, `y` = -4807.91 WHERE `entry` = 308;
        UPDATE `points_of_interest` SET `x` = 1472.91, `y` = -4148.62 WHERE `entry` = 312;

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
