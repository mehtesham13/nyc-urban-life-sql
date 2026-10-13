query3 = """
SELECT 
    substr(ARREST_DATE, 1, 7) AS arrest_month,
    OFNS_DESC AS crime_type,
    COUNT(*) AS monthly_arrests
FROM arrests
WHERE OFNS_DESC IN ('ROBBERY', 'BURGLARY', 'ASSAULT', 'GRAND LARCENY')
    AND ARREST_DATE LIKE '2024-%'
GROUP BY arrest_month, crime_type
ORDER BY arrest_month, monthly_arrests DESC;
"""

result3 = pd.read_sql_query(query2, conn)
print("\nQUERY 3: Monthly Arrest Trends")
print(result2.head(15))