with orders as (
    select * from {{ ref('int_orders') }}
),

ref_date as (
    select max(order_date) as ref_date from orders
),

last_orders as (
    select
        customer_id,
        max(order_date) as last_order_date,
        count(*) as orders
    from orders
    group by customer_id
)

select
    l.customer_id,
    c.region,
    l.last_order_date,
    l.orders,
    {{ dbt.datediff('l.last_order_date', 'r.ref_date', 'day') }} as days_since_last_order,
    case
        when {{ dbt.datediff('l.last_order_date', 'r.ref_date', 'day') }} > 90
        then 1 else 0
    end as is_churned
from last_orders l
cross join ref_date r
join {{ ref('dim_customers') }} c on l.customer_id = c.customer_id