-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2025 at 11:26 AM
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
-- Database: `tgj`
--

-- --------------------------------------------------------

--
-- Table structure for table `favourites`
--

CREATE TABLE `favourites` (
  `favouriteId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `gameId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favourites`
--

INSERT INTO `favourites` (`favouriteId`, `userId`, `gameId`) VALUES
(1, 1, 24),
(2, 1, 27),
(3, 1, 30),
(4, 1, 28),
(5, 1, 37),
(6, 12, 28),
(7, 12, 33),
(8, 12, 32),
(9, 12, 38),
(10, 12, 35),
(11, 2, 25),
(12, 2, 29),
(13, 2, 38),
(14, 2, 34),
(15, 2, 36),
(16, 13, 26),
(17, 13, 35),
(18, 13, 34),
(19, 13, 37),
(20, 13, 29);

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `gameId` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `developer` varchar(255) NOT NULL,
  `releaseDate` date NOT NULL,
  `dateUploaded` date NOT NULL,
  `imagesUrl` varchar(255) NOT NULL,
  `avgRating` int(11) NOT NULL DEFAULT 0,
  `GameUrl` varchar(255) NOT NULL,
  `age_restriction` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`gameId`, `title`, `description`, `developer`, `releaseDate`, `dateUploaded`, `imagesUrl`, `avgRating`, `GameUrl`, `age_restriction`) VALUES
(24, 'Elden Ring', 'An open-world action RPG blending Souls-style combat with deep exploration.', 'FromSoftware', '2022-02-25', '2025-05-05', 'assets\\gamesImages\\elden_ring.jpg', 10, 'https://en.bandainamcoent.eu/elden-ring/elden-ring', '18+'),
(25, 'Dark Souls', 'A brutal and atmospheric action RPG that launched a legendary franchise.', 'FromSoftware', '2011-09-22', '2025-05-05', 'assets\\gamesImages\\dark_souls.jpg', 9, 'https://www.bandainamcoent.com/games/dark-souls', '16+'),
(26, 'Dark Souls II', 'Sequel to the cult hit, featuring expanded mechanics and world design.', 'FromSoftware', '2014-03-11', '2025-05-05', 'assets\\gamesImages\\dark_souls_2.jpg', 8, 'https://www.bandainamcoent.com/games/dark-souls-ii', '16+'),
(27, 'Dark Souls III', 'A refined and stunning conclusion to the Dark Souls saga.', 'FromSoftware', '2016-03-24', '2025-05-05', 'assets\\gamesImages\\dark_souls_3.jpg', 9, 'https://www.bandainamcoent.com/games/dark-souls-iii', '16+'),
(28, 'God of War', 'A narrative-rich action game that reimagines Kratos in Norse mythology.', 'Santa Monica Studio', '2018-04-20', '2025-05-05', 'assets\\gamesImages\\god_of_war.jpg', 10, 'https://www.playstation.com/en-us/games/god-of-war/', '18+'),
(29, 'God of War Ragnarok', 'The epic sequel to God of War (2018) continuing Kratos and Atreus’ journey.', 'Santa Monica Studio', '2022-11-09', '2025-05-05', 'assets\\gamesImages\\god_of_war_ragnarok.jpg', 10, 'https://www.playstation.com/en-us/games/god-of-war-ragnarok/', '18+'),
(30, 'Valorant', 'A competitive tactical shooter blending precise gunplay with unique abilities.', 'Riot Games', '2020-06-02', '2025-05-05', 'assets\\gamesImages\\valorant.jpg', 9, 'https://playvalorant.com/', '16+'),
(31, 'Overwatch', 'Team-based hero shooter with fast-paced combat and diverse characters.', 'Blizzard Entertainment', '2016-05-24', '2025-05-05', 'assets\\gamesImages\\overwatch.jpg', 8, 'https://playoverwatch.com/', '13+'),
(32, 'Overwatch 2', 'The sequel to Overwatch with new content and PvE elements.', 'Blizzard Entertainment', '2022-10-04', '2025-05-05', 'assets\\gamesImages\\overwatch_2.jpg', 7, 'https://playoverwatch.com/en-us/', '13+'),
(33, 'Apex Legends', 'A free-to-play battle royale featuring unique legends and fluid movement.', 'Respawn Entertainment', '2019-02-04', '2025-05-05', 'assets\\gamesImages\\apex_legends.jpg', 9, 'https://www.ea.com/games/apex-legends', '16+'),
(34, 'Silent Hill 2', 'Psychological horror masterpiece known for its atmosphere and story.', 'Konami', '2001-09-24', '2025-05-05', 'assets\\gamesImages\\silent_hill_2.jpg', 9, 'https://www.konami.com/games/silenthill/', '18+'),
(35, 'Resident Evil 4 Remake', 'Modern remake of the survival horror classic with stunning visuals.', 'Capcom', '2023-03-24', '2025-05-05', 'assets\\gamesImages\\re4_remake.jpg', 10, 'https://www.residentevil.com/re4/en-us/', '18+'),
(36, 'The Last of Us Part I', 'Remake of the award-winning story-driven survival adventure.', 'Naughty Dog', '2022-09-02', '2025-05-05', 'assets\\gamesImages\\last_of_us_part1.jpg', 10, 'https://www.playstation.com/en-us/games/the-last-of-us-part-i/', '18+'),
(37, 'The Witcher 3 Wild Hunt', 'A massive open-world RPG with gripping story and deep mechanics.', 'CD Projekt Red', '2015-05-19', '2025-05-05', 'assets\\gamesImages\\witcher_3.jpg', 10, 'https://thewitcher.com/en/witcher3', '18+'),
(38, 'Red Dead Redemption 2', 'An epic Western adventure with rich storytelling and realism.', 'Rockstar Games', '2018-10-26', '2025-05-05', 'assets\\gamesImages\\rdr2.jpg', 10, 'https://www.rockstargames.com/reddeadredemption2', '18+');

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `genreId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`genreId`, `name`) VALUES
(1, 'First-Person Shooter'),
(2, 'Battle Royale'),
(3, 'Souls-like'),
(4, 'Souls Game'),
(5, 'Role-Playing Game'),
(6, 'Action-Adventure'),
(7, 'Platformer'),
(8, 'Survival Horror'),
(9, 'Simulation'),
(10, 'Fighting'),
(11, 'Puzzle');

-- --------------------------------------------------------

--
-- Table structure for table `genres_games`
--

CREATE TABLE `genres_games` (
  `id` int(11) NOT NULL,
  `genreId` int(11) NOT NULL,
  `gameId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genres_games`
--

INSERT INTO `genres_games` (`id`, `genreId`, `gameId`) VALUES
(5, 3, 24),
(6, 4, 24),
(7, 5, 24),
(8, 6, 24),
(9, 3, 25),
(10, 4, 25),
(11, 5, 25),
(12, 6, 25),
(13, 3, 26),
(14, 4, 26),
(15, 5, 26),
(16, 6, 26),
(17, 3, 27),
(18, 4, 27),
(19, 5, 27),
(20, 6, 27),
(21, 6, 28),
(22, 5, 28),
(23, 6, 29),
(24, 5, 29),
(25, 1, 30),
(26, 1, 31),
(27, 10, 31),
(28, 1, 32),
(29, 10, 32),
(30, 1, 33),
(31, 2, 33),
(32, 8, 34),
(33, 8, 35),
(34, 6, 35),
(35, 6, 36),
(36, 8, 36),
(37, 5, 37),
(38, 6, 37),
(39, 6, 38),
(40, 5, 38);

-- --------------------------------------------------------

--
-- Table structure for table `platforms`
--

CREATE TABLE `platforms` (
  `platformId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `platforms`
--

INSERT INTO `platforms` (`platformId`, `name`) VALUES
(1, 'PlayStation 3'),
(2, 'PlayStation 4'),
(3, 'PlayStation 5'),
(4, 'Xbox'),
(5, 'Nintendo Switch'),
(6, 'PC'),
(7, 'Steam Deck'),
(8, 'Android'),
(9, 'iOS');

-- --------------------------------------------------------

--
-- Table structure for table `platforms_games`
--

CREATE TABLE `platforms_games` (
  `id` int(11) NOT NULL,
  `platformId` int(11) NOT NULL,
  `gameId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `platforms_games`
--

INSERT INTO `platforms_games` (`id`, `platformId`, `gameId`) VALUES
(9, 2, 24),
(10, 3, 24),
(11, 4, 24),
(12, 6, 24),
(13, 1, 25),
(14, 2, 25),
(15, 4, 25),
(16, 6, 25),
(17, 1, 26),
(18, 2, 26),
(19, 4, 26),
(20, 6, 26),
(21, 2, 27),
(22, 4, 27),
(23, 6, 27),
(24, 2, 28),
(25, 3, 28),
(26, 6, 28),
(27, 2, 29),
(28, 3, 29),
(29, 6, 30),
(30, 2, 31),
(31, 4, 31),
(32, 5, 31),
(33, 6, 31),
(34, 2, 32),
(35, 3, 32),
(36, 4, 32),
(37, 5, 32),
(38, 6, 32),
(39, 2, 33),
(40, 3, 33),
(41, 4, 33),
(42, 5, 33),
(43, 6, 33),
(44, 3, 34),
(45, 6, 34),
(46, 2, 35),
(47, 3, 35),
(48, 4, 35),
(49, 6, 35),
(50, 3, 36),
(51, 6, 36),
(52, 2, 37),
(53, 3, 37),
(54, 4, 37),
(55, 5, 37),
(56, 6, 37),
(57, 2, 38),
(58, 4, 38),
(59, 6, 38);

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `ratingId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `gameId` int(11) NOT NULL,
  `ratingValue` int(11) NOT NULL,
  `ratingDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`ratingId`, `userId`, `gameId`, `ratingValue`, `ratingDate`) VALUES
(1, 1, 24, 10, '2025-05-05'),
(2, 1, 27, 9, '2025-05-05'),
(3, 1, 30, 8, '2025-05-05'),
(4, 1, 28, 9, '2025-05-05'),
(5, 1, 37, 10, '2025-05-05'),
(6, 12, 28, 10, '2025-05-06'),
(7, 12, 33, 9, '2025-05-06'),
(8, 12, 32, 7, '2025-05-06'),
(9, 12, 38, 8, '2025-05-06'),
(10, 12, 35, 9, '2025-05-06'),
(11, 2, 25, 8, '2025-05-06'),
(12, 2, 29, 9, '2025-05-06'),
(13, 2, 38, 10, '2025-05-06'),
(14, 2, 34, 7, '2025-05-06'),
(15, 2, 36, 9, '2025-05-06'),
(16, 13, 26, 8, '2025-05-07'),
(17, 13, 35, 9, '2025-05-07'),
(18, 13, 34, 8, '2025-05-07'),
(19, 13, 37, 10, '2025-05-07'),
(20, 13, 29, 9, '2025-05-07');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `reviewId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `gameId` int(11) NOT NULL,
  `reviewText` varchar(500) NOT NULL,
  `reviewDate` date NOT NULL,
  `likes` int(11) NOT NULL,
  `dislikes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`reviewId`, `userId`, `gameId`, `reviewText`, `reviewDate`, `likes`, `dislikes`) VALUES
(1, 1, 24, 'Elden Ring is a masterpiece. The open world is vast and beautiful, and the combat is as challenging as it is rewarding. A must-play for any RPG fan!', '2025-05-05', 120, 5),
(2, 1, 27, 'Dark Souls III is everything a Souls game should be: difficult, atmospheric, and incredibly satisfying when you overcome its challenges. Love the lore and design!', '2025-05-05', 110, 4),
(3, 1, 30, 'Valorant offers fast-paced tactical gameplay that keeps me coming back. It’s a great blend of strategy and action. The team coordination is key to winning!', '2025-05-05', 95, 3),
(4, 1, 28, 'God of War is a stunning reimagining of Kratos. The storytelling is phenomenal, and the gameplay is so satisfying. A true work of art!', '2025-05-05', 130, 2),
(5, 1, 37, 'The Witcher 3 Wild Hunt is one of the best open-world RPGs ever made. The story, characters, and world-building are top-notch. Geralt is a legend!', '2025-05-05', 150, 4),
(6, 12, 28, 'God of War offers an emotional journey with breathtaking visuals. The combat mechanics are smooth, and the bond between Kratos and Atreus is truly heartwarming.', '2025-05-06', 140, 3),
(7, 12, 33, 'Apex Legends is a blast! Fast-paced, exciting, and the character abilities add a unique touch. It’s one of the best battle royales out there.', '2025-05-06', 120, 2),
(8, 12, 32, 'Overwatch 2 is fun but feels a bit rushed in some areas. Still, the heroes are engaging, and the team-based gameplay keeps me hooked. The new maps are nice.', '2025-05-06', 105, 5),
(9, 12, 38, 'Red Dead Redemption 2 is an absolute work of art. The world feels so alive, and the storytelling is second to none. A true epic experience.', '2025-05-06', 160, 2),
(10, 12, 35, 'Resident Evil 4 Remake has brought the classic back to life. The visuals and gameplay feel modernized, but the terrifying atmosphere remains intact. A must-play for fans of the franchise.', '2025-05-06', 145, 3),
(11, 2, 25, 'Dark Souls is a tough game, but the sense of accomplishment after defeating a boss is incredible. It’s challenging, rewarding, and deeply satisfying.', '2025-05-06', 130, 6),
(12, 2, 29, 'God of War Ragnarok builds on the first game and enhances everything. The story is gripping, and the combat is even better than before. Kratos’ journey is emotional and powerful.', '2025-05-06', 160, 5),
(13, 2, 38, 'Red Dead Redemption 2 is one of the most immersive games ever made. The attention to detail is mind-blowing, and the story is a masterpiece of modern gaming.', '2025-05-06', 170, 3),
(14, 2, 34, 'Silent Hill 2 remains one of the scariest and most psychological horror games ever made. Its atmosphere and plot twists still hold up today. A true classic!', '2025-05-06', 140, 7),
(15, 2, 36, 'The Last of Us Part I is a heart-wrenching and beautiful journey. The story is emotional, and the character development is unmatched. Truly a gem of a game.', '2025-05-06', 155, 4),
(16, 13, 26, 'Dark Souls II improved upon its predecessor with better mechanics and deeper lore. It’s still as challenging as ever, but with a more refined experience.', '2025-05-07', 100, 3),
(17, 13, 35, 'Resident Evil 4 Remake is fantastic! The visuals are amazing, and the gameplay keeps the original spirit while feeling fresh. The terror is still very real!', '2025-05-07', 110, 2),
(18, 13, 34, 'Silent Hill 2 remains a timeless horror game. It still holds up in terms of its psychological terror and atmosphere. An absolute must for horror fans.', '2025-05-07', 95, 4),
(19, 13, 37, 'The Witcher 3 Wild Hunt is nothing short of incredible. The story, characters, and open world make it an unforgettable RPG. Geralt’s journey is one of the best in gaming.', '2025-05-07', 160, 3),
(20, 13, 29, 'God of War Ragnarok is the perfect sequel. The narrative continues with high stakes, and the gameplay is as solid as ever. Kratos’ emotional journey is so well-done.', '2025-05-07', 150, 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userId` int(11) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `joinDate` date NOT NULL,
  `profile_picture_filename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userId`, `userName`, `email`, `password`, `role`, `joinDate`, `profile_picture_filename`) VALUES
(1, 'Jason Joymore', 'pdl.rishav88@gmail.com', 'K/IKTmdYNbFRwT+lR2Ekj7mPJY1aQ+j8YcYde0iB/z1DTJxtp9wLMogyRzLID1iJioNW+kIyb7Q=', 'user', '2025-05-02', 'Jason Joymore_profilePicture.png'),
(2, 'Jason', 'pdl.rishav88@gmail.com', 'G9W2iZ8g7hwbW3jyr8UR4sWsx73qMA093tWDg3+1yVsskTwAn54Kix4mY8dsU6oni2xsIZIz8Dw=', 'user', '2025-05-03', 'Jason_profilePicture.jpg'),
(4, 'JasonZ', 'pdl.rishav88@gmail.com', '2baC5B/izPOLa/b7Gg8hPkDes7EghliD/3TC74n8SaZU89zIRYO/WnlJY/X1eZkJkAJ21Y8owL8=', 'admin', '2025-05-03', 'JasonZ_profilePicture.jpg'),
(12, 'JasonZZ', 'pdl.rishav88@gmail.com', '7dB+wdaCTUNX4PWxObREnsfIqKMoD/Ih82J+ysp/mkyVhtfQUg2MPTh+QVza0e+TzPUdk0qYm+4=', 'user', '2025-05-05', 'JasonZZ_profilePicture.jpg'),
(13, 'rabina12', 'rabina@gmail.com', 'VdflVsZUfZocxZYVSTH2aZi3+d5SV/fj1KYkYle9o/qfg/xPir9E8WMoKiA7GCTE98GoALVD', 'user', '2025-05-08', 'rabina12_profilePicture.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `favourites`
--
ALTER TABLE `favourites`
  ADD PRIMARY KEY (`favouriteId`),
  ADD KEY `user_favourite` (`userId`),
  ADD KEY `game_favourite` (`gameId`);

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`gameId`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`genreId`);

--
-- Indexes for table `genres_games`
--
ALTER TABLE `genres_games`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genre_games_relation` (`genreId`),
  ADD KEY `games_genre_relation` (`gameId`);

--
-- Indexes for table `platforms`
--
ALTER TABLE `platforms`
  ADD PRIMARY KEY (`platformId`);

--
-- Indexes for table `platforms_games`
--
ALTER TABLE `platforms_games`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plaform_games_relation` (`platformId`),
  ADD KEY `games_platforms_relation` (`gameId`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`ratingId`),
  ADD KEY `user_rating` (`userId`),
  ADD KEY `game_rating` (`gameId`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`reviewId`),
  ADD KEY `user_review` (`userId`),
  ADD KEY `game_review` (`gameId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `favourites`
--
ALTER TABLE `favourites`
  MODIFY `favouriteId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `gameId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `genreId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `genres_games`
--
ALTER TABLE `genres_games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `platforms`
--
ALTER TABLE `platforms`
  MODIFY `platformId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `platforms_games`
--
ALTER TABLE `platforms_games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `ratingId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `reviewId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favourites`
--
ALTER TABLE `favourites`
  ADD CONSTRAINT `game_favourite` FOREIGN KEY (`gameId`) REFERENCES `games` (`gameId`),
  ADD CONSTRAINT `user_favourite` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`);

--
-- Constraints for table `genres_games`
--
ALTER TABLE `genres_games`
  ADD CONSTRAINT `games_genre_relation` FOREIGN KEY (`gameId`) REFERENCES `games` (`gameId`),
  ADD CONSTRAINT `genre_games_relation` FOREIGN KEY (`genreId`) REFERENCES `genres` (`genreId`);

--
-- Constraints for table `platforms_games`
--
ALTER TABLE `platforms_games`
  ADD CONSTRAINT `games_platforms_relation` FOREIGN KEY (`gameId`) REFERENCES `games` (`gameId`),
  ADD CONSTRAINT `plaform_games_relation` FOREIGN KEY (`platformId`) REFERENCES `platforms` (`platformId`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `game_rating` FOREIGN KEY (`gameId`) REFERENCES `games` (`gameId`),
  ADD CONSTRAINT `user_rating` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `game_review` FOREIGN KEY (`gameId`) REFERENCES `games` (`gameId`),
  ADD CONSTRAINT `user_review` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
