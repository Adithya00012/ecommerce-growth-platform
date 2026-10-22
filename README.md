# E-commerce Customer Growth, Retention, and Revenue Analytics Platform

## Status
Phase 1 (MVP) and Phase 2 (warehouse and dbt) complete.

## Flow
Synthetic data (Python, Faker) -> PostgreSQL `raw` schema -> dbt staging views -> dbt marts (star schema) -> Power BI

## Warehouse
- Local: PostgreSQL `ecommerce_staging` (schemas `raw`, `analytics`)
- Cloud: Snowflake `ECOMMERCE` (schemas `RAW`, `ANALYTICS`)
- Staging: `stg_customers`, `stg_products`, `stg_orders`, `stg_order_items`
- Marts: `dim_customers`, `dim_products`, `fact_order_items`, `mart_daily_revenue`
- Tests: 15 dbt data tests, passing on both databases

## Run dbt
1. Load `.env` into the shell:
   `Get-Content .env | ForEach-Object { if ($_ -match '^([^=]+)=(.*)$') { Set-Item "Env:$($matches[1])" $matches[2] } }`
2. `cd ecommerce_dbt`
3. Postgres: `dbt build`
4. Snowflake: `dbt build --target snowflake`

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