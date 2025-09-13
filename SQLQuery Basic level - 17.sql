--QUERY - TRIGGERS / INDEXES
--END DATE - 13 sept 2025

--CREATE LOG TABLE 
CREATE TABLE Sales.EmployeeLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    LogMessage VARCHAR(255),
    LogDate Date 
 )
 --CREATING TRIGGER TABLE 

 CREATE TRIGGER trg_AfternsertEmployee On Sales.Employees
 AFTER INSERT 
 AS 
 BEGIN
     INSERT INTO Sales.EmployeeLogs (EmployeeID, LogMessage ,LogDate)
     SELECT
           EmployeeID,
           'New Employee Added =' + CAST(EmployeeID AS VARCHAR),
           GETDATE()
     FROM INSERTED 
 END

 --INSERT NEW DATA INTO EMPLOYEE
SELECT * FROM Sales.EmployeeLogs

INSERT INTO Sales.Employees
VALUES
(7, 'Maria', 'Doe' , 'HR', '1988-01-12' , 'F' , 80000, 3)

--PERFORMANCE OPTIMIZATION - INDEXES --------------
SELECT *
INTO Sales.DBcUSTOMERS
FROM Sales.Customers

CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID)

SELECT
*
FROM Sales.DBCustomers
WHERE LastName= 'Brown'

CREATE NONCLUSTERED INDEX idx_DBCustmers_LastName
ON Sales.DBCustomers(LastName)

--COMPOSITE INDEX -----------------------------------------
SELECT
*
FROM Sales.DBcUSTOMERS
WHHERE Country = 'USA' AND Score > 500

CREATE INDEX idx_DBcUSTOMERS_CountryScore
ON Sales.DBcUSTOMERS (Country , Score)

--CLUSTRERED COLUMNSTORE INDEX----------------
CREATE CLUSTERED COLUMNSTORE INDEX idx_DBcUSTOMERS_CS
ON Sales.DBcUSTOMERS 

DROP INDEX [idx_DBCustomers_CustomerID] ON Sales.DBcUSTOMERS

-- unique index 
SELECT * FROM Sales.Products

CREATE UNIQUE NONCLUSTERED INDEX idx_Products_Product
ON Sales.Products (Product)

--FILTERED INDEX --------------
SELECT * FROM Sales.Customers 
WHERE Country = 'Germany'

create nonclustered inDEX idx_customers_Cuntry 
on sales.customers (Country)
WHERE Country = 'USA'

--Monitoring Index Usage 
SELECT 
    tbl.name AS TableName,
    idx.name AS IndexName,
    idx.type_desc AS IndexType,
    idx.is_primary_key AS IsPrimaryKey,
    idx.is_unique AS IsDisabled,
    s.user_seeks AS UserSeeks,
    s.user_scans AS UserScans,
    s.user_lookups  AS UserLookups,
    s.user_updates AS UserUpdates,
    COALESCE(s.last_user_seeks,s.last_user_scans) LastUpdate
FROM sys.indexes idx
JOIN sys.tables tbl
ON idx.object_id = tbl.object_id
LEFT JOIN sys.dm_db_index_usage_stats s
ON s.object_id = idx.object_id
AND s.index_id = idx.index_id
ORDER BY tbl.name, idx.name

SELECT * FROM sys.dm_db_index_usage_stats

--Monitor Duplicate Indexes -------------------------------------------------
SELECT
tbl.name AS TableName,
col.name AS IndexColumn,
idx.name AS IndexName,
Count(*) OVER (PARTITION BY tbl.name , col.name) ColumnCount
FROM sys.indexes idx
JOIN sys.tables tbl ON idx.object_id = tbl.object_id
JOIN sys.index_columns ic ON idx.object_id = ic.object_id AND idx.index_id = ic.index_id
JOIN sys.columns col ON ic.object_id = col.object_id AND ic.column_id = col.column_id
ORDER BY ColumnCount DESC

