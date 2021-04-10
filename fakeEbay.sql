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

DROP TABLE IF EXISTS `endUser`;
CREATE TABLE `endUser` (
	`account_id` integer NOT NULL DEFAULT '',
	`password` varchar (20), 
    `email` varchar(20),
    `login_name` varchar(10),
    `upper_bid_limit` float,
    `isBuyer` boolean,
    `isSeller` boolean,
    PRIMARY KEY (`account_id`)
    ); 

DROP TABLE IF EXISTS `Product`;
CREATE TABLE `endUser` (
);

DROP TABLE IF EXISTS `AuctionEvent`;
CREATE TABLE `AuctionEvent` (
);

DROP TABLE IF EXISTS `ParticipatesIn`;
CREATE TABLE `ParticipatesIn` (
);

DROP TABLE IF EXISTS `Alert`;
CREATE TABLE `Alert` (
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