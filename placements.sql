-- Hackerrank - https://www.hackerrank.com/challenges/placements/problem?isFullScreen=true
-- Solution - 
SELECT s.Name
FROM Students s 
JOIN Friends f
   ON s.ID = f.ID
JOIN Packages p1
   ON s.ID = p1.ID  
JOIN Packages p2
   ON f.friend_ID = p2.ID
WHERE p2.salary > p1.salary
ORDER BY p2.salary;
