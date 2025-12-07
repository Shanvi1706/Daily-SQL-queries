# Write your MySQL query statement below
WITH ordered AS (
    SELECT
        student_id,
        subject,
        score,
        exam_date,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date ASC) AS rn_first,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date DESC) AS rn_last
    FROM Scores
),
first_last AS (
    SELECT
        f.student_id,
        f.subject,
        f.score AS first_score,
        l.score AS latest_score
    FROM ordered f
    JOIN ordered l
        ON f.student_id = l.student_id
       AND f.subject = l.subject
    WHERE f.rn_first = 1
      AND l.rn_last = 1
)
SELECT
    student_id,
    subject,
    first_score,
    latest_score
FROM first_last
WHERE latest_score > first_score
ORDER BY student_id, subject;

                    