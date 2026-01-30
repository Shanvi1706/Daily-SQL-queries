# Write your MySQL query statement below
WITH reaction_counts AS (
    SELECT
        user_id,
        reaction,
        COUNT(*) AS reaction_count
    FROM reactions
    GROUP BY user_id, reaction
),
total_reactions AS (
    SELECT
        user_id,
        COUNT(*) AS total_count
    FROM reactions
    GROUP BY user_id
    HAVING COUNT(DISTINCT content_id) >= 5
),
dominant_reaction AS (
    SELECT
        rc.user_id,
        rc.reaction AS dominant_reaction,
        rc.reaction_count,
        tr.total_count,
        ROUND(rc.reaction_count * 1.0 / tr.total_count, 2) AS reaction_ratio
    FROM reaction_counts rc
    JOIN total_reactions tr
        ON rc.user_id = tr.user_id
    WHERE rc.reaction_count = (
        SELECT MAX(rc2.reaction_count)
        FROM reaction_counts rc2
        WHERE rc2.user_id = rc.user_id
    )
)
SELECT
    user_id,
    dominant_reaction,
    reaction_ratio
FROM dominant_reaction
WHERE reaction_ratio >= 0.60
ORDER BY reaction_ratio DESC, user_id ASC;
