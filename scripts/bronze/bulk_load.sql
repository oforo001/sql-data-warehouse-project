/*
=============================================
Definition:
	The script bulk-loads the .csv files from local storage

Constaints:
	It truncates the tables before bulk inseart to keep the data idempotent 
=============================================

*/



TRUNCATE TABLE bronze.crm_cust_info; -- it removes all rows from table but not the structure.
BULK INSERT bronze.crm_cust_info
FROM 'C:\Repos\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
SELECT COUNT(*) FROM bronze.crm_cust_info;
