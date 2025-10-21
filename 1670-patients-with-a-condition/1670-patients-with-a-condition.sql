# Write your MySQL query statement below
SELECT 
    patient_id,
    patient_name,
    conditions
FROM 
    Patients
WHERE 
    conditions LIKE '% DIAB1%'     -- condition appears in middle
    OR conditions LIKE 'DIAB1%'    -- condition starts the string
    OR conditions LIKE '% DIAB1';  -- condition appears at end
