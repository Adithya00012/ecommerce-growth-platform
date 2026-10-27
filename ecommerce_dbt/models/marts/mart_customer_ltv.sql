select
    f.customer_id,
    c.region,
    min(f.order_date) as first_order_date,
    max(f.order_date) as last_order_date,
    {{ dbt.datediff('min(f.order_date)', 'max(f.order_date)', 'day') }} as tenure_days,
    count(distinct f.order_id) as orders,
    sum(f.line_revenue) as revenue,
    sum(f.line_profit) as clv,
    round(sum(f.line_revenue) / count(distinct f.order_id), 2) as aov
from {{ ref('fact_order_items') }} f
join {{ ref('dim_customers') }} c on f.customer_id = c.customer_id
where f.status = 'completed'
group by f.customer_id, c.region