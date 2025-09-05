--QUERY - CTE (COMMON TABLE EXPRESSION)
--END DATE - 5 sept 2025

--PROJECT
-- #STEP 1 - Find the total sales per customer.(Standalone CTE)
WITH CTE_Total_Sales AS
(
SELECT 
CustomerID,
SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
--#Step 2 - Find the last order date for each customer
,CTE_Last_Order AS
(
SELECT
CustomerID,
MAX(OrderDate) as Last_Order
FROM Sales.orders
Group by CustomerID
)
--#Step 3- Rank Customers based on Total Sales Per Customer(NESTED CTE)
,CTE_Customer_Rank AS 
(
SELECT
     CustomerID,
     TotalSales,
     RANK() OVER (ORDER BY TotaLSales DESC) AS CustomerRank
FROM CTE_Total_Sales
)
--#STEP 4 - Segment customers based on their total sales (Nested CTE)
,CTE_Customer_Segment AS 
(
SELECT
CustomerID,
CASE WHEN TotalSales > 100 THEN 'High'
     WHEN TotalSales > 50 THEN 'Medium'
     ELSE 'Low'
END CustomerSegments
FROM CTE_Total_Sales
)
SELECT 
c.CustomerID,
c.FirstName,
c.LastName,
cts.TotalSales,
clo.Last_Order,
ccr.CustomerRank,
ccs.CustomerSegments
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo 
ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank ccr
ON CCR.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segment ccs
ON ccs.CustomerID = c. CustomerID

--RECURSIVE CTE QUERY 
--Generate a Sequennce of Numbers from 1 to 20
WITH Series AS (
--ANCHOR QUERY
SELECT 
1 as mynumber
UNION ALL
--Recursive Query
SELECT
mynumber + 1
FROM Series
WHERE mynumber < 20
)
--Main Query
SELECT *
FROM Series 

--Show the employee hierarchy by displaying each employee's level within the organization
WITH CTE_Emp_Hierarchy AS
(
SELECT
EmployeeID,
FirstName,
ManagerID,
1 AS LEVEL
FROM Sales.Employees
WHERE ManagerID IS NULL

UNION ALL 

SELECT
    e.EmployeeID,
    e.FirstName,
    e.ManagerID,
    Level + 1 
FROM Sales.Employees AS e
INNER JOIN CTE_Emp_Hierarchy ceh
ON e.ManagerID = ceh.EmployeeID
)

SELECT
*
FROM CTE_Emp_Hierarchy



