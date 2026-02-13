--Hackerrank - https://www.hackerrank.com/challenges/earnings-of-employees/problem?isFullScreen=true
-- solution 
SELECT 
  (months * salary) AS max_earnings,
  COUNT(*) AS employee_count
FROM Employee
GROUP BY (months * salary)
ORDER BY max_earnings DESC
LIMIT 1;
