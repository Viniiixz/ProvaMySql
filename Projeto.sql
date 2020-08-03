-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.35-MariaDB


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema dpto_projeto
--

CREATE DATABASE IF NOT EXISTS dpto_projeto;
USE dpto_projeto;

--
-- Definition of table `dependente`
--

DROP TABLE IF EXISTS `dependente`;
CREATE TABLE `dependente` (
  `cd_dependente` int(11) NOT NULL,
  `nm_dependente` varchar(50) DEFAULT NULL,
  `nm_parentesco` char(15) DEFAULT NULL,
  PRIMARY KEY (`cd_dependente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dependente`
--

/*!40000 ALTER TABLE `dependente` DISABLE KEYS */;
INSERT INTO `dependente` (`cd_dependente`,`nm_dependente`,`nm_parentesco`) VALUES 
 (2763,'José Francisco Brito','pai'),
 (3322,'André Silva Marciel','filho'),
 (3768,'Leonardo Silva Marciel','filho'),
 (3776,'Mariana Lemos de Souza','filha'),
 (7316,'Leandro Silva Marciel','filho');
/*!40000 ALTER TABLE `dependente` ENABLE KEYS */;


--
-- Definition of table `dpto`
--

DROP TABLE IF EXISTS `dpto`;
CREATE TABLE `dpto` (
  `cd_dpto` int(11) NOT NULL,
  `nm_dpto` varchar(35) DEFAULT NULL,
  `nm_localizacao` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cd_dpto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dpto`
--

/*!40000 ALTER TABLE `dpto` DISABLE KEYS */;
INSERT INTO `dpto` (`cd_dpto`,`nm_dpto`,`nm_localizacao`) VALUES 
 (120,'Comercial','quadra B-01'),
 (211,'Jurídico','quadra A-13'),
 (231,'Financeiro','quadra A-25'),
 (456,'Tecnologia da informação','quadra A-31'),
 (466,'Recursos Humanos','quadra C-14'),
 (556,'Marketing','quadra A-12'),
 (560,'Presidência','quadra C-11');
/*!40000 ALTER TABLE `dpto` ENABLE KEYS */;


--
-- Definition of table `func`
--

DROP TABLE IF EXISTS `func`;
CREATE TABLE `func` (
  `cd_func` int(11) NOT NULL,
  `nm_func` varchar(50) DEFAULT NULL,
  `nm_endereco` varchar(60) DEFAULT NULL,
  `cd_telefone` char(9) DEFAULT NULL,
  `vl_salario` decimal(9,2) DEFAULT NULL,
  `cd_dpto` int(11) DEFAULT NULL,
  `cd_dpto_gerenciar` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_func`),
  KEY `fk_func_dpto` (`cd_dpto`),
  KEY `fk_func_dpto_gerenciar` (`cd_dpto_gerenciar`),
  CONSTRAINT `fk_func_dpto` FOREIGN KEY (`cd_dpto`) REFERENCES `dpto` (`cd_dpto`),
  CONSTRAINT `fk_func_dpto_gerenciar` FOREIGN KEY (`cd_dpto_gerenciar`) REFERENCES `dpto` (`cd_dpto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `func`
--

/*!40000 ALTER TABLE `func` DISABLE KEYS */;
INSERT INTO `func` (`cd_func`,`nm_func`,`nm_endereco`,`cd_telefone`,`vl_salario`,`cd_dpto`,`cd_dpto_gerenciar`) VALUES 
 (105462221,'Marcos Antonio da Silva','Jundiaí','319786874','980.00',456,NULL),
 (298456511,'Vanessa Brito','Sorocaba','312678904','950.00',466,NULL),
 (398569902,'Adilson Fernandez Souza','São Paulo','314220065','4500.00',231,231),
 (908562514,'Fernando Marciel','Santo André','318907654','2500.00',456,NULL),
 (1002225623,'Olivia de Paula Brito','São Paulo','314430089','1200.00',556,NULL);
/*!40000 ALTER TABLE `func` ENABLE KEYS */;


--
-- Definition of table `func_dependente`
--

DROP TABLE IF EXISTS `func_dependente`;
CREATE TABLE `func_dependente` (
  `cd_func` int(11) NOT NULL DEFAULT '0',
  `cd_dependente` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cd_func`,`cd_dependente`),
  KEY `fk_func_dependente_dependente` (`cd_dependente`),
  CONSTRAINT `fk_func_dependente_dependente` FOREIGN KEY (`cd_dependente`) REFERENCES `dependente` (`cd_dependente`),
  CONSTRAINT `fk_func_dependente_func` FOREIGN KEY (`cd_func`) REFERENCES `func` (`cd_func`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `func_dependente`
--

/*!40000 ALTER TABLE `func_dependente` DISABLE KEYS */;
INSERT INTO `func_dependente` (`cd_func`,`cd_dependente`) VALUES 
 (105462221,3768),
 (105462221,3776),
 (298456511,2763),
 (398569902,2763),
 (908562514,3322),
 (908562514,7316);
/*!40000 ALTER TABLE `func_dependente` ENABLE KEYS */;


--
-- Definition of table `func_projeto`
--

DROP TABLE IF EXISTS `func_projeto`;
CREATE TABLE `func_projeto` (
  `cd_func` int(11) NOT NULL DEFAULT '0',
  `cd_projeto` int(11) NOT NULL DEFAULT '0',
  `qt_hora` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`cd_func`,`cd_projeto`),
  KEY `fk_func_projeto_projeto` (`cd_projeto`),
  CONSTRAINT `fk_func_projeto_func` FOREIGN KEY (`cd_func`) REFERENCES `func` (`cd_func`),
  CONSTRAINT `fk_func_projeto_projeto` FOREIGN KEY (`cd_projeto`) REFERENCES `projeto` (`cd_projeto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `func_projeto`
--

/*!40000 ALTER TABLE `func_projeto` DISABLE KEYS */;
INSERT INTO `func_projeto` (`cd_func`,`cd_projeto`,`qt_hora`) VALUES 
 (105462221,21,30),
 (105462221,47,20),
 (298456511,46,48),
 (398569902,56,81),
 (908562514,12,99),
 (908562514,56,92);
/*!40000 ALTER TABLE `func_projeto` ENABLE KEYS */;


--
-- Definition of table `projeto`
--

DROP TABLE IF EXISTS `projeto`;
CREATE TABLE `projeto` (
  `cd_projeto` int(11) NOT NULL,
  `nm_projeto` varchar(30) DEFAULT NULL,
  `nm_tipo` varchar(25) DEFAULT NULL,
  `nm_verbba` varchar(25) DEFAULT NULL,
  `cd_dpto` int(11) DEFAULT NULL,
  `cd_cpf_func` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_projeto`),
  KEY `fk_projeto_dpto` (`cd_dpto`),
  CONSTRAINT `fk_projeto_dpto` FOREIGN KEY (`cd_dpto`) REFERENCES `dpto` (`cd_dpto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projeto`
--

/*!40000 ALTER TABLE `projeto` DISABLE KEYS */;
INSERT INTO `projeto` (`cd_projeto`,`nm_projeto`,`nm_tipo`,`nm_verbba`,`cd_dpto`,`cd_cpf_func`) VALUES 
 (12,'D3RE','integral - 1 ano','5 bolsas integrais',211,NULL),
 (21,'XR3','integral - 5 anos','5 bolsas integrais',456,NULL),
 (46,'X3','parcial - 2 anos','não determinada',456,NULL),
 (47,'Beta','parcial - 2 anos','5 bolsas integrais',556,NULL),
 (56,'Alfa','integral - 2 anos','5 bolsas integrais',556,NULL);
/*!40000 ALTER TABLE `projeto` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
