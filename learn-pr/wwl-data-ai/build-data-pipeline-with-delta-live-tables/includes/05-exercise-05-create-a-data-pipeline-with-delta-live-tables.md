# Exercise 05 - Create a data pipeline with Delta Live tables

## Objective
This exercise aims to make you learn to set up data pipeline using Delta Live Tables in Azure Databricks to ingest, transform, and aggregate COVID-19 time-series data to provide insights into trends over time across different regions.

## Prerequisites
- An active Azure subscription. If you do not have one, you can sign up for a [free trial](https://azure.microsoft.com/en-us/free/).
- Basic knowledge of Python and SQL.

## Estimated time: 60 minutes

## Step 1: Provision Azure Databricks (5 minutes)
- Login to Azure Portal:
    1. Go to Azure Portal and sign in with your credentials.
- Create Databricks Service:
    1. Navigate to "Create a resource" > "Analytics" > "Azure Databricks".
    2. Enter the necessary details like workspace name, subscription, resource group (create new or select existing), and location.
    3. Select the pricing tier (choose standard for this lab).
    4. Click "Review + create" and then "Create" once validation passes.

## Step 2: Launch Workspace and Create a Cluster (10 minutes)
- Launch Databricks Workspace:
    1. Once the deployment is complete, go to the resource and click "Launch Workspace".
- Create a Spark Cluster:
    1. In the Databricks workspace, click "Compute" on the sidebar, then "Create compute".
    2. Specify the cluster name and select a runtime version of Spark.
    3. Choose the Worker type as "Standard" and node type based on available options (choose smaller nodes for cost-efficiency).
    4. Click "Create compute".
    
## Step 3: Import Sample Dataset (10 minutes)
For this exercise, we'll use a publicly available dataset, such as the COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University, which provides daily updated data files. [Global Cases and Deaths](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports)

- Upload Dataset to DBFS (Databricks File System):
- Download a CSV file or collection of files from the repository.
- Use the "Catalog" tab in Azure Databricks to upload the CSV file/s to DBFS.
    
## Step 4: Create Initial Delta Table (5 minutes)

### Data Preparation
```sql
CREATE TABLE raw_covid_data
USING csv
OPTIONS (path '/FileStore/tables/covid_data/*.csv', header 'true', inferSchema 'true')
```

## Step 5: Develop Delta Live Tables Pipeline using SQL (10 minutes)

### Set Up a DLT Notebook:
- Open a new SQL notebook in Databricks and start defining the Delta Live Tables using SQL scripts. Ensure you have enabled the DLT SQL UI.
    
### Define DLT Code
```sql
CREATE LIVE TABLE processed_covid_data
COMMENT "Formatted and filtered data for analysis."
AS
SELECT 
    to_date(date, 'MM/dd/yyyy') as report_date,
    country_region,
    confirmed,
    deaths,
    recovered
FROM raw_covid_data
WHERE country_region = 'US';

CREATE LIVE TABLE aggregated_covid_data
COMMENT "Aggregated daily data for the US with total counts."
AS
SELECT
    report_date,
    sum(confirmed) as total_confirmed,
    sum(deaths) as total_deaths,
    sum(recovered) as total_recovered
FROM processed_covid_data
GROUP BY report_date;
```

## Step 6: Deploy and Run Pipeline (5 minutes)
- Deploy the Pipeline: Use the DLT UI to configure and initiate the pipeline. Set the update mode as required (Triggered or Continuous).
- Monitor Execution: View the pipeline's execution, inspect the output, and debug if needed.

## Step 7: Visualization and Analysis (10 minutes)
- Create Visuals in Notebooks: Use display() on DataFrame queries to visualize data, e.g., trends over time for COVID-19 cases.
- Connect to BI Tools: Optionally, connect to external BI tools like Power BI to create dashboards.

## Step 8: Clean Up Resources (5 minutes)
- Terminate the Cluster:
    1. Go back to the "Clusters" page, select your cluster, and click "Terminate" to stop the cluster.
- Optional: Delete the Databricks Service:
    2. To avoid incurring further charges, consider deleting the Databricks workspace if this lab is not part of a larger project or learning path.

This exercise provides a practical way to set up data pipeline using Delta Live Tables in Azure Databricks.