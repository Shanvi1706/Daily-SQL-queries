# Write your MySQL query statement below
SELECT
  ip,
  COUNT(*) AS invalid_count
FROM (
  SELECT
    ip,
    -- extract octets
    SUBSTRING_INDEX(ip, '.', 1) AS o1,
    SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) AS o2,
    SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) AS o3,
    SUBSTRING_INDEX(ip, '.', -1) AS o4,
    -- number of octets (dots + 1)
    (LENGTH(ip) - LENGTH(REPLACE(ip, '.', '')) + 1) AS octet_count
  FROM logs
) t
WHERE
  -- not exactly 4 octets
  octet_count <> 4
  -- or not all parts are digits separated by dots (handles non-numeric parts)
  OR ip NOT REGEXP '^[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+$'
  -- or any octet numeric and greater than 255
  OR (o1 REGEXP '^[0-9]+$' AND CAST(o1 AS UNSIGNED) > 255)
  OR (o2 REGEXP '^[0-9]+$' AND CAST(o2 AS UNSIGNED) > 255)
  OR (o3 REGEXP '^[0-9]+$' AND CAST(o3 AS UNSIGNED) > 255)
  OR (o4 REGEXP '^[0-9]+$' AND CAST(o4 AS UNSIGNED) > 255)
  -- or any octet has a leading zero (length>1 and starts with 0)
  OR o1 REGEXP '^0[0-9]+$' OR o2 REGEXP '^0[0-9]+$'
  OR o3 REGEXP '^0[0-9]+$' OR o4 REGEXP '^0[0-9]+$'
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;

