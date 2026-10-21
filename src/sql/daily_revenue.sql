SELECT o.order_date,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS daily_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY o.order_date
ORDER BY o.order_date;