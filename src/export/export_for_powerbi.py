import sqlite3
import pandas as pd

conn = sqlite3.connect("data/ecommerce.db")

queries = {
    "daily_revenue": "src/sql/daily_revenue.sql",
    "revenue_by_region": "src/sql/revenue_by_region.sql",
}

for name, path in queries.items():
    with open(path) as f:
        df = pd.read_sql_query(f.read(), conn)
    df.to_csv(f"data/powerbi/{name}.csv", index=False)
    print(f"Exported {name}.csv: {len(df)} rows")

conn.close()
