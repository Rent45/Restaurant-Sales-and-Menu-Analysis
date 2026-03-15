-- View the menu_items table and write a query to find the number of items on the menu --
SELECT COUNT(*) FROM menu_items;

--What are the least and most expensive items on the menu?--
SELECT MAX(price) AS max_price, MIN(price) AS min_price
FROM menu_items;

--How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?--
SELECT COUNT(*) AS all_italian, MAX(price) AS max_price_italian, MIN(price) AS min_price_italian
FROM menu_items
WHERE category ILIKE 'Italian';

--How many dishes are in each category? What is the average dish price within each category?--
SELECT category AS country, COUNT(*) AS dishes_of_country, ROUND(AVG(price),3) as avg_price
FROM menu_items
GROUP BY category;

--View the order_details table. What is the date range of the table?--
SELECT MIN(order_date) as min_date, MAX(order_date) as max_date
FROM order_details;

--How many orders were made within this date range? How many items were ordered within this date range?--
SELECT COUNT(*) AS number_of_items, COUNT(DISTINCT(order_id)) AS number_of_orders
FROM order_details;

--Which orders had the most number of items?--
SELECT order_id, COUNT(*) AS items_per_order
FROM order_details
GROUP BY order_id 
ORDER BY items_per_order DESC
LIMIT 20;

--How many orders had more than 12 items?--
WITH item_per_order AS
(
SELECT order_id, COUNT(*) AS items_per_order
FROM order_details
GROUP BY order_id 
)
SELECT COUNT(*) AS orders_over_12_items
FROM item_per_order
WHERE items_per_order>12;

--Combine the menu_items and order_details tables into a single table--
SELECT * 
FROM menu_items
JOIN order_details
ON order_details.item_id = menu_items.menu_item_id
LIMIT 1;

--What were the least and most ordered items? What categories were they in?--
WITH ItemCounts AS (
  SELECT menu_items.item_name, menu_items.category, COUNT(*) AS times_ordered
  FROM menu_items
  JOIN order_details ON order_details.item_id = menu_items.menu_item_id
  GROUP BY menu_items.item_name, menu_items.category
)
(SELECT 'Least Ordered' AS popularity, item_name, category, times_ordered 
 FROM ItemCounts 
 ORDER BY times_ordered ASC 
 LIMIT 1)
UNION ALL
(SELECT 'Most Ordered' AS popularity, item_name, category, times_ordered 
 FROM ItemCounts 
 ORDER BY times_ordered DESC 
 LIMIT 1);

 --What were the top 5 orders that spent the most money?--
SELECT order_id, SUM(price) as order_price
FROM menu_items
JOIN order_details
ON order_details.item_id = menu_items.menu_item_id
GROUP BY order_id
ORDER BY order_price DESC
LIMIT 5;

--View the details of the highest spend order. Which specific items were purchased?--
WITH highest_order AS 
(
SELECT order_id, SUM(price) as order_price
FROM menu_items
JOIN order_details
ON order_details.item_id = menu_items.menu_item_id
GROUP BY order_id
ORDER BY order_price DESC
LIMIT 1
)
SELECT order_details.order_id, item_name, category, price, order_price as total_price, order_date, order_time
FROM menu_items
JOIN order_details
ON order_details.item_id = menu_items.menu_item_id
JOIN highest_order
ON order_details.order_id = highest_order.order_id;

--BONUS: View the details of the top 5 highest spend orders--
WITH highest_orders AS (
  SELECT order_details.order_id, SUM(menu_items.price) AS order_price
  FROM menu_items
  JOIN order_details ON order_details.item_id = menu_items.menu_item_id
  GROUP BY order_details.order_id
  ORDER BY order_price DESC
  LIMIT 5
)
SELECT 
  DENSE_RANK() OVER (ORDER BY highest_orders.order_price DESC) AS order_of_highness, 
  order_details.order_id, 
  menu_items.item_name, 
  menu_items.category, 
  menu_items.price, 
  highest_orders.order_price as total_price,
  order_details.order_date, 
  order_details.order_time
FROM menu_items
JOIN order_details ON order_details.item_id = menu_items.menu_item_id
JOIN highest_orders ON order_details.order_id = highest_orders.order_id
ORDER BY highest_orders.order_price DESC, order_details.order_id;
