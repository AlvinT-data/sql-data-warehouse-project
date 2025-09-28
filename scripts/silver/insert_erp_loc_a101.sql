/*
===============================================================================
Script: Insert data into  silver.erp_loc_a101 table
===============================================================================
Script Purpose:
    Drop all rows in silver.erp_loc_a101 table. 
    Clean and insert data from bronze table into it.
===============================================================================
*/

TRUNCATE TABLE silver.erp_loc_a101;
INSERT INTO silver.erp_loc_a101 (
	cid,
	cntry
)
SELECT
	REPLACE(cid, '-', '') cid, -- mapping to fit the key from another table
	CASE
		WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
		WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'N/A'
		ELSE TRIM(cntry)
	END AS cntry -- Standardize country names
FROM bronze.erp_loc_a101;

