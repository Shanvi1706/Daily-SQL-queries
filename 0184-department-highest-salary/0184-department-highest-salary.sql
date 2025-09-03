# Write your MySQL query statement below
SELECT 
    d.name AS department,
    e.name AS employee,
    e.salary
FROM Employee e
JOIN Department d
    ON e.departmentId = d.id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE departmentId = e.departmentId
);
