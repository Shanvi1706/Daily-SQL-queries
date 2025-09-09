# Write your MySQL query statement below
SELECT 
d.name AS department, 
e.name AS Employee,
e.salary AS Salary
FROM (
 SELECT *,
           DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rnk
    FROM Employee
) e
JOIN department d
     ON e.departmentid = d.id 
WHERE e.rnk <= 3
ORDER BY d.name, e.salary DESC;     