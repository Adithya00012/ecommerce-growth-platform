# E-commerce Customer Growth, Retention, and Revenue Analytics Platform

## Status
Phases 1 to 3 complete: MVP, warehouse and dbt, customer growth and retention.

## Flow
Synthetic data (Python, Faker) -> PostgreSQL `raw` schema -> dbt staging views -> dbt marts (star schema) -> Power BI

## Warehouse
- Local: PostgreSQL `ecommerce_staging` (schemas `raw`, `analytics`)
- Cloud: Snowflake `ECOMMERCE` (schemas `RAW`, `ANALYTICS`)
- Staging: `stg_customers`, `stg_products`, `stg_orders`, `stg_order_items`
- Intermediate: `int_orders`
- Marts: `dim_customers`, `dim_products`, `fact_order_items`, `mart_daily_revenue`, `mart_new_vs_returning_monthly`, `mart_customer_rfm`, `mart_retention_cohorts`, `mart_cohort_matrix`, `mart_customer_ltv`, `mart_customer_churn`, `mart_repeat_purchase`
- Tests: 33 dbt data tests, passing on both databases

## Phase 3 metrics (validated against pandas)
- New customers: 6,971
- Repeat buyers: 3,502 (50.24%)
- Retention: 30-day 20.5%, 60-day 32.7%, 90-day 40.5%
- Total CLV (gross profit): 1,476,837.64. Average per customer: 211.85
- Churn (no order in 90 days): 5,484 customers, 78.67%

## Known limitation
Synthetic customers order within about four months of signup, then stop. Churn is inflated.

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