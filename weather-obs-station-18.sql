--Hackerrank - https://www.hackerrank.com/challenges/weather-observation-station-18/problem
-- Solution-
SELECT
CAST(ROUND(ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W)), 4) as DECIMAL(10,4))
FROM STATION;
