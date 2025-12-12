# Write your MySQL query statement below
SELECT 
    u.user_id,
    ROUND(AVG(CASE WHEN activity_type = 'free_trial' THEN activity_duration END), 2)
        AS trial_avg_duration,
    ROUND(AVG(CASE WHEN activity_type = 'paid' THEN activity_duration END), 2)
        AS paid_avg_duration
FROM UserActivity u
WHERE u.user_id IN (
    SELECT user_id
    FROM UserActivity
    WHERE activity_type = 'free_trial'
)
AND u.user_id IN (
    SELECT user_id
    FROM UserActivity
    WHERE activity_type = 'paid'
)
GROUP BY u.user_id
ORDER BY u.user_id;
