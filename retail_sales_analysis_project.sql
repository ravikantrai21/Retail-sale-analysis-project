--Create database
CREATE DATABASE retail_sales_analysis_project

--Create table
CREATE TABLE retail_sale(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(10),
	age INT,
	category VARCHAR(20),
	quantiy FLOAT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sale
LIMIT 10;

-- Count no of row in table
SELECT COUNT(*) FROM retail_sale;

-- null value in any column
SELECT * FROM retail_sale
Where transactions_id is NUll
	  OR
	  sale_date is NUll
	  OR
	  sale_time is NUll
	  OR
	  customer_id is NUll
	  OR
	  gender is NUll
	  OR
	  age is NUll
	  OR
	  category is NUll
	  OR
	  quantiy is NUll
	  OR
	  price_per_unit is NUll
	  OR
	  cogs is NUll
	  OR
	  total_sale is NUll;

-- Count total transactions
SELECT COUNT(*) FROM retail_sale;

-- Total Distinct Customers
SELECT COUNT(DISTINCT customer_id) AS Number_of_customer FROM retail_sale;

-- Different category and no of category
SELECT DISTINCT category AS category_type FROM retail_sale;
SELECT COUNT(DISTINCT category) AS No_of_category FROM retail_sale;
''
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sale
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
-- the quantity sold is more than and equal to 4 in the month of Nov-2022
SELECT * FROM retail_sale
WHERE 
	category = 'Clothing' 
	AND
	quantiy >= 4 
	AND
	TO_CHAR(sale_date, 'YYYY_MM')= '2022_11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT rs.category, SUM(rs.total_sale) FROM retail_sale AS rs
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased 
-- items from the 'Beauty' category.
SELECT ROUND(AVG(age),0) AS average_age FROM retail_sale
WHERE
	category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sale
WHERE 
	total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT rs.category As category, rs.gender AS gender, COUNT(transactions_id) AS no_of_transaction
FROM retail_sale AS rs
GROUP BY category, gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
	EXTRACT(YEAR FROM sale_date) AS year,
	EXTRACT(MONTH FROM sale_date) AS month,
	SUM(total_sale) AS sale
FROM retail_sale
GROUP BY year, month
ORDER BY year, sale DESC;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id, SUM(total_sale) AS total_sale
FROM retail_sale
WHERE total_sale IS NOT NULL
GROUP BY customer_id
ORDER BY customer_id ASC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,  count(DISTINCT customer_id)
FROM retail_sale
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sale
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

--end project