/*
This Fact Table combaints two dimentions tables:
1. gold.dim_customer
2.gold_dim_products
*/
  

CREATE VIEW gold.fact_sales AS
SELECT
sd.sls_ord_num AS order_number,
pr.product_key, --using the data lookup for inserting the product_key from gold.dim_product
cu.customer_key, --using the data lookup for inserting the product_key from gold.dim_customer
sd.sls_order_dt AS order_date,
sd.sls_ship_dt AS shipping_date,
sd.sls_due_dt AS due_dt,
sd.sls_sales AS sales,
sd.sls_quantity AS quantity,
sd.sls_price AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_product pr
ON		  sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON		sd.sls_cust_id = cu.customer_id;
