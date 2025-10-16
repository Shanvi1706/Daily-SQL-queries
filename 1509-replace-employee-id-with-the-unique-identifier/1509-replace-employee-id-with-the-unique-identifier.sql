# Write your MySQL query statement below
SELECT 
    e.unique_id,
    em.name
FROM 
    Employees AS em
LEFT JOIN 
    EmployeeUNI AS e
ON 
    em.id = e.id;
