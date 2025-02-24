WITH staged AS (
    SELECT * FROM {{ ref('staging_bank_marketing') }}
),

kpis AS (
    SELECT 
        COUNT(*) AS total_contacts,
        SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS successful_contacts,
        ROUND(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate,
        
        -- Segmentación por edad
        CASE 
            WHEN age < 30 THEN 'young'
            WHEN age BETWEEN 30 AND 50 THEN 'middle_age'
            ELSE 'senior'
        END AS age_segment,

        -- Segmentación por trabajo
        job,

        -- Segmentación por estado civil
        marital,

        -- Segmentación por educación
        education,

        COUNT(*) AS segment_count
    FROM staged
    GROUP BY age_segment, job, marital, education
)

SELECT * FROM kpis
