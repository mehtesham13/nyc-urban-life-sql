query5 = """
SELECT 
    CASE 
        WHEN substr(ARREST_DATE, 6, 2) IN ('12', '01', '02') THEN 'Winter'
        WHEN substr(ARREST_DATE, 6, 2) IN ('03', '04', '05') THEN 'Spring'
        WHEN substr(ARREST_DATE, 6, 2) IN ('06', '07', '08') THEN 'Summer'
        WHEN substr(ARREST_DATE, 6, 2) IN ('09', '10', '11') THEN 'Fall'
    END AS season,
    OFNS_DESC AS crime_type,
    COUNT(*) AS arrest_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY 
        CASE 
            WHEN substr(ARREST_DATE, 6, 2) IN ('12', '01', '02') THEN 'Winter'
            WHEN substr(ARREST_DATE, 6, 2) IN ('03', '04', '05') THEN 'Spring'
            WHEN substr(ARREST_DATE, 6, 2) IN ('06', '07', '08') THEN 'Summer'
            WHEN substr(ARREST_DATE, 6, 2) IN ('09', '10', '11') THEN 'Fall'
        END), 2) AS season_percentage
FROM arrests
WHERE OFNS_DESC IN ('ROBBERY', 'BURGLARY', 'ASSAULT', 'GRAND LARCENY', 'DANGEROUS DRUGS')
    AND ARREST_DATE IS NOT NULL
GROUP BY season, crime_type
HAVING arrest_count > 100
ORDER BY season, arrest_count DESC;
"""

result5 = pd.read_sql_query(query5, conn)
print("\nQUERY 5: Seasonal Crime Patterns")
print(result5)