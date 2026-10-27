select
    date_trunc('month', order_date) as order_month,
    count(distinct case when customer_order_number = 1 then customer_id end) as new_customers,
    count(distinct case when customer_order_number > 1 then customer_id end) as returning_customers,
    sum(case when customer_order_number = 1 then order_revenue else 0 end) as new_customer_revenue,
    sum(case when customer_order_number > 1 then order_revenue else 0 end) as returning_customer_revenue,
    sum(order_revenue) as revenue
from {{ ref('int_orders') }}
group by 1