--QUERY - WINDOW FUNCTIONS / ANAYTICAL FUNCITONS (BASICS)
--END DATE - 29 AUG 2025

/*Find the total sales across all orders additonally provide details such orderID, order date
*/
SELECT
OrderID,
OrderDate,
SUM(Sales) OVER () TotalSales 
FROM Sales.Orders

--Find the total sales for each product, additionally provide deatails such order id & orderdate 
SELECT
ProductID,
OrderID,
OrderDate,
SUM(sales) OVER (PARTITION BY ProductID) TotalSales
FROM Sales.Orders

--Find the total sales for each combination of product and order status 
SELECT 
ProductID,
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(sales) OVER (PARTITION BY ProductID) TotalSales,
SUM(sales) OVER (PARTITION BY ProductID, OrderStatus) SalesByProductAndStatus
FROM Sales.Orders

--Rank each order based on their sales from highest to lowest ,
--additonaly provide details such order id & order date 
SELECT 
OrderID,
OrderDate,
Sales,
RANK () OVER (ORDER BY Sales ASC) RankSales
FROM Sales.Orders

-- WINDOW FUNCTIONS USE BY RULE 3 :-
--SQL EXECUTE W.F AFTER WHERE CLAUSE 
--Find the total sales for each order status, only for two products 101 and 102 
SELECT 
Orderstatus,
OrderID, 
OrderDate,
ProductID,
Sales,
SUM(Sales) OVER (PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN (101, 102)

--Rank customers based on their total Sales 
SELECT
    CustomerID,
    SUM(Sales) TotalSales,
    RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID







