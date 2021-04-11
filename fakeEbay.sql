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
    `upper_bid_limit` float,
    `isBuyer` boolean,
    `isSeller` boolean,
    PRIMARY KEY (`account_id`)
    ); 

DROP TABLE IF EXISTS `Product`;
CREATE TABLE `Product` (
	`product_id` integer NOT NULL DEFAULT 0,
	`screen size` int,
    `weight` float,
    `condition` ENUM('Brand New', 'Like New', 'Very Good', 'Good', 'Acceptable'),
    `description` varchar(50),
    `brand` varchar(20),
    `model` varchar(20),
    `operating_system` varchar(20),
    `isLaptop` boolean,
    `isTablet` boolean,
    `isDesktop` boolean,
    PRIMARY KEY (`product_id`)
);
 -- don't think we need an image, can maybe remove description?
 -- need a system that generates a new ID (maybe query highest ID # and add 1)

DROP TABLE IF EXISTS `AuctionEvent`;
CREATE TABLE `AuctionEvent` (
	`product_id` integer NOT NULL DEFAULT 0,
    `account_id` integer NOT NULL DEFAULT 0,
    `upper_bid_limit` float,
    `start_date` date,
    `closing_date` date,
    `start_time` time,
    `closing_time` time,
    `initial_price` float, -- should we change float to decimal precision 2?
    `bid_increment` float,
    `secret_minimum` float,
    PRIMARY KEY (`product_id`, `account_id`),
    FOREIGN KEY (`product_id`) REFERENCES Product(`product_id`),
    FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`)
);

DROP TABLE IF EXISTS `ParticipatesIn`;
CREATE TABLE `ParticipatesIn` (
	`product_id` integer NOT NULL DEFAULT 0,
    `account_id` integer NOT NULL DEFAULT 0,
    `current_bid` float NOT NULL DEFAULT 0,
    PRIMARY KEY (`product_id`, `account_id`),
    FOREIGN KEY (`account_id`) REFERENCES endUser(`account_id`),
    FOREIGN KEY (`product_id`) REFERENCES Product(`product_id`)
);

DROP TABLE IF EXISTS `Alert`;
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

-- Queries for testing
select * from accounts;
select * from adminStaff;
select * from customerRep;
