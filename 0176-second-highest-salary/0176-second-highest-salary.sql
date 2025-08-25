/* Write your T-SQL query statement below */
SELECT 
    ISNULL(
        (SELECT DISTINCT TOP 1 salary
         FROM Employee
         WHERE salary < (SELECT MAX(salary) FROM Employee)
         ORDER BY salary DESC),
    NULL) AS SecondHighestSalary;
