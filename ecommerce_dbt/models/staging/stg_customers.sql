with source as (
    select * from {{ source('raw', 'customers') }}
),

deduped as (
    select *,
           row_number() over (partition by customer_id order by signup_date) as rn
    from source
)

select
    customer_id,
    initcap(trim(full_name)) as full_name,
    lower(email) as email,
    region,
    signup_date::date as signup_date
from deduped
where rn = 1