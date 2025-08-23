--QUERY : DML ( INSERT , DELETE ,UPDATE  )
--END DATE : 22 aug 2025



INSERT INTO customers (id, first_name, country , score)
VALUES (6, 'Anna' ,'USA ', null),
       (7,'Sam' ,  NULL , 100)
SELECT * FROM customers

--INSERT using SELECT
--copy data from 'customers' table into 'persons'
INSERT INTO persons (id , person_name, birth_dated, phone)
SELECT
id,
first_name,
NULL,
'UNKNOWN'
FROM customers

--UPDATE 
--change the score of customers 6 to 0
UPDATE customers
SET score = 0
where id = 6

SELECT * FROM CUSTOMERS
-- CHANGE the score of customer with id 7 to 0 and update the country to 'UK'
UPDATE customers
SET score = 0,
    country = 'UK'
where id = 7



--Update all customers with a NULL score by setting their score to 0 
UPDATE customers 
SET score = 0 
WHERE score IS NULL 

SELECT * 
FROM customers 
WHERE score IS NULL

--DELETE ( Delete all customers with an ID greater than 5)
DELETE FROM CUSTOMERS 
WHERE id > 5

SELECT * FROM CUSTOMERS

--Delete all data from the table persons 
DELETE FROM Persons 


