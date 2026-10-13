Q2 = """
WITH UnhealthyTreesByBorough AS (
  SELECT Borough, COUNT(*) AS PoorTreeCount
  FROM Trees
  WHERE health = 'Poor'
  GROUP BY Borough
)
SELECT *
FROM UnhealthyTreesByBorough
WHERE PoorTreeCount > 50
ORDER BY PoorTreeCount DESC;
"""

Query2 = pd.read_sql_query(Q2, conn)
print("Q2 — Boroughs with Most Unhealthy Trees:")
display(Query2)