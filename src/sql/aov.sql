SELECT COUNT(DISTINCT o.order_id) AS completed_orders,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue,
       ROUND(SUM(oi.quantity * oi.unit_price) * 1.0 / COUNT(DISTINCT o.order_id), 2) AS aov
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed';