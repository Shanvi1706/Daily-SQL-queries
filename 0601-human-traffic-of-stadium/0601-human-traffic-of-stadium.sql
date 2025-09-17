# Write your MySQL query statement below
SELECT id, visit_date, people
FROM (
    SELECT *,
           LEAD(people,1) OVER (ORDER BY id) AS next1,
           LEAD(people,2) OVER (ORDER BY id) AS next2,
           LAG(people,1) OVER (ORDER BY id) AS prev1,
           LAG(people,2) OVER (ORDER BY id) AS prev2
    FROM Stadium
) t
WHERE people >= 100
  AND (
       (people >= 100 AND next1 >= 100 AND next2 >= 100)
    OR (people >= 100 AND prev1 >= 100 AND prev2 >= 100)
    OR (people >= 100 AND prev1 >= 100 AND next1 >= 100)
  )
ORDER BY visit_date;
