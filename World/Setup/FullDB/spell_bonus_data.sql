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
(1822,0,0,0.147,0.147,'Rake - AP*0.147, AP*0.441 over 3 ticks; Wowhead 2012-03-03'),
(1978,0,0,0,0.08,'Serpent Sting - RAP*0.4 over 5 ticks; Wowhead 2012-03-05'),
(2812,0.61,0,0,0,'Holy Wrath - 0.61*SPH; Wowhead 2012-05-12'),
(3044,0,0,0.0483,0,'Arcane Shot - RAP*0.0483; Wowhead 2012-02-26'),
(3110,0.657,0,0,0,'Firebolt - override 0.657*pet SP'),
(3716,0.512,0,0,0,'Torment - override 0.512*pet SP'),
(6229,0.807,0,0,0,'Shadow Ward - absorb 0.807*SP'),
(6360,0.85,0,0,0,'Whiplash - override 0.85*pet SP'),
(6807,0,0,0.19,0,'Maul - AP*0.19; Wowhead 2012-05-12'),
(7001,0,0.308,0,0,'Lightwell Renew - override 0.308*SP per tick'),
(7814,0.612,0,0,0,'Lash of Pain - override 0.612*pet SP'),
(11426,0.87,0,0,0,'Ice Barrier - absorb 0.87*SPFR'),
(13797,0,0,0,0.02,'Immolation Trap - attack power'),
(19306,0,0,0.2,0,'Counterattack - attack power'),
(19434,0,0,0.724,0,'Aimed Shot - RAP*0.724; Wowhead 2012-05-12'),
(20187,0,0,0.2,0,'Judgement of Righteousness - 1+0.2*AP+0.32*SPH; Wowhead 2011-01-28'),
(33110,0.318,0,0,0,'Prayer of Mending heal - override 0.318*SP'),
(33745,0,0,0.0552,0.00369,'Lacerate - AP*0.0552, 5*(m1+AP*0.00369) over 5 ticks; Wowhead 2012-05-03'),
(45477,0,0,0.2,0,'Icy Touch - AP*0.2; Wowhead 2012-05-11'),
(45524,0,0,0.08,0,'Chains of Ice - glyph: m3+0.08*AP; Wowhead 2012-05-09'),
(47632,0,0,0.23,0,'Death Coil damage - m1+0.23*AP; Wowhead 2012-01-28'),
(47633,0,0,0.805,0,'Death Coil heal - (m1+0.23*AP)*3.5; Wowhead 2012-01-28'),
(48181,0.6971,0,0,0,'Haunt - override 0.5577*1.25*SP'),
(48721,0,0,0.08,0,'Blood Boil - m1+0.08*AP; Wowhead 2012-03-20'),
(49184,0,0,0.44,0,'Howling Blast - AP*0.44; Wowhead 2012-02-28'),
(53209,0,0,0.732,0,'Chimera Shot - RAP*0.732; Wowhead 2012-05-03'),
(53301,0,0,0,0.273,'Explosive Shot - RAP*0.273 per blast; Wowhead 2012-05-12'),
(54049,1.228,0,0,0,'Shadow Bite - override 1.228*pet SP'),
(55078,0,0,0,0.06325,'Blood Plague - attack power'),
(55095,0,0,0,0.06325,'Frost Fever - attack power'),
(56641,0,0,0.021,0,'Steady Shot - RAP*0.021; Wowhead 2012-05-12'),
(77478,0.11,0,0,0,'Earthquake - 0.11*SPN per hit, 61882\'s text; Wowhead 2012-05-12'),
(77758,0,0,0.0982,0.0167,'Thrash - AP*0.0982, (AP*0.0167+m2)*3 over 3 ticks; Wowhead 2012-05-12'),
(77767,0,0,0.017,0,'Cobra Shot - RAP*0.017; Wowhead 2012-05-12'),
(82928,0,0,0.724,0,'Aimed Shot! - RAP*0.724; Wowhead 2012-05-22'),
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
