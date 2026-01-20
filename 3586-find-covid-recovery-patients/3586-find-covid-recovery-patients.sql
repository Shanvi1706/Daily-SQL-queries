# Write your MySQL query statement below
WITH first_positive AS (
    SELECT
    patient_id,
    MIN(test_date) as first_positive_date
    FROM covid_tests ct
    WHERE result = 'Positive'
    GROUP BY patient_id
),

first_negative_after_positive AS (
    SELECT
         ct.patient_id,
         MIN(ct.test_date) AS first_negative_date
    FROM covid_tests ct
    JOIN first_positive fp 
        ON ct.patient_id = fp.patient_id
        AND ct.test_date > fp.first_positive_date
   WHERE ct.result = 'Negative'
   GROUP BY ct.patient_id      
)

SELECT 
    p.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(fn.first_negative_date, fp.first_positive_date) AS recovery_time 
FROM patients p 
JOIN first_positive fp 
   ON p.patient_id = fp.patient_id
JOIN first_negative_after_positive fn
   ON p.patient_id = fn.patient_id
ORDER BY 
    recovery_time ASC,
    p.patient_name ASC;          

