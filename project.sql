-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 21, 2025 at 06:35 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `blank`
--

CREATE TABLE `blank` (
  `FBExerciseID` int(11) NOT NULL,
  `blankNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blankanswer`
--

CREATE TABLE `blankanswer` (
  `FBExerciseID` int(11) NOT NULL,
  `blankNumber` int(11) NOT NULL,
  `answer` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blanksuggestion`
--

CREATE TABLE `blanksuggestion` (
  `FBSuggestionID` int(11) NOT NULL,
  `blankNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blanksuggestionanswer`
--

CREATE TABLE `blanksuggestionanswer` (
  `FBSuggestionID` int(11) NOT NULL,
  `blankNumber` int(11) NOT NULL,
  `answer` varchar(500) NOT NULL,
  `explanation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `codingattempt`
--

CREATE TABLE `codingattempt` (
  `attemptID` int(11) NOT NULL,
  `codeBody` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `codingexercise`
--

CREATE TABLE `codingexercise` (
  `exerciseID` int(11) NOT NULL,
  `codeBody` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `codingexercise`
--

INSERT INTO `codingexercise` (`exerciseID`, `codeBody`) VALUES
(1, 'print()'),
(2, '');

-- --------------------------------------------------------

--
-- Table structure for table `codingsuggestion`
--

CREATE TABLE `codingsuggestion` (
  `suggestionID` int(11) NOT NULL,
  `codeBody` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `codingsuggestiontestcase`
--

CREATE TABLE `codingsuggestiontestcase` (
  `ID` int(11) NOT NULL,
  `codingSuggestionID` int(11) DEFAULT NULL,
  `input` text DEFAULT NULL,
  `expectedOutput` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `codingtestcase`
--

CREATE TABLE `codingtestcase` (
  `ID` int(11) NOT NULL,
  `codingExerciseID` int(11) DEFAULT NULL,
  `input` text DEFAULT NULL,
  `expectedOutput` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `codingtestcase`
--

INSERT INTO `codingtestcase` (`ID`, `codingExerciseID`, `input`, `expectedOutput`) VALUES
(1, 1, '', 'Hello, world!'),
(2, 2, '', 'Hi, mom!');

-- --------------------------------------------------------

--
-- Table structure for table `concept`
--

CREATE TABLE `concept` (
  `ID` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `moduleID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `concept`
--

INSERT INTO `concept` (`ID`, `name`, `moduleID`) VALUES
(1, 'Printing', 1);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `ID` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`ID`, `name`) VALUES
(1, 'Python'),
(2, 'Java');

-- --------------------------------------------------------

--
-- Table structure for table `endofmoduletest`
--

CREATE TABLE `endofmoduletest` (
  `ID` int(11) NOT NULL,
  `moduleID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exercise`
--

CREATE TABLE `exercise` (
  `ID` int(11) NOT NULL,
  `conceptID` int(11) DEFAULT NULL,
  `questionStatement` text NOT NULL,
  `codeBlock` varchar(3000) DEFAULT NULL,
  `diagram` varchar(3000) DEFAULT NULL,
  `audio` varchar(3000) DEFAULT NULL,
  `video` varchar(3000) DEFAULT NULL,
  `type` enum('e','p','eom') NOT NULL,
  `testID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exercise`
--

INSERT INTO `exercise` (`ID`, `conceptID`, `questionStatement`, `codeBlock`, `diagram`, `audio`, `video`, `type`, `testID`) VALUES
(1, 1, 'Complete the code to print \"Hello, world!\"', NULL, NULL, NULL, NULL, 'e', NULL),
(2, 1, 'Write the code to print \"Hi, mom!\".', NULL, NULL, NULL, NULL, 'p', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `exerciseusesconcept`
--

CREATE TABLE `exerciseusesconcept` (
  `exerciseID` int(11) NOT NULL,
  `conceptID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `explanation`
--

CREATE TABLE `explanation` (
  `ID` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `conceptID` int(11) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `diagram` varchar(3000) DEFAULT NULL,
  `audio` varchar(3000) DEFAULT NULL,
  `video` varchar(3000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `explanation`
--

INSERT INTO `explanation` (`ID`, `name`, `conceptID`, `text`, `diagram`, `audio`, `video`) VALUES
(1, 'Print Hello World', 1, 'Welcome to Python. Let us build our first program! We will build a program that outputs the statement \"Hello, world!\" to the console. In Python, you can print text as output using the print() function. We place the text we want to print inside the brackets. For example: print(\"Hello, world!\"). Note that the text must be inside quotation marks as well.', 'hello_world.png', NULL, NULL),
(2, 'First Steps', 1, 'Now it\'s your turn! Write the code that would print \"Hello, world!\" to the screen.', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fbexercise`
--

CREATE TABLE `fbexercise` (
  `exerciseID` int(11) NOT NULL,
  `explanation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fbsuggestion`
--

CREATE TABLE `fbsuggestion` (
  `suggestionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `interactiveexplanation`
--

CREATE TABLE `interactiveexplanation` (
  `explanationID` int(11) NOT NULL,
  `exerciseID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `interactiveexplanation`
--

INSERT INTO `interactiveexplanation` (`explanationID`, `exerciseID`) VALUES
(2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `learner`
--

CREATE TABLE `learner` (
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pwHash` varchar(2000) NOT NULL,
  `currentStreak` int(11) NOT NULL DEFAULT 0,
  `longestStreak` int(11) NOT NULL DEFAULT 0,
  `dateJoined` date NOT NULL DEFAULT curdate(),
  `tournamentRating` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `learner`
--

INSERT INTO `learner` (`username`, `email`, `pwHash`, `currentStreak`, `longestStreak`, `dateJoined`, `tournamentRating`) VALUES
('Nira', 'moniraoyshi@gmail.com', '$2y$10$KjzfayAAlO//o4ze2iQAROjyg9y1SQUy/RQeM/koa2pWql39azOFm', 0, 0, '2025-12-21', 1000),
('Siam', 'shudipto.siam@g.bracu.ac.bd', '$2y$10$TV5QvPHuttFPjLC7pSIYIefEsOeC9.DASI.JbdesJ2oYWrRKE.h2O', 0, 0, '2025-12-21', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `learnerattemptseom`
--

CREATE TABLE `learnerattemptseom` (
  `username` varchar(100) NOT NULL,
  `testID` int(11) NOT NULL,
  `score` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `learnerattemptsexercise`
--

CREATE TABLE `learnerattemptsexercise` (
  `ID` int(11) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `exerciseID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `learnertakescourse`
--

CREATE TABLE `learnertakescourse` (
  `username` varchar(100) NOT NULL,
  `courseID` int(11) NOT NULL,
  `dateTaken` date DEFAULT NULL,
  `currentModule` int(11) DEFAULT NULL,
  `currentConcept` int(11) DEFAULT NULL,
  `currentExplanation` int(11) DEFAULT NULL,
  `currentExercise` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `learnertakescourse`
--

INSERT INTO `learnertakescourse` (`username`, `courseID`, `dateTaken`, `currentModule`, `currentConcept`, `currentExplanation`, `currentExercise`) VALUES
('Nira', 1, '2025-12-21', NULL, NULL, NULL, NULL),
('Nira', 2, '2025-12-21', NULL, NULL, NULL, NULL),
('Siam', 1, '2025-12-21', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lessonplanner`
--

CREATE TABLE `lessonplanner` (
  `username` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `pwHash` varchar(200) DEFAULT NULL,
  `currentStreak` int(11) DEFAULT NULL,
  `longestStreak` int(11) DEFAULT NULL,
  `dateJoined` date DEFAULT NULL,
  `tournamentRating` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lessonplannerbuildscourse`
--

CREATE TABLE `lessonplannerbuildscourse` (
  `username` varchar(100) NOT NULL,
  `courseID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lessonplannervotessuggestion`
--

CREATE TABLE `lessonplannervotessuggestion` (
  `username` varchar(100) NOT NULL,
  `suggestionID` int(11) NOT NULL,
  `isUpvote` tinyint(1) NOT NULL DEFAULT 0,
  `isDownvote` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mcqattempt`
--

CREATE TABLE `mcqattempt` (
  `attemptID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mcqattemptanswers`
--

CREATE TABLE `mcqattemptanswers` (
  `MCQAttemptID` int(11) NOT NULL,
  `userAnswer` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mcqexercise`
--

CREATE TABLE `mcqexercise` (
  `exerciseID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mcqoptions`
--

CREATE TABLE `mcqoptions` (
  `optionNo` char(1) NOT NULL,
  `MCQExerciseID` int(11) NOT NULL,
  `optionText` text DEFAULT NULL,
  `isCorrect` tinyint(1) NOT NULL DEFAULT 0,
  `explanation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mcqsuggestion`
--

CREATE TABLE `mcqsuggestion` (
  `suggestionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mcqsuggestionoptions`
--

CREATE TABLE `mcqsuggestionoptions` (
  `optionNo` char(1) NOT NULL,
  `MCQSuggestionID` int(11) NOT NULL,
  `optionText` text DEFAULT NULL,
  `isCorrect` tinyint(1) NOT NULL,
  `explanation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

CREATE TABLE `module` (
  `ID` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `courseID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `module`
--

INSERT INTO `module` (`ID`, `name`, `courseID`) VALUES
(1, 'Hello, world', 1);

-- --------------------------------------------------------

--
-- Table structure for table `noninteractiveexplanation`
--

CREATE TABLE `noninteractiveexplanation` (
  `explanationID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `noninteractiveexplanation`
--

INSERT INTO `noninteractiveexplanation` (`explanationID`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `simulation`
--

CREATE TABLE `simulation` (
  `ID` int(11) NOT NULL,
  `exerciseID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `simulationstep`
--

CREATE TABLE `simulationstep` (
  `simulationID` int(11) NOT NULL,
  `stepNo` int(11) NOT NULL,
  `explanation` text DEFAULT NULL,
  `codeLine` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suggestedexercise`
--

CREATE TABLE `suggestedexercise` (
  `ID` int(11) NOT NULL,
  `upvotes` int(11) DEFAULT NULL,
  `downvotes` int(11) DEFAULT NULL,
  `suggestedBy` varchar(100) DEFAULT NULL,
  `dateAdded` date DEFAULT NULL,
  `conceptID` int(11) DEFAULT NULL,
  `acceptedAsExercise` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracecell`
--

CREATE TABLE `tracecell` (
  `traceTableID` int(11) NOT NULL,
  `rowIndex` int(11) NOT NULL,
  `colIndex` int(11) NOT NULL,
  `value` text DEFAULT NULL,
  `explanation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracecellattempt`
--

CREATE TABLE `tracecellattempt` (
  `traceTableAttemptID` int(11) NOT NULL,
  `rowIndex` int(11) NOT NULL,
  `colIndex` int(11) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracecellsuggestion`
--

CREATE TABLE `tracecellsuggestion` (
  `traceSuggestionID` int(11) NOT NULL,
  `rowIndex` int(11) NOT NULL,
  `colIndex` int(11) NOT NULL,
  `value` text DEFAULT NULL,
  `explanation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracetable`
--

CREATE TABLE `tracetable` (
  `ID` int(11) NOT NULL,
  `tracingExerciseID` int(11) NOT NULL,
  `numRows` int(11) DEFAULT NULL,
  `numCols` int(11) DEFAULT NULL,
  `colHeaders` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`colHeaders`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracetableattempt`
--

CREATE TABLE `tracetableattempt` (
  `ID` int(11) NOT NULL,
  `tracingAttemptID` int(11) DEFAULT NULL,
  `numRows` int(11) DEFAULT NULL,
  `numCols` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracetablesuggestion`
--

CREATE TABLE `tracetablesuggestion` (
  `ID` int(11) NOT NULL,
  `tracingSuggestionID` int(11) DEFAULT NULL,
  `numRows` int(11) DEFAULT NULL,
  `numCols` int(11) DEFAULT NULL,
  `colHeaders` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`colHeaders`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracingattempt`
--

CREATE TABLE `tracingattempt` (
  `attemptID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracingexercise`
--

CREATE TABLE `tracingexercise` (
  `exerciseID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracingsuggestion`
--

CREATE TABLE `tracingsuggestion` (
  `suggestionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blank`
--
ALTER TABLE `blank`
  ADD PRIMARY KEY (`FBExerciseID`,`blankNumber`);

--
-- Indexes for table `blankanswer`
--
ALTER TABLE `blankanswer`
  ADD PRIMARY KEY (`FBExerciseID`,`blankNumber`,`answer`);

--
-- Indexes for table `blanksuggestion`
--
ALTER TABLE `blanksuggestion`
  ADD PRIMARY KEY (`FBSuggestionID`,`blankNumber`);

--
-- Indexes for table `blanksuggestionanswer`
--
ALTER TABLE `blanksuggestionanswer`
  ADD PRIMARY KEY (`FBSuggestionID`,`blankNumber`,`answer`);

--
-- Indexes for table `codingattempt`
--
ALTER TABLE `codingattempt`
  ADD PRIMARY KEY (`attemptID`);

--
-- Indexes for table `codingexercise`
--
ALTER TABLE `codingexercise`
  ADD PRIMARY KEY (`exerciseID`);

--
-- Indexes for table `codingsuggestion`
--
ALTER TABLE `codingsuggestion`
  ADD PRIMARY KEY (`suggestionID`);

--
-- Indexes for table `codingsuggestiontestcase`
--
ALTER TABLE `codingsuggestiontestcase`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `codingSuggestionID` (`codingSuggestionID`);

--
-- Indexes for table `codingtestcase`
--
ALTER TABLE `codingtestcase`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `codingExerciseID` (`codingExerciseID`);

--
-- Indexes for table `concept`
--
ALTER TABLE `concept`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `moduleID` (`moduleID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `endofmoduletest`
--
ALTER TABLE `endofmoduletest`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `moduleID` (`moduleID`);

--
-- Indexes for table `exercise`
--
ALTER TABLE `exercise`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `conceptID` (`conceptID`),
  ADD KEY `testID` (`testID`);

--
-- Indexes for table `exerciseusesconcept`
--
ALTER TABLE `exerciseusesconcept`
  ADD PRIMARY KEY (`exerciseID`,`conceptID`),
  ADD KEY `conceptID` (`conceptID`);

--
-- Indexes for table `explanation`
--
ALTER TABLE `explanation`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `conceptID` (`conceptID`);

--
-- Indexes for table `fbexercise`
--
ALTER TABLE `fbexercise`
  ADD PRIMARY KEY (`exerciseID`);

--
-- Indexes for table `fbsuggestion`
--
ALTER TABLE `fbsuggestion`
  ADD PRIMARY KEY (`suggestionID`);

--
-- Indexes for table `interactiveexplanation`
--
ALTER TABLE `interactiveexplanation`
  ADD PRIMARY KEY (`explanationID`),
  ADD KEY `exerciseID` (`exerciseID`);

--
-- Indexes for table `learner`
--
ALTER TABLE `learner`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `learnerattemptseom`
--
ALTER TABLE `learnerattemptseom`
  ADD PRIMARY KEY (`username`,`testID`),
  ADD KEY `testID` (`testID`);

--
-- Indexes for table `learnerattemptsexercise`
--
ALTER TABLE `learnerattemptsexercise`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `username` (`username`),
  ADD KEY `exerciseID` (`exerciseID`);

--
-- Indexes for table `learnertakescourse`
--
ALTER TABLE `learnertakescourse`
  ADD PRIMARY KEY (`username`,`courseID`),
  ADD KEY `courseID` (`courseID`),
  ADD KEY `currentModule` (`currentModule`),
  ADD KEY `currentConcept` (`currentConcept`),
  ADD KEY `currentExplanation` (`currentExplanation`),
  ADD KEY `currentExercise` (`currentExercise`);

--
-- Indexes for table `lessonplanner`
--
ALTER TABLE `lessonplanner`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `lessonplannerbuildscourse`
--
ALTER TABLE `lessonplannerbuildscourse`
  ADD PRIMARY KEY (`username`,`courseID`),
  ADD KEY `courseID` (`courseID`);

--
-- Indexes for table `lessonplannervotessuggestion`
--
ALTER TABLE `lessonplannervotessuggestion`
  ADD PRIMARY KEY (`username`,`suggestionID`),
  ADD KEY `suggestionID` (`suggestionID`);

--
-- Indexes for table `mcqattempt`
--
ALTER TABLE `mcqattempt`
  ADD PRIMARY KEY (`attemptID`);

--
-- Indexes for table `mcqattemptanswers`
--
ALTER TABLE `mcqattemptanswers`
  ADD PRIMARY KEY (`MCQAttemptID`,`userAnswer`);

--
-- Indexes for table `mcqexercise`
--
ALTER TABLE `mcqexercise`
  ADD PRIMARY KEY (`exerciseID`);

--
-- Indexes for table `mcqoptions`
--
ALTER TABLE `mcqoptions`
  ADD PRIMARY KEY (`optionNo`,`MCQExerciseID`),
  ADD KEY `MCQExerciseID` (`MCQExerciseID`);

--
-- Indexes for table `mcqsuggestion`
--
ALTER TABLE `mcqsuggestion`
  ADD PRIMARY KEY (`suggestionID`);

--
-- Indexes for table `mcqsuggestionoptions`
--
ALTER TABLE `mcqsuggestionoptions`
  ADD PRIMARY KEY (`optionNo`,`MCQSuggestionID`),
  ADD KEY `MCQSuggestionID` (`MCQSuggestionID`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `courseID` (`courseID`);

--
-- Indexes for table `noninteractiveexplanation`
--
ALTER TABLE `noninteractiveexplanation`
  ADD PRIMARY KEY (`explanationID`);

--
-- Indexes for table `simulation`
--
ALTER TABLE `simulation`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `exerciseID` (`exerciseID`);

--
-- Indexes for table `simulationstep`
--
ALTER TABLE `simulationstep`
  ADD PRIMARY KEY (`simulationID`,`stepNo`);

--
-- Indexes for table `suggestedexercise`
--
ALTER TABLE `suggestedexercise`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `suggestedBy` (`suggestedBy`),
  ADD KEY `conceptID` (`conceptID`),
  ADD KEY `acceptedAsExercise` (`acceptedAsExercise`);

--
-- Indexes for table `tracecell`
--
ALTER TABLE `tracecell`
  ADD PRIMARY KEY (`traceTableID`,`rowIndex`,`colIndex`);

--
-- Indexes for table `tracecellattempt`
--
ALTER TABLE `tracecellattempt`
  ADD PRIMARY KEY (`traceTableAttemptID`,`rowIndex`,`colIndex`);

--
-- Indexes for table `tracecellsuggestion`
--
ALTER TABLE `tracecellsuggestion`
  ADD PRIMARY KEY (`traceSuggestionID`,`rowIndex`,`colIndex`);

--
-- Indexes for table `tracetable`
--
ALTER TABLE `tracetable`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `tracingExerciseID` (`tracingExerciseID`);

--
-- Indexes for table `tracetableattempt`
--
ALTER TABLE `tracetableattempt`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `tracingAttemptID` (`tracingAttemptID`);

--
-- Indexes for table `tracetablesuggestion`
--
ALTER TABLE `tracetablesuggestion`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `tracingSuggestionID` (`tracingSuggestionID`);

--
-- Indexes for table `tracingattempt`
--
ALTER TABLE `tracingattempt`
  ADD PRIMARY KEY (`attemptID`);

--
-- Indexes for table `tracingexercise`
--
ALTER TABLE `tracingexercise`
  ADD PRIMARY KEY (`exerciseID`);

--
-- Indexes for table `tracingsuggestion`
--
ALTER TABLE `tracingsuggestion`
  ADD PRIMARY KEY (`suggestionID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `blank`
--
ALTER TABLE `blank`
  ADD CONSTRAINT `blank_ibfk_1` FOREIGN KEY (`FBExerciseID`) REFERENCES `fbexercise` (`exerciseID`);

--
-- Constraints for table `blankanswer`
--
ALTER TABLE `blankanswer`
  ADD CONSTRAINT `blankanswer_ibfk_1` FOREIGN KEY (`FBExerciseID`,`blankNumber`) REFERENCES `blank` (`FBExerciseID`, `blankNumber`);

--
-- Constraints for table `blanksuggestion`
--
ALTER TABLE `blanksuggestion`
  ADD CONSTRAINT `blanksuggestion_ibfk_1` FOREIGN KEY (`FBSuggestionID`) REFERENCES `fbsuggestion` (`suggestionID`);

--
-- Constraints for table `blanksuggestionanswer`
--
ALTER TABLE `blanksuggestionanswer`
  ADD CONSTRAINT `blanksuggestionanswer_ibfk_1` FOREIGN KEY (`FBSuggestionID`,`blankNumber`) REFERENCES `blanksuggestion` (`FBSuggestionID`, `blankNumber`);

--
-- Constraints for table `codingattempt`
--
ALTER TABLE `codingattempt`
  ADD CONSTRAINT `codingattempt_ibfk_1` FOREIGN KEY (`attemptID`) REFERENCES `learnerattemptsexercise` (`ID`);

--
-- Constraints for table `codingexercise`
--
ALTER TABLE `codingexercise`
  ADD CONSTRAINT `codingexercise_ibfk_1` FOREIGN KEY (`exerciseID`) REFERENCES `exercise` (`ID`);

--
-- Constraints for table `codingsuggestion`
--
ALTER TABLE `codingsuggestion`
  ADD CONSTRAINT `codingsuggestion_ibfk_1` FOREIGN KEY (`suggestionID`) REFERENCES `suggestedexercise` (`ID`);

--
-- Constraints for table `codingsuggestiontestcase`
--
ALTER TABLE `codingsuggestiontestcase`
  ADD CONSTRAINT `codingsuggestiontestcase_ibfk_1` FOREIGN KEY (`codingSuggestionID`) REFERENCES `codingsuggestion` (`suggestionID`);

--
-- Constraints for table `codingtestcase`
--
ALTER TABLE `codingtestcase`
  ADD CONSTRAINT `codingtestcase_ibfk_1` FOREIGN KEY (`codingExerciseID`) REFERENCES `codingexercise` (`exerciseID`);

--
-- Constraints for table `concept`
--
ALTER TABLE `concept`
  ADD CONSTRAINT `concept_ibfk_1` FOREIGN KEY (`moduleID`) REFERENCES `module` (`ID`);

--
-- Constraints for table `endofmoduletest`
--
ALTER TABLE `endofmoduletest`
  ADD CONSTRAINT `endofmoduletest_ibfk_1` FOREIGN KEY (`moduleID`) REFERENCES `module` (`ID`);

--
-- Constraints for table `exercise`
--
ALTER TABLE `exercise`
  ADD CONSTRAINT `exercise_ibfk_1` FOREIGN KEY (`conceptID`) REFERENCES `concept` (`ID`),
  ADD CONSTRAINT `exercise_ibfk_2` FOREIGN KEY (`testID`) REFERENCES `endofmoduletest` (`ID`);

--
-- Constraints for table `exerciseusesconcept`
--
ALTER TABLE `exerciseusesconcept`
  ADD CONSTRAINT `exerciseusesconcept_ibfk_1` FOREIGN KEY (`exerciseID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `exerciseusesconcept_ibfk_2` FOREIGN KEY (`conceptID`) REFERENCES `concept` (`ID`);

--
-- Constraints for table `explanation`
--
ALTER TABLE `explanation`
  ADD CONSTRAINT `explanation_ibfk_1` FOREIGN KEY (`conceptID`) REFERENCES `concept` (`ID`);

--
-- Constraints for table `fbexercise`
--
ALTER TABLE `fbexercise`
  ADD CONSTRAINT `fbexercise_ibfk_1` FOREIGN KEY (`exerciseID`) REFERENCES `exercise` (`ID`);

--
-- Constraints for table `fbsuggestion`
--
ALTER TABLE `fbsuggestion`
  ADD CONSTRAINT `fbsuggestion_ibfk_1` FOREIGN KEY (`suggestionID`) REFERENCES `suggestedexercise` (`ID`);

--
-- Constraints for table `interactiveexplanation`
--
ALTER TABLE `interactiveexplanation`
  ADD CONSTRAINT `interactiveexplanation_ibfk_1` FOREIGN KEY (`explanationID`) REFERENCES `explanation` (`ID`),
  ADD CONSTRAINT `interactiveexplanation_ibfk_2` FOREIGN KEY (`exerciseID`) REFERENCES `exercise` (`ID`);

--
-- Constraints for table `learnerattemptseom`
--
ALTER TABLE `learnerattemptseom`
  ADD CONSTRAINT `learnerattemptseom_ibfk_1` FOREIGN KEY (`username`) REFERENCES `learner` (`username`),
  ADD CONSTRAINT `learnerattemptseom_ibfk_2` FOREIGN KEY (`testID`) REFERENCES `endofmoduletest` (`ID`);

--
-- Constraints for table `learnerattemptsexercise`
--
ALTER TABLE `learnerattemptsexercise`
  ADD CONSTRAINT `learnerattemptsexercise_ibfk_1` FOREIGN KEY (`username`) REFERENCES `learner` (`username`),
  ADD CONSTRAINT `learnerattemptsexercise_ibfk_2` FOREIGN KEY (`exerciseID`) REFERENCES `exercise` (`ID`);

--
-- Constraints for table `learnertakescourse`
--
ALTER TABLE `learnertakescourse`
  ADD CONSTRAINT `learnertakescourse_ibfk_1` FOREIGN KEY (`username`) REFERENCES `learner` (`username`),
  ADD CONSTRAINT `learnertakescourse_ibfk_2` FOREIGN KEY (`courseID`) REFERENCES `course` (`ID`),
  ADD CONSTRAINT `learnertakescourse_ibfk_3` FOREIGN KEY (`currentModule`) REFERENCES `module` (`ID`),
  ADD CONSTRAINT `learnertakescourse_ibfk_4` FOREIGN KEY (`currentConcept`) REFERENCES `concept` (`ID`),
  ADD CONSTRAINT `learnertakescourse_ibfk_5` FOREIGN KEY (`currentExplanation`) REFERENCES `explanation` (`ID`),
  ADD CONSTRAINT `learnertakescourse_ibfk_6` FOREIGN KEY (`currentExercise`) REFERENCES `exercise` (`ID`);

--
-- Constraints for table `lessonplannerbuildscourse`
--
ALTER TABLE `lessonplannerbuildscourse`
  ADD CONSTRAINT `lessonplannerbuildscourse_ibfk_1` FOREIGN KEY (`username`) REFERENCES `lessonplanner` (`username`),
  ADD CONSTRAINT `lessonplannerbuildscourse_ibfk_2` FOREIGN KEY (`courseID`) REFERENCES `course` (`ID`);

--
-- Constraints for table `lessonplannervotessuggestion`
--
ALTER TABLE `lessonplannervotessuggestion`
  ADD CONSTRAINT `lessonplannervotessuggestion_ibfk_1` FOREIGN KEY (`username`) REFERENCES `lessonplanner` (`username`),
  ADD CONSTRAINT `lessonplannervotessuggestion_ibfk_2` FOREIGN KEY (`suggestionID`) REFERENCES `suggestedexercise` (`ID`);

--
-- Constraints for table `mcqattempt`
--
ALTER TABLE `mcqattempt`
  ADD CONSTRAINT `mcqattempt_ibfk_1` FOREIGN KEY (`attemptID`) REFERENCES `learnerattemptsexercise` (`ID`);

--
-- Constraints for table `mcqattemptanswers`
--
ALTER TABLE `mcqattemptanswers`
  ADD CONSTRAINT `mcqattemptanswers_ibfk_1` FOREIGN KEY (`MCQAttemptID`) REFERENCES `mcqattempt` (`attemptID`);

--
-- Constraints for table `mcqexercise`
--
ALTER TABLE `mcqexercise`
  ADD CONSTRAINT `mcqexercise_ibfk_1` FOREIGN KEY (`exerciseID`) REFERENCES `exercise` (`ID`);

--
-- Constraints for table `mcqoptions`
--
ALTER TABLE `mcqoptions`
  ADD CONSTRAINT `mcqoptions_ibfk_1` FOREIGN KEY (`MCQExerciseID`) REFERENCES `mcqexercise` (`exerciseID`);

--
-- Constraints for table `mcqsuggestion`
--
ALTER TABLE `mcqsuggestion`
  ADD CONSTRAINT `mcqsuggestion_ibfk_1` FOREIGN KEY (`suggestionID`) REFERENCES `suggestedexercise` (`ID`);

--
-- Constraints for table `mcqsuggestionoptions`
--
ALTER TABLE `mcqsuggestionoptions`
  ADD CONSTRAINT `mcqsuggestionoptions_ibfk_1` FOREIGN KEY (`MCQSuggestionID`) REFERENCES `mcqsuggestion` (`suggestionID`);

--
-- Constraints for table `module`
--
ALTER TABLE `module`
  ADD CONSTRAINT `module_ibfk_1` FOREIGN KEY (`courseID`) REFERENCES `course` (`ID`);

--
-- Constraints for table `noninteractiveexplanation`
--
ALTER TABLE `noninteractiveexplanation`
  ADD CONSTRAINT `noninteractiveexplanation_ibfk_1` FOREIGN KEY (`explanationID`) REFERENCES `explanation` (`ID`);

--
-- Constraints for table `simulation`
--
ALTER TABLE `simulation`
  ADD CONSTRAINT `simulation_ibfk_1` FOREIGN KEY (`exerciseID`) REFERENCES `exercise` (`ID`);

--
-- Constraints for table `simulationstep`
--
ALTER TABLE `simulationstep`
  ADD CONSTRAINT `simulationstep_ibfk_1` FOREIGN KEY (`simulationID`) REFERENCES `simulation` (`ID`);

--
-- Constraints for table `suggestedexercise`
--
ALTER TABLE `suggestedexercise`
  ADD CONSTRAINT `suggestedexercise_ibfk_1` FOREIGN KEY (`suggestedBy`) REFERENCES `lessonplanner` (`username`),
  ADD CONSTRAINT `suggestedexercise_ibfk_2` FOREIGN KEY (`conceptID`) REFERENCES `concept` (`ID`),
  ADD CONSTRAINT `suggestedexercise_ibfk_3` FOREIGN KEY (`acceptedAsExercise`) REFERENCES `exercise` (`ID`);

--
-- Constraints for table `tracecell`
--
ALTER TABLE `tracecell`
  ADD CONSTRAINT `tracecell_ibfk_1` FOREIGN KEY (`traceTableID`) REFERENCES `tracetable` (`ID`);

--
-- Constraints for table `tracecellattempt`
--
ALTER TABLE `tracecellattempt`
  ADD CONSTRAINT `tracecellattempt_ibfk_1` FOREIGN KEY (`traceTableAttemptID`) REFERENCES `tracetableattempt` (`ID`);

--
-- Constraints for table `tracecellsuggestion`
--
ALTER TABLE `tracecellsuggestion`
  ADD CONSTRAINT `tracecellsuggestion_ibfk_1` FOREIGN KEY (`traceSuggestionID`) REFERENCES `tracetablesuggestion` (`ID`);

--
-- Constraints for table `tracetable`
--
ALTER TABLE `tracetable`
  ADD CONSTRAINT `tracetable_ibfk_1` FOREIGN KEY (`tracingExerciseID`) REFERENCES `tracingexercise` (`exerciseID`);

--
-- Constraints for table `tracetableattempt`
--
ALTER TABLE `tracetableattempt`
  ADD CONSTRAINT `tracetableattempt_ibfk_1` FOREIGN KEY (`tracingAttemptID`) REFERENCES `tracingattempt` (`attemptID`);

--
-- Constraints for table `tracetablesuggestion`
--
ALTER TABLE `tracetablesuggestion`
  ADD CONSTRAINT `tracetablesuggestion_ibfk_1` FOREIGN KEY (`tracingSuggestionID`) REFERENCES `tracingsuggestion` (`suggestionID`);

--
-- Constraints for table `tracingattempt`
--
ALTER TABLE `tracingattempt`
  ADD CONSTRAINT `tracingattempt_ibfk_1` FOREIGN KEY (`attemptID`) REFERENCES `learnerattemptsexercise` (`ID`);

--
-- Constraints for table `tracingexercise`
--
ALTER TABLE `tracingexercise`
  ADD CONSTRAINT `tracingexercise_ibfk_1` FOREIGN KEY (`exerciseID`) REFERENCES `exercise` (`ID`);

--
-- Constraints for table `tracingsuggestion`
--
ALTER TABLE `tracingsuggestion`
  ADD CONSTRAINT `tracingsuggestion_ibfk_1` FOREIGN KEY (`suggestionID`) REFERENCES `suggestedexercise` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
