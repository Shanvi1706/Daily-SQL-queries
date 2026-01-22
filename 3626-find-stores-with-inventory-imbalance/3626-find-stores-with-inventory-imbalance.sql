# Write your MySQL query statement below
WITH ranked_inventory AS (
    SELECT 
        i.store_id,
        i.product_name,
        i.quantity,
        i.price,
        ROW_NUMBER() OVER (PARTITION BY i.store_id ORDER BY i.price DESC ) AS rn_desc,
        ROW_NUMBER() OVER (PARTITION BY i.store_id ORDER BY i.price ASC) AS rn_asc,
        COUNT(*) OVER (PARTITION BY i.store_id) AS product_count
    FROM inventory i     
),

store_prices AS (
    SELECT 
        store_id,
        MAX(CASE WHEN rn_desc = 1 THEN product_name END) AS most_exp_product,
        MAX(CASE WHEN rn_desc = 1 THEN quantity END) AS most_exp_qty,
        MAX(CASE WHEN rn_asc = 1 THEN product_name END) AS cheapest_product,
        MAX(CASE WHEN rn_asc = 1 THEN quantity END) AS cheapest_qty,
        MAX(product_count) AS product_count
    FROM ranked_inventory
    GROUP BY store_id
)        

SELECT 
    s.store_id,
    s.store_name,
    s.location,
    sp.most_exp_product,
    sp.cheapest_product,
    ROUND(sp.cheapest_qty * 1.0/ sp.most_exp_qty, 2) AS imbalance_ratio 
FROM store_prices sp  
JOIN stores s
ON s.store_id = sp.store_id
WHERE sp.product_count >= 3
    AND sp.most_exp_qty < sp.cheapest_qty
ORDER BY 
    imbalance_ratio DESC,
    s.store_name ASC;    