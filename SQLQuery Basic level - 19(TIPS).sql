--Query - Performance Tips 
--EndDate - 16 sept 2025

--Tip 1: Select Only What You Need 

--Bad Practice
SELECT * FROM Sales.Customers 

--Good Practice 
SELECT CustomerID , FirstName, LastName FROM Sales.Customers

--TIP 2 : Avoid unnecessary DISTINCT & ORDER BY

-- BAD PRACTICE 
SELECT DISTINCT
     FirstName
FROM Sales.Customers
ORDER BY FirstName

--Tip 3 : For  Exploration Purpose , Limit Rows!

-- Bad Practice
SELECT
    OrderID,
    Sales
FROM Sales.Orders

--Good Practice
SELECT TOP 10
    OrderID,
    Sales
FROM Sales.Orders

--Tip 4 : Create nonclustered Index on frequentl used Columns in WHERE Clauses 
SELECT * FROM Sales.Orders WHERE OrderStatus = 'Delivered'

CREATE NONCLUSTERED INDEX Idx_Orders_OrderStatus ON Sales.Orders(OrderStatus)

--Tip 5: Avoid applying functions to columns in WHERE clauses

--Bad Practice
SELECT * FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'delivered'

--Good Practice
SELECT * FROM Sales.Orders
WHERE OrderStatus = 'Delivered'

--Tip 6: Avoid leading wildcards as they prevent index usage 

-- Bad Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIKE '%Gold%'

--Good Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIKE 'Gold%'

--Tip 7: USE IN instead of Multiple OR

--Bad Practice
SELECT *
FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 3

--Good Practice
SELECT *
FROM Sales.Orders
WHERE CustomerID IN (1,2,3)

--Tip 8 : Understand The Speed of Joins & Use Inner Join when possible

--Best Performance
SELECT c.firstName, o.OrderID FROM Sales.Customers c INNER JOIN Sales.Orders o ON C.CustomerId = o.CustomerID

--Slightly slower performance
SELECT c.FirstName ,o.OrderID FROM Sales.Customers c RIGHT JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
SELECT c.FirstName ,o.OrderID FROM Sales.Customers c LEFT JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

--Worst Performance
SELECT c.FirstName, o.OrderID FROM Sales.Customers c OUTER JOIN Sales.Orders o ON c.CustoemrID = o.CustomerID

--Tip 9: Use Explicit Join (ANSI JOIN Instead of Implicit Join (non ANSI JOIN)

--Bad Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c, Sales.Orders o
WHERE c.CustomerID = o.CustomerID

--Good Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID

--Tip 10: Make sure to Index the columns used in the ON Clause 
SELECT c.FirstName, o.OrderID
FROM Sales.Orders o
INNER JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID

-- Tip 11: Filter Before Joining (Big Tables)
--Tip 12: Aggregate Before Joining (Big Tables)

-- Tip 13: Use Union Instead of OR in Joins 

-- Tip 14: Chech for Nested Loops and Use SQL HINTS
-- Tip 15 : Use UNION ALL instead of using UNION | duplicates are acceptable
-- Tip 16 : Use UNION ALL + DISTINCT instad of using UNION | duplicates are not acceptable
SELECT DISTINCT CustomerID
FROM (
      SELECT CustomerID FROM Sales.Orders
      UNION ALL 
      SELECT CustomerID FROM Sales.OrdersArchive
) AS CombinedData

-- Tip 17 : Use Columnstore Index for Agrregations on Large Table
SELECT CustomerID, COUNT(OrderID) AS OrderCount
FROM Sales.Orders
GROUP BY CustomerID

CREATE CLUSTERED COLUMNSTORE INDEX Idx_Orders_Columnstore ON Sales.Orders

--Tip 18: Pre-Aggregate Data and store it in new Tablee for Reporting
SELECT MONTH(OrderDate) OrderYear, SUM(Sales) AS TotalSales
INTO Sales.SalesSummary
FROM Sales.Orders 
GROUP BY MONTH(OrderDate) 

SELECT OrderYear, TotalSales FROM Sales.Summary

--Tip 19: EXISTS IS BETTER THAN JOIN

--Tip 20 : Avoid redundant logic in your query 

-- Tip 21: Try to avoid data type VARCHAR & TEXT 
---        Avoid (MAX) unnecessarily large lengths in data types
---        Use the NOT NULL constraint where applicable 
---        Ensure all your tables have a Clustered Primary key 
---        Create a non clustered index for foreign keys that are 
CREATE TABLE CustomersInfo (
     CustomerID INT PRIMARY KEY CONSTRAINT
     FirstName VARCHAR (50) NOT NULL,
     Lastname VARCHAR (50) NOT NULL,
     Country VARCHAR (50) NOT NULL, 
     TotalPurchases FLOAT,
     Score INT,
     BirthDate DATE, 
     EmployeeID INT,
     CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
           REFERENCES Sales.Employees(EmployeerID)
)

CREATE NONCLUSTERED INDEX IX_CustomersInfo_EmployeeID
ON CustomersInfo(EmployeeID) 


-- Tip 22: Avoid Over Indexing 
-- Tip 23: Drop unsused indexes
--Tip 24: Update Statistics(Weekly)
--Tip 25: Reorganize & Rebuild Indexes (Weekly)

--Tip 26: Partition Large Tables(Fscts) to improve performance
--Next, apply a columnstore Index for th best results 

