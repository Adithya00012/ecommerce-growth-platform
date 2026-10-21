select *
from {{ ref('mart_daily_revenue') }}
where revenue < 0 or orders < 1