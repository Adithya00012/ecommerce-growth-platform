import random
import pandas as pd
from faker import Faker

fake = Faker()
Faker.seed(42)
random.seed(42)

NUM_CUSTOMERS = 10000
rows = []

for i in range(1, NUM_CUSTOMERS + 1):
    rows.append(
        {
            "customer_id": i,
            "full_name": fake.name(),
            "email": fake.email(),
            "region": random.choice(["North", "South", "East", "West"]),
            "signup_date": fake.date_between(start_date="-2y", end_date="today"),
        }
    )

df = pd.DataFrame(rows)

dupes = df.sample(n=200, random_state=1)
df = pd.concat([df, dupes], ignore_index=True)

upper = df.sample(n=500, random_state=2).index
df.loc[upper, "full_name"] = df.loc[upper, "full_name"].str.upper()

spaced = df.sample(n=300, random_state=3).index
df.loc[spaced, "full_name"] = "  " + df.loc[spaced, "full_name"] + "  "
df.to_csv("data/raw/customers.csv", index=False)

print(f"Generated {len(df):,} customers")
print("File created: data/raw/customers.csv")
