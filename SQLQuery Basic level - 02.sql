--QUERY : DDL COMMANDS : CREAE ,ALTER, DROP
-- END DATE : 21 aug 2025



--CREATE a new table called persons with columns : id, person_name ,  birth-date, phone
CREATE TABLE persons (
     id INT NOT NULL,
     person_name VARCHAR(50),
     birth_dated DATE,
     phone VARCHAR (15) NOT NULL,
     CONSTRAINT PK_PEPRSONS primary key (id)
)
-- ALTER (add a new column caled email to the persons table )
ALTER TABLE persons
ADD EMAIL VARCHAR(50) NOT NULL

SELECT * FROM PERSONS
-- Remove the column phone from the persons table 

ALTER TABLE persons
DROP COLUMN phone

--delete the table persons from database
DROP TABLE persons