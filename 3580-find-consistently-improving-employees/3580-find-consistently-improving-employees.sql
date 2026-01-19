# Write your MySQL query statement below
WITH ranked_reviews AS (
    SELECT
        pr.employee_id,
        pr.review_date,
        pr.rating,
        ROW_NUMBER() OVER (
            PARTITION BY pr.employee_id
            ORDER BY pr.review_date DESC
        ) AS rn
    FROM performance_reviews pr
),
last_three AS (
    SELECT
        employee_id,
        MAX(CASE WHEN rn = 1 THEN rating END) AS r1, 
        MAX(CASE WHEN rn = 2 THEN rating END) AS r2,
        MAX(CASE WHEN rn = 3 THEN rating END) AS r3  
    FROM ranked_reviews
    WHERE rn <= 3
    GROUP BY employee_id
    HAVING COUNT(*) = 3
),
improving_employees AS (
    SELECT
        lt.employee_id,
        (lt.r1 - lt.r3) AS improvement_score
    FROM last_three lt
    WHERE lt.r1 > lt.r2
      AND lt.r2 > lt.r3
)
SELECT
    e.employee_id,
    e.name,
    ie.improvement_score
FROM improving_employees ie
JOIN employees e
  ON e.employee_id = ie.employee_id
ORDER BY
    ie.improvement_score DESC,
    e.name ASC;
