--QUERY : filtering data 
--END DATE : 22 aug 2025 


--LOGICAL OPERATORS ( and , or , not )
--AND (All conditions must be true)

--Retrieve all customers who are from the USA  AND have a score greater than 500
SELECT *
FROM Customers 
WHERE country = 'USA'
AND score > 500

--OR( at least one conditon must be true)
--Retrieve all customers who are either from the USA  OR  have a score greater than 500 )
SELECT *
FROM customers 
WHERE country = 'USA'
OR score > 500

--NOT ( REVERSE ( excludes the matching values))
--Retrieve all customers with a score Not LESS THAN 500 
SELECT* 
FROM customers 
WHERE NOT score < 500

--RANGE operators (BETWEEN)
--check if a value is within a range 
--reteieve all cutomers whose score falls in the range bebtween 100 and 500
SELECT * 
FROM customers 
WHERE score BETWEEN 100 AND 500

--MEMBERSHIP OPEARTORS ( IN , NOT IN )
--RETRIEVE all customers from either germany or uk 
SELECT * 
FROM customers
WHERE country IN ('Germany', 'USA')  

--SEARCH OPERATOR ( like)
--SEARCH FOR A PATTERN IN TEXT 
--find all customers whpse first name starts with 'M'
SELECT * 
from customers 
WHERE first_name LIKE 'M%'

--find all customers whose first name ends with 'n'
SELECT * 
from customers 
WHERE first_name LIKE '%N'

--FIND ALL CUTSOMERS WHOSE FIRST NAME CONTAINS 'R'
SELECT * 
from customers 
WHERE first_name LIKE '%R%'

--fIND ALL customers whose first name has 'r' in the third position 
SELECT * 
from customers 
WHERE first_name LIKE '__r%'




