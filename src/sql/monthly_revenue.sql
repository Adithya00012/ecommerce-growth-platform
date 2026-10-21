SELECT substr(o.order_date, 1, 7) AS month,
       ROUND(SUM(oi.quantity * oi.unit_price)) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY month
ORDER BY month; 