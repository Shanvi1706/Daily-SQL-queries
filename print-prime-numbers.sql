-- hackerrank - https://www.hackerrank.com/challenges/print-prime-numbers/problem?isFullScreen=true
-- Solution 
WITH RECURSIVE numbers AS (
    SELECT 2 AS num
    UNION ALL
    SELECT num + 1 FROM numbers WHERE num < 1000
),
primes AS (
    SELECT n1.num
    FROM numbers n1
    WHERE NOT EXISTS (
        SELECT 1
        FROM numbers n2
        WHERE n2.num < n1.num
        AND n1.num % n2.num = 0
    )
)
SELECT GROUP_CONCAT(num SEPARATOR '&') AS primes
FROM primes;
