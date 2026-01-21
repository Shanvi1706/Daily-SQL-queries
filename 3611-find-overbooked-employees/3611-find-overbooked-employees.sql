# Write your MySQL query statement belowWIR
WITH weekly_meetings AS (
    SELECT
        m.employee_id,
        YEARWEEK(m.meeting_date, 3) AS year_week,   
        SUM(m.duration_hours) AS weekly_hours
    FROM meetings m
    GROUP BY
        m.employee_id,
        YEARWEEK(m.meeting_date, 3)
),

meeting_heavy_weeks AS (
    SELECT
        employee_id,
        COUNT(*) AS meeting_heavy_weeks
    FROM weekly_meetings
    WHERE weekly_hours > 20
    GROUP BY employee_id
)

SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    mh.meeting_heavy_weeks
FROM meeting_heavy_weeks mh
JOIN employees e
    ON mh.employee_id = e.employee_id
WHERE mh.meeting_heavy_weeks >= 2
ORDER BY
    mh.meeting_heavy_weeks DESC,
    e.employee_name ASC;



