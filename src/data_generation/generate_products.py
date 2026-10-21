import random
import pandas as pd

random.seed(42)

categories = {
    "Electronics": (30, 400),
    "Clothing": (10, 120),
    "Home": (15, 200),
    "Beauty": (5, 80),
    "Sports": (15, 250),
}

rows = []
product_id = 1
for category, (low, high) in categories.items():
    for _ in range(40):
        price = round(random.uniform(low, high), 2)
        cost = round(price * random.uniform(0.4, 0.8), 2)
        rows.append(
            {
                "product_id": product_id,
                "product_name": f"{category} Item {product_id}",
                "category": category,
                "price": price,
                "cost": cost,
            }
        )
        product_id += 1

df = pd.DataFrame(rows)
df.to_csv("data/raw/products.csv", index=False)

print(f"Generated {len(df):,} products")
print("File created: data/raw/products.csv")
