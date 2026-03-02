-- Hackerrank - https://www.hackerrank.com/challenges/contest-leaderboard/problem?isFullScreen=true
-- Solution - 
SELECT h.hacker_id, h.name, SUM(ms.max_score) AS total_score
FROM Hackers h
JOIN (
    SELECT hacker_id, challenge_id, MAX(score) AS max_score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
) ms
ON h.hacker_id = ms.hacker_id
GROUP BY h.hacker_id, h.name
HAVING SUM(ms.max_score) > 0
ORDER BY total_score DESC, h.hacker_id ASC;
