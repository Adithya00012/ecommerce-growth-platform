with orders as (
    select * from {{ ref('int_orders') }}
),

cohorts as (
    select
        customer_id,
        date_trunc('month', order_date) as cohort_month
    from orders
    where customer_order_number = 1
),

activity as (
    select distinct
        customer_id,
        date_trunc('month', order_date) as activity_month
    from orders
),

joined as (
    select
        c.cohort_month,
        {{ dbt.datediff('c.cohort_month', 'a.activity_month', 'month') }} as months_since_first,
        a.customer_id
    from cohorts c
    join activity a on c.customer_id = a.customer_id
),

sizes as (
    select cohort_month, count(*) as cohort_size
    from cohorts
    group by cohort_month
)

select
    j.cohort_month,
    j.months_since_first,
    count(distinct j.customer_id) as active_customers,
    s.cohort_size,
    round(count(distinct j.customer_id) * 100.0 / s.cohort_size, 2) as retention_pct
from joined j
join sizes s on j.cohort_month = s.cohort_month
group by j.cohort_month, j.months_since_first, s.cohort_size