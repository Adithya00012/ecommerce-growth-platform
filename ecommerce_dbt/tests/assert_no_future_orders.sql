select *
from {{ ref('fact_order_items') }}
where order_date > current_date