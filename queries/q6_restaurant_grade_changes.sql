query6 = """
WITH restaurant_grades AS (
    SELECT
        CAMIS,
        DBA AS restaurant_name,
        BORO AS borough,
        "CUISINE DESCRIPTION" AS cuisine,
        "INSPECTION DATE",
        GRADE,
        -- SCORE, -- SCORE column is not available
        LAG(GRADE) OVER (PARTITION BY CAMIS ORDER BY "INSPECTION DATE") AS previous_grade
        -- LAG(SCORE) OVER (PARTITION BY CAMIS ORDER BY "INSPECTION DATE") AS previous_score -- SCORE column is not available
    FROM inspections -- Corrected table name
    WHERE GRADE IS NOT NULL -- AND SCORE IS NOT NULL -- SCORE column is not available
),
grade_changes AS (
    SELECT *,
        CASE
            -- WHEN SCORE < previous_score THEN 'Improved' -- SCORE column is not available
            -- WHEN SCORE > previous_score THEN 'Worsened' -- SCORE column is not available
            -- ELSE 'No Change' -- SCORE column is not available
            WHEN GRADE < previous_grade THEN 'Improved Grade'
            WHEN GRADE > previous_grade THEN 'Worsened Grade'
            ELSE 'No Change in Grade'
        END AS grade_change_status
    FROM restaurant_grades
    WHERE previous_grade IS NOT NULL
)

SELECT
    borough,
    cuisine,
    grade_change_status,
    COUNT(*) AS change_count
    -- ROUND(AVG(SCORE), 2) AS current_avg_score, -- SCORE column is not available
    -- ROUND(AVG(previous_score), 2) AS previous_avg_score, -- SCORE column is not available
    -- ROUND(AVG(previous_score - SCORE), 2) AS avg_score_improvement -- SCORE column is not available
FROM grade_changes
GROUP BY borough, cuisine, grade_change_status
HAVING change_count >= 10
ORDER BY borough, change_count DESC;
"""

result6 = pd.read_sql_query(query6, conn)
print("\nQUERY 6: Restaurant Grade Change Analysis (without average score)")
print(result6.head(15))