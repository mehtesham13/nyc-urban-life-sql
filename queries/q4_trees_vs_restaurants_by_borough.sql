query4 = """
WITH neighborhood_trees AS (
    SELECT
        borough AS borough,
        COUNT(*) AS tree_count,
        ROUND(AVG(tree_dbh), 2) AS avg_tree_diameter
    FROM trees
    WHERE borough IS NOT NULL AND health IS NOT NULL
    GROUP BY borough
),
neighborhood_restaurants AS (
    SELECT
        BORO AS borough,
        -- ROUND(AVG(SCORE), 2) AS avg_restaurant_score, -- SCORE column is not available
        COUNT(*) AS restaurant_count
    FROM inspections -- Corrected table name
    WHERE BORO IS NOT NULL
    GROUP BY BORO
)

SELECT
    t.borough,
    t.tree_count,
    t.avg_tree_diameter,
    -- r.avg_restaurant_score, -- SCORE column is not available
    r.restaurant_count
FROM neighborhood_trees t
JOIN neighborhood_restaurants r ON t.borough = r.borough
ORDER BY t.tree_count DESC;
"""

result4 = pd.read_sql_query(query4, conn)
print("\nQUERY 4: Tree Coverage vs Restaurant Quality (without average score)")
print(result4)