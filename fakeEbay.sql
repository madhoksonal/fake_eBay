DROP DATABASE IF EXISTS `fakeEbay`;
CREATE DATABASE IF NOT EXISTS `fakeEbay`;
USE `fakeEbay`;

--
-- Creating tables for accounts, admin, and customer support
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `login_name` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(30) NOT NULL DEFAULT '',
  `upper_bid_limit` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`email`)
);

-- need to implement account ID? temporarily using email as pk
-- should we used email as primary key and assume no user can have the same email?
-- can delete this once end user is consistent with pages

DROP TABLE IF EXISTS `adminStaff`;
CREATE TABLE `adminStaff` (
  `login_name` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`email`)
);

DROP TABLE IF EXISTS `customerRep`;
CREATE TABLE `customerRep` (
  `login_name` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`email`)
);

DROP TABLE IF EXISTS `endUser`;  -- merge this with the accounts table and update other pages
CREATE TABLE `endUser` (
	`account_id` integer NOT NULL DEFAULT 0,
	`password` varchar (20), 
    `email` varchar(20),
    `login_name` varchar(10),
    `isBuyer` boolean,
    `isSeller` boolean,
    PRIMARY KEY (`account_id`)
    ); 

DROP TABLE IF EXISTS `Product`;
CREATE TABLE `Product` (
	`product_id` integer NOT NULL DEFAULT 0,
	`screen_size` int,
    `weight` float,
    `condition` ENUM('Brand New', 'Like New', 'Very Good', 'Good', 'Used'),
    `description` varchar(50),
    `brand` varchar(20),
    `model` varchar(20),
    `operating_system` varchar(20),
    `isLaptop` boolean, -- should we change this to ENUM??
    `isTablet` boolean,
    `isDesktop` boolean,
    PRIMARY KEY (`product_id`)
);
 -- don't think we need an image, can maybe remove description?
 -- also want to remove weight
 -- need a system that generates a new ID (maybe query highest ID # and add 1)

DROP TABLE IF EXISTS `AuctionEvent`;
CREATE TABLE `AuctionEvent` (
	`product_id` integer NOT NULL DEFAULT 0,
    `account_id` integer NOT NULL DEFAULT 0, -- this is the seller!
    `upper_bid_limit` float, -- why is this here? should be with buyers??
    `start_date` date,
    `closing_date` date,
    `start_time` time,
    `closing_time` time,
    `initial_price` float, -- should we change float to decimal precision 2 for price stuff? (decimal(9,2))
    `bid_increment` float, 
    `secret_minimum` float,
    PRIMARY KEY (`product_id`, `account_id`),
    FOREIGN KEY (`product_id`) REFERENCES Product(`product_id`),
    FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`)
);

DROP TABLE IF EXISTS `ParticipatesIn`;
CREATE TABLE `ParticipatesIn` ( -- these are all the "buyers"
	`product_id` integer NOT NULL DEFAULT 0,
    `account_id` integer NOT NULL DEFAULT 0,
    `current_bid` float NOT NULL DEFAULT 0,
    PRIMARY KEY (`product_id`, `account_id`),
    FOREIGN KEY (`product_id`) REFERENCES Product(`product_id`),
    FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`)
);

DROP TABLE IF EXISTS `Alert`;  --- I THINK WE NEED TO RE-DO SCHEMA, SHOULD BE SIMILAR TO PRODUCTS TABLE BUT ALLOWS FIELDS TO BE NULL
CREATE TABLE `Alert` (
	`product_id` integer NOT NULL DEFAULT 0,
    `account_id` integer NOT NULL DEFAULT 0,
    `alert_number` integer NOT NULL DEFAULT 0,
    `exists` boolean,
    PRIMARY KEY (`product_id`, `account_id`, `alert_number`),
    FOREIGN KEY (`product_id`) REFERENCES Product(`product_id`),
    FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`)
);
	

--
-- inserting adminStaff and customerRep manually
--

insert into adminStaff values
('admin36','admin@admin.auction.com', 'cs336');

insert into customerRep values
('support_flora','supportfairy@support.auction.com', 'redFairy'),
('support_fauna','fairygodmother@support.auction.com', 'greenFairy'),
('support_merryweather','guardian@support.auction.com', 'blueFairy');

--
-- Populating Accounts With Data to Test With
--

insert into accounts values
('winnie','wtp@gmail.com', 'h0ney', NULL),
('piglet','pinkpig@yahoo.com', 'b3stfri3nd', NULL),
('eeyore','donkeyboy@hotmail.com', '33y0r3', NULL),
('chrisrobin','robinchris@gmail.com', 'fr!endsh!p', NULL);

insert into endUser values
(500, 'pw1', 'ds@gmail.com', 'dhruvi', NULL, NULL),
(501, 'pw2', 'at@yahoo.com', 'amruta', NULL, NULL),
(502, 'pw3', 'sm@yahoo.com', 'sonal', NULL, NULL),
(503, 'pw4', 'ka@gmail.com', 'kateri', NULL, NULL);

insert into Product values
(100, 13, 2.29, 'Brand New', NULL, 'Samsung', 'Galaxy Chromebook', 'Chrome OS', 1, 0, 0),
(101, 15, NULL, 'Like New', NULL, 'Samsung', 'Galaxy Book Flex', 'Windows', 1, 0, 0),
(102, 11, NULL, 'Brand New', NULL, 'Samsung', 'Galaxy Tab S7', 'Android', 0, 1, 0),
(103, 21, NULL, 'Very Good', NULL, 'Apple', 'iMac', 'Apple OS', 0, 0, 1),
(104, 27, NULL, 'Like New', NULL, 'Apple', 'iMac', 'Apple OS', 0, 0, 1),
(105, 13, NULL, 'Brand New', NULL, 'Apple', 'Macbook Pro', 'Apple OS', 1, 0, 0),
(106, 10, NULL, 'Very Good', NULL, 'Apple', 'iPad Air', 'Apple OS', 0, 1, 0),
(107, 8, NULL, 'Brand New', NULL, 'Apple', 'iPad Mini', 'Apple OS', 0, 1, 0),
(108, NULL, NULL, 'Brand New', NULL, 'HP', 'Omen Desktop', 'Windows', 0, 0, 1);

insert into AuctionEvent values
(104, 503, NULL, '2021-03-21', '2020-04-30', '12:30', '14:30', 1099.99, 1.00, 1299.99),
(100, 502, NULL, '2021-03-30', '2020-04-15', '12:30', '14:30', 699.99, 1.00, 800);

insert into ParticipatesIn values  -- DOESN'T WORK!! Can't perform queries
(104, 501, 1100.00),
(100, 504, 700.00);

-- Queries for testing
select * from accounts;
select * from endUser;
select * from adminStaff;
select * from customerRep;
select * from Product;
select * from AuctionEvent;
select * from ParticipatesIn;

SELECT * FROM AuctionEvent a, Product p WHERE a.product_id = p.product_id;

-- Queries for History
SELECT * FROM AuctionEvent a JOIN ParticipatesIn pi USING(product_id);
SELECT * FROM endUser u JOIN ParticipatesIn pi USING(account_id);
