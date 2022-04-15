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
  [OrderPrice] MONEY NOT NULL,
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
  [PaymentAmount] MONEY NOT NULL,
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
  [UnitPrice] MONEY NOT NULL,
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
  [OrderID] INT NOT NULL,
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


/* start INSERTING DATA to tables*/
--------------------INSERT ADDRESS SCHEMA----------------------
-- insert state from excel file (all states) via import wizard

-- insert City with CityID:
INSERT INTO Address.City 
VALUES ('Seattle'), ('Bellevue'), ('Lynnwood'), 
		('Portland'), ('Eugene'), 
		('New York'), ('Los Angeles'), ('Chicago'), 
		('Miami'), ('Dallas')


--insert randomly generated addresses (fake address) for customers, real addresses for restaurants:
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

--insert more address for customers, randomly generated (total 20 customers):
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

-- Retrieve results from Address Schema:
SELECT * FROM Address.Address;
SELECT * FROM Address.City;
SELECT * FROM Address.State;

---------------- INSERT Restaurant SCHEMA----------------------
-- Insert Restaurant Entity
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

-- INSERT Menu entity:
INSERT INTO Restaurant.Menu
VALUES (11, 'Pasta and Entree'),
	(12, 'Ramen and Drink'), (13, 'Lunch and Dinner'),
	(14, 'Hot Pot'), (15, 'Soups and Grill'),
	(16, 'Chef Special'), (17, 'Menu'), (18, 'Donut'),
	(19, 'Special menu'), (20, 'Coffee');

-- Insert MenuItems: import from excel file (MenuItems.xlsx)

--Retrieve results from RESTAURANT Schema:
SELECT * FROM Restaurant.Restaurant;
SELECT * FROM Restaurant.Menu;
SELECT * FROM Restaurant.MenuItems;

-- Retrieve the restaurant menu
SELECT r.RestaurantID, r.Name, m.MenuName, mi.ItemID, mi.ItemName, mi.UnitPrice
FROM Restaurant.Restaurant r
JOIN Restaurant.Menu m
ON r.RestaurantID = m.RestaurantID
JOIN Restaurant.MenuItems mi
ON m.MenuID = mi.MenuID
--WHERE r.RestaurantID IN (11,12,13,14,15,16) -- can change as needed. Restaurant ID = 11 - 20
ORDER BY r.RestaurantID;

-- Retrieve customer and city
SELECT c.CustomerID, c.AddressID, a.CityID, ct.CityName
FROM [User].[Customer] c
JOIN Address.Address a
ON c.AddressID = a.AddressID
JOIN Address.City ct
ON a.CityID = ct.CityID;

-- Retrieve restaurant and city
SELECT r.RestaurantID, r.Name, r.AddressID, a.CityID, ct.CityName
FROM Restaurant.Restaurant r
JOIN Address.Address a
ON r.AddressID = a.AddressID
JOIN Address.City ct
ON a.CityID = ct.CityID;


-- UPDATE member start date to check if the MemberType changed as described in TRIGGER:
UPDATE [User].Membership
SET StartDate = '2022-01-01'
WHERE MemberID IN (7,8,9); --memberID =custID in our case

--Retrieve results:
SELECT * FROM [User].Membership;


--------------------------INSERT SALES SCHEMA--------------

-- INSERT ORDER
-- for troubleshooting when entering order...
DELETE FROM Sales.[Order]; -- start form empty column

--if needed, reseed so that IDENTITY ID starts from 0:
DBCC CHECKIDENT ('Sales.[Order]', RESEED, 0) -- (Database Console Command), reset OrderID identity to 0
GO

-- COLUMN: OrderID(IDENTITY)	RestaurantID(11-20)	CustomerID(2-21)	DeliveryPersonID(0-9)	OrderStatus(varchar)	OrderPrice(function)
-- delivery person: 0-5 are in WA, 6-7 portland, 8-9 in LA
INSERT INTO Sales.[Order] VALUES (11, 7, 0,  'Complete', 0); 
-- 11= Pink door, 12 = Danbo, 13= Cedars, 14= Dolar Shop, 15=New Seoul
INSERT INTO Sales.[Order] VALUES (11, 7, 0,  'Pending', 0); 
INSERT INTO Sales.[Order] VALUES (11, 8, 1,  'Pending', 0); 
INSERT INTO Sales.[Order] VALUES (11, 9, 2,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (12, 12, 3,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (12, 15, 4,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (12, 12, 5,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (13, 15, 1,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (13, 12, 2,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (13, 15, 3,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (14, 10, 4,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (14, 13, 5,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (15, 2, 1,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (15, 3, 2,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (15, 14, 3,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (16, 11, 4,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (16, 16, 5,  'Pending', 0);

-- add more so each customer at least order 3x (to cID 12 and 15).
INSERT INTO Sales.[Order] VALUES (11, 12, 1,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (11, 15, 2,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (14, 12, 3,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (14, 15, 4,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (15, 12, 5,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (15, 15, 1,  'Pending', 0);

-- add more for CustomerID# 10, 11 (bellevue) and 18 -19 (Portland):
-- Order ID 23 - 25 for RestID 14 and 26 -28 for RestID 16
INSERT INTO Sales.[Order] VALUES (14, 10, 4,  'Pending', 0); --RestID 14 and 16 are in bellevue
INSERT INTO Sales.[Order] VALUES (14, 11, 4,  'Pending', 0); 
INSERT INTO Sales.[Order] VALUES (14, 10, 5,  'Pending', 0); 
INSERT INTO Sales.[Order] VALUES (16, 11, 5,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (16, 10, 3,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (16, 11, 3,  'Pending', 0);
-- Order ID 29 - 31 for RestID 17 and 32 -34 for RestID 18
INSERT INTO Sales.[Order] VALUES (17, 18, 6,  'Pending', 0); --RestID 17 and 18 are in Portland
INSERT INTO Sales.[Order] VALUES (17, 19, 7,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (17, 18, 6,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (18, 19, 7,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (18, 18, 6,  'Pending', 0);
INSERT INTO Sales.[Order] VALUES (18, 19, 7,  'Pending', 0);


-- INSERT ItemOrdered:
-- if needed for troubleshooting:
DELETE FROM Sales.ItemOrdered; -- start from 0 entry

--OrderID(int)	ItemID(int)	Quantity(int)
INSERT INTO Sales.ItemOrdered VALUES (1, 1, 2), (1, 2, 1);
INSERT INTO Sales.ItemOrdered VALUES (2, 1, 1),  (2, 2, 1); --11
INSERT INTO Sales.ItemOrdered VALUES (3, 3, 1),  (3, 4, 1);

INSERT INTO Sales.ItemOrdered VALUES (4, 6, 2), (4, 7, 1), (4, 8, 1); --12
INSERT INTO Sales.ItemOrdered VALUES (5, 6, 1),  (5, 7, 1);
INSERT INTO Sales.ItemOrdered VALUES (6, 9, 1),  (6, 6, 1);

INSERT INTO Sales.ItemOrdered VALUES (7, 11, 2), (7, 12, 1), (7, 13, 1); --13
INSERT INTO Sales.ItemOrdered VALUES (8, 11, 1),  (8, 14, 1);
INSERT INTO Sales.ItemOrdered VALUES (9, 11, 1),  (9, 15, 1);

INSERT INTO Sales.ItemOrdered VALUES (10, 16, 1),  (10, 17, 1); --14
INSERT INTO Sales.ItemOrdered VALUES (11, 16, 1),  (11, 18, 1);

INSERT INTO Sales.ItemOrdered VALUES (12, 21, 2), (12, 22, 1), (12, 23, 1); --15
INSERT INTO Sales.ItemOrdered VALUES (13, 21, 1),  (13, 24, 1);
INSERT INTO Sales.ItemOrdered VALUES (14, 21, 1),  (14, 25, 1);

INSERT INTO Sales.ItemOrdered VALUES (15, 26, 1),  (15, 27, 1); --16
INSERT INTO Sales.ItemOrdered VALUES (16, 27, 1),  (16, 29, 1);

-- add more to Order ID 17 - 22:
INSERT INTO Sales.ItemOrdered VALUES (17, 3, 1),  (17, 4, 1); --11
INSERT INTO Sales.ItemOrdered VALUES (18, 3, 1),  (18, 4, 1);

INSERT INTO Sales.ItemOrdered VALUES (19, 16, 1),  (19, 17, 1); --14
INSERT INTO Sales.ItemOrdered VALUES (20, 16, 1),  (20, 17, 1);

INSERT INTO Sales.ItemOrdered VALUES (21, 21, 1),  (21, 24, 1); --15
INSERT INTO Sales.ItemOrdered VALUES (22, 21, 1),  (22, 25, 1);

-- Order ID 23 - 25 for RestID 14 and 26 -28 for RestID 16
INSERT INTO Sales.ItemOrdered VALUES (23, 18, 1),  (23, 19, 2),  (23, 20, 2); --14 ITEMID# 16 - 20
INSERT INTO Sales.ItemOrdered VALUES (24, 17, 1),  (24, 18, 1);
INSERT INTO Sales.ItemOrdered VALUES (25, 19, 1),  (25, 18, 1), (25, 16, 1); 
INSERT INTO Sales.ItemOrdered VALUES (26, 26, 1),  (26, 27, 1); --16 ITEMID# 26-30
INSERT INTO Sales.ItemOrdered VALUES (27, 26, 1),  (27, 29, 1), (27, 28, 2); 
INSERT INTO Sales.ItemOrdered VALUES (28, 26, 1),  (28, 27, 1), (28, 30, 2);

-- Order ID 29 - 31 for RestID 17 and 32 -34 for RestID 18
INSERT INTO Sales.ItemOrdered VALUES (29, 31, 1),  (29, 32, 2),  (29, 34, 2); --17 ITEMID# 31-35
INSERT INTO Sales.ItemOrdered VALUES (30, 31, 1),  (30, 33, 1);
INSERT INTO Sales.ItemOrdered VALUES (31, 31, 1),  (31, 34, 1), (31, 35, 1); 
INSERT INTO Sales.ItemOrdered VALUES (32, 36, 2),  (32, 37, 2); --18 ITEMID# 36-40
INSERT INTO Sales.ItemOrdered VALUES (33, 38, 1),  (33, 36, 1), (33, 39, 2); 
INSERT INTO Sales.ItemOrdered VALUES (34, 40, 1),  (34, 38, 3), (34, 36, 2);


--INSERT OrderReview (OrderID# 1-22), randomly generated:
-- RID, OrderID (int), Rate (1-5), Review (varchar)
INSERT INTO Sales.OrderReview VALUES 
	(1, 5, 'Friendly delivery'),
	(2, 4, 'good'),
	(3, 5, 'Great delivery'),
	(4, 3, 'Okay'),
	(5, 5, 'Great food'),
	(6, 5, 'Friendly delivery'),
	(7, 4, 'good'),
	(8, 5, 'Great delivery'),
	(9, 3, 'Okay'),
	(10, 5, 'Great food'),
	(11, 5, 'Friendly delivery'),
	(12, 4, 'good'),
	(13, 5, 'Great'),
	(14, 3, 'Okay'),
	(15, 5, 'Great food'),
	(16, 5, 'Good experience'),
	(17, 4, 'Good'),
	(18, 5, 'Great food'),
	(19, 2, 'The food is cold and take a while'),
	(20, 5, 'Great food'),
	(21, 4, 'Okay'),
	(22, 1, 'Not a great experience');

-- INSERT OrderReview for Order#23-28:
INSERT INTO Sales.OrderReview VALUES 
	(23, 5, 'Great'),
	(24, 3, 'Good selection but overpriced'),
	(25, 2, 'Better to dine in. It is expensive!'),
	(26, 5, 'Good experience'),
	(27, 4, 'Good'),
	(28, 1, 'Food is bland and delivery takes a long time');

-- INSERT OrderReview for Order#23-28:
INSERT INTO Sales.OrderReview VALUES 
	(29, 3, 'Okay'),
	(30, 5, 'Great food'),
	(31, 5, 'Friendly delivery'),
	(32, 4, 'Good donut!'),
	(33, 5, 'Great flavor'),
	(34, 3, 'Overpriced!');


-- INSERT PAYMENT-------------



-- RETRIEVE results for SALES Schema:
SELECT * FROM Sales.[Order];
SELECT * FROM Sales.ItemOrdered;
SELECT * FROM Sales.Payment;
SELECT * FROM Sales.OrderReview;
