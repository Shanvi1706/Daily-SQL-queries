# Write your MySQL query statement below
SELECT ids.employee_id
FROM (
  SELECT employee_id FROM Employees
  UNION
  SELECT employee_id FROM Salaries
) AS ids
LEFT JOIN Employees e ON ids.employee_id = e.employee_id
LEFT JOIN Salaries s  ON ids.employee_id = s.employee_id
WHERE e.name IS NULL OR s.salary IS NULL
ORDER BY ids.employee_id;
