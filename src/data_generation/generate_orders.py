import random
from datetime import date, timedelta
import pandas as pd

random.seed(42)

customers = pd.read_csv("data/clean/customers.csv", parse_dates=["signup_date"])
today = date.today()

rows = []
order_id = 1
for _, c in customers.iterrows():
    n_orders = random.choices([0, 1, 2, 3, 4, 5], [20, 35, 20, 12, 8, 5])[0]
    signup = c.signup_date.date()
    days_available = (today - signup).days
    for _ in range(n_orders):
        order_date = signup + timedelta(days=random.randint(0, days_available))
        rows.append(
            {
                "order_id": order_id,
                "customer_id": c.customer_id,
                "order_date": order_date,
                "status": random.choices(["completed", "cancelled"], [93, 7])[0],
            }
        )
        order_id += 1

df = pd.DataFrame(rows)
df.to_csv("data/raw/orders.csv", index=False)

print(f"Generated {len(df):,} orders")
print("File created: data/raw/orders.csv")
