-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Nov 26, 2024 at 02:11 AM
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
                                                                                                                       ('VN102', 'Scheduled', '2024-12-07 03:00:00', '2024-12-07 07:00:00', 'HAN', 'SGN', '2024-12-07 02:30:00', 'A380'),
                                                                                                                       ('VN103', 'Scheduled', '2024-12-08 15:00:00', '2024-12-08 23:00:00', 'HAN', 'SGN', '2024-12-08 14:30:00', 'A380');

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
                                                                              ('VN103', 'A380', '20B', NULL),
                                                                              ('VN101', 'B787', '20B', 'T328760'),
                                                                              ('VN101', 'B787', '20A', 'T372183');

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
                                                                                                                                          ('P002', 'Jane', 'Smith', '1990-03-15', 'F', 'janesmith@example.com', '987654321', 'C98765432', '987654321098', NULL),
                                                                                                                                          ('P16444', 'Jane', 'Doe', '2015-05-01', 'F', NULL, NULL, NULL, NULL, 'P001');

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

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`TicketID`, `FlightID`, `AircraftID`, `SeatNo`, `PassID`, `CancellationDeadline`) VALUES
                                                                                                            ('T328760', 'VN101', 'B787', '20B', 'P16444', '2024-12-05 08:00:00'),
                                                                                                            ('T372183', 'VN101', 'B787', '20A', 'P001', '2024-12-05 08:00:00');

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
                                                                 ('Economy', 'VN103', 50.00),
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
                         `Password` varchar(255) NOT NULL,
                         `Role` varchar(255) NOT NULL DEFAULT 'User'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `Password`, `Role`) VALUES
                                                                   ('U1N7G5543', 'user1', '$2b$10$SpOxbY/QtUOAU2mwlYUaEuSTS4LfttYXNfnUn1SVLeH.0GLIzfNIa', 'User'),
                                                                   ('UR77N9869', 'user', '$2b$10$ujfhCCYo30pvnSaw6SXEjeim0FNDqG2FxksXOnTwjk15NcNMUihLa', 'User'),
                                                                   ('UWXV18946', 'admin', '$2b$10$bEuWOizrEX3Ex5xTqDWdVueXrvrkZuFIA6jPMKeunAIgbybNpwBxK', 'admin');

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
  ADD UNIQUE KEY `Username` (`Username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
    ADD CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`),
  ADD CONSTRAINT `flight_ibfk_10` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_100` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_101` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_102` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_103` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_104` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_105` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_106` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_107` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_108` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_109` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_11` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_110` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_111` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_112` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_113` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_114` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_115` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_116` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_117` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_118` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_119` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_12` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_120` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_121` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_122` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_123` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_124` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_125` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_126` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_127` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_128` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_129` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_13` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_130` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_131` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_132` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_133` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_134` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_135` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_136` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_137` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_138` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_139` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_14` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_140` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_141` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_142` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_143` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_144` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_145` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_146` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_147` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_148` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_149` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_15` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_150` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_151` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_152` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_153` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_154` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_155` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_156` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_157` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_158` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_159` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_16` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_160` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_161` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_162` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_163` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_164` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_165` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_166` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_167` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_168` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_169` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_17` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_170` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_171` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_172` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_173` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_174` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_175` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_176` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_177` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_178` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_179` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_18` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_180` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_181` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_182` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_183` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_184` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_185` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_186` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_187` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_188` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_189` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_19` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_190` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_191` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_192` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_193` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_194` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_195` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_196` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_197` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_198` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_199` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`),
  ADD CONSTRAINT `flight_ibfk_20` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_200` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_201` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_202` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_203` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_204` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_205` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_206` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_207` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_208` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_209` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_21` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_210` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_211` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_212` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_213` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_214` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_215` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_216` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_217` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_218` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_219` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_22` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_220` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_221` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_222` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_223` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_224` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_225` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_226` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_227` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_228` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_229` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_23` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_230` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_231` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_232` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_233` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_234` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_235` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_236` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_237` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_238` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_239` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_24` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_240` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_241` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_242` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_243` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_244` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_245` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_246` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_247` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_248` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_249` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_25` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_250` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_251` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_252` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_253` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_254` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_255` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_256` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_257` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_258` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_259` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_26` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_260` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_261` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_262` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_263` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_264` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_265` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_266` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_267` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_268` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_269` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_27` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_270` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_271` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_272` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_273` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_274` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_275` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_276` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_277` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_278` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_279` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_28` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_280` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_281` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_282` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_283` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_284` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_285` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_286` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_287` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_288` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
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
  ADD CONSTRAINT `flight_ibfk_76` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_77` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_78` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_79` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_8` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_80` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_81` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_82` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_83` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_84` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_85` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_86` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_87` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_88` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_89` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_9` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_90` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_91` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_92` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_93` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_94` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_95` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_96` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_97` FOREIGN KEY (`DepID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_98` FOREIGN KEY (`DestID`) REFERENCES `airport` (`AirportID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_99` FOREIGN KEY (`AircraftID`) REFERENCES `aircraft` (`AircraftID`) ON DELETE NO ACTION ON UPDATE CASCADE;

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
  ADD CONSTRAINT `flightseat_ibfk_27` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_28` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_29` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_3` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_30` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_31` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_32` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_33` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_34` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_35` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_36` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_37` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_38` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_39` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_4` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_40` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_41` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_42` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_43` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_44` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_45` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_46` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_47` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_48` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_49` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_5` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_50` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_51` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_52` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_53` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_54` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_55` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_56` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_57` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_58` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_59` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_6` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_60` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_61` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_62` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_63` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_64` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_65` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_66` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_67` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_68` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_69` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_7` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_70` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_71` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_72` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_73` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_74` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_75` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_76` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_77` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_78` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_79` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_8` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_80` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_81` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_82` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_83` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_84` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_85` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_86` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_87` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_88` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_89` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_9` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_90` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_91` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_92` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_93` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_94` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_95` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_96` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `flightseat_ibfk_97` FOREIGN KEY (`TicketID`) REFERENCES `ticket` (`TicketID`) ON DELETE SET NULL ON UPDATE CASCADE;

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
  ADD CONSTRAINT `passenger_ibfk_26` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_27` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_28` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_29` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_3` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_30` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_31` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_32` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_33` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_34` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_35` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_36` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_37` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_38` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_39` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_4` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_40` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_41` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_42` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_43` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_44` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_45` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_46` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_47` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_48` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_49` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_5` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_50` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_51` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_52` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_53` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_54` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_55` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_56` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_57` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_58` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_59` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_6` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_60` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_61` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_62` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_63` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_64` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_65` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_66` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_67` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_68` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_69` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_7` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_70` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_71` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_72` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_73` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_74` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_75` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_76` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_77` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_78` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_79` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_8` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_80` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_81` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_82` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_83` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_84` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_85` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_86` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_87` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_88` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_89` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_9` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_90` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_91` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_92` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_93` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_94` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_95` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_ibfk_96` FOREIGN KEY (`GuardianID`) REFERENCES `passenger` (`PassID`) ON DELETE SET NULL ON UPDATE CASCADE;

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
  ADD CONSTRAINT `ticket_ibfk_100` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_101` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_102` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_103` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_104` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_105` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_106` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_107` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_108` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_109` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_11` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_110` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_111` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_112` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_113` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_114` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_115` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_116` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_117` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_118` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_119` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_12` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_120` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_121` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_122` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_123` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_124` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_125` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_126` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_127` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_128` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_129` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_13` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_130` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_131` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_132` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_133` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_134` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_135` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_136` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_137` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_138` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_139` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_14` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_140` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_141` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_142` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_143` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_144` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_145` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_146` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_147` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_148` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_149` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_15` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_150` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_151` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_152` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_153` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_154` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_155` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_156` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_157` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_158` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_159` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_16` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_160` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_161` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_162` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_163` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_164` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_165` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_166` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_167` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_168` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_169` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_17` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_170` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_171` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_172` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_173` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_174` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_175` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_176` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_177` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_178` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_179` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_18` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_180` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_181` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_182` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_183` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_184` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_185` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_186` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_187` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_188` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_189` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_19` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_190` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_191` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_192` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_193` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
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
  ADD CONSTRAINT `ticket_ibfk_52` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_53` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_54` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_55` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_56` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_57` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_58` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_59` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_6` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_60` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_61` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_62` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_63` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_64` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_65` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_66` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_67` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_68` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_69` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_7` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_70` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_71` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_72` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_73` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_74` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_75` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_76` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_77` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_78` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_79` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_8` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_80` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_81` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_82` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_83` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_84` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_85` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_86` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_87` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_88` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_89` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_9` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_90` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_91` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_92` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_93` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_94` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_95` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_96` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_97` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_98` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_99` FOREIGN KEY (`PassID`) REFERENCES `passenger` (`PassID`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `ticketclass`
--
ALTER TABLE `ticketclass`
    ADD CONSTRAINT `ticketclass_ibfk_1` FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
