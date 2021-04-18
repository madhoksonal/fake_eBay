DROP DATABASE IF EXISTS `fakeEbay`;
CREATE DATABASE `fakeEbay`;
USE `fakeEbay`;

-- how are we implementing account id as an int during account creation?
-- alternative -> use email as pk, assume each email is unique?
DROP TABLE IF EXISTS `AdminStaff`;
CREATE TABLE `AdminStaff`
(
 `account_id` int NOT NULL,
 `email`      varchar(50) NOT NULL,
 `login_name` varchar(20) NOT NULL,
 `password`   varchar(20) NOT NULL,
PRIMARY KEY (`account_id`)
);

DROP TABLE IF EXISTS `CustomerRep`;
CREATE TABLE `CustomerRep`
(
 `account_id` int NOT NULL,
 `email`      varchar(50) NOT NULL,
 `login_name` varchar(20) NOT NULL,
 `password`   varchar(20) NOT NULL,
PRIMARY KEY (`account_id`)
);

-- MAKE SURE WEB APP IS CONSISTENT WITH "ENDUSER" AND NOT "ACCOUNTS"

DROP TABLE IF EXISTS `endUser`;  -- merge this with the accounts table and update other pages
CREATE TABLE `endUser` -- removed isBuyer and isSeller
(
 `account_id` int NOT NULL,
 `email`      varchar(50) NOT NULL,
 `login_name` varchar(20) NOT NULL,
 `password`   varchar(20) NOT NULL,
PRIMARY KEY (`account_id`)
);

DROP TABLE IF EXISTS `question_answer`; -- originally called "Questions_input_Asks_Answer"
CREATE TABLE `question_answer` -- removed keyword attribute, don't think we need it
(
 `question_id`     int NOT NULL,
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
 `product_id`       int NOT NULL,
 `brand`            varchar(20) NOT NULL,
 `model`            varchar(20) NOT NULL,
 `operating_system` varchar(20) NOT NULL,
 `screen_size`      int NOT NULL,
 `condition`        enum('Brand New', 'Like New', 'Good', 'Used') NOT NULL,
 `isLaptop`         boolean NOT NULL, -- should we change these to enum values? (see wishlist_alerts)
 `isTablet`         boolean NOT NULL,
 `isDesktop`        boolean NOT NULL,
PRIMARY KEY (`product_id`)
);

DROP TABLE IF EXISTS `Sells`; -- was originally "AuctionEvent"
CREATE TABLE `Sells`
(
 `account_id`     int NOT NULL, -- indicates the seller!
 `product_id`     int NOT NULL,
 `auction_id`     int NOT NULL,
 `start_date`     date NOT NULL,
 `closing_date`   date NOT NULL,
 `start_time`     time NOT NULL,
 `closing_time`   time NOT NULL,
 `initial_price`  float NOT NULL, -- first price
 `bid_increment`  float NOT NULL, -- lowest bound to be added to current bid for next valid bid
 `secret_minimum` float NOT NULL, -- seller is not willing to give up item for less than this
 -- suggestion: change all float values to decimal(9,2)
 PRIMARY KEY (`account_id`, `product_id`, `auction_id`),
 FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`),
 FOREIGN KEY (`product_id`) REFERENCES Product(`product_id`)
);

DROP TABLE IF EXISTS `Buys`; -- was originally ParticipatesIn
CREATE TABLE `Buys`
(
 `account_id`      int NOT NULL,
 `product_id`      int NOT NULL,
 `auction_id`      int NOT NULL,
 `upper_bid_limit` float NOT NULL, -- the maximum price a buyer is willing to pay
 `current_bid`     float NOT NULL,

PRIMARY KEY (`account_id`, `product_id`, `auction_id`),
FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`),
FOREIGN KEY (`product_id`) REFERENCES Sells(`product_id`) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (`auction_id`) REFERENCES Sells(`auction_id`) ON UPDATE CASCADE ON DELETE CASCADE
);
-- PROBLEM WITH BUYS TABLE: "Error Code: 1822. Failed to add the foreign key constraint. Missing index for constraint 'buys_ibfk_3' in the referenced table 'Sells'

DROP TABLE IF EXISTS `Wishlist_Alert`; -- system for "Alerts"
CREATE TABLE `Wishlist_Alert`
(
 `account_id`       int NOT NULL ,
 `product_id`       int NOT NULL ,
 `alert_id`         int NOT NULL ,
 `brand`            varchar(20) NULL ,
 `model`            varchar(20) NULL ,
 `operating_system` varchar(20) NULL ,
 `screen_size`      int NULL ,
 `condition`        enum('brand new', 'like new', 'good', 'used') NULL ,
 `category`         enum('laptop', 'tablet', 'desktop') NULL , -- combined booleans from product into an enum 

PRIMARY KEY (`account_id`, `product_id`, `alert_id`),
FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`),
FOREIGN KEY (`product_id`) REFERENCES Product(`product_id`)
);

--
-- inserting adminStaff and customerRep manually
--

insert into adminStaff values
(1, 'admin@admin.auction.com', 'admin36', 'cs336');

insert into customerRep values
(11, 'support-cat@support.auction.com', 'Support_Cat', 'meow'),
(12, 'support-dog@support.auction.com', 'Support_Dog', 'woof');

--
-- Populating Tables With Data to Test With
--

insert into endUser values
(500, 'ds@gmail.com', 'dhruvi', 'pw1'),
(501, 'at@yahoo.com', 'amruta', 'pw2'),
(502, 'sm@yahoo.com', 'sonal', 'pw3'),
(503, 'ka@gmail.com', 'kateri', 'pw4');

insert into Product values
(100, 'Samsung', 'Galaxy Chromebook', 'Chrome OS', 13, 'Brand New', 1, 0, 0),
(101, 'Samsung', 'Galaxy Book Flex', 'Windows', 15, 'Like New', 1, 0, 0),
(102, 'Samsung', 'Galaxy Tab S7', 'Android', 11, 'Brand New', 0, 1, 0),
(103, 'Apple', 'iMac', 'Apple OS', 21, 'Good', 0, 0, 1),
(104, 'Apple', 'iMac', 'Apple OS', 27, 'Like New', 0, 0, 1),
(105, 'Apple', 'Macbook Pro', 'Apple OS', 13, 'Brand New', 1, 0, 0),
(106, 'Apple', 'iPad Air', 'Apple OS', 10, 'Used', 0, 1, 0),
(107, 'Apple', 'iPad Mini', 'Apple OS', 8, 'Brand New', 0, 1, 0),
(108, 'HP', 'Omen Desktop', 'Windows', 21, 'Brand New', 1, 0, 1);

insert into Sells values -- This is an auction
(500, 100, 201, '2020-12-21', '2021-01-30', '12:30', '14:30', 699.99, 1.00, 700),
(501, 102, 202, '2021-01-21', '2021-02-30', '12:30', '14:30', 659.99, 1.00, 800),
(502, 106, 203, '2021-02-21', '2021-03-30', '12:30', '14:30', 1099.99, 1.00, 1299.99),
(503, 108, 204, '2021-03-21', '2021-04-30', '12:30', '14:30', 1299.99, 1.00, 1350);

-- Buys is incomplete.
