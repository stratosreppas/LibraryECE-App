CREATE DATABASE Library;
USE Library;

-- DROP DATABASE Library;

CREATE TABLE books (
  id int(11) NOT NULL ,
  title varchar(255) DEFAULT NULL,
  subtitle varchar(255) DEFAULT NULL,
  author varchar(255) DEFAULT NULL,
  isbn varchar(50) DEFAULT NULL,
  year varchar(4) DEFAULT NULL,
  language varchar(50) DEFAULT NULL,
  edition varchar(50) DEFAULT NULL,
  category varchar(11) DEFAULT 'Διαθέσιμο',
  barcode varchar(50) DEFAULT NULL,
  dewey varchar(20) DEFAULT NULL,
  publisher varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




CREATE TABLE `temp` (
  `te` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Άδειασμα δεδομένων του πίνακα `temp`
--

INSERT INTO `temp` (`te`) VALUES
('a'),
('%%%a%%'),
('k%'),
('k');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL,
  `visitor_id` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  `borrow_date` date DEFAULT NULL,
  `must_return_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `visitor`
--

CREATE TABLE `visitor` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `am` varchar(50) DEFAULT NULL,
  `property` int(11) DEFAULT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `penalty` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Άδειασμα δεδομένων του πίνακα `visitor`
--

INSERT INTO `visitor` (`id`, `name`, `surname`, `am`, `property`, `barcode`, `phone`, `mail`, `penalty`) VALUES
(1, 'John', 'Doe', '123445', 1, NULL, '698980', NULL, NULL),


--
-- Ευρετήρια για άχρηστους πίνακες
--

--
-- Ευρετήρια για πίνακα `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Ευρετήρια για πίνακα `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Ευρετήρια για πίνακα `visitor`
--
ALTER TABLE `visitor`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT για άχρηστους πίνακες
--

--
-- AUTO_INCREMENT για πίνακα `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9623;

--
-- AUTO_INCREMENT για πίνακα `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76890;

--
-- AUTO_INCREMENT για πίνακα `visitor`
--
ALTER TABLE `visitor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6894;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

CREATE TABLE favorites (
  isbn int(11) NOT NULL,
  id int(11) NOT NULL,
  PRIMARY KEY (id,isbn),
  CONSTRAINT fk_favorites_isbn FOREIGN KEY (isbn) REFERENCES books(isbn) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_favorites_user_id FOREIGN KEY (id) REFERENCES visitor(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE notify (
  isbn int(11) NOT NULL,
  id int(11) NOT NULL,
  PRIMARY KEY (id,isbn),
  CONSTRAINT fk_notify_isbn FOREIGN KEY (isbn) REFERENCES books(isbn) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_notify_user_id FOREIGN KEY (id) REFERENCES visitor(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `books`
ADD COLUMN `image` BLOB;

UPDATE `books`
SET `image` = LOAD_FILE('/assets/images/img_book.png')

ALTER TABLE `visitor`
ADD COLUMN `password` VARCHAR(255) DEFAULT NULL;

