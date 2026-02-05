-- HackerRank: Type of Triangle
--Link: https://www.hackerrank.com/challenges/what-type-of-triangle/problem?isFullScreen=true

-- **Task:**  
Classify triangles based on side lengths into Equilateral, Isosceles, Scalene, or Not a Triangle using SQL CASE logic.
  
SELECT
    CASE
        WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR B = C OR A = C THEN 'Isosceles'
        ELSE 'Scalene'
    END
FROM TRIANGLES;
