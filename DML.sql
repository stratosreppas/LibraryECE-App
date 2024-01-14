DROP DATABASE ecel;
CREATE DATABASE ecel;
USE ecel;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE TABLE books (
  id int(11) NOT NULL ,
  title varchar(255) DEFAULT NULL,
  subtitle varchar(255) DEFAULT NULL,
  author varchar(255) DEFAULT NULL,
  isbn varchar(50) NOT NULL,
  year varchar(4) DEFAULT NULL,
  language varchar(50) DEFAULT NULL,
  edition varchar(50) DEFAULT NULL,
  category varchar(11) DEFAULT 'Διαθέσιμο',
  barcode varchar(50) DEFAULT NULL,
  dewey varchar(20) DEFAULT NULL,
  publisher varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL,
  `visitor_id` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  `borrow_date` date DEFAULT NULL,
  `must_return_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `visitor` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `am` varchar(50) DEFAULT NULL,
  `property` int(11) DEFAULT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `mail` varchar(50) NOT NULL,
  password varchar(50) NOT NULL,
  `penalty` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`);

ALTER TABLE `visitor`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9623;

ALTER TABLE `books`
  ADD INDEX `idx_isbn` (`isbn`);

ALTER TABLE `transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76890;

ALTER TABLE `visitor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6894;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

CREATE TABLE favorites (
  isbn varchar(50) NOT NULL,
  id int(11) NOT NULL,
  PRIMARY KEY (id, isbn)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE notify (
  id int(11) NOT NULL,
  isbn varchar(50) NOT NULL,
  PRIMARY KEY (id, isbn)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `favorites`
  ADD CONSTRAINT `fk_favorites_isbn` FOREIGN KEY (isbn) REFERENCES `books` (isbn) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_favorites_user_id` FOREIGN KEY (`id`) REFERENCES `visitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `notify`
  ADD CONSTRAINT `fk_notify_isbn` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_notify_user_id` FOREIGN KEY (`id`) REFERENCES `visitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `books`
  ADD COLUMN `image_url` varchar(500) DEFAULT NULL;

ALTER TABLE `visitor`
  ADD COLUMN `password` VARCHAR(255) DEFAULT NULL;