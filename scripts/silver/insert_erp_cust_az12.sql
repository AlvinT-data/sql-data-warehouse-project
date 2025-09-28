/*
===============================================================================
Script: Insert data into  silver.erp_cust_az12 table
===============================================================================
Script Purpose:
    Drop all rows in silver.erp_cust_az12 table. 
    Clean and insert data from bronze table into it.
===============================================================================
*/

TRUNCATE TABLE silver.erp_cust_az12;
INSERT INTO silver.erp_cust_az12 (
	cid,
	bdate,
	gen
)
SELECT 
	CASE 
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		ELSE cid
	END AS cid,
	CASE 
		WHEN bdate > GETDATE() THEN NULL
		ELSE bdate
	END AS bdate,
	CASE 
		WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
		WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
		ELSE 'N/A'
	END AS gen	
FROM bronze.erp_cust_az12;
