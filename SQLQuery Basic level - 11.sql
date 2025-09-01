--Query - Window Ranking Functions 
--End Date - 1 sept 2025

--ROW_NUMBER()
--Rank the orders based on their sales from highest to lowest

SELECT
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(Order by Sales DESC) SalesRank_ROW
FROM Sales.Orders

--RANK/DENSE_RANK()
--Rank the orders based on their sales from highest to lowest 
SELECT
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(Order by Sales DESC) SalesRank_ROW,
RANK() over(Order by Sales DESC) sALESrANK_rANK,
DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRank_dense
FROM Sales.Orders

--USE CASE OF ROW_NUMBER()
--TOP N ANALYSIS
--Find the top highest sales for each product
SELECT *
FROM 
(
SELECT
OrderID,
ProductID,
Sales,
ROW_number() over ( Partition by ProductID Order by sALES DESC) RANKBYPRODUCT
from Sales.Orders ) t 
WHERE Rankbyproduct = 1

--BOTTOM-N ANALYSIS 
--Find the lowest 2 customers based on their total sales 
SELECT * 
FROM(

SELECT
CustomerID,
SUM(Sales) TotalSales,
ROW_NUMBER() OVER( ORDER BY SUM(Sales)) rankCustomers
FROM Sales.Orders
GROUP BY
CustomerID
)t WHERE RankCustomers <= 2

--GENERATE UNIQUE ID'S
--assign unique ID'S to the rows of the 'ORDERS ARCHIVE table
SELECT 
ROW_NUMBER() OVER (ORDER BY OrderID , oRDERdate) UniqueID,
*
FROM sALES.OrdersArchive

--IDENTIFY DUPLICATES 
--Identify duplicate rows in the table 'OrdersArchive'
--and return a clean result without any duplicates 
SELECT* FROM (
SELECT
ROW_NUMBER() OVER(PARTITION BY ORDERID ORDER BY creationtime DESC) RN,
*
FROM SALES.OrdersArchive
)t where rn>1

--NTILE()
SELECT
OrderID,
Sales,
NTILE(1) OVER (ORDER  BY Sales DESC) onebucket,
NTILE(2) OVER (ORDER BY Sales DESC) twobucket,
NTILE(3) OVER (ORDER BY Sales DESC) Threebcket
FROM Sales.Orders

--USE CASE 
--DATA SEGMENTATION for DATA ANALYST
--Segmentall orders into 3 categories : high , medium and low sales 
SELECT
*,
CASE WHEN Buckets = 1 THEN 'High'
     WHEN Buckets = 2 THEN 'Medium'
     WHEN Buckets = 3 THEN 'Low'
END SalesSegmentations
FROM(
SELECT
OrderID,
Sales,
NTILE(3) over (ORDER BY sales DESC)Buckets
FROM Sales.Orders
)t


-- EQUALIZING LOAD FOR DATA ENGINEER
--In order to export the data , divide the orders into 2 groups 
SELECT 
NTILE(2) OVER (ORDER BY ORDERID) BUCKETS,
*
FROM Sales.ORDERS

--PERCENTAGE - based ranking functions 
--CUME_DIST
--Find the producs that fall within the highest 40 % of prices 
select
*,
CONCAT(DistRank * 100, '%') DistRankPerc
FROM (
SELECT
Product,
Price,
CUME_DIST() OVER (ORDER BY Price DESC ) DistRank
FROM Sales.Products
)t 
WHERE DistRank <= 0.4




