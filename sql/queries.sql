-- Hospital Readmission Analysis: Business Queries
-- Database: hospital.db (SQLite), table: encounters

-- 1. Readmission rate by age group
SELECT 
    age,
    COUNT(*) AS total_patients,
    SUM(readmitted_30d) AS readmitted_count,
    ROUND(AVG(readmitted_30d) * 100, 2) AS readmission_rate_pct
FROM encounters
GROUP BY age
ORDER BY age;

-- 2. Readmission rate by primary diagnosis group (min 100 patients)
SELECT 
    diag_1_group,
    COUNT(*) AS total_patients,
    ROUND(AVG(readmitted_30d) * 100, 2) AS readmission_rate_pct
FROM encounters
GROUP BY diag_1_group
HAVING COUNT(*) > 100
ORDER BY readmission_rate_pct DESC;

-- 3. Top risk diagnosis group per age bracket (window function)
SELECT *
FROM (
    SELECT 
        age,
        diag_1_group,
        COUNT(*) AS total_patients,
        ROUND(AVG(readmitted_30d) * 100, 2) AS readmission_rate_pct,
        RANK() OVER (PARTITION BY age ORDER BY AVG(readmitted_30d) DESC) AS risk_rank
    FROM encounters
    GROUP BY age, diag_1_group
    HAVING COUNT(*) > 30
) ranked
WHERE risk_rank = 1
ORDER BY age;

-- 4. Risk segmentation by prior inpatient visits (CTE)
WITH risk_segments AS (
    SELECT 
        *,
        CASE 
            WHEN number_inpatient = 0 THEN 'No Prior Admissions'
            WHEN number_inpatient BETWEEN 1 AND 2 THEN 'Low Risk (1-2 prior)'
            WHEN number_inpatient BETWEEN 3 AND 5 THEN 'Medium Risk (3-5 prior)'
            ELSE 'High Risk (6+ prior)'
        END AS risk_segment
    FROM encounters
)
SELECT 
    risk_segment,
    COUNT(*) AS total_patients,
    ROUND(AVG(readmitted_30d) * 100, 2) AS readmission_rate_pct,
    ROUND(AVG(time_in_hospital), 1) AS avg_length_of_stay,
    ROUND(AVG(num_medications), 1) AS avg_medications
FROM risk_segments
GROUP BY risk_segment
ORDER BY readmission_rate_pct DESC;