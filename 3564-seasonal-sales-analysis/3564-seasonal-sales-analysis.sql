WITH sales_season AS (
    SELECT
        p.category,
        CASE
            WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(s.sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(s.sale_date) IN (6, 7, 8) THEN 'Summer'
            WHEN MONTH(s.sale_date) IN (9, 10, 11) THEN 'Fall'
        END AS season,
        s.quantity,
        s.quantity * s.price AS revenue
    FROM sales s
    JOIN products p
        ON s.product_id = p.product_id
),

category_agg AS (
    SELECT
        season,
        category,
        SUM(quantity) AS total_quantity,
        SUM(revenue) AS total_revenue
    FROM sales_season
    GROUP BY season, category
),

ranked AS (
    SELECT
        season,
        category,
        total_quantity,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY season
            ORDER BY
                total_quantity DESC,
                total_revenue DESC,
                category ASC
        ) AS rn
    FROM category_agg
)

SELECT
    season,
    category,
    total_quantity,
    total_revenue
FROM ranked
WHERE rn = 1
ORDER BY
    CASE season
        WHEN 'Fall' THEN 1
        WHEN 'Spring' THEN 2
        WHEN 'Summer' THEN 3
        WHEN 'Winter' THEN 4
    END;
