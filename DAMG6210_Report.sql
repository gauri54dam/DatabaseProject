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


