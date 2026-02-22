--Hackerrank - https://www.hackerrank.com/challenges/weather-observation-station-20/problem?isFullScreen=true
-- Solution - 
SELECT ROUND(AVG(lat_n),4) 
FROM ( SELECT lat_n, ROW_NUMBER() OVER (ORDER BY lat_n) AS rn, COUNT(*) OVER () AS total FROM station ) t 
WHERE rn IN (FLOOR((total+1)/2), FLOOR((total+2)/2));
