SELECT COUNT(*) AS buyers,
       SUM(CASE WHEN n >= 2 THEN 1 ELSE 0 END) AS repeat_buyers,
       ROUND(SUM(CASE WHEN n >= 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS repeat_rate_pct
FROM (
    SELECT customer_id, COUNT(*) AS n
    FROM orders
    WHERE status = 'completed'
    GROUP BY customer_id
);