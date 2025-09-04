--QUERY - ADVANCED SQL TECHNIQUE 
-- END DATE - 5 sept 2025

--INFORMATION SCHEMA 
SELECT 
DISTINCT TABLE_NAME 
FROM INFORMATION_SCHEMA.COLUMNS

--SUBQUERY :- RESULT SUBQUERY 
--SCALAR SUBQUERY 
SELECT
AVG(Sales)
FROM Sales.Orders

--ROW SUBQUERY 
SELECT
CustomerID
FROM Sales.Orders

--TABLE SUBQUERY 
SELECT
OrderID, 
OrderDate
FROM Sales.Orders

--SUBQUERY :- LOCATION/CLAUSES SUBQUERY
--FROM CLAUSE
--Findthe products that have a price higherthan the average price of all products 
SELECT
*
FROM(
SELECT
ProductID,
Price,
AVG(Price) OVER() avgprice
from Sales.Products
)t 
WHERE price> avgprice

--Rank customers based on their total amount of sales 
SELECT
*,
RANK() OVER (ORDER BY TotalSales DESC) CustomerRank
FROM(
SELECT 
CustomerID,
SUM(sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID)t

--SELECT CLAUSE
--Show the product IDS, names prices, and total number of orders 
SELECT
ProductID,
Product,
price,
    (SELECT COUNT(*) TotalOrders FROM Sales.Orders) AS TotalOrders
from Sales.Products;

--JOIN CLAUSE 
--Show all customers details and find the total orders for each customer
SELECT
*
FROM Sales.Customers  AS c
LEFT JOIN ( 
     SELECT
     CustomerID,
     COUNT (*) TotalOrders
     FROM Sales.Orders
     GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID

-- WHERE CLAUSE /Comparison operators 
-- Find the products that have a price higher than the average price 
--of all products 
SELECT
ProductID,
Price 
FROM Sales.Products 
WHERE Price > ( SELECT AVG(price) FROM Sales.Products )

--( it can only put the scalar sub query with the WHERE CLAUSE )

-- WHERE CLAUSE / LOGICAL OPERATORS 
--IN OPERATOR
--Show the details of orders made by customers in Germany 
SELECT
*
FROM Sales.Orders
WHERE CustomerID IN (
        SELECT 
        CustomerID
        FROM Sales.Customers
        WHERE Country  = 'Germany')


-- ANY OPERATOR 
-- Find female employees whose salaries are greater than the salaries of
-- any male employees 
SELECT 
EmployeeID,
FirstName,
Salary
FROM Sales.Employees
WHERE GENDER = 'F'
AND Salary > ANY
(SELECT Salary FROM Sales.Employees WHERE GENDER = 'M')

-- ALL OPERATOR
--Find female employees whose salaries are greater than the salaries of 
-- all male  employees 
SELECT 
EmployeeID,
FirstName,
Salary
FROM Sales.Employees
WHERE GENDER = 'F'
AND Salary > ALL
(SELECT Salary FROM Sales.Employees WHERE GENDER = 'M')

--Non - correlated / correlated sub query 
-- Show all customer details and find the total orders for each customer.
SELECT 
*,
(SELECT
COUNT(*) 
FROM Sales.Orders o WHERE o.CustomerID = c.CustomerID) TotalSales
FROM Sales.Customers c

--EXISTS OPERATOR (WHERE CLAUSE)
--Show the details of orders made by customers in Germany 
SELECT
*
FROM Sales.Orders o
WHERE EXISTS  (
        SELECT 
        1
        FROM Sales.Customers c
        WHERE Country  = 'Germany'
        AND o.customerID = c.customerID)



