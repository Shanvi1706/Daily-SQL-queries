--QUERY - Partiion Plan
-- END DATE - 15 sept 2025

--Step 1: Create a Partition Function 

CREATE PARTITION FUNCTION PartitionByYear (DATE)
AS RANGE LEFT FOR VALUES ('2023-12-31' , '2024-12-31' , '2025-12-31')

--Step 2 : Create Filegroups

ALTER DATABASE SalesDB ADD FILEGROUP FG_2023;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2024;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2025;
ALTER DATABASE SalesDB ADD FILEGROUP FG_2026;

--Step 3: Add .ndf files to each filegroup

ALTER DATABASE SalesDB ADD FILE
(
      NAME = P_2023, --Logical Name
      FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2023.ndf'
)TO FILEGROUP FG_2023;

ALTER DATABASE SalesDB ADD FILE
(
      NAME = P_2024, --Logical Name
      FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2024.ndf'
)TO FILEGROUP FG_2024;

ALTER DATABASE SalesDB ADD FILE
(
      NAME = P_2025, --Logical Name
      FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2025.ndf'
)TO FILEGROUP FG_2025;

ALTER DATABASE SalesDB ADD FILE
(
      NAME = P_2026, --Logical Name
      FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2026.ndf'
)TO FILEGROUP FG_2026;

--Step 4: Create Partition Scheme 

CREATE PARTITION SCHEME SchemePartitionByYear
AS PARTITION PartitionByYear
TO (FG_2023, FG_2024, FG_2025, FG_2026) -- ORDER OF THE FG IS IMPORTRANT

--Step 5 :Craete the Partiition Table 

CREATE TABLE Sales.Orders_Partioned
(
      OrderID INT,
      OrderDate DATE,
      Sales INT
) ON SchemePartitionByYear (OrderDate)

--Step 6: Insert Data Into the Partitioned Table

INSERT INTO Sales.Orders_Partioned VALUES (1, '2023-05-15', 100);
INSERT INTO Sales.Orders_Partioned VALUES (2, '2023-05-20', 50);
INSERT INTO Sales.Orders_Partioned VALUES (3, '2025-12-31', 20);
INSERT INTO Sales.Orders_Partioned VALUES (1, '2026-01-01', 100);
SELECT* FROM Sales.Orders_Partioned

