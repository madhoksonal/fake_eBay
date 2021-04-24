DROP DATABASE IF EXISTS `fakeEbay`;
CREATE DATABASE `fakeEbay`;
USE `fakeEbay`;

DROP TABLE IF EXISTS `AdminStaff`;
CREATE TABLE `AdminStaff`
(
 `account_id` int NOT NULL AUTO_INCREMENT,
 `email`      varchar(50) NOT NULL,
 `login_name` varchar(20) NOT NULL,
 `password`   varchar(20) NOT NULL,
PRIMARY KEY (`account_id`)
);

DROP TABLE IF EXISTS `CustomerRep`;
CREATE TABLE `CustomerRep`
(
 `account_id` int NOT NULL AUTO_INCREMENT,
 `email`      varchar(50) NOT NULL,
 `login_name` varchar(20) NOT NULL,
 `password`   varchar(20) NOT NULL,
PRIMARY KEY (`account_id`)
);


DROP TABLE IF EXISTS `endUser`;
CREATE TABLE `endUser`
(
 `account_id` int NOT NULL AUTO_INCREMENT,
 `email`      varchar(50) NOT NULL,
 `login_name` varchar(20) NOT NULL,
 `password`   varchar(20) NOT NULL,
PRIMARY KEY (`account_id`)
);

DROP TABLE IF EXISTS `question_answer`; -- originally called "Questions_input_Asks_Answer"
CREATE TABLE `question_answer` -- removed keyword attribute, don't think we need it (jiust use "like")
(
 `question_id`     int NOT NULL AUTO_INCREMENT,
 `question`        varchar(100) NOT NULL, -- can exist questions w/ out answers
 `answer`          varchar(100) ,
 `user_account_id` int NOT NULL ,
 `rep_account_id`  int, -- if a question doesn't have an answer, there won't be a rep

PRIMARY KEY (`question_id`),
FOREIGN KEY (`user_account_id`) REFERENCES endUser(`account_id`),
FOREIGN KEY (`rep_account_id`) REFERENCES CustomerRep(`account_id`)
);

DROP TABLE IF EXISTS `Product`;
CREATE TABLE `Product`
(
 `product_id`       int NOT NULL AUTO_INCREMENT,
 `brand`            varchar(20) NOT NULL,
 `model`            varchar(20) NOT NULL,
 `operating_system` varchar(20) NOT NULL,
 `screen_size`      int NOT NULL,
 `cond`        enum('Brand New', 'Like New', 'Good', 'Used') NOT NULL,  -- saying "condition" doesn't work for some reason
 `category`				enum('Laptop', 'Tablet', 'Desktop') NOT NULL,
PRIMARY KEY (`product_id`)
);

DROP TABLE IF EXISTS `Sells`; -- was originally "AuctionEvent"
CREATE TABLE `Sells`
(
 `account_id`     int NOT NULL, -- indicates the seller!
 `product_id`     int NOT NULL,
 `auction_id`     int NOT NULL AUTO_INCREMENT,
 `start_date`     date NOT NULL,
 `closing_date`   date NOT NULL,
 `start_time`     time NOT NULL,
 `closing_time`   time NOT NULL,
 `initial_price`  float NOT NULL, -- first price
 `bid_increment`  float NOT NULL, -- lowest bound to be added to current bid for next valid bid
 `secret_minimum` float NOT NULL, -- seller is not willing to give up item for less than this
 -- suggestion: change all float values to decimal(9,2)
 PRIMARY KEY (`auction_id`), -- changed to just auction id to be the only ID because autoincrement didn't allow for multiple keys
 FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`),
 FOREIGN KEY (`product_id`) REFERENCES Product(`product_id`)
);

DROP TABLE IF EXISTS `Buys`; -- was originally ParticipatesIn
CREATE TABLE `Buys`
(
 `account_id`      int NOT NULL,
 `auction_id`      int NOT NULL,
 `product_id`      int NOT NULL,
 `upper_bid_limit` float NOT NULL, -- the maximum price a buyer is willing to pay
 `current_bid`     float NOT NULL,

PRIMARY KEY (`account_id`, `auction_id`),
FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`),
FOREIGN KEY (`product_id`) REFERENCES Sells(`product_id`) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (`auction_id`) REFERENCES Sells(`auction_id`) ON UPDATE CASCADE ON DELETE CASCADE
);
-- PROBLEM WITH BUYS TABLE: "Error Code: 1822. Failed to add the foreign key constraint. Missing index for constraint 'buys_ibfk_3' in the referenced table 'Sells'

DROP TABLE IF EXISTS `Wishlist_Alert`; -- system for "Alerts"
CREATE TABLE `Wishlist_Alert`
(
 `account_id`       int NOT NULL ,
 `alert_id`         int NOT NULL AUTO_INCREMENT,
 `brand`            varchar(20) NULL ,
 `model`            varchar(20) NULL ,
 `operating_system` varchar(20) NULL ,
 `screen_size`      int NULL ,
 `cond`        enum('brand new', 'like new', 'good', 'used') NULL ,
 `category`         enum('laptop', 'tablet', 'desktop') NULL , -- combined booleans from product into an enum 

PRIMARY KEY (`alert_id`),
FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`)
);

--
-- inserting adminStaff and customerRep manually
--

INSERT INTO adminStaff (email, login_name, password) VALUES
	('admin@admin.auction.com', 'admin36', 'cs336');

INSERT INTO customerRep (email, login_name, password) VALUES
	('support-cat@support.auction.com', 'Support_Cat', 'meow'),
    ('support-dog@support.auction.com', 'Support_Dog', 'woof');

--
-- Populating Tables With Data to Test With
--

INSERT INTO endUser (email, login_name, password) VALUES
	('ds@gmail.com', 'dhruvi', 'pw1'),
    ('at@yahoo.com', 'amruta', 'pw2'),
    ('sm@yahoo.com', 'sonal', 'pw3'),
    ('ka@gmail.com', 'kateri', 'pw4');
    
INSERT INTO Product (brand, model, operating_system, screen_size, cond, category)
VALUES ('Samsung', 'Galaxy Chromebook', 'Chrome OS', 13, 'Brand New', 'Laptop'),
    ('Samsung', 'Galaxy Book Flex', 'Windows', 15, 'Like New', 'Laptop'),
    ('Samsung', 'Galaxy Tab S7', 'Android', 11, 'Brand New', 'Tablet'),
    ('Apple', 'iMac', 'Apple OS', 21, 'Good', 'Desktop'),
    ('Apple', 'iMac', 'Apple OS', 27, 'Like New', 'Desktop'),
    ('Apple', 'Macbook Pro', 'Apple OS', 13, 'Brand New', 'Laptop'),
    ('Apple', 'iPad Air', 'Apple OS', 10, 'Used', 'Tablet'),
    ('Apple', 'iPad Mini', 'Apple OS', 8, 'Brand New', 'Tablet'),
    ('HP', 'Omen Desktop', 'Windows', 21, 'Brand New', 'Desktop');
    
-- This is the auction part
INSERT INTO Sells (account_id, product_id, start_date, closing_date, start_time, closing_time, initial_price, bid_increment, secret_minimum)
VALUES
	(1, 1, '2020-12-21', '2021-01-30', '12:30', '14:30', 699.99, 1.00, 700),
    (2, 3, '2021-01-21', '2021-02-28', '12:30', '14:30', 659.99, 1.00, 800),
    (3, 5, '2021-02-21', '2021-03-30', '12:30', '14:30', 1099.99, 1.00, 1299.99),
    (4, 8, '2021-03-21', '2021-04-30', '12:30', '14:30', 1299.99, 1.00, 1350);

INSERT INTO Buys VALUES -- THESE ARE THE BIDS THEMSELVES
	(2, 1, 1, 750, 700),
	(2, 3, 5, 1500, 1350),
	(3, 1, 1, 1000, 800),
	(4, 3, 5, 1600, 1400),
	(1, 4, 8, 1400, 1315);

-- Buys is incomplete.
-- insert into Wishlist_Alert values(503, 0, null, null, null, null, null, null);

SELECT * FROM Wishlist_Alert;
SELECT MAX(account_ID) FROM endUser;
