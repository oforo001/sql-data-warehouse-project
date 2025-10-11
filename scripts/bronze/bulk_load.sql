/*
=============================================
Definition:
	The script bulk-loads the .csv files from local storage
	It sets the local variables for debugging purpuses

Constaints:
	It truncates the tables before bulk inseart to keep the data idempotent 
=============================================

*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @bronze_load_start_time DATETIME, @bronze_load_end_time DATETIME;
	SET @bronze_load_start_time = GETDATE();

	PRINT '==============================';
	PRINT 'Start loading the bronze layer';
	PRINT '==============================';

	PRINT '------------------------------';
	PRINT '   Loading CRM tables';
	PRINT '------------------------------';
	--==================================
	--load the crm.cust_info.csv (local)
	--==================================
	DECLARE @start_time DATETIME, @end_time DATETIME;

	BEGIN TRY
		SET @start_time = GETDATE();
		PRINT '>> Truncating the bronze.crm_cust_info table ';

		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting into: bronze.crm_cust_info';

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Repos\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		--==================================
		--load the crm.prd_info.csv (local)
		--==================================
		SET @start_time = GETDATE();
		PRINT '>> Truncating the bronze.crm_prd_info table';

		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting into: bronze.crm_prd_info';

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Repos\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT'----------------------------------'
		--==================================
		--load the crm.sales_details.csv (local)
		--==================================
		SET @start_time = GETDATE();
		PRINT '>> Truncating the bronze.crm_sales_details table';

		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting into: bronze.crm_sales_details'

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Repos\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'----------------------------------'

		PRINT '------------------------------';
		PRINT '    Loading ERP tables';
		PRINT '------------------------------';
		--==================================
		--load the erp.CUST_AZ12.csv (local)
		--==================================
		SET @start_time = GETDATE();
		PRINT '>> Truncating the bronze.erp_cust_az12 table';

		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting into: bronze.erp_cust_az12';

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Repos\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'----------------------------------'
		--==================================
		--load the erp.LOC_A101.csv (local)
		--==================================
		SET @start_time = GETDATE();
		PRINT '>> Truncating the bronze.erp_loc_a101 table';

		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting into: bronze.erp_loc_a101';

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Repos\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'----------------------------------'
		--==================================
		--load the erp.PX_CAT_G1V2.csv (local)
		--==================================
		SET @start_time = GETDATE();
		PRINT '>> Truncating the bronze.erp_px_cat_g1v2 table';

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting into: bronze.erp_px_cat_g1v2';

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Repos\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'----------------------------------'

		SET @bronze_load_end_time = GETDATE();
		PRINT 'Full bronze layer load-time duration: ' + CAST(DATEDIFF(second, @bronze_load_start_time, @bronze_load_end_time) AS NVARCHAR)
		END TRY
	BEGIN CATCH
		PRINT '==================================';
		PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER: ' + CAST(ERROR_NUMBER() AS NVARCHAR); 
		PRINT 'ERROR STATE: ' + CAST(ERROR_STATE() AS NVARCHAR); 
		PRINT '==================================';
	END CATCH
END
