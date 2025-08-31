--QUERY - WINDOW AGGREGATE FUNCTIONS 
--END DATE - 31 AUG 2025


--COUNT FUNCTION 
--FIND THE TOTAL NUMBERS OF ORDERS
--Find the total orders for each customers
--additionally provide details such as order ID , order date 
SELECT 
OrderID,
OrderDate,
CustomerID,
COUNT(*) OVER() totalORDERS,
COUNT(*) OVER(PARTITION BY CustomerID) as orderpercustomer 
FROM Sales.Orders;

--Find the total number of customers,
--Find the total no. of scores
--additionally provide all customers details 
SELECT 
*,
COUNT(*) OVER() totalcustomers,
COUNT(SCORE) OVER() totalscores
FROM Sales.Customers;

--Duplicates finding 
--Check whether the table 'orders' contains any duplicate rows 
SELECT
OrderID,
COUNT(*) OVER (PARTITION BY OrderID) CheckPK
FROM Sales.Orders;

--SUM FUNCTION
--Find the total sales across all orders
-- and the total sales from each product 
-- additionally, provide details such as Order ID and OrderDate

SELECT
Sales,
ProductID,
OrderID,
OrderDate,
SUM(Sales) OVER () AS Totalsales,
SUM(Sales) OVER (PARTITION BY ProductID) AS Totalsalesbyproduct
FROM Sales.Orders;

--COMPARISON ANALYSIS 
--Find the percentage contribution of each product's sales
--to the total sales 
SELECT
OrderID,
ProductID,
Sales,
SUM(Sales) OVER () TotalSales,
ROUND (CAST(Sales AS Float) / SUM(Sales) OVER () * 100 , 2) PercentageofTotal
FROM Sales.Orders

--AVG FUNCTION
--find the average sales across all orders
--and the avaerage sales for each product .
--Additionally , provide details such as orderID AND orderdate 

SELECT
OrderID,
OrderDate,
Sales,
ProductID,
AVG(Sales) OVER () AVGSALES,
AVG(Sales) OVER (PARTITION BY ProductID) AVGSALESBYPRODUCTS
FROM Sales.Orders;

--DEALING WITH NULLS TOO 
--Find the average scores of customers 
--Additionally , provide details such as CustomerID AND LAST NAME 
SELECT 
CustomerID,
LastName,
Score,
AVG(COALESCE(Score, 0)) OVER() avgsccorewithoutnull
FROM Sales.Customers;

--Find all orders where sales are higher than the average sales 
--across all orders 
SELECT
*
FROM(
SELECT 
OrderID,
ProductID,
Sales,
AVG(Sales) Over() avgsales
FROM Sales.Orders
)t WHERE Sales > AvgSales

--MIN/MAX FUNCTION
--Find the highest & lowest sales across all orders 
--and the hIghest & lowest Sales for each product.
--Additonally , provide details such as OrderID and Order Date
SELECT
OrderID,
OrderDate,
Sales,
ProductID,
MIN(Sales) OVER() lOWESTSALES,
MAX(Sales) OVER() Highestsales,
Min(Sales) Over(Partition by ProductID) Minsalesbyproduct,
Max(Sales) Over(Partition by ProductID) Maxsalesbyproduct
from Sales.Orders;

--Show the employees with the highest salaries 
SELECT
*
FROM (
SELECT
*,
MAX(Salary) OVER () Highestsalary 
FROM Sales.Employees
) t WHERE Salary = HighestSalary

--Calculate the deviation of each sale from both the min and max
-- sales amount 
SELECT
OrderID,
OrderDate,
Sales,
ProductID,
MIN(Sales) OVER() lOWESTSALES,
MAX(Sales) OVER() Highestsales,
Sales - MIN(Sales) OVER() Deviationfrommin,
MAX(Sales) OVER() - Sales as deviationfrommax
from Sales.Orders;

--MOVING AVERAGE 
--Calculate the moving average ofsales for each product over time 
SELECT
OrderID,
ProductID,
OrderDate,
Sales,
AVG(Sales) over (Partition by ProductID)AVGBYPRODUCT,
AVG(Sales) over (Partition by ProductID Order by OrderID) MOVINGAVG
From Sales.Orders;

--alculate the moving average of sales for each product over tiime
--including only the next order .
SELECT
OrderID,
ProductID,
OrderDate,
Sales,
AVG(Sales) over (Partition by ProductID)AVGBYPRODUCT,
AVG(Sales) over (Partition by ProductID Order by OrderID ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING )
From Sales.Orders;







