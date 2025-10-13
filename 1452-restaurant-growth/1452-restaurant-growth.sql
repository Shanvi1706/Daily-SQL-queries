# Write your MySQL query statement below
WITH daily AS (
  SELECT visited_on, SUM(amount) AS total_amount
  FROM Customer
  GROUP BY visited_on
)
SELECT
  d1.visited_on,
  SUM(d2.total_amount) AS amount,
  ROUND(SUM(d2.total_amount) / 7, 2) AS average_amount
FROM daily d1
JOIN daily d2
  ON d2.visited_on BETWEEN DATE_SUB(d1.visited_on, INTERVAL 6 DAY) AND d1.visited_on
WHERE d1.visited_on >= (
  SELECT DATE_ADD(MIN(visited_on), INTERVAL 6 DAY) FROM daily
)
GROUP BY d1.visited_on
ORDER BY d1.visited_on;
