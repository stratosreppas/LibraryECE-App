-- DROP DATABASE ecel;
-- DELETE FROM transaction;
-- DROP TABLE transaction;
-- DELETE FROM notifications;
-- DELETE FROM notify_me;
CREATE DATABASE ecel;
USE ecel;

SET GLOBAL sql_mode = "STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION";


CREATE TABLE books (
  id int NOT NULL ,
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
  publisher varchar(100) DEFAULT NULL,
  image_url varchar(500) DEFAULT NULL,
  semester varchar(255) DEFAULT NULL,
  interest varchar(255) DEFAULT NULL,
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `books`
  ADD INDEX `idx_isbn` (`isbn`);

CREATE TABLE visitor (
	id int NOT NULL AUTO_INCREMENT,
    name varchar(150) DEFAULT NULL,
    surname varchar(150) DEFAULT NULL,
    am varchar(50) DEFAULT NULL,
	property int DEFAULT NULL,
	barcode varchar(50) DEFAULT NULL,
	phone varchar(20) DEFAULT NULL,
	email varchar(50) NOT NULL,
	password varchar(50) NOT NULL,
	penalty date DEFAULT NULL,
	primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE transaction (
  transaction_id int NOT NULL auto_increment,
  visitor_id int DEFAULT NULL,
  book_id int DEFAULT NULL,
  borrow_date date DEFAULT NULL,
  must_return_date date DEFAULT NULL,
  return_date date DEFAULT NULL,
  renew bool DEFAULT true,
  primary key(transaction_id),
  CONSTRAINT fk_transaction_visitor_id FOREIGN KEY (visitor_id) REFERENCES visitor(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_transaction_book_id FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE categories (
  isbn varchar(255) NOT NULL,
  category varchar(255) NOT NULL,
  PRIMARY KEY (category, isbn)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- CREATE TABLE authors_books (
--   isbn varchar(255) NOT NULL,
--   author_id int(11) NOT NULL,
--   PRIMARY KEY (author_id, isbn),
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- CREATE TABLE authors (
--   author_id int(11) NOT NULL AUTO_INCREMENT,
--   first_name varchar(255) NOT NULL,
--   middle_name varchar(255) DEFAULT NULL,
--   last_name varchar(255) NOT NULL,
--   PRIMARY KEY (author_id),
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ALTER TABLE `books`
--   ADD PRIMARY KEY (`id`);

-- ALTER TABLE `transaction`
--   ADD PRIMARY KEY (`transaction_id`);

-- ALTER TABLE `visitor`
--   ADD PRIMARY KEY (`id`);

-- ALTER TABLE `books`
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9623;



-- ALTER TABLE `transaction`
--   MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76890;

-- ALTER TABLE `visitor`
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6894;
-- COMMIT;

CREATE TABLE favorites (
  isbn varchar(50) NOT NULL,
  id int(11) NOT NULL,
  PRIMARY KEY (id, isbn)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE set_notification (
  isbn varchar(50) NOT NULL,
  id int(11) NOT NULL,
  PRIMARY KEY (id, isbn)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE notify_me (
    id INT AUTO_INCREMENT PRIMARY KEY,
    notification_id int NOT NULL,
    user_id int NOT NULL,
    category int NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notifications (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    title varchar(200) NOT NULL,
    notification_date date NOT NULL,
    content varchar(1000) NOT NULL,
    category int NOT NULL,
    opened bool DEFAULT FALSE,
    PRIMARY KEY(id),
    CONSTRAINT `fk_user_id` FOREIGN KEY (user_id) REFERENCES visitor (id) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE `favorites`
  ADD CONSTRAINT `fk_favorites_isbn` FOREIGN KEY (isbn) REFERENCES `books` (isbn) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_favorites_user_id` FOREIGN KEY (`id`) REFERENCES `visitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

  ALTER TABLE `categories`
  ADD CONSTRAINT `fk_categories_isbn` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `set_notification`
  ADD CONSTRAINT `fk_set_nots_isbn` FOREIGN KEY (isbn) REFERENCES `books` (isbn) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_set_nots_user_id` FOREIGN KEY (`id`) REFERENCES `visitor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER //
CREATE TRIGGER book_notification_trigger_update
AFTER UPDATE
ON books FOR EACH ROW
BEGIN
    -- Check if ISBN was updated
    IF NEW.category = 'Διαθέσιμο' AND OLD.category <> 'Διαθέσιμο' THEN
        -- Insert into notify_me for the updated ISBN
        INSERT INTO notifications (user_id, title, notification_date, content)
        SELECT sn.id, 'Διαθέσιμο βιβλίο', CURDATE(), CONCAT('Το βιβλίο με ISBN: ', NEW.isbn, ' είναι διαθέσιμο.')
        FROM set_notification sn
        WHERE sn.isbn = NEW.isbn;
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER book_notification_trigger_insert
AFTER INSERT
ON books FOR EACH ROW
BEGIN
    -- Check if ISBN was updated
    IF NEW.category = 'Διαθέσιμο' THEN
        -- Insert into notify_me for the updated ISBN
        INSERT INTO notifications (user_id, title, notification_date, content)
        SELECT sn.id, 'Διαθέσιμο βιβλίο', CURDATE(), CONCAT('Το βιβλίο με ISBN: ', NEW.isbn, ' είναι διαθέσιμο.')
        FROM set_notification sn
        WHERE sn.isbn = NEW.isbn;
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER new_notification_trigger
AFTER INSERT
ON notifications FOR EACH ROW
BEGIN
    INSERT INTO notify_me (notification_id, user_id,category) VALUES (NEW.id,NEW.user_id,NEW.category);
END;
//
DELIMITER ;