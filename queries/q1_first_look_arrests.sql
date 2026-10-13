# Queries Writing
Q1 = """
SELECT ARREST_DATE, PD_DESC, OFNS_DESC, ARREST_BORO
FROM arrests
LIMIT 15;
"""
Query1 = pd.read_sql_query(Q1, conn)
print("Q1 — Extract First 15 Rows:")
display(Query1)
