use DataWarehouse

/* 
   Load the latest unique customer records from bronze to silver layer,
   removing duplicates by cst_id and standardizing key fields (names, gender, marital status).
*/

/*
==========================
Insertion into silver.crm_cust_info
==========================
*/

INSERT INTO silver.crm_cust_info (
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date)

SELECT
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname)AS cst_lastname,
CASE
	 WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
	 WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
	 ELSE 'n/a'
END cst_marital_status,
CASE 
     WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
	 WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	 ELSE 'n/a'
END cst_gndr,
cst_create_date
FROM(
	SELECT *,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
	FROM bronze.crm_cust_info)
AS t WHERE t.flag_last = 1 AND t.cst_id IS NOT NULL

/*
==========================
Insertion into silver.crm_prd_info
==========================
*/
INSERT INTO silver.crm_prd_info (
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)

SELECT
prd_id,
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
SUBSTRING(prd_key, 7, LEN(prd_key)) as prd_key, -- for joining with sls_prd_key from bronze.crm_sales_details
TRIM(prd_nm) AS prd_nm,
ISNULL(prd_cost, 0) AS prd_cost,
CASE TRIM(UPPER(prd_line))
	WHEN 'M' THEN 'Mountain'
	WHEN 'R' THEN 'Road'
	WHEN 'S' THEN 'Other Sales'
	WHEN 'T' THEN 'Touring'
	ELSE 'n/a'
END AS prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_date,
CAST(DATEADD(DAY, -1, LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info

select * from silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

/*
==========================
TODO: Insertion into silver.crm_sales_details
==========================
*/

SELECT
TRIM(sls_ord_num) AS sls_ord_num,
sls_prd_key, -- key to silver.crm_prd_info
sls_cust_id, -- key to silver.crm_cust_info
CASE
    WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
	ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
END AS sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_quantity,
sls_price
FROM bronze.crm_sales_details;



