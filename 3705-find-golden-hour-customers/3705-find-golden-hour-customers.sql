# Write your MySQL query statement below
SELECT 
    customer_id,
    COUNT(*) AS total_orders,
    ROUND(
        100.0 * SUM(
            CASE 
                WHEN (
                    (EXTRACT(HOUR FROM order_timestamp) BETWEEN 11 AND 13)
                    OR
                    (EXTRACT(HOUR FROM order_timestamp) BETWEEN 18 AND 20)
                )
                THEN 1 ELSE 0
            END
        ) / COUNT(*),
        0
    ) AS peak_hour_percentage,
    ROUND(AVG(order_rating), 2) AS average_rating
FROM restaurant_orders
GROUP BY customer_id
HAVING 
    COUNT(*) >= 3
    AND
   
    100.0 * SUM(
        CASE 
            WHEN (
                (EXTRACT(HOUR FROM order_timestamp) BETWEEN 11 AND 13)
                OR
                (EXTRACT(HOUR FROM order_timestamp) BETWEEN 18 AND 20)
            )
            THEN 1 ELSE 0
        END
    ) / COUNT(*) >= 60
    AND
    COUNT(order_rating) * 1.0 / COUNT(*) >= 0.5
    AND
    AVG(order_rating) >= 4.0
ORDER BY average_rating DESC, customer_id DESC;
