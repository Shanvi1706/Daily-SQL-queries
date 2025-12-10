# Write your MySQL query statement below
SELECT
    sample_id,
    dna_sequence,
    species,
    
    -- starts with ATG
    CASE WHEN dna_sequence LIKE 'ATG%' THEN 1 ELSE 0 END AS has_start,
    
    -- ends with TAA, TAG, TGA
    CASE 
        WHEN dna_sequence LIKE '%TAA'
          OR dna_sequence LIKE '%TAG'
          OR dna_sequence LIKE '%TGA'
        THEN 1 ELSE 0 
    END AS has_stop,
    
    -- contains ATAT
    CASE WHEN dna_sequence LIKE '%ATAT%' THEN 1 ELSE 0 END AS has_atat,
    
    -- at least 3 consecutive G
    CASE WHEN dna_sequence LIKE '%GGG%' THEN 1 ELSE 0 END AS has_ggg

FROM Samples
ORDER BY sample_id;

