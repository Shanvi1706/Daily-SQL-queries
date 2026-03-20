-- Stratascratch - https://platform.stratascratch.com/coding/10318-new-products?code_type=3
-- Solution -
SELECT 
    company_name,
    SUM(CASE WHEN year = 2020 THEN 1 ELSE 0 END) -
    SUM(CASE WHEN year = 2019 THEN 1 ELSE 0 END) AS net_difference
FROM car_launches
WHERE year IN (2019, 2020)
GROUP BY company_name;
