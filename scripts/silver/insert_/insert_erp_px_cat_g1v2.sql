/*
===============================================================================
Script Purpose:
    Drop all rows in silver.erp_px_cat_g1v2 table. 
    Clean and insert data from bronze table into it.
===============================================================================
*/

TRUNCATE TABLE silver.erp_px_cat_g1v2;
INSERT INTO silver.erp_px_cat_g1v2 (
	id,
	cat,
	subcat,
	maintenance
)
SELECT
	id,
	cat,
	subcat,
	maintenance
FROM bronze.erp_px_cat_g1v2;
