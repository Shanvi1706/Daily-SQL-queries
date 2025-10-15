# Write your MySQL query statement below
WITH UserRatings AS (
   SELECT 
        u.name,
        COUNT(mr.movie_id) AS total_rated
    FROM MovieRating mr 
    LEFT JOIN Users u 
    ON mr.user_id = u.user_id
    GROUP BY u.name
),
TopUser AS (
    SELECT
         name
    FROM UserRatings
    ORDER BY total_rated DESC, name ASC
    LIMIT 1     
),
MovieRatingsFeb AS (
    SELECT
         m.title,
         AVG(mr.rating) AS avg_rating
    FROM MovieRating mr
    JOIN Movies m 
    ON mr.movie_id = m.movie_id
    WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY m.title
),
TopMovie AS (
    SELECT 
         title
    FROM MovieRatingsFeb
    ORDER BY avg_rating DESC, title ASC
    LIMIT 1     
) 
SELECT name AS results FROM TopUser
UNION ALL
SELECT title AS results FROM TopMovie;

