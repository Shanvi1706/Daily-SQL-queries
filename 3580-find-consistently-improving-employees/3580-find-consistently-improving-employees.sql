# Write your MySQL query statement below
WITH r AS (
  SELECT 
      pr.employee_id,
      pr.rating,
      ROW_NUMBER() OVER (PARTITION BY pr.employee_id ORDER BY pr.review_date DESC) AS rn
  FROM performance_reviews pr
),
t AS (
  SELECT 
      employee_id,
      MAX(CASE WHEN rn = 1 THEN rating END) AS r1,
      MAX(CASE WHEN rn = 2 THEN rating END) AS r2,
      MAX(CASE WHEN rn = 3 THEN rating END) AS r3
  FROM r
  WHERE rn <= 3
  GROUP BY employee_id
  HAVING COUNT(*) = 3
)
SELECT 
    e.employee_id,
    e.name,
    (r1 - r3) AS improvement_score
FROM t
JOIN employees e ON e.employee_id = t.employee_id
WHERE r1 > r2 AND r2 > r3
ORDER BY improvement_score DESC, e.name ASC;

  ON e.employee_id = ie.employee_id
ORDER BY
    ie.improvement_score DESC,
    e.name ASC;
