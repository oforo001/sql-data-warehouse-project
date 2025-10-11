/*
================================================
Create Database and Schemas
================================================
Script Purpose:
	The script creates a new DB nemaed "DataWarehouse" after checking if it already exist.
	If the database exist - it is droped and recreated. Additionally, the sript sets up thee schemas within DB
	'bronze', 'silver', 'gold'.

WARNING:
	Running the script will drop the entire 'DataWarehouce' DB if it exist.
*/

USE master;
GO

--Drop and recreate the 'DataWarehouce' DB
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_user WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse
END;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--Creating schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
