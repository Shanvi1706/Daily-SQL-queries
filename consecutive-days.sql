-- Stratascratch - https://platform.stratascratch.com/coding/2054-consecutive-days/discussion?code_type=3
-- Solution - 
WITH distinct_dates AS (
    SELECT DISTINCT user_id, record_date
    FROM sf_events
),
date_groups AS (
    SELECT 
        user_id,
        record_date,
        DATE_SUB(record_date, INTERVAL 
            ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY record_date) DAY
        ) AS grp
    FROM distinct_dates
),
streaks AS (
    SELECT 
        user_id,
        COUNT(*) AS streak_length
    FROM date_groups
    GROUP BY user_id, grp
)
SELECT DISTINCT user_id
FROM streaks
WHERE streak_length >= 3;
