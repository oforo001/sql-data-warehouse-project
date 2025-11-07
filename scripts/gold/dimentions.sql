
--Represents customer dimention
CREATE VIEW gold.dim_customers AS
SELECT
ROW_NUMBER() OVER (ORDER BY ci.cst_id) as customer_key,
ci.cst_id AS customer_id,
ci.cst_key AS customer_number,
ci.cst_firstname AS first_name,
ci.cst_lastname AS last_name,
la.ctry AS contry,
ci.cst_marital_status AS marital_status,
CASE	
	WHEN ci.cst_gndr <> NULL THEN ci.cst_gndr
	ELSE COALESCE(ca.gen, 'n/a')
END AS gender,
ca.bdate AS bithdate,
ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON        ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON        ci.cst_key = la.cid;


--Represents product dimention
CREATE VIEW gold.dim_product AS 
SELECT
ROW_NUMBER() OVER (ORDER BY prd_start_dt ,prd_key) AS product_key,
pn.prd_id AS product_id,
pn.prd_key AS product_number,
pn.prd_nm product_name,
pn.cat_id AS category_id,
pc.cat AS category,
pc.subcat AS subcategory,
pc.maintenance AS maintenance,
pn.prd_line AS product_line,
pn.prd_cost AS product_cost,
pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON		  pn.cat_id = pc.id
WHERE prd_end_dt IS NULL--Filer out all historical data)
