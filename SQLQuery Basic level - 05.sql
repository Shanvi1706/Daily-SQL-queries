--QUERY : COMBINING data ( JOINS , SET OPERATORS)
--END DATE:

-- BASIC JOINS --------------------------------------------------------
--1. NO JOIN 
--Retrieve all data from customers and orders as separate results 
SELECT * 
FROM customers;
SELECT*
FROM orders;
--2. INNER JOIN
--Get ALL CUSTOMERS along with their orders but only for customers who have placed an order
SELECT * 
FROM customers 
INNER JOIN orders
ON id = customer_id

--3.LEFT JOIN 
--Get all customers along with their orders , including those without orders 
SELECT 
     c.id,
     c.first_name,
     o.order_id,
     o.sales
FROM customers AS c
LEFT JOIN orders AS o 
ON  c.id = o.customer_id

--GET all customers along with their orders, including orders without matching customers
SELECT 
     c.id,
     c.first_name,
     o.order_id,
     o.sales
FROM orders AS o
LEFT JOIN customers AS c 
ON  c.id = o.customer_id


--4.RIGHT JOIN 
--GET all customers along with their orders, including orders without matching customers
SELECT
     c.id,
     c.first_name,
     o.order_id,
     o.sales
FROM customers AS c
RIGHT JOIN orders AS o 
ON  c.id = o.customer_id

--5.FULL JOIN 
--get all customers and all order , even if there's no match 
SELECT 
     c.id,
     c.first_name,
     o.order_id,
     o.sales
FROM customers AS c
FULL JOIN  orders AS o
ON c.id = o.customer_id

--ADVANCED JOINS--------------------------------------------------
--1.LEFT ANTI JOIN
--get all customers who haven't placed any order 
SELECT * 
FROM Customers AS c
LEFT JOIN orders AS o 
ON c.id = o.customer_id
WHERE o.customer_id IS NULL 

--2.RIGHT ANTI JOIN
-- Get all orders without matching customers 
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o 
ON c.id = o.customer_id
WHERE c.id IS NULL

-- GET ALL ORDERS WITHOUT MATCHING COLUMNS USING LEFT JOINS)
SELECT *
FROM orders AS o
LEFT JOIN customers AS c 
ON c.id = o.customer_id
WHERE c.id IS NULL


--3.FULL ANTI JOIN 
--find customers without orders and orders without customers 
SELECT * 
FROM customers AS c 
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL 
OR c.id IS NULL  

-- Get all customers along with their orders, but only for customers who have placed an order 
--(Without using INNER JOIN)
SELECT *
FROM customers AS c 
LEFT JOIN orders AS o 
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL 

--4. CROSS JOIN
--Generate all possible combinations of customers and orders. 
SELECT *
FROM customers 
CROSS JOIN orders 

--MULTI JOIN TYPE --------------------------------------------------
-- using SALESDB , retrieve a list of all orders , along with the related
--customer, product, and employee details .For each order , display :
--Order ID, Customer's name , PRODUCT name , Sales , Price , Sales person's name 

SELECT 
    o.OrderID,
    o.Sales,
    c.Firstname AS CustomerFirstName,
    c.Lastname AS CustomerLastname,
    p.Product AS ProductName,
    p.Price,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS  EmployeeLastName
FROM sales.Orders AS o
LEFT JOIN sales.customers AS c 
ON o.customerID = c.customerID  
LEFT JOIN sales.products AS p 
ON o.productID = p.ProductID 
LEFT JOIN sales.employees AS e
ON o.salespersonID = e.EmployeeID
 



SELECT * 
FROM Sales.Customers;

SELECT * 
FROM Sales.Employees;

SELECT * 
FROM Sales.Orders;

SELECT * 
FROM Sales.OrdersArchive;

SELECT * 
FROM Sales.Products;





