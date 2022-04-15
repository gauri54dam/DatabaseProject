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

--**************************************************
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
