--Stratascratch - https://platform.stratascratch.com/coding/10308-salaries-differences?code_type=3
-- Solution - 
SELECT 
    ABS(m.max_salary - e.max_salary) AS salary_difference
FROM
    (SELECT MAX(salary) AS max_salary
     FROM db_employee e
     JOIN db_dept d ON e.department_id = d.id
     WHERE d.department = 'marketing') m,

    (SELECT MAX(salary) AS max_salary
     FROM db_employee e
     JOIN db_dept d ON e.department_id = d.id
     WHERE d.department = 'engineering') e;
