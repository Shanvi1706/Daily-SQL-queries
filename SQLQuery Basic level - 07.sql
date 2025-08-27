--Query - ROW-LEVEL SQL Functions  
-- END DATE - 

--STRING FUNCTIONS (CONCAT)
--Show a list of customers first name together with their country in one column 
SELECT 
first_name,
country,
CONCAT(first_name,' ',country) AS name_country
FROM customers

--(UPPER / LOWER)
-- Convert the first name to lowercase 
SELECT 
first_name,
LOWER(first_name) AS low_name 
FROM customers
--Convert the first name to uppercase
SELECT 
first_name,
UPPER(first_name) AS upper_name 
FROM customers

--TRIM
--Find customers whose first name contains leading or trailing spaces
SELECT 
 first_name
From customers 
WHERE first_name != TRIM(first_name)

--REPLACE 
--Remove dashes (-) from a phone number 
SELECT 
'123-456-7890',
REPLACE ('123-456-7890', '-',' ') AS clean_phone 
-- Replace File Extence from txt to csv 
SELECT 
'report.txt' AS old_filename,
REPLACE('report.txt', '.txt' , '.csv') AS new_filename 

--LEN 
--Calculate the length of each customer's first name 
SELECT 
first_name,
LEN(first_name) AS len_name
FROM customers 

--LEFT 
--retrieve he first twocharacters of each first name 
SELECT
first_name,
LEFT(first_name ,2) first_2_char
FROM customers 

--RIGHT
--Retrieve the last two characters of each first name 
SELECT
first_name,
RIGHT(first_name ,2) last_2_char
FROM customers

--SUBSTRING
--Retrieve a list of customers first names removing the first character 
SELECT
first_name,
SUBSTRING(TRIM(first_name), 2, LEN(first_name)) as Sub_name
FROM customers 

--DATE & TIME FUNCTIONS
SELECT
OrderID,
Orderdate,
Shipdate,
CreationTime
from SALES.ORDERS
--(values)
SELECT 
OrderID,--Date from one column
CreationTime,
'2025-08-20' HardCoded,--Hardcoded
GETDATE() Today -- GETDATE
FROM Sales.Orders

--DATE & TIME (Functions)
--Part Extraction (day,month,year)
SELECT
OrderID,
CreationTime,
YEAR(CreationTime) Year,
Month(CreationTime) Month,
DAY( CreationTime) Day
FROM Sales.Orders

--DATEPART/DATENAME/DATETRUNC/EOMONTH()
SELECT
OrderID,
CreationTime,
--EOMONTH Examples
EOMONTH(CreationTime) endOFMONTH,
--DATETRUNC Examples
DATETRUNC(MINUTE , CreationTime) Minute_dt,
DATETRUNC(day , CreationTime) day_dt,
DATETRUNC(year , CreationTime) year_dt,
--DATENAME Examples
DATENAME(month, CreationTime) Month_dn,
DATENAME(Weekday, CreationTime)  week_dn,
--DATEPART Examples
DATEPART(year , CreationTime) Year_dp ,
DATEPART(Hour , CreationTime) Hour_dp, 
DATEPART(Quarter , CreationTime) quarter_dp,
DATEPART(Week , CreationTime) week_dp,
YEAR(CreationTime) Year,
Month(CreationTime) Month,
DAY( CreationTime) Day
FROM Sales.Orders

--How many orders were placed each year?
SELECT
Year(OrderDate),
Count(*) Nooforders
From SALES.ORDERS
GROUP BY YEAR(OrderDate)

--Data Filtering
--Show all orders that were placed during the month of february
SELECT
*
From sales.orders
WHERE Month(Orderdate) = 2

--FORMAT & CASTING 
--FORMATTING 

SELECT
OrderID,
CreationTime,
FORMAT(CreationTime, 'MM-dd-yyyy') USA_format,
FORMAT(CreationTime, 'dd-MM-yyyy') EURO_format,
FORMAT(CreationTime,'dd') dd,
FORMAT(CreationTime,'ddd') ddd,
FORMAT(CreationTime,'dddd') dddd,
FORMAT(CreationTime,'MM') MM,
FORMAT(CreationTime,'MMM') MMM,
FORMAT(CreationTime,'MMMM') MMMM
FROM Sales.Orders

--Show CreationTime using the following format:
--Day Wed Jan Q1 2025 12:34:56 PM ( Q REFERS QUARTER)
SELECT
OrderID,
CreationTime,
'Day ' + FORMAT(CreationTime, 'ddd  MMM') + 
' Q'+ DATENAME(quarter, CreationTime)+ ' ' +
FORMAT(CreationTime, 'yyyy hh:mm:ss tt') AS CustomerFormat
FROM Sales.Orders

--Another query for this format ---
SELECT
FORMAT(OrderDate, 'MMM yy') OrderDate,
COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy')
 
--CONVERT()--
SELECT 
CONVERT(INT, '123') AS [String to Int Convert],
CONVERT(DATE, '2025-08-20') AS [String to Date CONVERT]

--CAST()---------
SELECT
CAST('123'as int) AS [string to Int],
CAST(123 as VARCHAR) AS [Int to string],
CAST('2025-08-20' as DATE) AS [String to Date],
CAST ('2025-08-20' as DATEtime2) AS [String to Datetime],
CreationTime,
CAST(CreationTime AS DATE) as [Datetime to Date]
FROM Sales.Orders

--DATE CALCULATIONS ----
--DATEADD()
SELECT
OrderID,
OrderDate,
DATEADD(day , -10 , OrderDate) AS TendaysBefore,
DATEADD(day , 3 , OrderDate) AS ThreeMOnthssLater
FROM Sales.Orders

--DATEDIFF()------
--Calculate the age of Employees
SELECT
EmployeeID,
BirthDate,
DATEDIFF(year, BirthDate , GETDATE()) Age
from Sales.Employees

--Find the average shipping duration in days for each month---
SELECT
MONTH(OrderDate) as OrderDate,
AVG(DATEDIFF( day, OrderDate , ShipDate)) aVGShip  
from Sales.Orders
Group BY MONTH(OrderDate)

--TIME GAP ANALYSIS
--find the no. of days between each order and the previous order
SELECT
Orderid,
OrderDate CurrentOrderDate,
LAG(OrderDate) Over ( ORDER BY OrderDate) PreviousOrderDate,
Datediff(day ,LAG(OrderDate) Over ( ORDER BY OrderDate) , OrderDate) NOOFDAYS
From Sales.Orders

--Date Validation----
--ISDATE()
SELECT 
ISDATE('123') DateCheck1

--NULL FUNCTIONS--------
--ISNULL | COALESCE
--Find the average scores of the customers 
SELECT
CustomerID,
Score,
Coalesce(Score, 0) Score2,
AVG(Score) Over () AvgScores,
AVG(COALESCE(Score,0)) OVER() AvgScores
FROM Sales.Customers




















