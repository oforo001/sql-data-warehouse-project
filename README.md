# Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository.  
This project presents an end-to-end **data warehousing and analytics solution** — from building the data warehouse to generating actionable insights.  
It is designed as a **portfolio project**, demonstrating industry-standard practices in **data engineering, modeling, and analytics**.

---

##  1. Project Overview

This project aims to design, build, and deploy a **modern data warehouse** that consolidates sales and operational data from multiple sources.  
It provides a clean data foundation for **analytical reporting** and **business intelligence** using SQL Server and Power BI.

### Key Components
- **Data Architecture** — Designed using the Medallion Architecture (Bronze, Silver, Gold layers).
- **ETL Pipelines** — Automated extraction, transformation, and loading of data into SQL Server.
- **Data Modeling** — Fact and dimension tables designed for performance and analytical flexibility.
- **Analytics & Reporting** — Power BI dashboards and SQL queries for insights.

---

##  2. Data Architecture

The project adopts the **Medallion Architecture**, which organizes data into three refinement layers:

[<img src="https://github.com/user-attachments/assets/880f0ded-6f18-4dbb-9a4a-5bfb63df3b6a" width="800" />](https://github.com/user-attachments/assets/880f0ded-6f18-4dbb-9a4a-5bfb63df3b6a)

### Layer Descriptions
- **Bronze Layer:**  
  Stores raw data exactly as received from source systems (CSV files).  
  This ensures traceability and preserves original data fidelity.

- **Silver Layer:**  
  Cleansed, standardized, and validated data.  
  Business rules are applied, and data is normalized for consistency.

- **Gold Layer:**  
  Contains curated, business-ready data modeled into a **Star Schema** for reporting and analytics.

---

##  3. Data Sources and Flow

Data is ingested from multiple CSV files into SQL Server using ETL pipelines.  
The flow of data is illustrated below:

[<img src="https://github.com/user-attachments/assets/009c84a0-73fc-4d95-8045-0d9ca758220d" width="800" />](https://github.com/user-attachments/assets/009c84a0-73fc-4d95-8045-0d9ca758220d)

---

##  4. Data Model

The warehouse uses a **Star Schema** consisting of fact and dimension tables optimized for analytical queries.

[<img src="https://github.com/user-attachments/assets/ca62bbfb-edd8-4cbc-9199-1ae707159322" width="800" />](https://github.com/user-attachments/assets/ca62bbfb-edd8-4cbc-9199-1ae707159322)

### Main Tables
- **FactSales** — Central fact table storing transaction data.
- **DimCustomer**, **DimProduct**, **DimDate**, **DimRegion** — Supporting dimension tables providing context.

---

##  5. ETL Process

1. **Extract** — Load CSV files from source folders into staging tables.  
2. **Transform** — Clean, validate, and enrich data using SQL and stored procedures.  
3. **Load** — Move cleansed data into Silver and Gold layer tables.  

Automation is handled via **scheduled jobs** to maintain consistency.

---

##  6. Analytics and Reporting

Data from the Gold layer is visualized using **Power BI dashboards**, enabling insights such as:
- Total revenue and profit trends
- Top-performing products and regions
- Customer acquisition patterns
- Sales performance over time

---

##  7. Documentation

- **Tech Stack:** SQL Server, Power BI, SSMS, Azure Data Studio  
- **Architecture:** Medallion (Bronze, Silver, Gold)  
- **Modeling Approach:** Star Schema  
- **Data Quality:** Validation and standardization at the Silver layer  

---

## 8. Future Enhancements

- Automate ETL pipelines using **Azure Data Factory** or **Apache Airflow**
- Add real-time ingestion using **Event Hub** or **Kafka**
- Integrate CI/CD for pipeline deployment
- Expand Power BI reporting capabilities

---

## Author

**Oleksii Forostianov**  


---

