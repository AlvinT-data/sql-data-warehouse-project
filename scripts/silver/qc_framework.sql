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
SELECT field
FROM table_name
WHERE field < 0 OR field IS NULL

-- Data Standardization & Consistency
SELECT DISTINCT field
FRPOM table_name

-- Check for Invalidate Date Orders
SELECT *
FRIN table_name
WHERE start_date > end_date
