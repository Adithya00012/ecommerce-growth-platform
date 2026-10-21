select
    customer_id,
    full_name,
    email,
    region,
    signup_date
from {{ ref('stg_customers') }}