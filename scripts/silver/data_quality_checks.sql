
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
