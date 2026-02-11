--Hackerrank: https://www.hackerrank.com/challenges/the-blunder/problem?isFullScreen=true
--Solution -
SELECT 
CEILING(AVG(SALARY)-AVG(REPLACE(SALARY,'0','')))
FROM EMPLOYEES;
