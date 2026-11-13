-- ---------------------------------------- 
-- --        CLEAR DOWN THE TABLE        -- 
-- ---------------------------------------- 
TRUNCATE TABLE `spell_bonus_data`; 
-- ---------------------------------------- 
-- MySQL dump 10.13  Distrib 5.5.37, for Win32 (x86)
--
-- Host: localhost    Database: mangos3
-- ------------------------------------------------------
-- Server version	11.5.2-MariaDB

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
-- Dumping data for table `spell_bonus_data`
--

LOCK TABLES `spell_bonus_data` WRITE;
/*!40000 ALTER TABLE `spell_bonus_data` DISABLE KEYS */;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES 
(17,0.87,0,0,0,'Power Word: Shield - absorb 0.87*SP'),
(543,0.807,0,0,0,'Mage Ward - absorb 0.807*SPA'),
(703,0,0,0,0.07,'Garrote - attack power'),
(879,0.15,0,0.15,0,'Exorcism - attack power'),
(1463,0.807,0,0,0,'Mana Shield - absorb 0.807*SPA'),
(1776,0,0,0.21,0,'Gouge - attack power'),
(1822,0,0,0,0.06,'Rake - attack power'),
(1978,0,0,0,0.04,'Serpent Sting - attack power'),
(2812,0.61,0,0.07,0,'Holy Wrath - attack power; override 0.61*SPH'),
(2818,0,0,0,0.03,'Deadly Poison - attack power'),
(3044,0,0,0.15,0,'Arcane Shot - attack power'),
(3110,0.657,0,0,0,'Firebolt - override 0.657*pet SP'),
(3674,0,0,0,0.02,'Black Arrow - attack power'),
(3716,0.512,0,0,0,'Torment - override 0.512*pet SP'),
(6229,0.807,0,0,0,'Shadow Ward - absorb 0.807*SP'),
(6360,0.85,0,0,0,'Whiplash - override 0.85*pet SP'),
(7001,0,0.308,0,0,'Lightwell Renew - override 0.308*SP per tick'),
(7814,0.612,0,0,0,'Lash of Pain - override 0.612*pet SP'),
(8680,0,0,0.1,0,'Instant Poison - attack power'),
(9007,0,0,0,0.03,'Pounce Bleed - attack power'),
(11426,0.87,0,0,0,'Ice Barrier - absorb 0.87*SPFR'),
(13218,0,0,0.04,0,'Wound Poison - attack power'),
(13797,0,0,0,0.02,'Immolation Trap - attack power'),
(13812,0,0,0.1,0.1,'Explosive Trap - attack power'),
(19306,0,0,0.2,0,'Counterattack - attack power'),
(20925,0.09,0,0.056,0,'Holy Shield - attack power'),
(25742,0.07,0,0.039,0,'Seal of Righteousness - attack power'),
(33745,0,0,0.01,0.01,'Lacerate - attack power'),
(42463,0,0,0.003,0,'Seal of Truth - attack power'),
(45477,0,0,0.1,0,'Icy Touch - attack power'),
(47476,0,0,0.06,0,'Strangulate - attack power'),
(47632,0,0,0.15,0,'Death Coil damage - attack power'),
(47633,0,0,0.15,0,'Death Coil heal - attack power'),
(48181,0.6971,0,0,0,'Haunt - override 0.5577*1.25*SP'),
(48721,0,0,0.04,0,'Blood Boil - attack power'),
(49184,0,0,0.2,0,'Howling Blast - attack power'),
(50536,0,0,0,0.013,'Unholy Blight - attack power'),
(50842,0,0,0.04,0,'Pestilence - attack power'),
(52212,0,0,0.0475,0,'Death and Decay - attack power'),
(54049,1.228,0,0,0,'Shadow Bite - override 1.228*pet SP'),
(55078,0,0,0,0.06325,'Blood Plague - attack power'),
(55095,0,0,0,0.06325,'Frost Fever - attack power'),
(60089,0,0,0.15,0,'Faerie Fire (Feral) - attack power'),
(91711,0.807,0,0,0,'Nether Ward - absorb 0.807*SP'),
(96263,0,0,2.8,0,'Sacred Shield - absorb 2.8*AP');
/*!40000 ALTER TABLE `spell_bonus_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-31 20:17:07
