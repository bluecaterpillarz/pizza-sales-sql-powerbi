USE pizza_sales;
SELECT * FROM pizza_sales LIMIT 5;

-- TOTAL ORDERS BY DAY OF WEEK
SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date);

-- REVENUE BY DAY OF WEEK
SELECT DAYNAME(order_date) AS order_day,
       SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY order_day;

-- DAILY REVENUE TREND
SELECT order_date,
       SUM(total_price) AS daily_revenue
FROM pizza_sales
GROUP BY order_date
ORDER BY order_date;

-- MONTHLY TREND FOR TOTAL ORDERS
SELECT MONTHNAME(order_date) AS order_month, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTHNAME(order_date)
ORDER BY total_orders DESC;

-- PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT pizza_category, SUM(total_price) AS total_sales, 
	SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS PCT
FROM pizza_sales 
GROUP BY pizza_category;

-- PERCENTAGE OF SALES BY PIZZA CATEGORY FOR JANUARY
SELECT pizza_category, SUM(total_price) AS total_sales, 
	SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date)=1) AS PCT
FROM pizza_sales 
WHERE MONTH(order_date)=1
GROUP BY pizza_category;

-- PERCENTAGE OF SALES BY PIZZA SIZE
SELECT pizza_size, 
       SUM(total_price) AS total_sales, 
       CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales)
       AS DECIMAL(10,2)) AS pct
FROM pizza_sales 
GROUP BY pizza_size
ORDER BY pct DESC;

-- PERCENTAGE OF SALES BY PIZZA SIZE FOR FIRST QUARTER
SELECT pizza_size, 
       SUM(total_price) AS total_sales, 
       CAST(SUM(total_price) * 100.0 / 
           (SELECT SUM(total_price) FROM pizza_sales 
            WHERE QUARTER(order_date) = 1)
       AS DECIMAL(10,2)) AS pct
FROM pizza_sales 
WHERE QUARTER(order_date) = 1
GROUP BY pizza_size
ORDER BY pct DESC;

-- HOURLY ORDER DISTRIBUTION
SELECT HOUR(order_time) AS order_hour,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_hour
ORDER BY order_hour;

-- PEAK SALES TIME
SELECT DAYNAME(order_date) AS day,
       HOUR(order_time) AS hour,
       COUNT(*) AS total_orders
FROM pizza_sales
GROUP BY day, hour
ORDER BY total_orders DESC
LIMIT 10;

-- TOP 5 BEST SELLERS BY REVENUE, TOTAL QUANTITY AND TOTAL ORDERS
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

SELECT pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY total_quantity DESC
LIMIT 5;

SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

-- BOTTOM 5 WORST SELLERS BY REVENUE, TOTAL QUANTITY AND TOTAL ORDERS
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

SELECT pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY total_quantity 
LIMIT 5;

SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY total_orders ASC
LIMIT 5;

-- ORDER SIZE DISTRIBUTION
SELECT 
  CASE 
    WHEN quantity = 1 THEN 'Single'
    WHEN quantity BETWEEN 2 AND 3 THEN 'Small Order'
    WHEN quantity BETWEEN 4 AND 6 THEN 'Medium Order'
    ELSE 'Large Order'
  END AS order_type,
  COUNT(*) AS total_orders
FROM pizza_sales
GROUP BY order_type;

-- WEEKDAY VS WEEKEND
SELECT 
  CASE 
    WHEN DAYOFWEEK(order_date) IN (1,7) THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,
  COUNT(DISTINCT order_id) AS total_orders,
  SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY day_type;

-- REVENUE BY CATEGORY & SIZE
SELECT pizza_category, pizza_size,
       SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY pizza_category, pizza_size
ORDER BY revenue DESC;

