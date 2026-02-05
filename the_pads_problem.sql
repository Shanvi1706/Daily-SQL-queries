-- Hackerrank - The Pads problem
-- Link : https://www.hackerrank.com/challenges/the-pads/problem?isFullScreen=true

-- Solution :->
Select
     CONCAT(Name, '(' , LEFT(Occupation, 1), ')') 
FROM OCCUPATIONS
ORDER BY Name;

Select
  concat(
    'There are a total of ',
    COUNT(*),
    ' ', lower(Occupation),
    's.')
  FROM OCCUPATIONS
  GROUP BY Occupation
  ORDER BY COUNT(*), Occupation;
