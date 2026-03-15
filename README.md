# Restaurant Sales and Menu Analysis

## Project Overview
This project explores a restaurant's database to uncover actionable insights about menu performance, customer ordering habits, and overall sales trends. By analyzing the `menu_items` and `order_details` tables, this project answers key business questions regarding the most popular dishes, category profitability, and high-value customer orders.

## Tools & Technologies Used
* **SQL (PostgreSQL):** Used for all data extraction, transformation, and analysis. Techniques include Common Table Expressions (CTEs), Window Functions (`DENSE_RANK`), Multi-table `JOIN`s, and Aggregations.

## Repository Structure
* `setup_restaurant_db.sql`: Contains the DDL (Data Definition Language) to build the `restaurant_db` schema and the `order_details` and `menu_items` tables.
* `analysis.sql`: The main SQL script containing all exploratory and analytical queries.
* `restaurant_db_data_dictionary.csv`: Explains the table structures.

## Key Questions Answered
This analysis tackles the following business questions:
1. **Menu Optimization:** What are the most and least expensive items? What is the average price of a dish within each specific cuisine category?
2. **Order Volume:** How many total orders were placed within the dataset's timeframe, and what is the maximum number of items in a single order?
3. **Item Popularity:** Which specific menu items are ordered the most frequently, and which are ordered the least?
4. **Revenue Tracking:** What are the top 5 highest-grossing orders, and what specific combination of items did those customers purchase?

## Key Insights & Findings
* **Top Seller:** The most ordered item on the menu is **Hamburger**, which was ordered **622** times.
* **Category Breakdown:** The **Italian** category has the highest average dish price at **$16.75**.
* **High-Value Orders:** The highest single order generated **$192.15** in revenue. 

## How to Run This Project
1. Clone this repository to your local machine.
2. Open your preferred SQL client (e.g., pgAdmin).
3. Run the `setup_restaurant_db.sql` file to build the database schema and tables. I had a bunch of problems here and had to name the DB itself `restaurant_db`.
4. Import your dataset (CSV files) into the newly created tables. 
5. Run the queries in `analysis.sql` to view the insights.
