select
    oi.order_item_id,
    oi.order_id,
    o.customer_id,
    oi.product_id,
    o.order_date,
    o.status,
    oi.quantity,
    oi.unit_price,
    oi.line_revenue,
    round((oi.quantity * p.cost)::numeric, 2) as line_cost,
    round((oi.line_revenue - oi.quantity * p.cost)::numeric, 2) as line_profit
from {{ ref('stg_order_items') }} oi
join {{ ref('stg_orders') }} o on oi.order_id = o.order_id
join {{ ref('stg_products') }} p on oi.product_id = p.product_id