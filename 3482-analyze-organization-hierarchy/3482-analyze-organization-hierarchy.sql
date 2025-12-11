# Write your MySQL query statement below
WITH RECURSIVE hierarchy AS (
    SELECT 
        employee_id,
        employee_name,
        manager_id,
        salary,
        1 AS level
    FROM Employees
    WHERE manager_id IS NULL

    UNION ALL

    
    SELECT 
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        h.level + 1
    FROM Employees e
    JOIN hierarchy h 
        ON e.manager_id = h.employee_id
),


subtree AS (
    SELECT 
        employee_id,
        employee_id AS root,
        salary
    FROM Employees

    UNION ALL

    SELECT 
        e.employee_id,
        s.root,
        e.salary
    FROM Employees e
    JOIN subtree s 
        ON e.manager_id = s.employee_id
)

SELECT 
    h.employee_id,
    h.employee_name,
    h.level,
    
    COUNT(s.employee_id) - 1 AS team_size,
   
    SUM(s.salary) AS budget
FROM hierarchy h
JOIN subtree s 
    ON h.employee_id = s.root
GROUP BY 
    h.employee_id,
    h.employee_name,
    h.level
ORDER BY 
    h.level ASC,
    budget DESC,
    h.employee_name ASC;
