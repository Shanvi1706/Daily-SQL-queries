--QUERY - VIEWS
--END DATE - 5 sept 2025

--FIND THE RUNNING TOTAL OF SALES FOR EACH MONTH 
WITH CTE_Monthly_Summary AS
(
SELECT
DATETRUNC(MONTH , OrderDate) OrderMonth,
SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY DATETRUNC(month,OrderDate)
)
SELECT
OrderMonth,
TotalSales,
SUM(TotalSales)OVER (ORDER BY OrderMonth) AS RunningTotal
FROM CTE_Monthly_Summary

--UPDATED IT WITH VIEW--------------------------------

CREATE VIEW Sales.V_Monthly_Summary AS 
(
	SELECT
	DATETRUNC(MONTH , OrderDate) OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
	)

--Provide a view that combines details from orders, products,
--customers and employees.

CREATE VIEW Sales.V_Order_Details AS (
	SELECT
	o.OrderID,
	o.OrderDate,
	p.Product,
	p.Category,
	COALESCE(c.FirstName,'') + ' ' + COALESCE(c.LastName,'') CustomerName,
	c.country CustomerCountry,
	COALESCE(e.FirstName,'') + ' ' + COALESCE(e.LastName,'') SalesName,
	e.Department,
	o.Sales,
	o.Quantity
	FROM Sales.Orders o
	LEFT JOIN Sales.Products p 
	ON p.ProductID = o.ProductID
	LEFT JOIN Sales.Customers c
	ON c.CustomerID = o.CustomerID
	LEFT JOIN Sales.Employees e
	ON e.EmployeeID =  o.SalesPersonID
)

--Provide a view for EU Sales Team 
--that combines details from All Tables
-- And excludes Data related to the USA.
CREATE VIEW Sales.V_Order_Details_EU AS (

	SELECT
	o.OrderID,
	o.OrderDate,
	p.Product,
	p.Category,
	COALESCE(c.FirstName,'') + ' ' + COALESCE(c.LastName,'') CustomerName,
	c.country CustomerCountry,
	COALESCE(e.FirstName,'') + ' ' + COALESCE(e.LastName,'') SalesName,
	e.Department,
	o.Sales,
	o.Quantity
	FROM Sales.Orders o
	LEFT JOIN Sales.Products p 
	ON p.ProductID = o.ProductID
	LEFT JOIN Sales.Customers c
	ON c.CustomerID = o.CustomerID
	LEFT JOIN Sales.Employees e
	ON e.EmployeeID =  o.SalesPersonID
	WHERE c.Country != 'USA'
)



