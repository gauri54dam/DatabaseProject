use master;

DROP DATABASE IF EXISTS DAMG6210_Team1 ;
GO

CREATE DATABASE DAMG6210_Team1;
GO 

USE DAMG6210_Team1;


-- SQLINES DEMO *** orward Engineering

/* SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0; */
/* SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0; */
/* SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; */

-- SQLINES DEMO *** ------------------------------------
-- Schema mydb
-- SQLINES DEMO *** ------------------------------------

-- SQLINES DEMO *** ------------------------------------
-- Schema mydb
-- SQLINES DEMO *** ------------------------------------
--DROP SCHEMA IF EXISTS mydb;
--CREATE SCHEMA mydb;
--GO 


CREATE SCHEMA [User];
CREATE SCHEMA [Sales];
CREATE SCHEMA [Address];
CREATE SCHEMA [Restaurant];

-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** te]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [Address].State (
  [StateID] CHAR(2) NOT NULL,
  [StateName] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([StateID]))
;


-- SQLINES DEMO *** ------------------------------------
-- Table [City]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [Address].City (
  [CityID] INT NOT NULL IDENTITY,
  [CityName] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([CityID]))
;

-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** ress]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [Address].Address (
  [AddressID] INT NOT NULL IDENTITY,
  [Street] VARCHAR(100) NOT NULL,
  [AptNo] VARCHAR(45),
  [ZipCode] VARCHAR(10) NOT NULL,
  [CityID] INT NOT NULL,
  [StateID] CHAR(2) NOT NULL,
  [AddressType] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([AddressID]),
  CONSTRAINT FK_Address_StateID
    FOREIGN KEY ([StateID])
    REFERENCES [Address].[State] ([StateID]),
  CONSTRAINT FK_Address_CityID
    FOREIGN KEY ([CityID])
    REFERENCES [Address].[City] ([CityID])
    )
;


-- SQLINES DEMO *** ------------------------------------
-- Table [User]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [User].[User] (
  [UserID] INT NOT NULL IDENTITY, 
  [UserType] VARCHAR(45) NOT NULL,
  [LastName] VARCHAR(45) NOT NULL,
  [FirstName] VARCHAR(45) NOT NULL,
  [PhoneNo] VARCHAR(45) NOT NULL,
  [Email] VARCHAR(45) NOT NULL,
  [Password] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([UserID]))
;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** embership]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [User].Membership (
  [MemberID] INT NOT NULL IDENTITY,
  [MemberType] VARCHAR(45) NOT NULL,
  [Discount] FLOAT NOT NULL,
  [StartDate] DATE NOT NULL,
  PRIMARY KEY ([MemberID]))
;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** tomer]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [User].Customer (
  [CustomerID] INT NOT NULL IDENTITY,
  [UserID] INT NOT NULL,
  [MemberID] INT,
  [AddressID] INT,
  PRIMARY KEY ([CustomerID]),
  CONSTRAINT FK_Customer_UserID
    FOREIGN KEY ([UserID])
    REFERENCES [User].[User] ([UserID]),
  CONSTRAINT FK_Customer_MemberID
    FOREIGN KEY ([MemberID])
    REFERENCES [User].[Membership] ([MemberID]),
  CONSTRAINT FK_Customer_AddressID
    FOREIGN KEY ([AddressID])
    REFERENCES [Address].[Address] ([AddressID])
    )
;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** iveryPerson]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [User].DeliveryPerson (
  [DeliveryPersonID] INT NOT NULL IDENTITY,
  [UserID] INT NOT NULL,
  PRIMARY KEY ([DeliveryPersonID]),
  CONSTRAINT FK_DeliveryPerson_UserID 
	FOREIGN KEY (UserID) 
	REFERENCES [User].[User](UserID)
  )
;

--ALTER TABLE mydb.DeliveryPerson ADD CONSTRAINT FK_DeliveryPerson
--FOREIGN KEY (UserID) REFERENCES mydb.[User](UserID)

-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** ager]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [User].Manager (
  [ManagerID] INT NOT NULL IDENTITY,
  [UserID] INT NOT NULL,
  PRIMARY KEY ([ManagerID]),
  CONSTRAINT FK_Manager_UserID 
	FOREIGN KEY (UserID) 
	REFERENCES [User].[User](UserID))
;
--ALTER TABLE mydb.Manager ADD CONSTRAINT FK_Manager
--FOREIGN KEY (UserID) REFERENCES mydb.[User](UserID)


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** taurant]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [Restaurant].Restaurant (
  [RestaurantID] INT NOT NULL IDENTITY,
  [ManagerID] INT NOT NULL,
  [AddressID] INT NOT NULL,
  [Name] VARCHAR(45) NOT NULL,
  [PhoneNo] VARCHAR(25) NOT NULL,
  [OpenTime] TIME(0) NOT NULL,
  [CloseTime] TIME(0) NOT NULL,
  PRIMARY KEY ([RestaurantID]),
  CONSTRAINT FK_Restaurant_ManagerID
    FOREIGN KEY ([ManagerID])
    REFERENCES [User].[Manager] ([ManagerID]),
  CONSTRAINT FK_Restaurant_AddressID
    FOREIGN KEY ([AddressID])
    REFERENCES [Address].[Address] ([AddressID])
    )
;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** er]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [Sales].[Order] (
  [OrderID] INT NOT NULL IDENTITY,
  [RestaurantID] INT NOT NULL,
  [CustomerID] INT NOT NULL,
  [DeliveryPersonID] INT NOT NULL,
  [OrderPrice] FLOAT NOT NULL,
  [OrderStatus] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([OrderID]),
  CONSTRAINT FK_Order_CustomerID
    FOREIGN KEY ([CustomerID])
    REFERENCES [User].[Customer] ([CustomerID]) ,
  CONSTRAINT FK_Order_DeliveryPersonID
    FOREIGN KEY ([DeliveryPersonID])
    REFERENCES [User].[DeliveryPerson] ([DeliveryPersonID]),
  CONSTRAINT FK_Order_RestaurantID
    FOREIGN KEY ([RestaurantID])
    REFERENCES [Restaurant].[Restaurant] ([RestaurantID])
    )
;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** ment]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [Sales].Payment (
  [PaymentID] INT NOT NULL IDENTITY,
  [OrderID] INT NOT NULL,
  [PaymentAmount] FLOAT NOT NULL,
  [CustomerID] INT NOT NULL,
  PRIMARY KEY ([PaymentID]),
  CONSTRAINT FK_Payment_OrderID
    FOREIGN KEY ([OrderID])
    REFERENCES [Sales].[Order] ([OrderID]),
  CONSTRAINT  FK_Payment_CustomerID
    FOREIGN KEY ([CustomerID])
    REFERENCES [User].[Customer] ([CustomerID]))
;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** erReview]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [Sales].OrderReview (
  [ReviewID] INT NOT NULL IDENTITY,
  [OrderID] INT NOT NULL,
  [Rate] INT NOT NULL,
  [Review] VARCHAR(500),
  PRIMARY KEY ([ReviewID]),
  CONSTRAINT FK_OrderReview
    FOREIGN KEY ([OrderID])
    REFERENCES [Sales].[Order] ([OrderID])
    )
;


-- SQLINES DEMO *** ------------------------------------
-- Table [Menu]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [Restaurant].Menu (
  [MenuID] INT NOT NULL IDENTITY,
  [RestaurantID] INT NOT NULL,
  [MenuName] VARCHAR(45) NOT NULL,
  PRIMARY KEY ([MenuID]),
  CONSTRAINT FK_Menu
    FOREIGN KEY ([RestaurantID])
    REFERENCES [Restaurant].[Restaurant] ([RestaurantID])
    )
;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** uItems]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [Restaurant].MenuItems (
  [ItemID] INT NOT NULL IDENTITY,
  [MenuID] INT NOT NULL,
  [ItemName] VARCHAR(200) NOT NULL,
  [UnitPrice] FLOAT NOT NULL,
  [Description] VARCHAR(500) NULL,
  PRIMARY KEY ([ItemID]),
  CONSTRAINT FK_MenuItems
    FOREIGN KEY ([MenuID])
    REFERENCES [Restaurant].Menu ([MenuID])
    )
;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** mOrdered]
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE [Sales].ItemOrdered (
  [OrderID] INT NOT NULL IDENTITY,
  [ItemID] INT NOT NULL,
  [Quantity] INT NOT NULL,
  PRIMARY KEY ([OrderID], [ItemID]),
  CONSTRAINT FK_ItemOrdered_OrderID
    FOREIGN KEY ([OrderID])
    REFERENCES [Sales].[Order] ([OrderID]),
  CONSTRAINT FK_ItemOrdered_ItemID
    FOREIGN KEY ([ItemID])
    REFERENCES [Restaurant].[MenuItems] ([ItemID]))
;


/* SET SQL_MODE=@OLD_SQL_MODE; */
/* SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS; */
/* SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS; */

/* start inserting data to tables*/
-- insert state from excel file (all states)

-- insert City with CityID:
INSERT INTO Address.City 
VALUES ('Seattle'), ('Bellevue'), ('Lynnwood'), 
		('Portland'), ('Eugene'), 
		('New York'), ('Los Angeles'), ('Chicago'), 
		('Miami'), ('Dallas')


--insert randomly generated addresses (fake address) :
-- AddressID	Street	AptNo	ZipCode	CityID	StateID	AddressType
INSERT INTO [Address].Address
VALUES ('9226 Walnut Lane', NULL, '60018', 3, 'WA', 'C');
INSERT INTO Address.Address
VALUES ('1 Applegate Ave.', '213', '33129', 3, 'WA', 'C');
INSERT INTO Address.Address
VALUES ('21 Devon Street', NULL, '11226', 4, 'OR', 'C');
INSERT INTO Address.Address
VALUES ('533 Wall Street', '435', '11229', 4, 'OR', 'C');
INSERT INTO Address.Address
VALUES ('7650 East Cypress Lane', '110', '90291', 7, 'CA', 'C');
INSERT INTO Address.Address
VALUES ('567 East Longfellow Dr.', NULL, '98109', 1, 'WA', 'C');
INSERT INTO Address.Address
VALUES ('11 Newcastle Dr.', NULL, '98108', 1, 'WA', 'C');
INSERT INTO Address.Address
VALUES ('8669 North Grant Ave.', '321', '98109', 1, 'WA', 'C');
INSERT INTO Address.Address
VALUES ('80 Roberts Street', NULL, '98107', 2, 'WA', 'C');
INSERT INTO Address.Address
VALUES ('137 Ivy Street', NULL, '98104', 2, 'WA', 'C');
INSERT INTO Address.Address
VALUES ('1919 Post Alley', NULL, '98101', 1, 'WA', 'R'); --Pink Door
INSERT INTO Address.Address
VALUES ('1222 East Pine St.', NULL, '98122', 1, 'WA', 'R'); --Ramen Danbo
INSERT INTO Address.Address
VALUES ('4759 Brooklyn Ave NE', NULL, '98104', 1, 'WA', 'R'); -- Cedars
INSERT INTO Address.Address
VALUES ('11020 NE 6th St #90', NULL, '98004', 2, 'WA', 'R'); --Dolar Shop
INSERT INTO Address.Address
VALUES ('14007 Hwy 99 # G', NULL, '98087', 3, 'WA', 'R'); -- New Seoul
INSERT INTO Address.Address
VALUES ('12121 Northup Way #205', NULL, '98005', 2, 'WA', 'R'); --Looking for Chai 
INSERT INTO Address.Address
VALUES ('609 SE Ankeny St C', NULL, '97214', 4, 'OR', 'R'); --Nong's Khao Man Gai
INSERT INTO Address.Address
VALUES ('1701 SW Jefferson St', NULL, '97201', 4, 'OR', 'R'); -- Blue Star Donut
INSERT INTO Address.Address
VALUES ('3470 W 6th St #7', NULL, '90020', 7, 'CA', 'R'); --Sun Nong Dan
INSERT INTO Address.Address
VALUES ('555 S Alexandria Ave', '110', '90020', 7, 'CA', 'R'); --Blue Bottle Coffee

--insert more address for customers (total 20 customers):
INSERT INTO Address.Address
VALUES ('12345 8th AVE NE', '3', '98125', 1, 'WA', 'C'),
	('635 Wood Street', NULL, '98107', 2, 'WA', 'C'),
	('14 216th PL SE', NULL, '98036', 3, 'WA', 'C'),
	('9880 Harrison Dr.', '321', '98109', 1, 'WA', 'C'),
	('238 Sage Ave.', NULL, '98107', 2, 'WA', 'C'),
	('5200 169th PL SW', NULL, '98037', 3, 'WA', 'C'),
	('212 Primrose St.', '145', '11226', 4, 'OR', 'C'),
	('9824 Pine Drive', NULL, '11227', 4, 'OR', 'C'),
	('9617 Academy Drive', '888', '90072', 7, 'CA', 'C'),
	('15 Princeton Ave.', '777', '90071', 7, 'CA', 'C'); 


-- Insert Restaurant:
--COLUMN: RestaurantID	ManagerID	AddressID	Name	PhoneNo	OpenTime	CloseTime
INSERT INTO Restaurant.Restaurant
VALUES (11, 11, 'The Pink Door', '206-443-3241', '11:30', '22:00'),
	(2, 12, 'Ramen Danbo', '206-566-5479', '11:00', '23:00'),
	(3, 13, 'Cedars in University District', '206-527-4000', '11:00', '22:00'),
	(4, 14, 'The Dolar Shop Seattle', '425-390-8888', '12:00', '22:00'),
	(5, 15, 'New Seoul Restaurant', '425-787-8616', '10:30', '21:00'),
	(6, 16, 'Looking For Chai Taiwanese Kitchen', '425-502-7766', '11:00', '21:30'),
	(7, 17, 'Nongs Khao Man Gai', '503-740-2907', '10:00', '20:00'),
	(8, 18, 'Blue Star Donut', '503-265-8410', '07:00', '14:00'),
	(9, 19, 'Sun Nong Dan 6th St.', '213-365-0303', '09:00', '23:30'),
	(10, 20, 'Blue Bottle Coffee', '510-653-3394', '07:00', '18:00');

-- INSERT menu:
INSERT INTO Restaurant.Menu
VALUES (11, 'Pasta and Entree'),
	(12, 'Ramen and Drink'), (13, 'Lunch and Dinner'),
	(14, 'Hot Pot'), (15, 'Soups and Grill'),
	(16, 'Chef Special'), (17, 'Menu'), (18, 'Donut'),
	(19, 'Special menu'), (20, 'Coffee');

-- Insert menu items: import from excel file (MenuItems.xlsx)

-- UPDATE member start date to check if the MemberType changed as described in TRIGGER:
UPDATE [User].Membership
SET StartDate = '2022-01-01'
WHERE MemberID IN (7,8,9); --memberID =custID in our case

----------PAYMENT TABLE--------------
-- Alter table to include UpatePayment function
ALTER TABLE Sales.Payment DROP COLUMN PaymentAmount;
ALTER TABLE Sales.Payment ADD PaymentAmount AS (dbo.UpatePayment(OrderID));

-- alter table to include PaymentStatus:
ALTER TABLE Sales.Payment ADD PaymentStatus varchar(45); -- Pending, In Progress, Completed

-- INSERT ORDERS:
-- OrderID(ID)	RestaurantID(11-20)	CustomerID(2-21)	DeliveryPersonID(0-9)	OrderStatus(varchar)	OrderPrice(function)
-- delivery person: 0-5 are in WA, 6-7 portland, 8-9 in LA
INSERT INTO Sales.[Order] VALUES (11, 7, 0,  'Complete', 0); 
-- 11= Pink door, 12 = Danbo, 13= Cedars, 14= Dolar Shop, 15=New Seoul

--troubleshooting when entering order...
-- start form empty column
DELETE FROM Sales.[Order];

--if needed, reseed so that IDENTITY ID starts from 0:
DBCC CHECKIDENT ('Sales.[Order]', RESEED, 0) -- (Database Console Command), reset OrderID identity to 0
GO


--INSERT Payment:
--PaymentID(ID)	OrderID	CustomerID	PaymentAmount
INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (1, 7, 'Pending');

--if needed for troubleshooting
DELETE FROM Sales.Payment;
DBCC CHECKIDENT ('Sales.Payment', RESEED, 0) -- (Database Console Command), reset OrderID identity to 0
GO

-- INSERT ItemOrdered:
--OrderID(int)	ItemID(int)	Quantity(int)
DELETE FROM Sales.ItemOrdered;

INSERT INTO Sales.ItemOrdered VALUES (1, 1, 2), (1, 2, 1); -- $24*2 + $23*1 = $71


-- see results:
SELECT * FROM Sales.[Order];
SELECT * FROM Sales.ItemOrdered;
SELECT * FROM Sales.Payment;
