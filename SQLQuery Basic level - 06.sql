--Query - SET operators ( UNION , UNON ALL, EXCEPT, INTERSECT )
--End Date - 24 aug 2025

--UNION 
--Combine the data from employees and customers into one table .
SELECT 
    FirstName,
    Lastname
FROM sales.customers
UNION 
SELECT 
FirstName,
Lastname
from sales.employees; 

--UNION ALL
--Combine the data from employees and customers into one table, including duplicates. 
SELECT 
    FirstName,
    Lastname
FROM sales.customers
UNION ALL 
SELECT 
FirstName,
Lastname
from sales.employees; 

--EXCEPT
--Find the employees who are not customers at the same time
SELECT 
    FirstName,
    Lastname
FROM sales.employees
EXCEPT  
SELECT 
FirstName,
Lastname
from sales.customers;

--INTERSECT
--Find employees who are also customers
SELECT 
    FirstName,
    Lastname
FROM sales.employees
INTERSECT
SELECT 
FirstName,
Lastname
from sales.customers;

--COMBINE SET OPERATERS 
--(UNIONS)
--Orders are stored in separate tables ( Orders and OrdersArchive)
--Combine all order into one report without duplicates. 
SELECT 
'Orders' AS sourcetable
  ,[OrderID],
      [ProductID],
      [CustomerID],
      [SalesPersonID],
      [OrderDate],
      [ShipDate],
      [OrderStatus],
      [ShipAddress],
      [BillAddress],
      [Quantity],
      [Sales],
      [CreationTime]

from sales.orders
UNION  
SELECT 
'OrdersArchive' AS sourcetable
      , [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from sales.ordersarchive
ORDER BY OrderID

