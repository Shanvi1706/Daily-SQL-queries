--QUERY - WINDOW VALUE FUNCTIONS
--END DATE - 2 aug 2025

--LEAD/LAG USE CASE
-- MIN/MAX USE CASE 
--(MoM ) ANALYSIS 
--Analyze the month-over-month performance by finding the percentage
--change in sales between the current and previous month 
SELECT
*,
CurrentMonthSales - PreviousMonthSales AS MoM_Change,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales ) AS FLOAT)/PreviousMonthSales *100 , 1) AS MoM_Perc
FROM (
SELECT
Month(OrderDate) OrderMonth,
SUM(Sales) CurrentMonthSales,
LAG(SUM(Sales)) OVER (Order by Month(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY 
Month(Orderdate)
)t

--LEAD 
--Customer Retention Analysis 
--In order to analyze customer loyalty, 
--rank customers on the average days between their orders 
SELECT
CustomerID,
AVG(DaysUntilNextOrder) Avgdays,
RANK() OVER (ORDER BY COALESCE(AVG(DaysUntilNextOrder) , 999999)) RankAvg
FROM (
SELECT
OrderID,
CustomerID,
OrderDate CurrentOrder,
LEAD(OrderDate) OVER (Partition by CustomerID ORDER BY OrderDate) NextOrder ,
DATEDIFF(DAY, OrderDate, LEAD(OrderDate) over (PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
FROM Sales.Orders
)t
GROUP BY 
CustomerID

--FIRST_VALUE/LAST_VALUE()
--Find the lowest and highest sales for each product
--Find the difference in sales between the current and the lowest sales 
SELECT
OrderID,
ProductID,
Sales,
FIRST_VALUE(Sales) OVER (Partition by ProductID ORDER BY Sales) LowestSales,
LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales 
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
Sales - FIRST_VALUE(Sales) OVER (Partition by ProductID ORDER BY Sales) AS SalesDifference,
FIRST_VALUE(Sales) OVER (Partition by productID ORDER BY SALES desc) HIgestSales2
FROM Sales.Orders




