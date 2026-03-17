-- Hackerrank - https://www.hackerrank.com/challenges/draw-the-triangle-1/problem?isFullScreen=true
-- Solution - 
WITH RECURSIVE pattern(n) AS (
    SELECT 20
    UNION ALL
    SELECT n - 1 FROM pattern WHERE n > 1
)
SELECT REPEAT('* ', n) AS pattern
FROM pattern;
