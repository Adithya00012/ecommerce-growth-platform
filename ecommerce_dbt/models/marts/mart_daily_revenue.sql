select
    order_date,
    count(distinct order_id) as orders,
    count(distinct customer_id) as customers,
    sum(line_revenue) as revenue,
    sum(line_cost) as cost,
    sum(line_profit) as profit,
    round(sum(line_revenue) / count(distinct order_id), 2) as aov
from {{ ref('fact_order_items') }}
where status = 'completed'
group by order_date