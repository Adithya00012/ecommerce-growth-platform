with per_customer as (
    select
        customer_id,
        count(*) as orders,
        min(order_date) as first_date,
        max(order_date) as last_date
    from {{ ref('int_orders') }}
    group by customer_id
),

bucketed as (
    select
        customer_id,
        case when orders >= 5 then 5 else orders end as order_bucket,
        case
            when orders >= 2
            then {{ dbt.datediff('first_date', 'last_date', 'day') }} * 1.0 / (orders - 1)
        end as avg_days_between_orders
    from per_customer
)

select
    order_bucket,
    count(*) as customers,
    round(count(*) * 100.0 / sum(count(*)) over (), 2) as pct_customers,
    round(avg(avg_days_between_orders), 1) as avg_days_between_orders
from bucketed
group by order_bucket