-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Nov 18, 2024 at 02:26 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qairline`
--

-- --------------------------------------------------------

--
-- Table structure for table `aircraft`
--

CREATE TABLE `aircraft` (
  `AircraftID` varchar(10) NOT NULL,
  `Model` varchar(50) NOT NULL,
  `Manufacturer` varchar(50) NOT NULL,
  `Capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aircraft`
--

INSERT INTO `aircraft` (`AircraftID`, `Model`, `Manufacturer`, `Capacity`) VALUES
('A380', 'Airbus A380', 'Airbus', 500),
('B777', 'Boeing 777', 'Boeing', 396),
('B787', 'Boeing 787 Dreamliner', 'Boeing', 242);

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `AirportID` char(3) NOT NULL,
  `AirportName` varchar(100) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `airport`
--

INSERT INTO `airport` (`AirportID`, `AirportName`, `City`, `Country`) VALUES
('HAN', 'Noi Bai International Airport', 'Hanoi', 'Vietnam'),
('JFK', 'John F. Kennedy International Airport', 'New York', 'USA'),
('LAX', 'Los Angeles International Airport', 'Los Angeles', 'USA'),
('NRT', 'Narita International Airport', 'Tokyo', 'Japan'),
('SGN', 'Tan Son Nhat International Airport', 'Ho Chi Minh City', 'Vietnam');

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE `flight` (
  `FlightID` varchar(10) NOT NULL,
  `Status` varchar(20) NOT NULL,
  `DepTime` datetime NOT NULL,
  `ArrTime` datetime NOT NULL,
  `DepID` char(3) NOT NULL,
  `DestID` char(3) NOT NULL,
  `BoardingTime` datetime NOT NULL,
  `AircraftID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flight`
--

INSERT INTO `flight` (`FlightID`, `Status`, `DepTime`, `ArrTime`, `DepID`, `DestID`, `BoardingTime`, `AircraftID`) VALUES
('VN100', 'Scheduled', '2024-12-08 03:00:00', '2024-12-08 07:00:00', 'HAN', 'SGN', '2024-12-08 02:30:00', 'B787'),
('VN101', 'Scheduled', '2024-12-08 08:00:00', '2024-12-08 12:00:00', 'SGN', 'HAN', '2024-12-08 07:30:00', 'B787'),
('VN102', 'Scheduled', '2024-12-09 03:00:00', '2024-12-09 07:00:00', 'HAN', 'LAX', '2024-12-09 02:30:00', 'A380'),
('VN103', 'Scheduled', '2024-12-17 15:00:00', '2024-12-17 23:00:00', 'LAX', 'HAN', '2024-12-17 14:30:00', 'A380');

-- --------------------------------------------------------

--
-- Table structure for table `flightseat`
--

CREATE TABLE `flightseat` (
  `FlightID` varchar(10) NOT NULL,
  `AircraftID` varchar(10) NOT NULL,
  `SeatNo` varchar(5) NOT NULL,
  `TicketID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flightseat`
--

INSERT INTO `flightseat` (`FlightID`, `AircraftID`, `SeatNo`, `TicketID`) VALUES
('VN100', 'B787', '10B', NULL),
('VN100', 'B787', '1A', NULL),
('VN100', 'B787', '1B', NULL),
('VN100', 'B787', '20A', NULL),
('VN100', 'B787', '20B', NULL),
('VN101', 'B787', '10A', NULL),
('VN101', 'B787', '10B', NULL),
('VN101', 'B787', '1A', NULL),
('VN101', 'B787', '1B', NULL),
('VN101', 'B787', '20A', NULL),
('VN101', 'B787', '20B', NULL),
('VN102', 'A380', '10A', NULL),
('VN102', 'A380', '10B', NULL),
('VN102', 'A380', '1A', NULL),
('VN102', 'A380', '1B', NULL),
('VN102', 'A380', '20A', NULL),
('VN102', 'A380', '20B', NULL),
('VN103', 'A380', '10A', NULL),
('VN103', 'A380', '10B', NULL),
('VN103', 'A380', '1A', NULL),
('VN103', 'A380', '1B', NULL),
('VN103', 'A380', '20A', NULL),
('VN103', 'A380', '20B', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `passenger`
--

CREATE TABLE `passenger` (
  `PassID` varchar(10) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` char(1) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `Passport` varchar(20) DEFAULT NULL,
  `SSN` char(12) DEFAULT NULL,
  `GuardianID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passenger`
--

INSERT INTO `passenger` (`PassID`, `FirstName`, `LastName`, `DOB`, `Gender`, `Email`, `PhoneNumber`, `Passport`, `SSN`, `GuardianID`) VALUES
('P001', 'John', 'Doe', '1985-07-23', 'M', 'johndoe@example.com', '123456789', 'B12345678', '123456789012', NULL),
('P002', 'Jane', 'Smith', '1990-03-15', 'F', 'janesmith@example.com', '987654321', 'C98765432', '987654321098', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `promotion`
--

CREATE TABLE `promotion` (
  `PromotionID` varchar(10) NOT NULL,
  `Content` text NOT NULL,
  `Title` varchar(100) NOT NULL,
  `Amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `promotion`
--

INSERT INTO `promotion` (`PromotionID`, `Content`, `Title`, `Amount`) VALUES
('PR001', '10% off on all economy tickets', 'Economy Discount', 10.00),
('PR002', '20% off on business tickets for round trips', 'Business Round Trip Discount', 20.00);

-- --------------------------------------------------------

--
-- Table structure for table `seat`
--

CREATE TABLE `seat` (
  `AircraftID` varchar(10) NOT NULL,
  `SeatNo` varchar(5) NOT NULL,
  `Class` enum('Economy','Business','First') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seat`
--

INSERT INTO `seat` (`AircraftID`, `SeatNo`, `Class`) VALUES
('A380', '10A', 'Business'),
('A380', '10B', 'Business'),
('A380', '1A', 'First'),
('A380', '1B', 'First'),
('A380', '20A', 'Economy'),
('A380', '20B', 'Economy'),
('B787', '10A', 'Business'),
('B787', '10B', 'Business'),
('B787', '1A', 'First'),
('B787', '1B', 'First'),
('B787', '20A', 'Economy'),
('B787', '20B', 'Economy');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `TicketID` varchar(10) NOT NULL,
  `FlightID` varchar(10) NOT NULL,
  `AircraftID` varchar(10) NOT NULL,
  `SeatNo` varchar(5) NOT NULL,
  `PassID` varchar(10) NOT NULL,
  `CancellationDeadline` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticketclass`
--

CREATE TABLE `ticketclass` (
  `ClassName` enum('Economy','Business','First') NOT NULL,
  `FlightID` varchar(10) NOT NULL,
  `Price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticketclass`
--

INSERT INTO `ticketclass` (`ClassName`, `FlightID`, `Price`) VALUES
('Economy', 'VN100', 100.00),
('Economy', 'VN101', 100.00),
('Economy', 'VN102', 700.00),
('Economy', 'VN103', 700.00),
('Business', 'VN100', 300.00),
('Business', 'VN101', 300.00),
('Business', 'VN102', 1000.00),
('Business', 'VN103', 1000.00),
('First', 'VN100', 500.00),
('First', 'VN101', 500.00),
('First', 'VN102', 1500.00),
('First', 'VN103', 1500.00);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` varchar(10) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `Role` enum('user','admin') NOT NULL DEFAULT 'user',
  `CreatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `PasswordHash`, `Role`, `CreatedAt`) VALUES
('U001', 'admin', 'hashed_password_for_admin', 'admin', '2024-11-02 03:52:57'),
('U002', 'john_doe', 'hashed_password_for_john', 'user', '2024-11-02 03:52:57'),
('U003', 'jane_smith', 'hashed_password_for_jane', 'user', '2024-11-02 03:52:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aircraft`
--
ALTER TABLE `aircraft`
  ADD PRIMARY KEY (`AircraftID`);

--
-- Indexes for table `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`AirportID`);

--
-- Indexes for table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`FlightID`),
  ADD KEY `DepID` (`DepID`),
  ADD KEY `DestID` (`DestID`),
  ADD KEY `AircraftID` (`AircraftID`);

--
-- Indexes for table `flightseat`
--
ALTER TABLE `flightseat`
  ADD PRIMARY KEY (`FlightID`,`AircraftID`,`SeatNo`),
  ADD KEY `AircraftID` (`AircraftID`,`SeatNo`),
  ADD KEY `TicketID` (`TicketID`);

--
-- Indexes for table `passenger`
--
ALTER TABLE `passenger`
  ADD PRIMARY KEY (`PassID`),
  ADD KEY `GuardianID` (`GuardianID`);

--
-- Indexes for table `promotion`
--
ALTER TABLE `promotion`
  ADD PRIMARY KEY (`PromotionID`);

--
-- Indexes for table `seat`
--
ALTER TABLE `seat`
  ADD PRIMARY KEY (`AircraftID`,`SeatNo`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`TicketID`),
  ADD KEY `FlightID` (`FlightID`,`AircraftID`,`SeatNo`),
  ADD KEY `PassID` (`PassID`);

--
-- Indexes for table `ticketclass`
--
ALTER TABLE `ticketclass`
  ADD PRIMARY KEY (`ClassName`,`FlightID`),
  ADD KEY `FlightID` (`FlightID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `Username_2` (`Username`),
  ADD UNIQUE KEY `Username_3` (`Username`),
  ADD UNIQUE KEY `Username_4` (`Username`),
  ADD UNIQUE KEY `Username_5` (`Username`),
  ADD UNIQUE KEY `Username_6` (`Username`),
  ADD UNIQUE KEY `Username_7` (`Username`),
  ADD UNIQUE KEY `Username_8` (`Username`),
  ADD UNIQUE KEY `Username_9` (`Username`),
  ADD UNIQUE KEY `Username_10` (`Username`),
  ADD UNIQUE KEY `Username_11` (`Username`),
  ADD UNIQUE KEY `Username_12` (`Username`),
  ADD UNIQUE KEY `Username_13` (`Username`),
  ADD UNIQUE KEY `Username_14` (`Username`),
  ADD UNIQUE KEY `Username_15` (`Username`),
  ADD UNIQUE KEY `Username_16` (`Username`),
  ADD UNIQUE KEY `Username_17` (`Username`),
  ADD UNIQUE KEY `Username_18` (`Username`),
  ADD UNIQUE KEY `Username_19` (`Username`),
  ADD UNIQUE KEY `Username_20` (`Username`),
  ADD UNIQUE KEY `Username_21` (`Username`),
  ADD UNIQUE KEY `Username_22` (`Username`),
  ADD UNIQUE KEY `Username_23` (`Username`),
  ADD UNIQUE KEY `Username_24` (`Username`),
  ADD UNIQUE KEY `Username_25` (`Username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`),
  ADD CONSTRAINT `flight_ibfk_10` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_11` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_12` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_13` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_14` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_15` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_16` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_17` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_18` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_19` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`),
  ADD CONSTRAINT `flight_ibfk_20` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_21` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_22` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_23` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_24` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_25` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_26` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_27` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_28` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_29` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`),
  ADD CONSTRAINT `flight_ibfk_30` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_31` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_32` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_33` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_34` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_35` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_36` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_37` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_38` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_39` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_40` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_41` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_42` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_43` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_44` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_45` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_46` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_47` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_48` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_49` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_5` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_50` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_51` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_52` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_53` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_54` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_55` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_56` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_57` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_58` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_59` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_6` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_60` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_61` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_62` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_63` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_64` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_65` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_66` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_67` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_68` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_69` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_7` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_70` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_71` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_72` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_73` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_74` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_75` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_8` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_9` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `flightseat`
--
ALTER TABLE `flightseat`
  ADD CONSTRAINT `flightseat_ibfk_1` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`),
  ADD CONSTRAINT `flightseat_ibfk_10` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_11` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_12` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_13` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_14` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_15` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_16` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_17` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_18` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_19` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_2` FOREIGN KEY (`AircraftID`,`SeatNo`) REFERENCES `seat` (`AircraftID`, `SeatNo`),
  ADD CONSTRAINT `flightseat_ibfk_20` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_21` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_22` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_23` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_24` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_25` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_26` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_3` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_4` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_5` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_6` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_7` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_8` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_9` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `passenger`
--
ALTER TABLE `passenger`
  ADD CONSTRAINT `passenger_ibfk_1` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`),
  ADD CONSTRAINT `passenger_ibfk_10` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_11` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_12` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_13` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_14` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_15` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_16` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_17` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_18` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_19` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_2` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_20` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_21` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_22` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_23` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_24` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_25` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_3` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_4` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_5` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_6` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_7` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_8` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_9` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `seat`
--
ALTER TABLE `seat`
  ADD CONSTRAINT `seat_ibfk_1` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`);

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`),
  ADD CONSTRAINT `ticket_ibfk_10` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_11` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_12` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_13` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_14` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_15` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_16` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_17` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_18` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_19` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`),
  ADD CONSTRAINT `ticket_ibfk_20` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_21` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_22` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_23` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_24` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_25` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_26` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_27` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_28` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_29` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_3` FOREIGN KEY (`FlightID`,`AircraftID`,`SeatNo`) REFERENCES `flightseat` (`FlightID`, `AircraftID`, `SeatNo`),
  ADD CONSTRAINT `ticket_ibfk_30` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_31` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_32` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_33` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_34` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_35` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_36` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_37` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_38` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_39` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_4` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_40` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_41` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_42` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_43` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_44` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_45` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_46` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_47` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_48` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_49` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_5` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_50` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_51` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_6` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_7` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_8` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_9` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `ticketclass`
--
ALTER TABLE `ticketclass`
  ADD CONSTRAINT `ticketclass_ibfk_1` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
