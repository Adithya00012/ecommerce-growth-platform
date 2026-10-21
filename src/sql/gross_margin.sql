SELECT ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue,
       ROUND(SUM(oi.quantity * p.cost), 2) AS total_cost,
       ROUND(SUM(oi.quantity * (oi.unit_price - p.cost)), 2) AS gross_profit,
       ROUND(SUM(oi.quantity * (oi.unit_price - p.cost)) * 100.0
             / SUM(oi.quantity * oi.unit_price), 2) AS gross_margin_pct
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'completed';