USE DAMG6210_Team1;

-- Database tables DDL scripts = Max
-- Connecting to data input wizard and load data into tables = Jessica
-- Trigger & Function sequence:
-- 	 Step 1: insert data into Order, leave Order.OrderPrice as 0 
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
				SET @Discount = 0.10				
			END
		ELSE IF @DateDiff < 90
			BEGIN 
				SET @MemberType = 'Gold'
				SET @Discount = 0.20				
			END
		ELSE IF @DateDiff < 120
			BEGIN 
				SET @MemberType = 'Platinum'
				SET @Discount = 0.25				
			END
		ELSE 
			BEGIN 
				SET @MemberType = 'Crown'
				SET @Discount = 0.30				
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

