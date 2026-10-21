import sqlite3
import pandas as pd

conn = sqlite3.connect("data/ecommerce.db")

tables = {
    "customers": "data/clean/customers.csv",
    "products": "data/raw/products.csv",
    "orders": "data/raw/orders.csv",
    "order_items": "data/raw/order_items.csv",
}

for name, path in tables.items():
    df = pd.read_csv(path)
    df.to_sql(name, conn, if_exists="replace", index=False)
    count = conn.execute(f"SELECT COUNT(*) FROM {name}").fetchone()[0]
    print(f"Loaded {count:,} rows into table: {name}")

conn.close()
