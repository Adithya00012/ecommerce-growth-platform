with orders as (
    select * from {{ ref('int_orders') }}
),

ref_date as (
    select max(order_date) as ref_date from orders
),

first_orders as (
    select customer_id, order_date as first_order_date
    from orders
    where customer_order_number = 1
),

second_orders as (
    select customer_id, order_date as second_order_date
    from orders
    where customer_order_number = 2
),

customers as (
    select
        f.customer_id,
        f.first_order_date,
        {{ dbt.datediff('f.first_order_date', 'r.ref_date', 'day') }} as days_since_first,
        {{ dbt.datediff('f.first_order_date', 's.second_order_date', 'day') }} as days_to_second
    from first_orders f
    cross join ref_date r
    left join second_orders s on f.customer_id = s.customer_id
),

flags as (
    select
        *,
        case when days_since_first >= 30 then 1 else 0 end as eligible_30,
        case when days_since_first >= 60 then 1 else 0 end as eligible_60,
        case when days_since_first >= 90 then 1 else 0 end as eligible_90,
        case when days_since_first >= 30 and days_to_second <= 30 then 1 else 0 end as retained_30,
        case when days_since_first >= 60 and days_to_second <= 60 then 1 else 0 end as retained_60,
        case when days_since_first >= 90 and days_to_second <= 90 then 1 else 0 end as retained_90
    from customers
)

select
    date_trunc('month', first_order_date) as cohort_month,
    count(*) as cohort_size,
    sum(eligible_30) as eligible_30,
    sum(retained_30) as retained_30,
    round(sum(retained_30) * 100.0 / nullif(sum(eligible_30), 0), 2) as retention_30_pct,
    sum(eligible_60) as eligible_60,
    sum(retained_60) as retained_60,
    round(sum(retained_60) * 100.0 / nullif(sum(eligible_60), 0), 2) as retention_60_pct,
    sum(eligible_90) as eligible_90,
    sum(retained_90) as retained_90,
    round(sum(retained_90) * 100.0 / nullif(sum(eligible_90), 0), 2) as retention_90_pct
from flags
group by 1