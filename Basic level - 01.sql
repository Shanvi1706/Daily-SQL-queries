-- QUERY LANGUAGE : SELECT , DINTINCT , TOP , WHERE , GROUP BY 
-- HAVING , ORDER BY 
-- END DATE - 21/AUG/2025





--Retrieve customers with a score not eual to 0
SELECT * 
FROM customers 
WHERE score != 0

-- Retrieve customers from Germany 
SELECT *
From Customers 
WHERE country = 'Germany'

-- Retrieve all customers and sort the results by the highest score first 
SELECT * 
from customers
Order by score DESC  

--Retrieve all customers and sort the results by the 
--country and then by the highest score
SELECT * 
FROM Customers
ORDER BY country ASC , SCORE desc

--find the total score for each country
SELECT 
    COUNTRY,
    first_name,
    SUM (SCORE) AS total_score
FROM customers
GROUP BY country,first_name

--Find the total score and total number of customers for each country
SELECT 
     COUNTRY,
     SUM(score) AS total_score,
     COUNT(id) AS total_customers 
FROM Customers
GROUP BY country

--Find the average score for each country considering only customers with a score not equal to 0
--and return only those countries with an avaerage score greater than 430
SELECT 
    country,
    AVG(score)AS avg_score
FROM CUSTOMERS
WHERE score != 0
GROUP BY country
HAVING avg(score)>430

--Return unique list of all countries 
SELECT DISTINCT country
FROM customers


--Retrieve only 3 customers 
SELECT Top 3
*
FROM CUSTOMERS 

----Retrieve  the top 3 customers with the Highest scores
SELECT TOP 3
* 
from CUSTOMERS 
order by SCORE desc

-- Retrieve the lowest two customers based on the score 
SELECT TOP 2 *
FROM customers
ORDER by score asc

---- GET the Two most recent orders 
SELECT top 2 *
FROM ORDERS 
order by order_date DESC


