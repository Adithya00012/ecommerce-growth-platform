with orders as (
    select * from {{ ref('int_orders') }}
),

ref_date as (
    select max(order_date) as ref_date from orders
),

customer as (
    select
        customer_id,
        max(order_date) as last_order_date,
        count(*) as frequency,
        sum(order_revenue) as monetary
    from orders
    group by customer_id
),

rfm as (
    select
        c.customer_id,
        c.last_order_date,
        {{ dbt.datediff('c.last_order_date', 'r.ref_date', 'day') }} as recency_days,
        c.frequency,
        c.monetary
    from customer c
    cross join ref_date r
),

scored as (
    select
        *,
        ntile(5) over (order by recency_days desc) as r_score,
        least(frequency, 5) as f_score,
        ntile(5) over (order by monetary) as m_score
    from rfm
)

select
    customer_id,
    last_order_date,
    recency_days,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    case
        when r_score >= 4 and f_score >= 3 then 'Champions'
        when f_score >= 3 then 'Loyal'
        when r_score >= 4 then 'Recent'
        when r_score <= 2 and f_score >= 2 then 'At Risk'
        when r_score <= 2 then 'Lost'
        else 'Needs Attention'
    end as segment
from scored