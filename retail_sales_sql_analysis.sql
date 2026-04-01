-- Join de tablas
SELECT 
    o.order_id,
    c.country,
    p.product_name,
    o.quantity,
    p.price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

-- Revenue por producto
SELECT 
    p.product_name,
    SUM(o.quantity * p.price) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- Clientes que más gastan
SELECT 
    o.customer_id,
    SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY o.customer_id
ORDER BY total_spent DESC;

-- Clientes con gasto mayor a 1000
SELECT 
    o.customer_id,
    SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY o.customer_id
HAVING total_spent > 1000;

-- Segmentación de clientes
SELECT 
    o.customer_id,
    SUM(o.quantity * p.price) AS total_spent,
    CASE
        WHEN SUM(o.quantity * p.price) > 2000 THEN 'High Value'
        WHEN SUM(o.quantity * p.price) > 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS segment
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY o.customer_id;

-- Revenue por país
SELECT 
    c.country,
    SUM(o.quantity * p.price) AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.country
ORDER BY revenue DESC;