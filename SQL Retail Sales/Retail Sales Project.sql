-- ======================================================================================================================================================================
-- =======================================================  SQL RETAIL SALES   ==========================================================================================
-- ======================================================================================================================================================================

---  Create Database--
CREATE DATABASE Retail_Sales_P1;

---  Use Database------------------------------------------------------------------------------------------------------------------------------------------------------------
USE  Retail_Sales_P1;

--- Create Table-------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sales_date DATE,
    sales_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantiy INT,
    unit_price INT,
    cogs FLOAT,
    total_sale FLOAT
    );
-- Import Data -------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Basic Exploration--  ----------------------------------------------------------------------------------------------------------------------------------------------------  
SELECT count(*)
FROM retail_sales;

-- Check for Null Values  --------------------------------------------------------------------------------------------------------------------------------------------------  
SELECT *
FROM retail_sales
WHERE transaction_id IS NULL
        OR sales_date IS NULL
        OR sales_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR unit_price IS NULL
        OR total_sale IS NULL;

-- Check for Duplicate Values ---------------------------------------------------------------------------------------------------------------------------------------------
Select  transaction_id, count(*) from retail_sales group by transaction_id having  count(*) >1;

-- SQL EDA — Understanding the Dataset  ------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    MIN(unit_price),
    MAX(unit_price),
    MIN(quantity),
    MAX(quantity),
    MIN(total_sale),
    AVG(total_sale),
    MAX(total_sale)
FROM retail_sales;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Data Analysis & Business  Problems & Answers
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Write SQL query to retrieve all columns for sales made on 2022-11-05. -----------------------------------------------------------------------------------------------
SELECT *
FROM retail_sales
WHERE sales_date = '2022-11-05';

-- 2. Write SQL query to retrieve all transactions where category is clothing and quantity greater than 4 in the month of Nov-2022.-------------------------------------------
SELECT *
FROM retail_sales
WHERE category = 'Clothing' AND quantity >= 4
	  AND sales_date BETWEEN '2022-11-01' AND '2022-11-30'
ORDER BY sales_date ASC;
 
-- 3. Write SQL query to calculate total sale for each category.-------------------------------------------------------------------------------------------------------------
SELECT  category AS Category, SUM(total_sale) AS 'Net sales'
FROM retail_sales
GROUP BY category;

-- 4. Write SQL query to calculate avg age of customers who purchased items from beauty category.------------------------------------------------------------------------------
SELECT ROUND(AVG(age), 2) AS 'Average Age'
FROM retail_sales
WHERE category = 'Beauty';

-- 5. Write SQL query to retrieve all transactions where total sales is greater than 1000.------------------------------------------------------------------------------------
SELECT *
FROM retail_sales
WHERE total_sale >= 1000;

-- 6. Write SQL query to find total number of transactions made by each gender in each category.------------------------------------------------------------------------------
SELECT gender, category, COUNT(transaction_id) AS 'transactions'
FROM retail_sales
GROUP BY gender , category
ORDER BY gender , category;

-- 7. Write SQL query to find avg sales for each month. ---------------------------------------------------------------------------------------------------------------------
SELECT 
    EXTRACT(YEAR FROM sales_date) AS 'Sales Year',
    EXTRACT(MONTH FROM sales_date) AS 'Sales Month',
    ROUND(AVG(total_sale),2) AS 'Avg Sales'
FROM retail_sales
GROUP BY EXTRACT(Year FROM sales_date), EXTRACT(MONTH FROM sales_date)
order by EXTRACT(Year FROM sales_date), EXTRACT(MONTH FROM sales_date);

-- 8. Find best selling month in each year -- -----------------------------------------------------------------------------------------------------------------------------
WITH MonthlySales AS(                                                                  -- Use of CTE --
    SELECT 
      EXTRACT(YEAR FROM sales_date) AS sales_year,
      EXTRACT(MONTH FROM sales_date) AS sales_month,
      SUM(total_sale) AS total_sales
    FROM retail_sales
    GROUP BY EXTRACT(Year FROM sales_date), EXTRACT(MONTH FROM sales_date)
-- order by EXTRACT(Year FROM sales_date), EXTRACT(MONTH FROM sales_date)
),
RankedMonths AS(
     Select sales_year, 
            sales_month, 
            total_sales,
			RANK() OVER (PARTITION BY sales_year ORDER BY total_sales DESC) AS sales_rank
     FROM MonthlySales
     )
SELECT 
    sales_year, sales_month, total_sales
FROM RankedMonths
WHERE sales_rank = 1
ORDER BY sales_year;

-- 9. Write SQL query to find top 5 customers based on highest total sales-----------------------------------------------------------------------------------------------
WITH ranked_sales AS(
  SELECT transaction_id,customer_id,gender,age,category,quantity,sum(total_sale) AS net_sale,
  DENSE_RANK() OVER (ORDER BY SUM(total_sale) DESC )AS sales_rank FROM retail_sales GROUP BY transaction_id ORDER BY customer_id
  )
  SELECT 
    sales_rank,transaction_id,customer_id,gender,age,category,quantity,net_sale FROM ranked_sales WHERE sales_rank <=5
    ORDER BY sales_rank ASC;

-- 10. Write SQL query to find number of unique customers who purchased from each category-------------------------------------------------------------------------------
SELECT category, 
       COUNT(DISTINCT customer_id) AS unique_customers_count
FROM  retail_sales
GROUP BY category; 

-- 11. Write SQL query to create each shift and number of orders (example-- Morning <=12, Afternoon between 12-17 , Night >17)-----------------------------------------------

SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sales_time) <= 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sales_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Night'
    END AS shift,
    COUNT(transaction_id) AS number_of_orders
FROM 
    retail_sales
GROUP BY 
    CASE 
        WHEN EXTRACT(HOUR FROM sales_time) <= 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sales_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Night'
    END;
    

