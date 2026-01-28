# Write your MySQL query statement below
WITH top_performers AS (
    SELECT
        user_id
    FROM course_completions
    GROUP BY user_id
    HAVING
        COUNT(*) >= 5
        AND AVG(course_rating) >= 4
),
ordered_courses AS (
    SELECT
        c.user_id,
        c.course_name AS first_course,
        LEAD(c.course_name) OVER (
            PARTITION BY c.user_id
            ORDER BY c.completion_date
        ) AS second_course
    FROM course_completions c
    JOIN top_performers t
        ON c.user_id = t.user_id
)
SELECT
    first_course,
    second_course,
    COUNT(*) AS transition_count
FROM ordered_courses
WHERE second_course IS NOT NULL
GROUP BY first_course, second_course
ORDER BY
    transition_count DESC,
    first_course ASC,
    second_course ASC;
