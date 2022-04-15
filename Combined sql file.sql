use master;

DROP DATABASE IF EXISTS DAMG6210_Team1 ;
GO

CREATE DATABASE DAMG6210_Team1;
GO 

USE DAMG6210_Team1;

-- Encryption KEY FOR DB
-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Test_P@sswOrd';
-- Create certificate to protect symmetric key
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'DAMG Certificate',
EXPIRY_DATE = '2026-10-31';
-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;

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
  [OrderStatus] VARCHAR(45) NOT NULL DEFAULT 'Pending',
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
  [PaymentStatus] varchar(45) NOT NULL DEFAULT 'Pending',
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
ALTER TABLE Sales.OrderReview ADD CONSTRAINT RateRange CHECK (Rate BETWEEN 1 AND 5);

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


--Triggers and Stored Procedures

DROP PROCEDURE IF EXISTS [User].insertUser;
CREATE PROCEDURE [User].insertUser 
@UserType varchar,
@LastName varchar(45) ,
@FirstName varchar(45),
@PhoneNo varchar(45),
@Email varchar(45),
@Password varchar(45)
AS

BEGIN
  OPEN SYMMETRIC KEY TestSymmetricKey DECRYPTION BY CERTIFICATE TestCertificate;
  
  INSERT INTO [User].[User] (UserType,LastName, FirstName, PhoneNo,Email,Password)
  VALUES
  (@UserType, @LastName, @FirstName, @PhoneNo, @Email, EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, @Password)));

  CLOSE SYMMETRIC KEY TestSymmetricKey;
END

CREATE TRIGGER [User].[onInsertUser]
  ON [DAMG6210_Team1].[User].[User]  
  FOR INSERT 
AS BEGIN 
  DECLARE @usertype varchar(5);
  DECLARE @userid INT;
  DECLARE @lastMemberId INT;
  
  SELECT @userid = i.UserID from INSERTED i;
  SELECT @usertype = i.UserType from INSERTED i;
    
  
  
  IF(@usertype = 'C')
  BEGIN 
    INSERT INTO DAMG6210_Team1.[User].[Membership] values('Bronze', 0.00, CAST(GETDATE() AS DATE));
    SET @lastMemberId = SCOPE_IDENTITY();
    INSERT INTO DAMG6210_Team1.[User].[Customer] values (@userid, @lastMemberId, null);
    
  END
  IF(@usertype = 'M')
  BEGIN 
    INSERT INTO DAMG6210_Team1.[User].[Manager]  values (@userid);
  END
  IF(@usertype = 'D')
  BEGIN 
    INSERT INTO DAMG6210_Team1.[User].[DeliveryPerson]  values (@userid);
  END   
END

USE DAMG6210_Team1;

-- Database tables DDL scripts = Max
-- Connecting to data input wizard and load data into tables = Jessica
-- Trigger & Function sequence:
--   Step 1: insert data into Order, leave Order.OrderPrice as 0 
--   Step 2: trigger the update of membership (Trigger 1)
--   Step 3: insert data into ItemOrdered, every insert will automatically update the Order.OrderPrice (Trigger 2)
--   Step 4: execute function to update Payment.PaymentAmount (Function 1)


-------------------------------------------- Computed Columns based on a function  ---------------------------------------------------------------------------

-- Function 1 - after the Membership.Discount & Order.OrderPrice having been updated by trigger, calcualte the Payment.PaymentAmount
CREATE FUNCTION UpatePayment
(@OrderID INT)
RETURNS MONEY
AS 
BEGIN 
  DECLARE @OrderPrice MONEY;
  DECLARE @Discount FLOAT;
  DECLARE @CustomerID INT;
  DECLARE @MemberID INT;  
  
  SELECT @CustomerID = CustomerID
  FROM Sales.[Order] o 
  WHERE OrderID = @OrderID
  
  SELECT @MemberID = MemberID
  FROM [User].Customer c 
  WHERE CustomerID = @CustomerID

  SELECT @OrderPrice = OrderPrice
  FROM Sales.[Order] o 
  WHERE OrderID = @OrderID
    
  SELECT @Discount = Discount
  FROM [User].Membership m 
  WHERE MemberID = @MemberID
  
  RETURN @OrderPrice * @Discount
END

ALTER TABLE Sales.Payment ALTER COLUMN PaymentAmount AS (dbo.UpatePayment(OrderID));

--------------------------------------------------------------- Trigger -----------------------------------------------------------

-- Trigger 1: when order inserted, update the Membership.MemberType & Membership.Discount based on date
CREATE TRIGGER UpdateMembershipAndDiscount
  ON Sales.[Order]  
  AFTER INSERT
AS
  BEGIN     
    DECLARE @CustomerInserted INT;        
    DECLARE @MemberType VARCHAR(45);
    DECLARE @Discount FLOAT;
    DECLARE @MemberID INT;    
    DECLARE @StartDate DATE;
    DECLARE @DateDiff INT;
  
    SELECT @CustomerInserted = i.CustomerID
    FROM Inserted i

    SELECT @MemberID = MemberID
    FROM [User].Customer
    WHERE CustomerID = @CustomerInserted

    SELECT @StartDate = StartDate
    FROM [User].Membership
    WHERE MemberID = @MemberID
    
    SET @DateDiff = DATEDIFF(DAY, @StartDate, GETDATE())
    
    IF @DateDiff < 30
      BEGIN 
        SET @MemberType = 'Bronze'
        SET @Discount = 0.00        
      END
    ELSE IF @DateDiff < 60
      BEGIN 
        SET @MemberType = 'Silver'
        SET @Discount = 0.04        
      END
    ELSE IF @DateDiff < 90
      BEGIN 
        SET @MemberType = 'Gold'
        SET @Discount = 0.08        
      END
    ELSE IF @DateDiff < 120
      BEGIN 
        SET @MemberType = 'Platinum'
        SET @Discount = 0.12        
      END
    ELSE 
      BEGIN 
        SET @MemberType = 'Crown'
        SET @Discount = 0.16        
      END   
    
    UPDATE dbo.Membership       
      SET MemberType = @MemberType
      WHERE MemberID = @MemberID
    UPDATE dbo.Membership       
      SET Discount = @Discount
      WHERE MemberID = @MemberID
  END


-- Trigger 2: when ItemOrdered inserted, update the Order.OrderPrice
CREATE TRIGGER UpdateOrderPrice
  ON Sales.ItemOrdered
  AFTER INSERT
AS 
BEGIN 
  DECLARE @NewOrderPrice MONEY;
  DECLARE @OldOrderPrice MONEY;
  DECLARE @OrderID INT;
  DECLARE @NewItemTotal MONEY;
  
  SELECT @OrderID = OrderID
  FROM Inserted i
  
  SELECT @OldOrderPrice = OrderPrice
  FROM Sales.[Order] o2 
  WHERE OrderID = @OrderID
  
  SELECT @NewItemTotal = SUM(m.UnitPrice * i.Quantity)
  FROM Inserted i
  JOIN Restaurant.MenuItems m
  ON i.ItemID = m.ItemID 
  
  UPDATE Sales.[Order]  
    SET OrderPrice = @OldOrderPrice + @NewItemTotal     
    WHERE OrderID = @OrderID            
END


--Trigger 3: change status of OrderStatus based on Payment Status.
DROP Trigger IF EXISTS Sales.changeOrderStatusWithPayment;
CREATE TRIGGER Sales.changeOrderStatusWithPayment ON Sales.Payment 
After UPDATE , INSERT
AS 
BEGIN
  DECLARE @oid int = 0;
  DECLARE @status varchar(45);

  SELECT @oid = OrderID, @status = PaymentStatus FROM inserted i;

  IF @status = 'Completed'
    UPDATE [Sales].[Order] SET OrderStatus = 'Completed' WHERE OrderId = @oid;
  ELSE 
    UPDATE [Sales].[Order] SET OrderStatus = 'Pending' WHERE OrderId = @oid;
END

--******************************************************--
--This stored procedure manually add all 34 orders
DROP PROCEDURE IF EXISTS Sales.insertPaymentManually;
CREATE PROCEDURE Sales.insertPaymentManually 
AS 
BEGIN 
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (1, 7,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (2, 8, 'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (3, 9, 'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (4, 12, 'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (5, 15,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (6, 12,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (7, 15,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (8, 12,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (9, 15,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (10, 10,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (11, 13,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (12, 2,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (13, 3,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (14, 14,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (15, 11,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (16, 16,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (17, 12,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (18, 15,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (19, 12,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (20, 15,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (21, 12,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (22, 15,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (23, 10,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (24, 11,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (25, 10,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (26, 11,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (27, 10,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (28, 11,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (29, 18,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (30, 19,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (31, 18,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (32, 19,'Completed');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (33, 18,'Pending');
  INSERT INTO Sales.Payment (OrderID, CustomerID, PaymentStatus) VALUES (34, 19,'Pending');
END

--******************************************************
-- Views
/*

Code for creating the views on base tables for data analytics.


*/

------------------------------- average rating for restaurant ----

USE [DAMG6210_Team1]
GO

/****** Object:  View [dbo].[avgRating]    Script Date: 4/14/2022 5:34:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[avgRating]  as 

select 
  b.RestaurantID, 
  a.[Name] as Restaurant_Name, 
  count(*) as Review_count, 
  avg(c.Rate) as Business_Rating,
  e.CityName,
  sum(b.OrderPrice) as TotalBusiness
from Restaurant.Restaurant a
join Sales.[Order] b
on a.RestaurantID = b.RestaurantID
join Sales.OrderReview c
on b.OrderID = c.OrderID
join Address.Address d
on a.AddressID = d.AddressID
join Address.City e
on e.CityID = d.CityID
group by b.RestaurantID, a.[Name], CityName
GO

-------------------------------------------------------------------------------

USE [DAMG6210_Team1]
GO

/****** Object:  View [dbo].[topRestaurants]    Script Date: 4/14/2022 5:25:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[topRestaurants] AS
with cte as  (
select a.CustomerID ,c.[Name] as Restaurant_Name,
rank() over (Partition by a.CustomerID order by sum(b.OrderPrice) desc) as [rank] --top 3 order values
from [User].Customer a
join Sales.[Order] b
on a.CustomerID = b.CustomerID
join Restaurant.Restaurant c
on b.RestaurantID = c.RestaurantID
group by a.CustomerID, c.[Name] ) ,
cte1 as 
(Select a.CustomerID, count(distinct b.OrderID) as [TotalOrderCount] --- customer total order count
from [User].Customer a 
join Sales.[Order] b
on a.CustomerID = b.CustomerID
group by a.CustomerID)
select a.CustomerID ,b.TotalOrderCount ,string_agg( cast(a.Restaurant_Name as varchar) ,' , ') as [Top3Restaurant]
from cte as a
join cte1 as b
on a.CustomerID=b.CustomerID
where a.[rank] <=3
group by  a.CustomerID , TotalOrderCount
GO


USE [DAMG6210_Team1]
GO

/****** Object:  View [dbo].[RestaurantReview]    Script Date: 4/14/2022 10:23:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[RestaurantReview] as
with cte as (
select 
  a.[Name] as Restaurant_Name, 
  count(c.orderID) as Review_count, 
  avg(c.Rate) as Business_Rating
from Restaurant.Restaurant a
join Sales.[Order] b
on a.RestaurantID = b.RestaurantID
join Sales.OrderReview c
on b.OrderID = c.OrderID
group by a.[Name]
)
select Restaurant_Name,
    isnull(cast([1] as int), 0) 'Rating 1',
    isnull(cast([2] as int), 0) 'Rating 2',
    isnull(cast([3] as int), 0) 'Rating 3',
    isnull(cast([4] as int), 0) 'Rating 4',
    isnull(cast([5] as int), 0) 'Rating 5'
from
(select Restaurant_Name, Review_count, Business_Rating from cte) as sourceTb
pivot (max(Review_count) for Business_Rating in ([1],[2],[3],[4],[5])) as pivotTb
GO



--CREATE VIEW to retrieve all restaurant menu and pricing in horizontal list:
USE [DAMG6210_Team1]
GO

CREATE VIEW [dbo].[AllRestaurantMenu] as 
  SELECT r.RestaurantID, r.Name, m.MenuName, 
    STRING_AGG(ItemName + ' $' + CAST(UnitPrice AS VARCHAR) 
        , ', ') AS [Item Names and Price]
  FROM Restaurant.Restaurant r
  JOIN Restaurant.Menu m
  ON r.RestaurantID = m.RestaurantID
  JOIN Restaurant.MenuItems mi
  ON m.MenuID = mi.MenuID
  GROUP BY r.RestaurantID, r.Name, m.MenuName;

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
-- AddressID  Street  AptNo ZipCode CityID  StateID AddressType
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

--Insert User, Manager, DeliveryPerson, Customer using StoredProcedure
--SP params - UserType(M - Manager, D - Delivery Person, C - Customer), LastName, FirstName, Phone, Email, Password
EXEC [User].insertUser 'M','Smith','James','2341567890', 'j.smith@gmail.com', 'password@2301';
EXEC [User].insertUser 'M', 'Davis', 'Michael', '2678554444', 'm.smith@gmail.com','password@2345';
EXEC [User].insertUser 'M','Robert','Andrew','5545432456', 'andrew.r@gmail.com', 'password@444';
EXEC [User].insertUser 'M', 'Maria', 'Garcia', '3421245678', 'gracia.@gmail.com', 'password@1111';
EXEC [User].insertUser 'M', 'Hernandez', 'Mary', '7789098765', 'm.hernandez@gmail.com', 'password@5678';
EXEC [User].insertUser 'M', 'Johnson', 'Robert', '5544326789', 'r.johnson@gmail.com', 'password@8888';
EXEC [User].insertUser 'M', 'Oliver', 'John', '5423678900', 'john.o@gmail.com', 'password@6666';
EXEC [User].insertUser 'M', 'Williams', 'Liam', '4445667899', 'liamWilliams@gmail.com', 'password@1991';
EXEC [User].insertUser 'M', 'Brown', 'Lucas', '2344588890', 'lucasbrown.m@gmail.com', 'password@2344';
EXEC [User].insertUser 'M', 'Miller', 'Evelyn', '3421245679', 'evelynmiller.m@gmail.com', 'password@8909';

EXEC [User].insertUser 'D','Jablonski','Karl','6789098765', 'karl.j@gmail.com', 'password@201';
EXEC [User].insertUser 'D', 'Karttunen', 'Matti', '2345436788', 'matti.k@gmail.com','password@45';
EXEC [User].insertUser 'D','Erricson','Tom','7890765423', 'tom.eric.r@gmail.com', 'password';
EXEC [User].insertUser 'D', 'Johnson', 'Michael', '2234567544', 'mic_jon.@gmail.com', 'password@111';
EXEC [User].insertUser 'D', 'Lopez', 'Sofia', '1234543211', 'ms_lopez@gmail.com', 'password@58';
EXEC [User].insertUser 'D', 'Rossi', 'Valentina', '2345678900', 'v_rossi@gmail.com', 'password@88';
EXEC [User].insertUser 'D', 'Patel', 'Sanjay', '2345678900', 'spatel@gmail.com', 'password@6666';
EXEC [User].insertUser 'D', 'Williams', 'Megan', '2345678888', 'Williams_m@gmail.com', 'password@11';
EXEC [User].insertUser 'D', 'Dunphey', 'Luke', '9090767666', 'luke_d.m@gmail.com', 'password@24';
EXEC [User].insertUser 'D', 'Pritchet', 'Jay', '1245432345', 'p_jay.m@gmail.com', 'password@89';

EXEC [User].insertUser 'C','Frank','Benjamin','6567876444', 'b.frank@gmail.com', 'password@20122';
EXEC [User].insertUser 'C', 'Davis', 'Jennifer', '8909765432', 'j_davis@gmail.com','password@4522';
EXEC [User].insertUser 'C','Matt','Liam','2277653454', 'liam_m@gmail.com', 'password22';
EXEC [User].insertUser 'C', 'James', 'Michael', '9878906678', 'mic_j@gmail.com', 'password@1141';
EXEC [User].insertUser 'C', 'Wilson', 'George', '2345142344', 'george_w@gmail.com', 'password@548';
EXEC [User].insertUser 'C', 'Moore', 'Benjamin', '8986725344', 'ben_m@gmail.com', 'password@868';
EXEC [User].insertUser 'C', 'Kapoor', 'Kunal', '3367873456', 'kunal_k@gmail.com', 'password@66';
EXEC [User].insertUser 'C', 'Taylor', 'Ethan', '987653457', 'ethan_t@gmail.com', 'password@11';
EXEC [User].insertUser 'C', 'Anderson', 'Daniel', '8765342122', 'daniel_a.m@gmail.com', 'password@24';
EXEC [User].insertUser 'C', 'Thomas', 'Emily', '9876345625', 'emily_t@gmail.com', 'password@859';
EXEC [User].insertUser 'C','White','Michael','2987634567', 'mic_w.j@gmail.com', 'password@2051';
EXEC [User].insertUser 'C', 'Green', 'Olivia', '9876543442', 'olivia_g@gmail.com','password@455';
EXEC [User].insertUser 'C','Harris','Charlie','785467388', 'charlie_h.r@gmail.com', 'password5';
EXEC [User].insertUser 'C', 'Wilson', 'Oscar', '3898764567', 'oscar_w.@gmail.com', 'password@1151';
EXEC [User].insertUser 'C', 'Harper', 'Poppy', '7874567899', 'poppy@gmail.com', 'password@558';
EXEC [User].insertUser 'C', 'Rossi', 'Noah', '9875643333', 'noah_r@gmail.com', 'password@838';
EXEC [User].insertUser 'C', 'Dawson', 'Jack', '9874562233', 'jack_d@gmail.com', 'password@66466';
EXEC [User].insertUser 'C', 'Anderson', 'Ava', '7645233322', 'ava_a@gmail.com', 'password@141';
EXEC [User].insertUser 'C', 'Brown', 'Margaret', '6532456733', 'margaret_b.m@gmail.com', 'password@244';
EXEC [User].insertUser 'C', 'Thomas', 'Mia', '8933445511', 'thomas_mia@gmail.com', 'password@849';

--Updating the AddressID for customers
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 1 WHERE CustomerID = 2;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 2 WHERE CustomerID = 3;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 3 WHERE CustomerID = 4;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 4 WHERE CustomerID = 5;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 5 WHERE CustomerID = 6;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 6 WHERE CustomerID = 7;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 7 WHERE CustomerID = 8;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 8 WHERE CustomerID = 9;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 9 WHERE CustomerID = 10;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 10 WHERE CustomerID = 11;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 21 WHERE CustomerID = 12;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 22 WHERE CustomerID = 13;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 23 WHERE CustomerID = 14;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 24 WHERE CustomerID = 15;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 25 WHERE CustomerID = 16;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 26 WHERE CustomerID = 17;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 27 WHERE CustomerID = 18;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 28 WHERE CustomerID = 19;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 29 WHERE CustomerID = 20;
UPDATE DAMG6210_Team1.[User].[Customer] SET AddressID = 30 WHERE CustomerID = 21;

-- Retrieve results from Address Schema:
SELECT * FROM Address.Address;
SELECT * FROM Address.City;
SELECT * FROM Address.State;


---------------- INSERT Restaurant SCHEMA----------------------
-- Insert Restaurant Entity
--COLUMN: RestaurantID  ManagerID AddressID Name  PhoneNo OpenTime  CloseTime
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

-- COLUMN: OrderID(IDENTITY)  RestaurantID(11-20) CustomerID(2-21)  DeliveryPersonID(0-9) OrderStatus(varchar)  OrderPrice(function)
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

--OrderID(int)  ItemID(int) Quantity(int)
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
--Clean up Payment
--UPDATE [Sales].[Order] SET OrderStatus = 'Pending';
--DELETE FROM Sales.Payment;
--DBCC CHECKIDENT ('Sales.Payment', RESEED, 0) -- (Database Console Command), reset OrderID identity to 0
--GO

-- Execute Store Procedure
EXEC Sales.insertPaymentManually;
GO

-- RETRIEVE results for SALES Schema:
SELECT * FROM Sales.[Order];
SELECT * FROM Sales.ItemOrdered;
SELECT * FROM Sales.Payment;
SELECT * FROM Sales.OrderReview;

