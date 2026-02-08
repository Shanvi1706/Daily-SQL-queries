--Hackerrank - Binary tree problem
--Link - https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true

Solution:
SELECT 
    N,
    CASE
        WHEN P IS NULL THEN 'Root'
        WHEN N NOT IN (SELECT DISTINCT P FROM BST WHERE P IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS NodeType
FROM BST
ORDER BY N;
