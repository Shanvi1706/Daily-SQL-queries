# Write your MySQL query statement below
WITH session_stats AS (
    SELECT
        rs.book_id,
        COUNT(*) AS total_sessions,
        MAX(rs.session_rating) AS highest_rating,
        MIN(rs.session_rating) AS lowest_rating,
        SUM(
            CASE 
                WHEN rs.session_rating >= 4 
                  OR rs.session_rating <= 2 
                THEN 1 
                ELSE 0 
            END
        ) AS extreme_count
    FROM reading_sessions rs
    GROUP BY rs.book_id
),

filtered_books AS (
    SELECT
        ss.book_id,
        ss.total_sessions,
        ss.highest_rating,
        ss.lowest_rating,
        ss.extreme_count,
        (ss.highest_rating - ss.lowest_rating) AS rating_spread,
        ROUND(ss.extreme_count * 1.0 / ss.total_sessions, 2) AS polarization_score
    FROM session_stats ss
    WHERE
        ss.total_sessions >= 5
        AND ss.highest_rating >= 4
        AND ss.lowest_rating <= 2
        AND (ss.extreme_count * 1.0 / ss.total_sessions) >= 0.6
)

SELECT
    b.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages,
    fb.rating_spread,
    fb.polarization_score
FROM filtered_books fb
JOIN books b
  ON b.book_id = fb.book_id
ORDER BY
    fb.polarization_score DESC,
    b.title DESC;
