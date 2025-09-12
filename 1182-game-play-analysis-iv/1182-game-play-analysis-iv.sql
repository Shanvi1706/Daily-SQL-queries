# Write your MySQL query statement below
SELECT 
  ROUND(
    COUNT(DISTINCT next_day.player_id) / COUNT(DISTINCT all_players.player_id),
    2
  ) AS fraction
FROM Activity all_players
LEFT JOIN (
    SELECT DISTINCT a.player_id
    FROM Activity a
    JOIN (
        SELECT player_id, MIN(event_date) AS first_login
        FROM Activity
        GROUP BY player_id
    ) f
      ON a.player_id = f.player_id
    WHERE a.event_date = DATE_ADD(f.first_login, INTERVAL 1 DAY)
) next_day
ON all_players.player_id = next_day.player_id;
