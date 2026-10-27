select
    order_id,
    customer_id,
    order_date,
    sum(line_revenue) as order_revenue,
    row_number() over (
        partition by customer_id
        order by order_date, order_id
    ) as customer_order_number
from {{ ref('fact_order_items') }}
where status = 'completed'
group by order_id, customer_id, order_date