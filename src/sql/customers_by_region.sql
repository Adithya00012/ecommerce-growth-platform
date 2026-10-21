SELECT region, COUNT(*) AS customer_count
FROM customers
GROUP BY region
ORDER BY customer_count DESC;