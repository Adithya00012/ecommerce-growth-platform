# E-commerce Customer Growth, Retention, and Revenue Analytics Platform

## Status
Phase 1 (MVP) complete.

## Flow
Synthetic data (Python, Faker) -> Clean (pandas) -> SQLite -> SQL metrics -> Power BI

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