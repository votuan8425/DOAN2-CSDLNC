--3a
go 
create function getStandard_Cost (@productId int, @Orderdate date)
RETURNS money 
AS 
-- Returns the standard cost for the product on a specific date.
BEGIN
    DECLARE @StandardCost money;

    SELECT @StandardCost = pch.StandardCost
    FROM Production.Product p 
        INNER JOIN Production.ProductCostHistory pch 
        ON p.[ProductID] = pch.[ProductID] 
            AND p.[ProductID] = @ProductID 
            AND @OrderDate BETWEEN pch.StartDate AND COALESCE(pch.EndDate, CONVERT(datetime, '99991231', 112));

    RETURN @StandardCost;	
END;
go

select dbo.getStandard_Cost(707,'2012-10-01') as StandardCost
go
--3b
go
Create function Stock_at_location (@locationID int , @productid int)
returns int
as

begin
return (select sum(Quantity) from Production.ProductInventory P where P.LocationID = @locationID and P.ProductID = @productid ) 
end

go
select dbo.Stock_at_location(50,1) as Quantity;
go