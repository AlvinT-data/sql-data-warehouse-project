/*
===============================================================================
Script: Insert data into  silver.crm_cust_info table
===============================================================================
Script Purpose:
    Drop all rows in silver.crm_cust_info table. 
    Clean and insert data from bronze table into it.
===============================================================================
*/

TRUNCATE TABLE silver.crm_cust_info
INSERT INTO silver.crm_cust_info (
	cst_id, 
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
SELECT 
	cst_id,
	cst_key,
	TRIM(cst_firstname) AS cst_firstname, -- Remove extra whitespace
	TRIM(cst_lastname) AS cst_lastname,
	CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Married'
		WHEN UPPER(TRIM(cst_gndr)) = 'S' THEN 'Single' 
		ELSE 'N/A' 
	END AS cst_marital_status,
	CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		ELSE 'N/A'
	END AS cst_gndr,
	cst_create_date
FROM ( -- Remove Duplicates
	SELECT 
		*, 
		ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
	FROM bronze.crm_cust_info
) t
WHERE flag_last = 1 AND cst_id IS NOT NULL

