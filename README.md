# NYC Urban Life Analysis: Arrests, Restaurant Inspections and Street Trees

Three NYC Open Data datasets, one question: how do public safety, food safety and street trees differ across the five boroughs? The data is loaded into SQLite and queried with SQL (CTEs and window functions), then charted in Python.

![Arrests by borough](Arrests%20by%20borough.png)

## Data

| Dataset | Contents |
|---|---|
| NYPD Arrests | Arrest date, offense, borough, demographics |
| DOHMH Restaurant Inspections | Inspection date, grade, violations, cuisine, borough |
| 2015 Street Tree Census | Species, trunk diameter, health, borough |

All three are on [NYC Open Data](https://opendata.cityofnewyork.us/). The CSVs are too large for this repo, so download them and save them as `NYPD_Arrests.csv`, `Restaurant_Inspection.csv` and `Street_Tree_Census_2015.csv`.

## Questions and queries

| File | Question |
|---|---|
| `query#1.sql` | First look at the arrests table |
| `query#2.sql` | Which boroughs have more than 50 trees in poor health? |
| `query#3.sql` | Monthly 2024 arrests for robbery, burglary, assault and grand larceny |
| `query#4.sql` | Tree counts and trunk size compared with restaurant counts by borough |
| `query#5.sql` | Arrests by season |
| `query#6.sql` | Restaurants whose grade changed between inspections (`LAG` window function) |

Each file holds the SQL as a Python string plus the `pd.read_sql_query` call that runs it.

## Charts

- Arrests: `Arrests by borough.png`, `Borough Distribution (Bar Plot).png`, `Top 10 Offense Descriptions.png`
- Restaurants: `Count grades per cuisine.png`, `Number of restaurants by borough and grade.png`, `Top 10 Cuisines by Inspection Count.png`, `Q1 results.png`, `Q2 results.png`
- Trees: `Tree health by borough.png`, `Tree Health Distribution (Stacked Bar Chart).png`, `Tree Species Diversity (Top 10 Pie Chart).png`

## How to run

```bash
pip install pandas matplotlib seaborn
```

```python
import sqlite3
import pandas as pd

conn = sqlite3.connect(":memory:")
pd.read_csv("NYPD_Arrests.csv").to_sql("arrests", conn, index=False)
pd.read_csv("Restaurant_Inspection.csv").to_sql("restaurants", conn, index=False)
pd.read_csv("Street_Tree_Census_2015.csv").to_sql("trees", conn, index=False)
```

Then paste a query from any `query#*.sql` file and run it with `pd.read_sql_query`.

## Next steps

- Add census demographics and transit data to explain borough differences
- Forecast restaurant grade drops from past inspection history

Author: Muhammad Ehtesham · [LinkedIn](https://www.linkedin.com/in/muhammad-ehtesham-dsa)
