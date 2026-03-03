--Hackerrank - https://www.hackerrank.com/challenges/interviews/problem?isFullScreen=true
-- Solutions - 
SELECT 
    c.contest_id,
    c.hacker_id,
    c.name,
    SUM(ss.total_submissions),
    SUM(ss.total_accepted_submissions),
    SUM(vs.total_views),
    SUM(vs.total_unique_views)
FROM Contests c
JOIN Colleges col 
    ON c.contest_id = col.contest_id
JOIN Challenges ch 
    ON col.college_id = ch.college_id

LEFT JOIN (
    SELECT challenge_id,
           SUM(total_submissions) AS total_submissions,
           SUM(total_accepted_submissions) AS total_accepted_submissions
    FROM Submission_Stats
    GROUP BY challenge_id
) ss 
ON ch.challenge_id = ss.challenge_id

LEFT JOIN (
    SELECT challenge_id,
           SUM(total_views) AS total_views,
           SUM(total_unique_views) AS total_unique_views
    FROM View_Stats
    GROUP BY challenge_id
) vs 
ON ch.challenge_id = vs.challenge_id

GROUP BY c.contest_id, c.hacker_id, c.name

HAVING 
    SUM(ss.total_submissions) +
    SUM(ss.total_accepted_submissions) +
    SUM(vs.total_views) +
    SUM(vs.total_unique_views) > 0

ORDER BY c.contest_id;
