
/*
Test Module for silver.crm_cst_info table
*/

--Check for cst_id uniquest
--Expected result: No result
SELECT cst_id, COUNT(cst_id) as test
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) >1;

--Check for unwanted spaces
--Expected result: No result
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

-- Data Standarization & Consistency
--Expected result: 'n/a', 'Male', 'Female'
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;




/*
Test Module for silver.crm_prd_info table
*/

use DataWarehouse

SELECT prd_id,
COUNT(*) AS dublicates
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

--checking of extra spaces
--Expected output: No output
SELECT
	prd_nm
FROM silver.crm_prd_info
WHERE TRIM(prd_nm) != prd_nm;

--checking negatie prices or NULL values
-- Expected output: No output
SELECT prd_cost
FROM silver.crm_prd_info
WHERE  prd_cost < 0 OR prd_cost IS NULL;

--check the data issue with dates
--Expected output: No output
SELECT *
FROM silver.crm_prd_info
WHERE prd_start_dt > prd_end_dt;



