-- Stratascratch -https://platform.stratascratch.com/coding/10172-best-selling-item?code_type=3
-- Solution -
WITH monthly_sales AS (
    SELECT 
        MONTH(invoicedate) AS month,
        description,
        SUM(unitprice * quantity) AS total_paid
    FROM online_retail
    WHERE quantity > 0
      AND invoiceno NOT LIKE 'C%'
    GROUP BY MONTH(invoicedate), description
),
ranked_sales AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY total_paid DESC) AS rnk
    FROM monthly_sales
)
SELECT 
    month,
    description,
    total_paid
FROM ranked_sales
WHERE rnk = 1;
