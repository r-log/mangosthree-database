-- MySQL dump 10.13  Distrib 5.5.37, for Win32 (x86)
--
-- Host: localhost    Database: character3
-- ------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@SESSION.TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `db_version`
--

DROP TABLE IF EXISTS `db_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_version` (
  `version` int(3) NOT NULL COMMENT 'The Version of the Release',
  `structure` int(3) NOT NULL COMMENT 'The current core structure level.',
  `content` int(3) NOT NULL COMMENT 'The current core content level.',
  `description` varchar(30) NOT NULL DEFAULT '' COMMENT 'A short description of the latest database revision.',
  `comment` varchar(150) DEFAULT '' COMMENT 'A comment about the latest database revision.',
  PRIMARY KEY (`version`,`structure`,`content`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Used DB version notes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_version`
--

LOCK TABLES `db_version` WRITE;
/*!40000 ALTER TABLE `db_version` DISABLE KEYS */;
INSERT  INTO `db_version`(`version`,`structure`,`content`,`description`,`comment`) VALUES 
(22,3,2,'Add_Quest_Tracker','Base Install of 21000_00 to Rel22_3_2');
/*!40000 ALTER TABLE `db_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_data`
--

DROP TABLE IF EXISTS `account_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_data` (
  `account` int(11) unsigned NOT NULL DEFAULT 0,
  `type` int(11) unsigned NOT NULL DEFAULT 0,
  `time` bigint(11) unsigned NOT NULL DEFAULT 0,
  `data` longblob NOT NULL,
  PRIMARY KEY (`account`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arena_team`
--

DROP TABLE IF EXISTS `arena_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arena_team` (
  `arenateamid` int(10) unsigned NOT NULL DEFAULT 0,
  `name` char(255) NOT NULL,
  `captainguid` int(10) unsigned NOT NULL DEFAULT 0,
  `type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `BackgroundColor` int(10) unsigned NOT NULL DEFAULT 0,
  `EmblemStyle` int(10) unsigned NOT NULL DEFAULT 0,
  `EmblemColor` int(10) unsigned NOT NULL DEFAULT 0,
  `BorderStyle` int(10) unsigned NOT NULL DEFAULT 0,
  `BorderColor` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`arenateamid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arena_team_member`
--

DROP TABLE IF EXISTS `arena_team_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arena_team_member` (
  `arenateamid` int(10) unsigned NOT NULL DEFAULT 0,
  `guid` int(10) unsigned NOT NULL DEFAULT 0,
  `played_week` int(10) unsigned NOT NULL DEFAULT 0,
  `wons_week` int(10) unsigned NOT NULL DEFAULT 0,
  `played_season` int(10) unsigned NOT NULL DEFAULT 0,
  `wons_season` int(10) unsigned NOT NULL DEFAULT 0,
  `personal_rating` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`arenateamid`,`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arena_team_stats`
--

DROP TABLE IF EXISTS `arena_team_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arena_team_stats` (
  `arenateamid` int(10) unsigned NOT NULL DEFAULT 0,
  `rating` int(10) unsigned NOT NULL DEFAULT 0,
  `games_week` int(10) unsigned NOT NULL DEFAULT 0,
  `wins_week` int(10) unsigned NOT NULL DEFAULT 0,
  `games_season` int(10) unsigned NOT NULL DEFAULT 0,
  `wins_season` int(10) unsigned NOT NULL DEFAULT 0,
  `rank` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`arenateamid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auction` (
  `id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Unique identifier for every auction.',
  `houseid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The AuctionHouseId (See AuctionHouse.dbc)',
  `itemguid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the item that is up for auction. (See item_instance.guid)',
  `item_template` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The entry of the item up for auction. See (item_template.entry)',
  `item_count` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The stack count of the item',
  `item_randompropertyid` int(11) NOT NULL DEFAULT 0 COMMENT 'A link to the Item''s RandomProperty Id (See item_template.Randompropertyid).',
  `itemowner` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the owner of the item up for auction. (See character.guid)',
  `buyoutprice` bigint(40) NOT NULL DEFAULT 0 COMMENT 'The buyout price of the item in copper.',
  `time` bigint(40) unsigned NOT NULL DEFAULT 0 COMMENT 'The time when this auction will end, measured in Unix time.',
  `moneyTime` bigint(40) unsigned NOT NULL DEFAULT 0,
  `buyguid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the highest bidder. See (character.guid)',
  `lastbid` bigint(40) NOT NULL DEFAULT 0 COMMENT 'The amount of copper of the last bid made on the item.',
  `startbid` bigint(40) NOT NULL DEFAULT 0 COMMENT 'The amount of copper of the starting bid made on the item.',
  `deposit` bigint(40) NOT NULL DEFAULT 0 COMMENT 'The amount of copper spent on the deposit.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bugreport`
--

DROP TABLE IF EXISTS `bugreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bugreport` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto generated value when records are inserted by the core.',
  `type` longtext NOT NULL COMMENT 'The text description of the type of bug report / suggestion.',
  `content` longtext NOT NULL COMMENT 'The text content of the bug/suggestion.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Debug System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_events`
--

DROP TABLE IF EXISTS `calendar_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_events` (
  `eventId` bigint(10) unsigned NOT NULL DEFAULT 0,
  `creatorGuid` int(10) unsigned NOT NULL DEFAULT 0,
  `guildId` int(10) unsigned NOT NULL DEFAULT 0,
  `type` tinyint(3) unsigned NOT NULL DEFAULT 4,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `dungeonId` int(10) NOT NULL DEFAULT -1,
  `eventTime` int(10) unsigned NOT NULL DEFAULT 0,
  `title` varchar(128) NOT NULL DEFAULT '',
  `description` varchar(1024) NOT NULL DEFAULT '',
  PRIMARY KEY (`eventId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_invites`
--

DROP TABLE IF EXISTS `calendar_invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_invites` (
  `inviteId` bigint(10) unsigned NOT NULL DEFAULT 0,
  `eventId` bigint(10) unsigned NOT NULL DEFAULT 0,
  `inviteeGuid` int(10) unsigned NOT NULL DEFAULT 0,
  `senderGuid` int(3) unsigned NOT NULL DEFAULT 0,
  `status` tinyint(10) unsigned NOT NULL DEFAULT 0,
  `lastUpdateTime` int(10) unsigned NOT NULL DEFAULT 0,
  `rank` tinyint(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`inviteId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_account_data`
--

DROP TABLE IF EXISTS `character_account_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_account_data` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0,
  `type` int(11) unsigned NOT NULL DEFAULT 0,
  `time` bigint(11) unsigned NOT NULL DEFAULT 0,
  `data` longblob NOT NULL,
  PRIMARY KEY (`guid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_achievement`
--

DROP TABLE IF EXISTS `character_achievement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_achievement` (
  `guid` int(11) unsigned NOT NULL,
  `achievement` int(11) unsigned NOT NULL,
  `date` bigint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`achievement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_achievement_progress`
--

DROP TABLE IF EXISTS `character_achievement_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_achievement_progress` (
  `guid` int(11) unsigned NOT NULL,
  `criteria` int(11) unsigned NOT NULL,
  `counter` int(11) unsigned NOT NULL,
  `date` bigint(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`criteria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_action`
--

DROP TABLE IF EXISTS `character_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_action` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the character (See character.id).',
  `spec` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `button` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'The ID of the button on the action bar where the action icon will be placed.',
  `action` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Depending on the type value, this could be various values.',
  `type` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'The type of action.',
  PRIMARY KEY (`guid`,`spec`,`button`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_aura`
--

DROP TABLE IF EXISTS `character_aura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_aura` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID (Full Global Unique Identifier) of the target affected by the aura.',
  `caster_guid` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID (Global Unique Identifier) of the player who cast the aura.',
  `item_guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID (Global Unique Identifier) of the item which casted the aura.',
  `spell` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The spell from which the aura was applied. (See Spell.dbc)',
  `stackcount` int(11) unsigned NOT NULL DEFAULT 1 COMMENT 'Determines how many stacks of the spell the character has.',
  `remaincharges` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The number of charges remaining on the aura.',
  `basepoints0` int(11) NOT NULL DEFAULT 0 COMMENT 'Primary effect.',
  `basepoints1` int(11) NOT NULL DEFAULT 0 COMMENT 'Secondary effect (healing)',
  `basepoints2` int(11) NOT NULL DEFAULT 0 COMMENT 'Secondary effect (damage)',
  `periodictime0` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Primary effect over time counter.',
  `periodictime1` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Primary effect (healing) over time counter.',
  `periodictime2` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Primary effect (damage) over time counter.',
  `maxduration` int(11) NOT NULL DEFAULT 0 COMMENT 'The maximum duration of the aura.',
  `remaintime` int(11) NOT NULL DEFAULT 0 COMMENT 'The time remaining in seconds on the aura. -1 means that the aura is indefinite.',
  `effIndexMask` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The effect index of the spell from which the aura came from.',
  PRIMARY KEY (`guid`,`caster_guid`,`item_guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_battleground_data`
--

DROP TABLE IF EXISTS `character_battleground_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_battleground_data` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The character battleground datar global unique identifier.',
  `instance_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The unique ID of the battleground instance the character has entered.',
  `team` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Neutral, Horde, or Alliance',
  `join_x` float NOT NULL DEFAULT 0 COMMENT 'The character''s X coordinate in the battleground.',
  `join_y` float NOT NULL DEFAULT 0 COMMENT 'The character''s Y coordinate in the battleground.',
  `join_z` float NOT NULL DEFAULT 0 COMMENT 'The character''s Z coordinate in the battleground.',
  `join_o` float NOT NULL DEFAULT 0 COMMENT 'The character''s orientation in the battleground.',
  `join_map` int(11) NOT NULL DEFAULT 0 COMMENT 'Battleground map ID where the character will spawn.',
  `taxi_start` int(11) NOT NULL DEFAULT 0,
  `taxi_end` int(11) NOT NULL DEFAULT 0,
  `mount_spell` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_currencies`
--

DROP TABLE IF EXISTS `character_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_currencies` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0,
  `id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `totalCount` int(11) unsigned NOT NULL DEFAULT 0,
  `weekCount` int(11) unsigned NOT NULL DEFAULT 0,
  `seasonCount` int(11) unsigned NOT NULL DEFAULT 0,
  `flags` tinyint(2) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Table structure for table `character_declinedname`
--

DROP TABLE IF EXISTS `character_declinedname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_declinedname` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `genitive` varchar(15) NOT NULL DEFAULT '',
  `dative` varchar(15) NOT NULL DEFAULT '',
  `accusative` varchar(15) NOT NULL DEFAULT '',
  `instrumental` varchar(15) NOT NULL DEFAULT '',
  `prepositional` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_equipmentsets`
--

DROP TABLE IF EXISTS `character_equipmentsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_equipmentsets` (
  `guid` int(11) NOT NULL DEFAULT 0,
  `setguid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `setindex` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL,
  `iconname` varchar(100) NOT NULL,
  `ignore_mask` int(11) unsigned NOT NULL DEFAULT 0,
  `item0` int(11) unsigned NOT NULL DEFAULT 0,
  `item1` int(11) unsigned NOT NULL DEFAULT 0,
  `item2` int(11) unsigned NOT NULL DEFAULT 0,
  `item3` int(11) unsigned NOT NULL DEFAULT 0,
  `item4` int(11) unsigned NOT NULL DEFAULT 0,
  `item5` int(11) unsigned NOT NULL DEFAULT 0,
  `item6` int(11) unsigned NOT NULL DEFAULT 0,
  `item7` int(11) unsigned NOT NULL DEFAULT 0,
  `item8` int(11) unsigned NOT NULL DEFAULT 0,
  `item9` int(11) unsigned NOT NULL DEFAULT 0,
  `item10` int(11) unsigned NOT NULL DEFAULT 0,
  `item11` int(11) unsigned NOT NULL DEFAULT 0,
  `item12` int(11) unsigned NOT NULL DEFAULT 0,
  `item13` int(11) unsigned NOT NULL DEFAULT 0,
  `item14` int(11) unsigned NOT NULL DEFAULT 0,
  `item15` int(11) unsigned NOT NULL DEFAULT 0,
  `item16` int(11) unsigned NOT NULL DEFAULT 0,
  `item17` int(11) unsigned NOT NULL DEFAULT 0,
  `item18` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`setguid`),
  UNIQUE KEY `idx_set` (`guid`,`setguid`,`setindex`),
  KEY `Idx_setindex` (`setindex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `character_gifts`
--

DROP TABLE IF EXISTS `character_gifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_gifts` (
  `guid` int(20) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID (Global Unique Identifier) of the character. (See character.guid).',
  `item_guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the item. (See item_instance.guid).',
  `entry` int(20) unsigned NOT NULL DEFAULT 0 COMMENT 'The entry of the item. (See item_template.entry).',
  `flags` int(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`item_guid`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_glyphs`
--

DROP TABLE IF EXISTS `character_glyphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_glyphs` (
  `guid` int(11) unsigned NOT NULL,
  `spec` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `slot` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `glyph` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`spec`,`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `character_homebind`
--

DROP TABLE IF EXISTS `character_homebind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_homebind` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID (Global Unique Identifier) of the character. (See character.guid).',
  `map` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The Map Identifier where the character gets teleported to. (See Maps.dbc).',
  `zone` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The Zone Identifier where the character gets teleported to.',
  `position_x` float NOT NULL DEFAULT 0 COMMENT 'The x position where the character gets teleported to.',
  `position_y` float NOT NULL DEFAULT 0 COMMENT 'The y position where the character gets teleported to.',
  `position_z` float NOT NULL DEFAULT 0 COMMENT 'The z position where the character gets teleported to.',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_instance`
--

DROP TABLE IF EXISTS `character_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_instance` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID (Global Unique Identifier) of the character.',
  `instance` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The instance ID. (See instance.id).',
  `permanent` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT 'Boolean 0 or 1 controlling if the player has been bound to the instance.',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_inventory`
--

DROP TABLE IF EXISTS `character_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_inventory` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID (Global Unique Identifier) of the character. (See character.guid).',
  `bag` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'If it isn''t 0, then it is the bag''s item GUID (Global Unique Identifier).',
  `slot` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'The slot is the slot in the bag where the item is.',
  `item` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The item''s GUID. (See item_instance.guid).',
  `item_template` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The item''s template entry (Item Identifier). (See item_template.entry).',
  PRIMARY KEY (`item`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_pet`
--

DROP TABLE IF EXISTS `character_pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_pet` (
  `id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The special pet ID. This is a unique identifier among all pets.',
  `entry` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The creature entry of this pet. (See creature_template.entry).',
  `owner` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the pet''s owner. (See character.guid).',
  `modelid` int(11) unsigned DEFAULT 0 COMMENT 'The model ID to use to display the pet.',
  `CreatedBySpell` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The ID of the spell that has created this pet.',
  `PetType` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'The type of pet that this is. 0 = summoned pet, 1 = tamed pet',
  `level` int(11) unsigned NOT NULL DEFAULT 1 COMMENT 'The current level of the pet.',
  `exp` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The current experience that this pet has.',
  `Reactstate` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT 'The current reaction state of the pet (passive, aggressive, etc).',
  `name` varchar(100) DEFAULT 'Pet' COMMENT 'The pet''s name.',
  `renamed` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT 'Boolean 1 or 0. 1 = Pet has been renamed.',
  `slot` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The pet slot that the pet is in. The slot is a number between 0 and 3 inclusive.',
  `curhealth` int(11) unsigned NOT NULL DEFAULT 1 COMMENT 'The current pet health at the time it was saved to DB.',
  `curmana` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The current pet mana at the time it was saved to DB.',
  `savetime` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'The time when the pet was last saved, in Unix time.',
  `resettalents_cost` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'This is the cost to untrain the pet talents.',
  `resettalents_time` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'How many times the pets talents have been reset.',
  `abdata` longtext DEFAULT NULL COMMENT 'Data about pet action bar and action type ten pairs of action bar entry.',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Pet System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_pet_declinedname`
--

DROP TABLE IF EXISTS `character_pet_declinedname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_pet_declinedname` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `owner` int(11) unsigned NOT NULL DEFAULT 0,
  `genitive` varchar(12) NOT NULL DEFAULT '',
  `dative` varchar(12) NOT NULL DEFAULT '',
  `accusative` varchar(12) NOT NULL DEFAULT '',
  `instrumental` varchar(12) NOT NULL DEFAULT '',
  `prepositional` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `owner_key` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_phase_data`
--

DROP TABLE IF EXISTS `character_phase_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_phase_data` (
  `guid` int(11) NOT NULL,
  `map` smallint(6) NOT NULL,
  `phase` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_queststatus`
--

DROP TABLE IF EXISTS `character_queststatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_queststatus` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the character. (See character.guid).',
  `quest` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The quest ID. (See quest_template.entry).',
  `status` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The current quest status.',
  `rewarded` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT 'Boolean 1 or 0 representing whether the quest has been rewarded or not.',
  `explored` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT 'Boolean 1 or 0 representing if the character has explored what was needed.',
  `timer` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'Remaining time left on the quest if the quest has a timer (See quest_template).',
  `mobcount1` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Current count of the first number of kills or casts.',
  `mobcount2` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Current count of the second number of kills or casts.',
  `mobcount3` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Current count of the third number of kills or casts.',
  `mobcount4` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Current count of the forth number of kills or casts.',
  `itemcount1` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Current item count for the first item in a delivery quest, if any.',
  `itemcount2` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Current item count for the second item in a delivery quest, if any.',
  `itemcount3` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Current item count for the third item in a delivery quest, if any.',
  `itemcount4` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Current item count for the forth item in a delivery quest, if any.',
  `itemcount5` int(11) unsigned NOT NULL DEFAULT 0,
  `itemcount6` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_queststatus_daily`
--

DROP TABLE IF EXISTS `character_queststatus_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_queststatus_daily` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `quest` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Quest Identifier',
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';

--
-- Table structure for table `character_queststatus_monthly`
--

DROP TABLE IF EXISTS `character_queststatus_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_queststatus_monthly` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `quest` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Quest Identifier',
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';

--
-- Table structure for table `character_queststatus_weekly`
--

DROP TABLE IF EXISTS `character_queststatus_weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_queststatus_weekly` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `quest` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Quest Identifier',
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';

--
-- Table structure for table `character_reputation`
--

DROP TABLE IF EXISTS `character_reputation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_reputation` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the character. (See character.guid).',
  `faction` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The faction ID that the character has the given reputation in (See Faction.dbc).',
  `standing` int(11) NOT NULL DEFAULT 0 COMMENT 'The current reputation value that the character has.',
  `flags` int(11) NOT NULL DEFAULT 0 COMMENT 'This field is a bitmask containing flags that apply to the faction.',
  PRIMARY KEY (`guid`,`faction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_skills`
--

DROP TABLE IF EXISTS `character_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_skills` (
  `guid` int(11) unsigned NOT NULL COMMENT 'The GUID (Global Unique Identifier) of the character. (See character.guid).',
  `skill` mediumint(9) unsigned NOT NULL COMMENT 'The list of skills a character knows. A listing of those can be found in here.',
  `value` mediumint(9) unsigned NOT NULL COMMENT 'The current skill rank(value) of the character skills a character has.',
  `max` mediumint(9) unsigned NOT NULL COMMENT 'The highest possible value for the given skill within a given rank.',
  PRIMARY KEY (`guid`,`skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_social`
--

DROP TABLE IF EXISTS `character_social`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_social` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the character. (See character.guid)',
  `friend` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the friend/ignored. (See character.guid)',
  `flags` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT 'Whether the character is a friend or ignored.',
  `note` varchar(48) NOT NULL DEFAULT '' COMMENT 'Friend Note',
  PRIMARY KEY (`guid`,`friend`,`flags`),
  KEY `guid_flags` (`guid`,`flags`),
  KEY `friend_flags` (`friend`,`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_spell`
--

DROP TABLE IF EXISTS `character_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_spell` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID (Global Unique Identifier) of the character. (See character.guid).',
  `spell` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The spell ID (Spell Identifier). (See Spell.dbc)',
  `active` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT 'Boolean 1 or 0 signifying whether the spell is active (appears in the spell book',
  `disabled` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'Boolean flag 0 or 1 when spell is disabled because of talents.',
  PRIMARY KEY (`guid`,`spell`),
  KEY `Idx_spell` (`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_spell_cooldown`
--

DROP TABLE IF EXISTS `character_spell_cooldown`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_spell_cooldown` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID (Global Unique Identifier, Low part) of the character.',
  `spell` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The spell ID (Spell Identifier). (See Spell.dbc)',
  `item` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'If the spell was casted from an item, the item ID (Item Identifier).',
  `time` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'The time when the spell cooldown will finish, measured in Unix Time.',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_stats`
--

DROP TABLE IF EXISTS `character_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_stats` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The guid of the character. (See character.guid).',
  `maxhealth` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Maximum amount of health that the character has.',
  `maxpower1` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Max Mana',
  `maxpower2` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Max Rage',
  `maxpower3` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Max Focus',
  `maxpower4` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Max Energy',
  `maxpower5` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Max Happiness',
  `strength` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current strength value.',
  `agility` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current agility value',
  `stamina` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current stamina value.',
  `intellect` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current intellect value.',
  `spirit` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current spirit value.',
  `armor` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current armor value.',
  `resHoly` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current holy resistance value.',
  `resFire` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current fire resistance value.',
  `resNature` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current nature resistance value.',
  `resFrost` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current frost resistance value.',
  `resShadow` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current shadow resistance value.',
  `resArcane` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current arcane resistance value.',
  `blockPct` float unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current block chance',
  `dodgePct` float unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current dodge chance.',
  `parryPct` float unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current parry chance.',
  `critPct` float unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current crit chance.',
  `rangedCritPct` float unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current ranged crit chance.',
  `spellCritPct` float unsigned NOT NULL DEFAULT 0,
  `attackPower` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current attackpower.',
  `rangedAttackPower` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Character''s current ranged attackpower.',
  `spellPower` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_talent`
--

DROP TABLE IF EXISTS `character_talent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_talent` (
  `guid` int(11) unsigned NOT NULL,
  `talent_id` int(11) unsigned NOT NULL,
  `current_rank` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `spec` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`talent_id`,`spec`),
  KEY `talent_key` (`talent_id`),
  KEY `spec_key` (`spec`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `character_ticket`
--

DROP TABLE IF EXISTS `character_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_ticket` (
  `ticket_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique ticket ID.',
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the character sending the ticket. (See character.guid).',
  `ticket_text` text DEFAULT NULL COMMENT 'The ticket description text; the text written by the player.',
  `response_text` text DEFAULT NULL COMMENT 'The ticket solution text; the text written by the GM.',
  `ticket_lastchange` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Stores the time when this ticket was last changed.',
  `resolved` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_tutorial`
--

DROP TABLE IF EXISTS `character_tutorial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_tutorial` (
  `account` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The account id of the user. (See account.id).',
  `tut0` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'These values are 32bits flags.',
  `tut1` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'These values are 32bits flags.',
  `tut2` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'These values are 32bits flags.',
  `tut3` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'These values are 32bits flags.',
  `tut4` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'These values are 32bits flags.',
  `tut5` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'These values are 32bits flags.',
  `tut6` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'These values are 32bits flags.',
  `tut7` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'These values are 32bits flags.',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `character_whispers`
--

DROP TABLE IF EXISTS `character_whispers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_whispers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id of the whisper, sort by this or time',
  `to_guid` int(10) NOT NULL COMMENT 'guid of receiver of the whisper',
  `from_guid` int(10) NOT NULL COMMENT 'guid of sender of the whisper',
  `message` varchar(256) NOT NULL COMMENT 'actual whisper that was sent',
  `regarding_ticket_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'link to character_ticket.ticket_id, if 0 just a log of a whisper sent',
  `sent_on` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'this is when the whisper was sent',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characters` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The character global unique identifier.',
  `account` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The account ID in which this character resides (See account.id) in the realm db.',
  `name` varchar(12) NOT NULL DEFAULT '' COMMENT 'The name of the character.',
  `race` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'The race of the character.',
  `class` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'The Class Id of the character (See chrclasses.dbc).',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'The Sex/Gender of the character.',
  `level` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'The current level of the designated player.',
  `xp` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'The total amount of xp that the signified player has.',
  `money` bigint(40) unsigned NOT NULL DEFAULT 0 COMMENT 'This is the amount of copper the character possesses.',
  `playerBytes` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'This defines the physical attributes of the character.',
  `playerBytes2` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'This defines the facial hair physical attribute of the character.',
  `playerFlags` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'These are the player flags, such as GM mode on or off.',
  `position_x` float NOT NULL DEFAULT 0 COMMENT 'The x position of the character''s location.',
  `position_y` float NOT NULL DEFAULT 0 COMMENT 'The y position of the character''s location.',
  `position_z` float NOT NULL DEFAULT 0 COMMENT 'The z position of the character''s location.',
  `map` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The map ID the character is in (See maps.dbc)',
  `dungeon_difficulty` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `orientation` float NOT NULL DEFAULT 0 COMMENT 'The orientation the character is facing. (North = 0.0, South = 3.14159)',
  `taximask` longtext DEFAULT NULL,
  `online` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'Records whether the character is online (1) or offline (0).',
  `cinematic` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'Boolean 1 or 0 controlling whether the start cinematic has been shown or not.',
  `totaltime` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The total time that the character has been active in the world.',
  `leveltime` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The total time the character has spent in the world at the current level.',
  `logout_time` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'The time when the character last logged out, measured in Unix time.',
  `is_logout_resting` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'Boolean 1 or 0 controlling if the character is currently in a resting zone.',
  `rest_bonus` float NOT NULL DEFAULT 0 COMMENT 'This is the rest bonus for the character.',
  `resettalents_cost` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The cost for the character to reset its talents, measured in copper.',
  `resettalents_time` bigint(20) unsigned NOT NULL DEFAULT 0,
  `primary_trees` varchar(10) NOT NULL DEFAULT '0 0 ',
  `trans_x` float NOT NULL DEFAULT 0 COMMENT 'The X coordinate of the character on the transport it is travelling on.',
  `trans_y` float NOT NULL DEFAULT 0 COMMENT 'The Y coordinate of the character on the transport it is travelling on.',
  `trans_z` float NOT NULL DEFAULT 0 COMMENT 'The Z coordinate of the character on the transport it is travelling on.',
  `trans_o` float NOT NULL DEFAULT 0 COMMENT 'The orientation of the character on the transport it is travelling on.',
  `transguid` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'This is the transprt the character is currently travelling on.',
  `extra_flags` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'These flags control certain player specific attributes, mostly GM features.',
  `stable_slots` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT 'The number of stable slots the player has available. Maximum is 2.',
  `at_login` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The status of the character.',
  `zone` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The zone ID the character is in.',
  `death_expire_time` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'Time when a character can be resurrected.',
  `taxi_path` text DEFAULT NULL COMMENT 'Stores the players current taxi path (TaxiPath.dbc) if logged off while on one.',
  `totalKills` int(10) unsigned NOT NULL DEFAULT 0,
  `todayKills` smallint(5) unsigned NOT NULL DEFAULT 0,
  `yesterdayKills` smallint(5) unsigned NOT NULL DEFAULT 0,
  `chosenTitle` int(10) unsigned NOT NULL DEFAULT 0,
  `watchedFaction` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'The faction whose rep is being followed on the experience bar.',
  `drunk` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'This represents the alcoholic strength of the drink.',
  `health` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'The character''s health when logging out.',
  `power1` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'If a mana user, then this is a character''s mana level when logging out.',
  `power2` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'If a warrior, then this is a character''s rage level when logging out.',
  `power3` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'This is a hunter pet''s focus level.',
  `power4` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'If a rogue, then this is a character''s energy level when logging out.',
  `power5` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'This is the current active pet''s happiness level.',
  `specCount` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `activeSpec` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `exploredZones` longtext DEFAULT NULL COMMENT 'This is a record of all areas discovered by the character.',
  `equipmentCache` longtext DEFAULT NULL COMMENT 'This is a record of all items that are currently equipped.',
  `knownTitles` longtext DEFAULT NULL,
  `actionBars` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'This represents which action bars are currently active.',
  `slot` tinyint(3) unsigned NOT NULL DEFAULT 255,
  `deleteInfos_Account` int(11) unsigned DEFAULT NULL COMMENT 'This is the account number from the characters table.',
  `deleteInfos_Name` varchar(12) DEFAULT NULL COMMENT 'The is the name of the character being deleted.',
  `deleteDate` bigint(20) unsigned DEFAULT NULL COMMENT 'This is the date the character was deleted,',
  `createdDate` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`),
  KEY `idx_account` (`account`),
  KEY `idx_online` (`online`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';

--
-- Table structure for table `corpse`
--

DROP TABLE IF EXISTS `corpse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corpse` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The character global unique identifier of the corpse.',
  `player` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The character global unique identifier. (See characters.guid).',
  `position_x` float NOT NULL DEFAULT 0 COMMENT 'The x position of the character''s corpse location.',
  `position_y` float NOT NULL DEFAULT 0 COMMENT 'The y position of the character''s corpse location.',
  `position_z` float NOT NULL DEFAULT 0 COMMENT 'The z position of the character''s corpse location.',
  `orientation` float NOT NULL DEFAULT 0 COMMENT 'The orientation of the corpse. (North = 0.0, South = 3.14159)',
  `map` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The map ID the corpse is in. (See maps.dbc)',
  `phaseMask` int(11) unsigned NOT NULL DEFAULT 1,
  `time` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'Time of death.',
  `corpse_type` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'The Display Type of the corpse.',
  `instance` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The instance ID that the corpse is in.',
  PRIMARY KEY (`guid`),
  KEY `idx_type` (`corpse_type`),
  KEY `instance` (`instance`),
  KEY `Idx_player` (`player`),
  KEY `Idx_time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Death System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_respawn`
--

DROP TABLE IF EXISTS `creature_respawn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_respawn` (
  `guid` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'Time till the creature should respawn.',
  `instance` mediumint(8) unsigned NOT NULL DEFAULT 0 COMMENT 'Instance ID of the instance the creature is respawning into.',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Grid Loading System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_status`
--

DROP TABLE IF EXISTS `game_event_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_status` (
  `event` smallint(6) unsigned NOT NULL DEFAULT 0 COMMENT 'The Event Id (see game_event.is) of currently active game events.',
  PRIMARY KEY (`event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Game event system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_respawn`
--

DROP TABLE IF EXISTS `gameobject_respawn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_respawn` (
  `guid` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Global unique ID of the game object.',
  `respawntime` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'Time till the game object should respawn.',
  `instance` mediumint(8) unsigned NOT NULL DEFAULT 0 COMMENT 'Instance ID that the game object will spawn in.',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Grid Loading System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_instance`
--

DROP TABLE IF EXISTS `group_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_instance` (
  `leaderGuid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The Guid of the group leader. (See characters.guid)',
  `instance` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'ID of the Instance session the group has enterd.',
  `permanent` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT 'Boolean flag if the group is bound to the Instance or not',
  PRIMARY KEY (`leaderGuid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_member`
--

DROP TABLE IF EXISTS `group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_member` (
  `groupId` int(11) unsigned NOT NULL COMMENT 'The group ID from the groups table.',
  `memberGuid` int(11) unsigned NOT NULL COMMENT 'The GUID of the character in the group.',
  `assistant` tinyint(1) unsigned NOT NULL COMMENT 'Flag stating whether or not the character is the assist.',
  `subgroup` smallint(6) unsigned NOT NULL COMMENT 'This is the group number within a raid (8 groups max)',
  PRIMARY KEY (`groupId`,`memberGuid`),
  KEY `Idx_memberGuid` (`memberGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `groupId` int(11) unsigned NOT NULL COMMENT 'Uniquie ID for the group.',
  `leaderGuid` int(11) unsigned NOT NULL COMMENT 'Guid of the group''s leader',
  `mainTank` int(11) unsigned NOT NULL COMMENT 'Guid of the character who is that main tank.',
  `mainAssistant` int(11) unsigned NOT NULL COMMENT 'Guid of the character who is that main assist.',
  `lootMethod` tinyint(4) unsigned NOT NULL COMMENT 'This is the loot method used by the group.',
  `looterGuid` int(11) unsigned NOT NULL COMMENT 'Guid of the character who retrieves the loot.',
  `lootThreshold` tinyint(4) unsigned NOT NULL COMMENT 'The quality of the items in the loot to be rolled for.',
  `icon1` int(11) unsigned NOT NULL COMMENT 'Guid of the target that has the star raid target on it.',
  `icon2` int(11) unsigned NOT NULL COMMENT 'Guid of the target that has the circle raid target on it.',
  `icon3` int(11) unsigned NOT NULL COMMENT 'Guid of target that has the dimond raid target on it.',
  `icon4` int(11) unsigned NOT NULL COMMENT 'Guid of the target that has the triangler raid target on it.',
  `icon5` int(11) unsigned NOT NULL COMMENT 'Guid of the target that has the moon raid target on it.',
  `icon6` int(11) unsigned NOT NULL COMMENT 'Guid of the target that has the square raid target on it.',
  `icon7` int(11) unsigned NOT NULL COMMENT 'Guid of the target that has the cross raid target on it.',
  `icon8` int(11) unsigned NOT NULL COMMENT 'Guid of the target that has the skull raid target on it.',
  `groupType` tinyint(1) unsigned NOT NULL,
  `difficulty` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `raiddifficulty` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`groupId`),
  UNIQUE KEY `leaderGuid` (`leaderGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild`
--

DROP TABLE IF EXISTS `guild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild` (
  `guildid` int(6) unsigned NOT NULL DEFAULT 0 COMMENT 'The ID of the guild.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The guild name.',
  `leaderguid` int(6) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the character who created the guild. (See characters.guid)',
  `EmblemStyle` int(5) NOT NULL DEFAULT 0 COMMENT 'The emblem style of the guild tabard.',
  `EmblemColor` int(5) NOT NULL DEFAULT 0 COMMENT 'The emblem color of the guild tabard.',
  `BorderStyle` int(5) NOT NULL DEFAULT 0 COMMENT 'The border style of the guild tabard.',
  `BorderColor` int(5) NOT NULL DEFAULT 0 COMMENT 'The border color of the guild tabard.',
  `BackgroundColor` int(5) NOT NULL DEFAULT 0 COMMENT 'The background color of the guild tabard.',
  `info` varchar(500) NOT NULL DEFAULT '' COMMENT 'The text message that appears in the Guild Information box.',
  `motd` varchar(128) NOT NULL DEFAULT '' COMMENT 'The text that appears in the Message Of The Day box.',
  `createdate` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'The date when the guild was created.',
  `BankMoney` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Guild System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild_bank_eventlog`
--

DROP TABLE IF EXISTS `guild_bank_eventlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_bank_eventlog` (
  `guildid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Guild Identificator',
  `LogGuid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Log record identificator - auxiliary column',
  `TabId` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'Guild bank TabId',
  `EventType` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'Event type',
  `PlayerGuid` int(11) unsigned NOT NULL DEFAULT 0,
  `ItemOrMoney` int(11) unsigned NOT NULL DEFAULT 0,
  `ItemStackCount` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `DestTabId` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT 'Destination Tab Id',
  `TimeStamp` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'Event UNIX time',
  PRIMARY KEY (`guildid`,`LogGuid`,`TabId`),
  KEY `Idx_PlayerGuid` (`PlayerGuid`),
  KEY `Idx_LogGuid` (`LogGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `guild_bank_item`
--

DROP TABLE IF EXISTS `guild_bank_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_bank_item` (
  `guildid` int(11) unsigned NOT NULL DEFAULT 0,
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `SlotId` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `item_guid` int(11) unsigned NOT NULL DEFAULT 0,
  `item_entry` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guildid`,`TabId`,`SlotId`),
  KEY `Idx_item_guid` (`item_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `guild_bank_right`
--

DROP TABLE IF EXISTS `guild_bank_right`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_bank_right` (
  `guildid` int(11) unsigned NOT NULL DEFAULT 0,
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `rid` int(11) unsigned NOT NULL DEFAULT 0,
  `gbright` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `SlotPerDay` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guildid`,`TabId`,`rid`),
  KEY `guildid_key` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `guild_bank_tab`
--

DROP TABLE IF EXISTS `guild_bank_tab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_bank_tab` (
  `guildid` int(11) unsigned NOT NULL DEFAULT 0,
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `TabName` varchar(100) NOT NULL DEFAULT '',
  `TabIcon` varchar(100) NOT NULL DEFAULT '',
  `TabText` text DEFAULT NULL,
  PRIMARY KEY (`guildid`,`TabId`),
  KEY `guildid_key` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `guild_eventlog`
--

DROP TABLE IF EXISTS `guild_eventlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_eventlog` (
  `guildid` int(11) unsigned NOT NULL COMMENT 'Id of related guild. (See guild.guildid).',
  `LogGuid` int(11) unsigned NOT NULL COMMENT 'A unique identifier given to each log entry to distinguish it.',
  `EventType` tinyint(1) unsigned NOT NULL COMMENT 'The Guild Event Type.',
  `PlayerGuid1` int(11) unsigned NOT NULL COMMENT 'Guid of character who made the change. (See character.guid)',
  `PlayerGuid2` int(11) unsigned NOT NULL COMMENT 'Guid of character who was changed. (See character.guid)',
  `NewRank` tinyint(2) unsigned NOT NULL COMMENT 'Id of new rank of PlayerGuid2. (See guild_rank.rid)',
  `TimeStamp` bigint(20) unsigned NOT NULL COMMENT 'Unix timestamp of when the event happened.',
  PRIMARY KEY (`guildid`,`LogGuid`),
  KEY `Idx_PlayerGuid1` (`PlayerGuid1`),
  KEY `Idx_PlayerGuid2` (`PlayerGuid2`),
  KEY `Idx_LogGuid` (`LogGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild Eventlog';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild_member`
--

DROP TABLE IF EXISTS `guild_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_member` (
  `guildid` int(6) unsigned NOT NULL DEFAULT 0 COMMENT 'The ID of the guild that the member is a part of. (See guild.guildid)',
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the player. (See character.guid)',
  `rank` tinyint(2) unsigned NOT NULL DEFAULT 0 COMMENT 'The rank that the player has in the guild. (See guild_rank.rid)',
  `pnote` varchar(31) NOT NULL DEFAULT '' COMMENT 'The Player Note set by the player.',
  `offnote` varchar(31) NOT NULL DEFAULT '' COMMENT 'The Officers Note set by officers in the guild.',
  `BankResetTimeMoney` int(11) unsigned NOT NULL DEFAULT 0,
  `BankRemMoney` int(11) unsigned NOT NULL DEFAULT 0,
  `BankResetTimeTab0` int(11) unsigned NOT NULL DEFAULT 0,
  `BankRemSlotsTab0` int(11) unsigned NOT NULL DEFAULT 0,
  `BankResetTimeTab1` int(11) unsigned NOT NULL DEFAULT 0,
  `BankRemSlotsTab1` int(11) unsigned NOT NULL DEFAULT 0,
  `BankResetTimeTab2` int(11) unsigned NOT NULL DEFAULT 0,
  `BankRemSlotsTab2` int(11) unsigned NOT NULL DEFAULT 0,
  `BankResetTimeTab3` int(11) unsigned NOT NULL DEFAULT 0,
  `BankRemSlotsTab3` int(11) unsigned NOT NULL DEFAULT 0,
  `BankResetTimeTab4` int(11) unsigned NOT NULL DEFAULT 0,
  `BankRemSlotsTab4` int(11) unsigned NOT NULL DEFAULT 0,
  `BankResetTimeTab5` int(11) unsigned NOT NULL DEFAULT 0,
  `BankRemSlotsTab5` int(11) unsigned NOT NULL DEFAULT 0,
  UNIQUE KEY `guid_key` (`guid`),
  KEY `guildid_key` (`guildid`),
  KEY `guildid_rank_key` (`guildid`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Guild System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild_rank`
--

DROP TABLE IF EXISTS `guild_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_rank` (
  `guildid` int(6) unsigned NOT NULL DEFAULT 0 COMMENT 'The guild ID that the rank is part of. (See guild.guildid)',
  `rid` int(11) unsigned NOT NULL COMMENT 'The particular rank ID. This number must be unique to each rank in a guild.',
  `rname` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the rank that is displayed in-game.',
  `rights` int(3) unsigned NOT NULL DEFAULT 0 COMMENT 'The rights a player with this rank has in the guild.',
  `BankMoneyPerDay` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guildid`,`rid`),
  KEY `Idx_rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Guild System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instance`
--

DROP TABLE IF EXISTS `instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance` (
  `id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The instance ID. This number is unique to every instance.',
  `map` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The map ID the instance is in. (See Map.dbc)',
  `resettime` bigint(40) unsigned NOT NULL DEFAULT 0 COMMENT 'The time when the instance will be reset, in Unix time.',
  `difficulty` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `encountersMask` int(10) unsigned NOT NULL DEFAULT 0,
  `data` longtext DEFAULT NULL COMMENT 'Specific data belonging to the individual instance.',
  PRIMARY KEY (`id`),
  KEY `map` (`map`),
  KEY `resettime` (`resettime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instance_reset`
--

DROP TABLE IF EXISTS `instance_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_reset` (
  `mapid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The map ID of the instance. (See Map.dbc)',
  `difficulty` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `resettime` bigint(40) unsigned NOT NULL DEFAULT 0 COMMENT 'Dungeon reset time in seconds.',
  PRIMARY KEY (`mapid`,`difficulty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_instance`
--

DROP TABLE IF EXISTS `item_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_instance` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the item. This number is unique for each item instance.',
  `owner_guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the character who has ownership of this item. (See character.guid)',
  `data` longtext DEFAULT NULL COMMENT 'Much like the playerbytes fields in the characters table.',
  `text` longtext DEFAULT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_owner_guid` (`owner_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_loot`
--

DROP TABLE IF EXISTS `item_loot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_loot` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Global unique ID of the item loot entry.',
  `owner_guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the owner. (See character.guid)',
  `itemid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Item template entry ID of the item.',
  `amount` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Total number of the item.',
  `suffix` int(11) unsigned NOT NULL DEFAULT 0,
  `property` int(11) NOT NULL DEFAULT 0 COMMENT 'Item random property.',
  PRIMARY KEY (`guid`,`itemid`),
  KEY `idx_owner_guid` (`owner_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail`
--

DROP TABLE IF EXISTS `mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail` (
  `id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Unique message id. Every new message gets a new auto incremented id.',
  `messageType` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'message_type.',
  `stationery` tinyint(3) NOT NULL DEFAULT 41 COMMENT 'The StationeryID (See Stationery.dbc).',
  `mailTemplateId` mediumint(8) unsigned NOT NULL DEFAULT 0 COMMENT 'The Mail Template Id (See MailTemplate.dbc)',
  `sender` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Guid of the character who sends the mail.',
  `receiver` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Guid of the character who receives the mail.',
  `subject` longtext DEFAULT NULL COMMENT 'The Subject of the mail.',
  `body` longtext DEFAULT NULL,
  `has_items` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'Boolean value showing whether or not atems have been sent.',
  `expire_time` bigint(40) unsigned NOT NULL DEFAULT 0 COMMENT 'Current Unix Time + Unix Time till expiry.',
  `deliver_time` bigint(40) unsigned NOT NULL DEFAULT 0 COMMENT 'Current Unix Time + Unix Time till delivery.',
  `money` bigint(40) unsigned NOT NULL DEFAULT 0 COMMENT 'Amount of money sent.',
  `cod` bigint(40) unsigned NOT NULL DEFAULT 0 COMMENT 'Amount of money needed (COD).',
  `checked` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'checked_flag.',
  PRIMARY KEY (`id`),
  KEY `idx_receiver` (`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Mail System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail_items`
--

DROP TABLE IF EXISTS `mail_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_items` (
  `mail_id` int(11) NOT NULL DEFAULT 0 COMMENT 'The Mail Id (See mail.id).',
  `item_guid` int(11) NOT NULL DEFAULT 0 COMMENT 'The GUID of the item.',
  `item_template` int(11) NOT NULL DEFAULT 0 COMMENT 'The entry ID of the item in the item_template table.',
  `receiver` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Guid of the character who receives the mail.',
  PRIMARY KEY (`mail_id`,`item_guid`),
  KEY `idx_receiver` (`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_aura`
--

DROP TABLE IF EXISTS `pet_aura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_aura` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the target affected by the aura. (See character.guid)',
  `caster_guid` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the player or creature who casted the aura. (See character.guid)',
  `item_guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Guid of the item that is casting the aura on the pet.',
  `spell` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The spell from which the aura was applied. (See Spell.dbc column 1)',
  `stackcount` int(11) unsigned NOT NULL DEFAULT 1 COMMENT 'This is the total number of times the aura can be stacked on the pet.',
  `remaincharges` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The number of charges remaining on the aura.',
  `basepoints0` int(11) NOT NULL DEFAULT 0 COMMENT 'Primary effect.',
  `basepoints1` int(11) NOT NULL DEFAULT 0 COMMENT 'Secondary effect (appears to be only healing related)',
  `basepoints2` int(11) NOT NULL DEFAULT 0 COMMENT 'Secondary effect (appears to be only damage related)',
  `periodictime0` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Primary effect over time.',
  `periodictime1` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Secondary effect (healing) over time',
  `periodictime2` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Secondary effect (damage) over time.',
  `maxduration` int(11) NOT NULL DEFAULT 0 COMMENT 'The maximum duration of the aura.',
  `remaintime` int(11) NOT NULL DEFAULT 0 COMMENT 'The time remaining in seconds on the aura. -1 means that the aura is indefinite.',
  `effIndexMask` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The effect index of the spell from which the aura came from.',
  PRIMARY KEY (`guid`,`caster_guid`,`item_guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Pet System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_spell`
--

DROP TABLE IF EXISTS `pet_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_spell` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The pet GUID. (See character_pet.id).',
  `spell` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The spell ID. See (Spell.dbc)',
  `active` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Boolean 0 or 1 controlling if the spell is active or not.',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Pet System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_spell_cooldown`
--

DROP TABLE IF EXISTS `pet_spell_cooldown`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_spell_cooldown` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the pet. (See character_pet.id)',
  `spell` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The spell ID to which the cooldown applies.',
  `time` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT 'The time when the cooldown expires, in Unix time.',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `petition`
--

DROP TABLE IF EXISTS `petition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `petition` (
  `ownerguid` int(10) unsigned NOT NULL COMMENT 'The petition owner''s GUID. (See characters.guid)',
  `petitionguid` int(10) unsigned DEFAULT 0 COMMENT 'The GUID of the petition item. See (item_instance.guid)',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the guild or arena team that the player is trying to petition.',
  PRIMARY KEY (`ownerguid`),
  UNIQUE KEY `index_ownerguid_petitionguid` (`ownerguid`,`petitionguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Guild System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `petition_sign`
--

DROP TABLE IF EXISTS `petition_sign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `petition_sign` (
  `ownerguid` int(10) unsigned NOT NULL COMMENT 'The GUID of the owner that is trying to make the guild/arena team.',
  `petitionguid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the charter item. (See item_template.guid)',
  `playerguid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The GUID of the player that has signed the charter. (See character.guid)',
  `player_account` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The account ID of the player that has signed the charter (See account.id).',
  PRIMARY KEY (`petitionguid`,`playerguid`),
  KEY `Idx_playerguid` (`playerguid`),
  KEY `Idx_ownerguid` (`ownerguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Guild System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pvpstats_players`
--
DROP TABLE IF EXISTS `pvpstats_players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pvpstats_players` (
  `battleground_id` bigint(20) unsigned NOT NULL,
  `character_guid` int(10) unsigned NOT NULL,
  `score_killing_blows` mediumint(8) unsigned NOT NULL,
  `score_deaths` mediumint(8) unsigned NOT NULL,
  `score_honorable_kills` mediumint(8) unsigned NOT NULL,
  `score_bonus_honor` mediumint(8) unsigned NOT NULL,
  `score_damage_done` mediumint(8) unsigned NOT NULL,
  `score_healing_done` mediumint(8) unsigned NOT NULL,
  `attr_1` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `attr_2` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `attr_3` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `attr_4` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `attr_5` mediumint(8) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`battleground_id`,`character_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quest_tracker`
--
DROP TABLE IF EXISTS `quest_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_tracker` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `character_guid` int(10) unsigned NOT NULL DEFAULT 0,
  `quest_accept_time` datetime NOT NULL,
  `quest_complete_time` datetime DEFAULT NULL,
  `quest_abandon_time` datetime DEFAULT NULL,
  `completed_by_gm` tinyint(1) NOT NULL DEFAULT 0,
  `core_hash` varchar(120) NOT NULL DEFAULT '0',
  `core_revision` varchar(120) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saved_variables`
--

DROP TABLE IF EXISTS `saved_variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_variables` (
  `NextArenaPointDistributionTime` bigint(40) unsigned NOT NULL DEFAULT 0,
  `NextDailyQuestResetTime` bigint(40) unsigned NOT NULL DEFAULT 0,
  `NextWeeklyQuestResetTime` bigint(40) unsigned NOT NULL DEFAULT 0,
  `NextMonthlyQuestResetTime` bigint(40) unsigned NOT NULL DEFAULT 0,
  `NextRandomBGResetTime` bigint(40) unsigned NOT NULL DEFAULT 0,
  `cleaning_flags` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The flags controlling character cleanup.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Variable Saves';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warden_action`
--

DROP TABLE IF EXISTS `warden_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warden_action` (
  `wardenId` smallint(5) unsigned NOT NULL,
  `action` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`wardenId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `world`
--

DROP TABLE IF EXISTS `world`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `world` (
  `map` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'The map ID (See Map.dbc)',
  `data` longtext DEFAULT NULL COMMENT 'Specific data belonging to the world.',
  PRIMARY KEY (`map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
