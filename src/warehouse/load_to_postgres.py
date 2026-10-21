import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text

load_dotenv()
pw = os.getenv("PG_PASSWORD")
engine = create_engine(
    f"postgresql+psycopg2://postgres:{pw}@127.0.0.1:5432/ecommerce_staging"
)

with engine.begin() as conn:
    conn.execute(text("CREATE SCHEMA IF NOT EXISTS raw"))

tables = {
    "customers": "data/raw/customers.csv",
    "products": "data/raw/products.csv",
    "orders": "data/raw/orders.csv",
    "order_items": "data/raw/order_items.csv",
}

for name, path in tables.items():
    df = pd.read_csv(path)
    df.to_sql(name, engine, schema="raw", if_exists="replace", index=False)
    with engine.connect() as conn:
        count = conn.execute(text(f"SELECT COUNT(*) FROM raw.{name}")).scalar()
    print(f"Loaded {count:,} rows into raw.{name}")