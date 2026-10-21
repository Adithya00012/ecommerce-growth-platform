import sqlite3
import sys
import pandas as pd

conn = sqlite3.connect("data/ecommerce.db")
with open(sys.argv[1]) as f:
    query = f.read()
print(pd.read_sql_query(query, conn))
conn.close()
