# E-commerce Customer Growth, Retention, and Revenue Analytics Platform

## Status
Phase 1 (MVP) complete. Phase 2 (dbt warehouse) in progress.

## Flow
Synthetic data (Python, Faker) -> PostgreSQL `raw` schema -> dbt staging views -> dbt marts (star schema) -> Power BI

## Warehouse
- Database: PostgreSQL `ecommerce_staging`
- Schemas: `raw` (loaded data), `analytics` (dbt models)
- Staging: `stg_customers`, `stg_products`, `stg_orders`, `stg_order_items`
- Marts: `dim_customers`, `dim_products`, `fact_order_items`
- Tests: 10 dbt data tests, all passing

## Run dbt
1. Set the password: `$env:PG_PASSWORD = "your-password"`
2. `cd ecommerce_dbt`
3. `dbt run`
4. `dbt test`

## Folders
- `src/data_generation`: creates raw CSV data
- `src/cleaning`: cleans customer data
- `src/loading`: loads CSVs into SQLite
- `src/sql`: SQL metric queries
- `src/export`: exports query results for Power BI
- `dashboards`: Power BI file

## Metrics built
- Total revenue: 3,657,186.57
- Average order value: 277.71
- Gross margin: 40.38%
- Repeat-purchase rate: 50.24%

## How to run
1. `venv\Scripts\activate`
2. `python src\data_generation\generate_customers.py`
3. `python src\cleaning\clean_customers.py`
4. `python src\data_generation\generate_products.py`
5. `python src\data_generation\generate_orders.py`
6. `python src\data_generation\generate_order_items.py`
7. `python src\loading\load_to_db.py`
8. `python src\export\export_for_powerbi.py`

## Known issues
- None.