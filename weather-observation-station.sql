--Hackerrank - https://www.hackerrank.com/domains/sql?filters%5Bstatus%5D%5B%5D=unsolved&badge_type=sql
--Solution - 
SELECT 
    ROUND(SUM(LAT_N), 2) AS sum_lat,
    ROUND(SUM(LONG_W), 2) AS sum_long
FROM STATION;
