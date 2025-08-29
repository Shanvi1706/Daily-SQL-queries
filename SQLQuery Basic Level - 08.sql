--Query - CASE STATEMENT 
--End Date - 29 aug 2025

--CASE STATEMENT
--Categorizing data
--Generate a report showing the total sales for each category
--high : If the sales higher than 50 
--Medium : If the sales between 20 and 50 
--Low: If the sales equal or lower than 20 
--Sort the result from lowest to highest.
SELECT
Category,
SUM(Sales) AS TotalSales
FROM (
   SELECT 
   OrderID,
   Sales,
   CASE 
        WHEN Sales > 50 THEN 'High'
        WHEN Sales > 20 THEN 'Medium'
        ELSE 'Low'
   END Category
   FROM Sales.Orders
) AS t
GROUP BY Category
Order by TotalSales  ASC;
-- Mapping Value 
--Retrieve employee details with gender displayed as full text
SELECT
EmployeeID,
Firstname,
Lastname,
Gender,
CASE
    WHEN Gender = 'F' THEN 'Female'
    WHEN Gender = 'M' THEN 'Male'
    ELSE 'NoT AVAILABLE'
END Genderfulltext
FROM Sales.Employees

--Retrieve customer details with abbreviated country code 
SELECT
CustomerID,
FirstName,
Lastname,
Country,
CASE 
    WHEN Country = 'Germany' THEN 'DE'
    WHEN Country = 'USA' THEN 'US'
    ELSE 'n/a'
  END Countryabbr
FROM Sales.Customers

--Handling NULLS 
--Find the average scores of customers and treat Nulls as 0
--And additional provide details such CustomerID & Lastname 
SELECT 
Customerid,
Lastname,
Score,
CASE
   WHEN Score IS NULL THEN 0
   ELSE Score
END ScoreClean,

AVG (CASE
   WHEN Score IS NULL THEN 0
   ELSE Score
END) OVER () AvgCustomerClean,

AVG(Score) OVER() AvgCustomer
FROM Sales.Customers

--Conditional Aggregations
--Count how many times each customer has
--made an order with sales greater than 30 
SELECT
CustomerID,
  SUM(CASE
      WHEN Sales > 30 THEN 1
      ELSE 0
   END) TotalOrdersHighSales,
   COUNT(*) TotalOrders
FROM Sales.Orders
GROUP by CustomerID




  

