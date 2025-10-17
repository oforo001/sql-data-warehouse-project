
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

--Test case for date columns colums
--Expected output: No output

WITH res AS (
    SELECT
        sls_order_dt,
        sls_ship_dt,
        sls_due_dt
    FROM silver.crm_sales_details
)
SELECT 
    sls_order_dt, 
    sls_ship_dt,
    sls_due_dt
FROM res 
WHERE 
    (sls_order_dt > sls_ship_dt)


/*
Test Module for silver.crm_sales_details table
*/

--Test case for Business Rule (negativ nums, zeros, Nulls are not allowd)
-- >> Sales = Quantity * Price
-- Expected output: No Nulls, no negativ numbers
SELECT 
sls_ord_num,
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales <> sls_quantity * sls_price
OR sls_sales IS NULL
OR sls_quantity IS NULL
OR sls_price IS NULL
OR sls_sales <= 0
OR sls_quantity <= 0
OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- Test Case: Rules: If sales is negativ, zero, null - derive it using Quanlity and Price
-- If price is zero, null, calculate it using Sales and Quanlity
-- If Price is negative, convert it to a positive value
-- Expected output: No Nulls and no negative numbers
SELECT 
CASE 
	WHEN sls_sales <= 0 OR sls_sales IS NULL THEN CAST(sls_price AS DECIMAL(10, 2)) / NULLIF(sls_quantity, 0)
	ELSE sls_sales
END AS sls_sales,
sls_quantity,
CASE
	WHEN sls_price IS NULL THEN CAST(sls_sales AS DECIMAL(10, 2)) * NULLIF(sls_quantity, 0)
	WHEN sls_price < 0 THEN (sls_price * -1)
	ELSE sls_price
END AS sls_price
FROM silver.crm_sales_details
WHERE sls_price < 1
OR sls_sales IS NULL;



