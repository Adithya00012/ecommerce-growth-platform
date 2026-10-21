import random
import pandas as pd

random.seed(42)

orders = pd.read_csv("data/raw/orders.csv")
products = pd.read_csv("data/raw/products.csv")
product_ids = products["product_id"].tolist()
price_lookup = products.set_index("product_id")["price"].to_dict()

rows = []
item_id = 1
for order_id in orders["order_id"]:
    n_items = random.choices([1, 2, 3, 4], [50, 30, 14, 6])[0]
    for pid in random.sample(product_ids, n_items):
        rows.append(
            {
                "order_item_id": item_id,
                "order_id": order_id,
                "product_id": pid,
                "quantity": random.choices([1, 2, 3], [70, 22, 8])[0],
                "unit_price": price_lookup[pid],
            }
        )
        item_id += 1

df = pd.DataFrame(rows)
df.to_csv("data/raw/order_items.csv", index=False)

print(f"Generated {len(df):,} order items")
print("File created: data/raw/order_items.csv")
