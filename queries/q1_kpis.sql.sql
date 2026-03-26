USE pizza_sales;
SELECT * FROM pizza_sales LIMIT 5;

-- TOTAL REVENUE
SELECT SUM(total_price) AS total_revenue FROM pizza_sales

-- AVERAGE ORDER VALUE
SELECT SUM(total_price)/ COUNT(DISTINCT order_id) AS avg_order_value FROM pizza_sales

-- TOTAL PIZZAS SOLD
SELECT SUM(quantity) AS total_pizza_sold FROM pizza_sales

-- TOTAL ORDERS
SELECT COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales

-- AVERAGE PIZZAS FOR ORDER
SELECT CAST(
	CAST(SUM(quantity) AS DECIMAL(10,2)) / 
    CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS avg_pizzas_for_order
FROM pizza_sales