# Write your MySQL query statement below
WITH trip_efficiency AS (
   SELECT
       t.driver_id,
       EXTRACT(MONTH FROM t.trip_date) AS trip_month,
       (t.distance_km/ t.fuel_consumed) AS efficiency
       FROM trips t
),

half_year_Avg AS (
    SELECT
        driver_id,
        AVG(CASE 
            WHEN trip_month between 1 AND 6 THEN efficiency
         END) AS first_half_avg,
        AVG(CASE
            WHEN trip_month between 7 and 12 THEN efficiency
        END) AS second_half_avg     
    FROM trip_efficiency
    GROUP BY driver_id      
)

SELECT 
    d.driver_id,
    d.driver_name,
    ROUND(h.first_half_avg, 2) AS first_half_avg,
    ROUND(h.second_half_avg, 2) AS second_half_avg,
    ROUND(h.second_half_avg - h.first_half_avg, 2) AS efficiency_improvement
FROM half_year_avg h
JOIN drivers d
    ON h.driver_id = d.driver_id
WHERE h.first_half_avg IS NOT NULL
 AND  h.second_half_avg IS Not NULL
 AND  h.second_half_avg > h.first_half_avg
 ORDER BY 
    efficiency_improvement DESC,
    d.driver_name ASC;  


