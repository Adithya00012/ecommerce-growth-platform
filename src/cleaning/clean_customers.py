import pandas as pd

df = pd.read_csv("data/raw/customers.csv")

df["full_name"] = df["full_name"].str.strip().str.title()

print(
    "Names with extra spaces:", (df["full_name"] != df["full_name"].str.strip()).sum()
)
print("All-uppercase names:", df["full_name"].str.isupper().sum())
print(df["full_name"].head())

before = len(df)
df = df.drop_duplicates(subset="customer_id", keep="first")
print(f"Removed {before - len(df)} duplicates")

df.to_csv("data/clean/customers.csv", index=False)
print(f"Saved {len(df):,} customers to data/clean/customers.csv")
