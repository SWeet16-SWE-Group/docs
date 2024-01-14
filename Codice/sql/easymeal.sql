-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql:3306
-- Generation Time: Jan 14, 2024 at 04:39 PM
-- Server version: 8.2.0
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `easymeal`
--

DROP DATABASE IF EXISTS `easymeal`;
CREATE DATABASE `easymeal`;
USE `easymeal`;

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `ID_cliente` int NOT NULL,
  `Username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Orario_creazione` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`ID_cliente`, `Username`, `Email`, `Password`, `Orario_creazione`) VALUES
(1, 'Pasta', 'pasta@gmail.com', 'pasta6', '2023-12-15 09:00:56'),
(2, 'Albero', 'albero@gmail.com', 'albero55', '2023-12-22 08:57:07'),
(3, 'Patata', 'patata@gmail.com', 'patatadolce', '2023-12-22 08:57:32'),
(4, 'Lollo', 'lollo@icloud.com', 'Sonolollo', '2024-01-07 12:02:53'),
(5, 'Biscotto', 'bisc@hotmail.com', 'Gnammy', '2024-01-07 12:02:53');

-- --------------------------------------------------------

--
-- Table structure for table `commento`
--

CREATE TABLE `commento` (
  `ID_commento` int NOT NULL,
  `Commento` varchar(500) NOT NULL,
  `Id_cliente` int NOT NULL,
  `Id_prodotto` int NOT NULL,
  `Orario` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `ordine`
--

CREATE TABLE `ordine` (
  `ID_ordine` int NOT NULL,
  `Id_cliente` int NOT NULL,
  `Id_tavolo` int NOT NULL,
  `Orario` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Id_prodotto` int NOT NULL,
  `Quantita` int NOT NULL DEFAULT '1',
  `Id_ristorante` int NOT NULL,
  `Totale` decimal(10,2) NOT NULL,
  `Note` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Pagamento` set('Non pagato','Pagato') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Preparazione` set('Da fare','In preparazione','Prodotto') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pagamento`
--

CREATE TABLE `pagamento` (
  `ID_pagamento` int NOT NULL,
  `Id_cliente` int NOT NULL,
  `Id_prenotazione` int NOT NULL,
  `Orario` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Ordinazione` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Id_ristorante` int NOT NULL,
  `Importo` decimal(10,2) NOT NULL,
  `Metodo` set('Cassa','Carta','Paypal','') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Status` set('Effettuato','Non effettuato') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prenotazione`
--

CREATE TABLE `prenotazione` (
  `ID_prenotazione` int NOT NULL,
  `Id_cliente` int NOT NULL,
  `Id_tavolo` int NOT NULL,
  `Id_ristorante` int NOT NULL,
  `Codice` varchar(30) NOT NULL,
  `Num_persone` int NOT NULL,
  `Partecipanti` varchar(500) NOT NULL,
  `Data_prenotazione` date NOT NULL,
  `Orario_arrivo` time NOT NULL,
  `Orario_partenza` time NOT NULL,
  `Orario_prenotazione` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Stato` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `prenotazione`
--

INSERT INTO `prenotazione` (`ID_prenotazione`, `Id_cliente`, `Id_tavolo`, `Id_ristorante`, `Codice`, `Num_persone`, `Partecipanti`, `Data_prenotazione`, `Orario_arrivo`, `Orario_partenza`, `Orario_prenotazione`, `Stato`) VALUES
(39, 1, 4, 1, '', 5, 'Lollo,Pasta', '2024-01-11', '19:00:00', '21:00:00', '2024-01-10 21:42:23', 1),
(40, 1, 4, 1, '', 5, 'Pappa,Pasta', '2024-01-15', '19:00:00', '21:00:00', '2024-01-10 21:42:23', NULL),
(41, 1, 4, 1, '', 5, 'Albero,Patata,Pasta', '2024-01-12', '19:00:00', '21:00:00', '2024-01-10 21:42:23', 0),
(42, 1, 4, 1, '', 5, 'Biscotto,Pasta,Lollo', '2024-01-10', '19:00:00', '21:00:00', '2024-01-10 21:42:23', NULL),
(43, 1, 4, 2, '', 5, 'Pappa,Pasta', '2024-01-10', '19:00:00', '21:00:00', '2024-01-10 21:42:23', NULL),
(44, 1, 4, 3, '', 5, 'Pappa,Pasta', '2024-01-10', '19:00:00', '21:00:00', '2024-01-10 21:42:23', NULL),
(45, 1, 4, 3, '', 5, 'Pappa,Pasta', '2024-01-13', '19:00:00', '21:00:00', '2024-01-10 21:42:23', NULL),
(46, 1, 4, 1, '', 5, 'Biscotto,Pasta,Lollo', '2024-01-14', '19:00:00', '21:00:00', '2024-01-10 21:42:23', 0),
(47, 1, 4, 1, '', 5, 'Pappa,Pasta', '2024-01-15', '19:00:00', '21:00:00', '2024-01-10 21:42:23', 1);

-- --------------------------------------------------------

--
-- Table structure for table `prodotto`
--

CREATE TABLE `prodotto` (
  `ID_prodotto` int NOT NULL,
  `Nome` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Descrizione` varchar(5000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Prezzo` decimal(10,2) NOT NULL,
  `Categoria` set('Antipasto','Primo','Secondo','Contorno','Dessert','Bevanda') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Codice` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Ingredienti` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Allergeni` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Immagine` longblob,
  `Nome_Immagine` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Immagine_2` longblob,
  `Nome_Immagine_2` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Immagine_3` longblob,
  `Nome_Immagine_3` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Immagine_4` longblob,
  `Nome_Immagine_4` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Immagine_5` longblob,
  `Nome_Immagine_5` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Id_ristorante` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `registro_cliente`
--

CREATE TABLE `registro_cliente` (
  `ID_accesso_cliente` int NOT NULL,
  `Id_cliente` int NOT NULL,
  `Orario` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `registro_utente`
--

CREATE TABLE `registro_utente` (
  `ID_accesso_utente` int NOT NULL,
  `Id_utente` int NOT NULL,
  `Orario` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ristorante`
--

CREATE TABLE `ristorante` (
  `ID_ristorante` int NOT NULL,
  `Ragione_sociale` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Indirizzo` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `CAP` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Citta` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Provincia` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Partita_iva` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Telefono` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Sito_internet` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Classificazione` set('Bistrot','Bar','Pub','Fast food','Trattoria','Osteria','Ristorante','Pizzeria','Ristorante-Pizzeria','Ristorante etnico','Sagra') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Descrizione` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Coperto` decimal(10,2) DEFAULT NULL,
  `Orario_apertura_mat` time NOT NULL,
  `Orario_chiusura_mat` time NOT NULL,
  `Orario_apertura_pom` time NOT NULL,
  `Orario_chiusura_pom` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `ristorante`
--

INSERT INTO `ristorante` (`ID_ristorante`, `Ragione_sociale`, `Indirizzo`, `CAP`, `Citta`, `Provincia`, `Partita_iva`, `Telefono`, `Email`, `Sito_internet`, `Classificazione`, `Descrizione`, `Coperto`, `Orario_apertura_mat`, `Orario_chiusura_mat`, `Orario_apertura_pom`, `Orario_chiusura_pom`) VALUES
(1, 'Antica Osteria Romana', 'Via Roma, 16', '00042', 'Roma', 'Roma', '01223580554 ', '06 77071658', 'anticaosteriaromana@gmail.com', 'http://anticaosteriaromana.it', 'Osteria', 'Descrizione Antica Osteria Romana', 2.00, '12:00:00', '15:00:00', '19:00:00', '22:00:00'),
(2, 'Il Gabbiano', 'Via dei santi, 3', '72100', 'Brindisi', 'Brindisi', '01223580772 ', '351 936 3719', 'ilgabbiano@gmail.com', 'http://ilgabbiano.it', 'Ristorante-Pizzeria', 'Descrizione Il Gabbiano', 2.00, '12:00:00', '15:30:00', '18:30:00', '23:00:00'),
(3, 'Ristorante Galleria', 'Galleria Vittorio Emanuele II, 75', '20121', 'Milano', 'Milano', '01223580222 ', '02 8646 4912', 'info@ristorantegalleria.it', 'https://ristorantegalleria.it', 'Ristorante', 'Descrizione Ristorante Galleria', 4.00, '12:00:00', '14:00:00', '18:30:00', '22:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `tavolo`
--

CREATE TABLE `tavolo` (
  `ID_tavolo` int NOT NULL,
  `Codice` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Num_posti` int NOT NULL,
  `Data_prenotazione` date DEFAULT NULL,
  `Orario_arrivo` time DEFAULT NULL,
  `Orario_partenza` time DEFAULT NULL,
  `Id_ristorante` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `tavolo`
--

INSERT INTO `tavolo` (`ID_tavolo`, `Codice`, `Num_posti`, `Data_prenotazione`, `Orario_arrivo`, `Orario_partenza`, `Id_ristorante`) VALUES
(1, 'P001', 3, NULL, NULL, NULL, 1),
(2, 'P002', 4, NULL, NULL, NULL, 1),
(3, 'P003', 5, NULL, NULL, NULL, 1),
(4, 'G001', 3, NULL, NULL, NULL, 2),
(5, 'G002', 4, NULL, NULL, NULL, 2),
(6, 'G003', 5, NULL, NULL, NULL, 2),
(7, 'R001', 2, NULL, NULL, NULL, 3),
(8, 'R002', 4, NULL, NULL, NULL, 3),
(9, 'R003', 6, NULL, NULL, NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `utente`
--

CREATE TABLE `utente` (
  `ID_utente` int NOT NULL,
  `Username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Password` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Ora_creazione` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Ruolo` set('Amministratore','Dipendente') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Id_ristorante` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `voto`
--

CREATE TABLE `voto` (
  `ID_voto` int NOT NULL,
  `Id_cliente` int NOT NULL,
  `Valutazione` tinyint(1) NOT NULL,
  `Id_prodotto` int NOT NULL,
  `Orario` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`ID_cliente`);

--
-- Indexes for table `commento`
--
ALTER TABLE `commento`
  ADD PRIMARY KEY (`ID_commento`),
  ADD KEY `commento_cliente` (`Id_cliente`),
  ADD KEY `commento_prodotto` (`Id_prodotto`) USING BTREE;

--
-- Indexes for table `ordine`
--
ALTER TABLE `ordine`
  ADD PRIMARY KEY (`ID_ordine`),
  ADD UNIQUE KEY `ordine_tavolo` (`Id_tavolo`) USING BTREE,
  ADD KEY `ordine_ristorante` (`Id_ristorante`),
  ADD KEY `ordine_cliente` (`Id_cliente`),
  ADD KEY `ordine_prodotto` (`Id_prodotto`) USING BTREE;

--
-- Indexes for table `pagamento`
--
ALTER TABLE `pagamento`
  ADD PRIMARY KEY (`ID_pagamento`),
  ADD UNIQUE KEY `pagamento_tavolo` (`Id_prenotazione`),
  ADD KEY `pagamento_cliente` (`Id_cliente`) USING BTREE,
  ADD KEY `pagamento_ristorante` (`Id_ristorante`) USING BTREE;

--
-- Indexes for table `prenotazione`
--
ALTER TABLE `prenotazione`
  ADD PRIMARY KEY (`ID_prenotazione`),
  ADD KEY `Prenotazione_tavolo` (`Id_tavolo`),
  ADD KEY `Prenotazione_cliente` (`Id_cliente`),
  ADD KEY `Prenotazione_ristorante` (`Id_ristorante`);

--
-- Indexes for table `prodotto`
--
ALTER TABLE `prodotto`
  ADD PRIMARY KEY (`ID_prodotto`),
  ADD KEY `prodotto_ristorante` (`Id_ristorante`) USING BTREE;

--
-- Indexes for table `registro_cliente`
--
ALTER TABLE `registro_cliente`
  ADD PRIMARY KEY (`ID_accesso_cliente`),
  ADD KEY `registro_cliente` (`Id_cliente`);

--
-- Indexes for table `registro_utente`
--
ALTER TABLE `registro_utente`
  ADD PRIMARY KEY (`ID_accesso_utente`),
  ADD KEY `registro_utente` (`Id_utente`);

--
-- Indexes for table `ristorante`
--
ALTER TABLE `ristorante`
  ADD PRIMARY KEY (`ID_ristorante`);

--
-- Indexes for table `tavolo`
--
ALTER TABLE `tavolo`
  ADD PRIMARY KEY (`ID_tavolo`),
  ADD KEY `tavolo_ristorante` (`Id_ristorante`);

--
-- Indexes for table `utente`
--
ALTER TABLE `utente`
  ADD PRIMARY KEY (`ID_utente`),
  ADD KEY `utente_ristorante` (`Id_ristorante`);

--
-- Indexes for table `voto`
--
ALTER TABLE `voto`
  ADD PRIMARY KEY (`ID_voto`),
  ADD KEY `voto_prodotto` (`Id_prodotto`) USING BTREE,
  ADD KEY `voto_cliente` (`Id_cliente`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `ID_cliente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `commento`
--
ALTER TABLE `commento`
  MODIFY `ID_commento` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ordine`
--
ALTER TABLE `ordine`
  MODIFY `ID_ordine` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pagamento`
--
ALTER TABLE `pagamento`
  MODIFY `ID_pagamento` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prenotazione`
--
ALTER TABLE `prenotazione`
  MODIFY `ID_prenotazione` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `prodotto`
--
ALTER TABLE `prodotto`
  MODIFY `ID_prodotto` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `registro_cliente`
--
ALTER TABLE `registro_cliente`
  MODIFY `ID_accesso_cliente` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `registro_utente`
--
ALTER TABLE `registro_utente`
  MODIFY `ID_accesso_utente` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ristorante`
--
ALTER TABLE `ristorante`
  MODIFY `ID_ristorante` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tavolo`
--
ALTER TABLE `tavolo`
  MODIFY `ID_tavolo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `utente`
--
ALTER TABLE `utente`
  MODIFY `ID_utente` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voto`
--
ALTER TABLE `voto`
  MODIFY `ID_voto` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `commento`
--
ALTER TABLE `commento`
  ADD CONSTRAINT `commento_cliente` FOREIGN KEY (`Id_cliente`) REFERENCES `cliente` (`ID_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commento_prodotto` FOREIGN KEY (`Id_prodotto`) REFERENCES `prodotto` (`ID_prodotto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ordine`
--
ALTER TABLE `ordine`
  ADD CONSTRAINT `ordine_cliente` FOREIGN KEY (`Id_cliente`) REFERENCES `cliente` (`ID_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ordine_prodotto` FOREIGN KEY (`Id_prodotto`) REFERENCES `prodotto` (`ID_prodotto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ordine_ristorante` FOREIGN KEY (`Id_ristorante`) REFERENCES `ristorante` (`ID_ristorante`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pagamento`
--
ALTER TABLE `pagamento`
  ADD CONSTRAINT `pagamento_cliente` FOREIGN KEY (`Id_cliente`) REFERENCES `cliente` (`ID_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pagamento_prenotazione` FOREIGN KEY (`Id_prenotazione`) REFERENCES `prenotazione` (`ID_prenotazione`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pagamento_ristorante` FOREIGN KEY (`Id_ristorante`) REFERENCES `ristorante` (`ID_ristorante`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prenotazione`
--
ALTER TABLE `prenotazione`
  ADD CONSTRAINT `Prenotazione_cliente` FOREIGN KEY (`Id_cliente`) REFERENCES `cliente` (`ID_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Prenotazione_ristorante` FOREIGN KEY (`Id_ristorante`) REFERENCES `ristorante` (`ID_ristorante`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Prenotazione_tavolo` FOREIGN KEY (`Id_tavolo`) REFERENCES `tavolo` (`ID_tavolo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prodotto`
--
ALTER TABLE `prodotto`
  ADD CONSTRAINT `prodotto_ristorante` FOREIGN KEY (`Id_ristorante`) REFERENCES `ristorante` (`ID_ristorante`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `registro_cliente`
--
ALTER TABLE `registro_cliente`
  ADD CONSTRAINT `registro_cliente` FOREIGN KEY (`Id_cliente`) REFERENCES `cliente` (`ID_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `registro_utente`
--
ALTER TABLE `registro_utente`
  ADD CONSTRAINT `registro_utente` FOREIGN KEY (`Id_utente`) REFERENCES `utente` (`ID_utente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tavolo`
--
ALTER TABLE `tavolo`
  ADD CONSTRAINT `tavolo_ristorante` FOREIGN KEY (`Id_ristorante`) REFERENCES `ristorante` (`ID_ristorante`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `utente`
--
ALTER TABLE `utente`
  ADD CONSTRAINT `utente_ristorante` FOREIGN KEY (`Id_ristorante`) REFERENCES `ristorante` (`ID_ristorante`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `voto`
--
ALTER TABLE `voto`
  ADD CONSTRAINT `voto_cliente` FOREIGN KEY (`Id_cliente`) REFERENCES `cliente` (`ID_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `voto_prodotto` FOREIGN KEY (`Id_prodotto`) REFERENCES `prodotto` (`ID_prodotto`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`%` EVENT `Delete_tavolo` ON SCHEDULE EVERY 1 HOUR STARTS '2024-01-06 16:03:34' ENDS '2034-01-06 16:03:34' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM tavolo WHERE Data_prenotazione <= CURRENT_DATE AND Orario_partenza < CURRENT_TIME$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
