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
SEE