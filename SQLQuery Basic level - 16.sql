--QUERY - CTAS & TEMP/ STORED PROCEDURE
-- END DATE - 9 SEPT 2025

--CTAS-----------
-- CREATE A TABLE FOR THE TOTAL NO.OF ORDERS FOR EACH MONTH 
--HOW TO REFRESH IT ? (By T-SQL)
IF OBJECT_ID('Sales.MonthlyOrders' , 'U') IS NOT NULL
   DROP TABLE Sales.MonthlyOrders;
GO
SELECT
      DATENAME(Month, OrderDate) OrderMonth,
     COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)

-- CREATING TEMP TABLES 
SELECT
*
INTO #Orders
FROM Sales.Orders

--STORED PROCEDURE -------------------------------------
--STEP 1: Write a Query
--For US Customers Find the Total Number of Customers and the Average Score

SELECT 
    COUNT(*) TotalCusomers,
    AVG(Score) Avgscore
FROM Sales.Customers
WHERE Country = 'USA'

--STEP 2: Turning the Query Into a Stored Procedure
CREATE PROCEDURE GetCustomerSummary AS
BEGIN
SELECT 
    COUNT(*) TotalCusomers,
    AVG(Score) Avgscore
FROM Sales.Customers
WHERE Country = 'USA'
END

--STEP 3: EXECUTE THE STORED PROCEDURE 

EXEC GetCustomerSummary

--For GERMAN CUSTOMERS FIND THE TOTAL NUMBER OF CUSTOMERS AND THE AVERAGE SCORE
--FOR MULTIPLE STATEMENTS AND PRINTING A MESSAGE TOO 

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) ='USA'
AS
BEGIN

DECLARE @TotalCustomers INT , @AvgScore FLOAT;
--Prepare & Cleanup Data 
IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
BEGIN
     PRINT('Updating NULL Scores to 0');
     UPDATE Sales.Customers
     SET Score = 0
     WHERE Score IS NULL AND Country = @Country;
END

ELSE
BEGIN
     PRINT('No NULL Scores found')
END;


--Generating Reports
SELECT 
    @TotalCustomers = COUNT(*) ,
    @AVGScore = AVG(score)
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total customers from' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
PRINT 'Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR) ;

SELECT
COUNT(OrderID) TotalOrders,
SUM(Sales) TotalSales
FROM Sales.Orders o 
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c .Country = @Country;

END TRY
BEGIN CATCH
    PRINT('An error occured.');
    PRINT('Error Message: ' + ERROR_MESSAGE());
    PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
    PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
    PRINT('Error Procedure ' + ERROR_PROCEDURE());
END CATCH
END 
GO


EXEC GetCustomerSummary @Country ='Germany'

EXEC GetCustomerSummary 

--Find the total no. of orders and total sales 
SELECT
COUNT(OrderID) TotalOrders,
SUM(Sales) TotalSales
FROM Sales.Orders o 
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c .Country = 'USA';




