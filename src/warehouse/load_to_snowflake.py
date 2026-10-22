import os
import pandas as pd
import snowflake.connector
from dotenv import load_dotenv
from snowflake.connector.pandas_tools import write_pandas

load_dotenv()

conn = snowflake.connector.connect(
    account=os.getenv("SNOWFLAKE_ACCOUNT"),
    user=os.getenv("SNOWFLAKE_USER"),
    password=os.getenv("SNOWFLAKE_PASSWORD"),
    role="DBT_ROLE",
    warehouse="ECOMMERCE_WH",
    database="ECOMMERCE",
    schema="RAW",
)

tables = {
    "CUSTOMERS": "data/raw/customers.csv",
    "PRODUCTS": "data/raw/products.csv",
    "ORDERS": "data/raw/orders.csv",
    "ORDER_ITEMS": "data/raw/order_items.csv",
}

for name, path in tables.items():
    df = pd.read_csv(path)
    df.columns = [c.upper() for c in df.columns]
    write_pandas(
        conn, df, name,
        auto_create_table=True,
        overwrite=True,
        quote_identifiers=False,
    )
    count = conn.cursor().execute(f"SELECT COUNT(*) FROM RAW.{name}").fetchone()[0]
    print(f"Loaded {count:,} rows into RAW.{name}")

conn.close()