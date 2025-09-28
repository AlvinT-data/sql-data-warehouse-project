/*
Used to check data quality of datable and decide what actions are needed to clean the data
*/

-- Qulity Checks Framework

-- Check Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT 
	id,
	COUNT(*)
FROM table_name
GROUP BY id
HAVIN COUNT(*) > 1 OR id IS NULL

-- Check for unwanted Spaces (Strings)
-- Expectation: No Results
SELECT field
FROM table_name
WHERE field != TRIM(field)

-- Check for NULLS or Negative Numbers
-- Expectation: No Results
SELECT sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 OR sls_order_dt IS NULL

-- Data Standardization & Consistency
SELECT DISTINCT field
FROM table_name

-- Check for Invalidate Date Orders
SELECT *
FROM bronze.crm_sales_details
WHERE sls_ship_dt < sls_order_dt AND sls_order_dt < sls__dt

-- Check for Invalid Dates
SELECT
	sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0 OR LEN(sls_ship_dt) != 8 OR sls_ship_dt IS NULL

-- Check business rule e.g. sales != quantity * price
SELECT DISTINCT
	sales, 
	quantity,
	price
FROM table
WHERE sales != quantity * price OR 
	sales IS NULL OR quantity IS NULL OR price IS NULL OR
	sales = 0 OR quantity = 0 OR price = 0
