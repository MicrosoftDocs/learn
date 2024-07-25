# Exercise 01 - Real-time Ingestion and Processing with Delta Live Tables with Azure Databricks

## Objective
In this exercise, you learn how to use Azure Databricks to set up a real-time data ingestion pipeline using Delta Live Tables. By the end of this exercise, you're able to:

1. Set up Azure Databricks and create a cluster.
2. Ingest streaming data using Delta Live Tables.
3. Process and store streaming data using Delta Lake.
4. Query real-time data.

## Prerequisites
- An active Azure subscription. If you do not have one, you can sign up for a [free trial](https://azure.microsoft.com/en-us/free/).
- Basic knowledge of SQL.

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
        
## Step 3: Load Data (5 minutes)
- Import Data:
    1. Navigate to "Catalog" in the sidebar, click "Add Data" and choose "Native Integrations > DBFS", and upload the sample CSV file. Use the following sample data and save it as 'device_data.csv'.

    ```sql
    sensor_id,timestamp,temperature,humidity
    1,2024-06-24 00:00:00,22.5,45
    2,2024-06-24 00:00:01,23.0,44
    3,2024-06-24 00:00:02,21.5,50
    ```
- Create a New Notebook:
    1. Within the Catalog Explorer, click on "Create" > "Notebook" (choose SQL as the language).
    2. Attach the notebook to the cluster you created.

## Step 4: Create Delta Live Table Pipeline (10 minutes)
1. Create a Delta Live Table Pipeline:
    1. In the Databricks workspace, navigate to Delta Live Tables under the Workflows section.
    2. Click on Create Pipeline.

2. Configure the Pipeline:
    1. Name the pipeline (e.g., RealTimeSensorPipeline).
    2. Choose the cluster to run the pipeline on.
    3. Define the pipeline using SQL or Python (select the option based on your preference).

3. Define Source Data:

In the pipeline configuration, define the source data location

```sql
CREATE OR REFRESH LIVE TABLE raw_sensor_data
COMMENT "Raw sensor data ingested from Azure Storage"
TBLPROPERTIES ("quality" = "bronze")
AS SELECT * FROM csv.`/FileStore/tables/device_data.csv`;
```

## Step 5: Transform and Enrich Data (10 minutes)
1. Create Transformation Tables:
    1. Define transformation steps to process and enrich the data:

```sql
CREATE OR REFRESH LIVE TABLE sensor_data_cleaned
COMMENT "Cleaned sensor data with necessary transformations"
TBLPROPERTIES ("quality" = "silver")
AS
SELECT
  timestamp,
  sensor_id,
  temperature,
  humidity,
  CASE
    WHEN temperature > 50 THEN 'High'
    WHEN temperature BETWEEN 30 AND 50 THEN 'Medium'
    ELSE 'Low'
  END AS temperature_category
FROM
  LIVE.raw_sensor_data;
```

2. Create Aggregated Tables:
    1. Define aggregation steps for real-time insights:

```sql
CREATE OR REFRESH LIVE TABLE sensor_data_aggregated
COMMENT "Aggregated sensor data for dashboarding"
TBLPROPERTIES ("quality" = "gold")
AS
SELECT
  sensor_id,
  AVG(temperature) AS avg_temperature,
  AVG(humidity) AS avg_humidity,
  COUNT(*) AS record_count
FROM
  LIVE.sensor_data_cleaned
GROUP BY
  sensor_id;
```
## Step 6: Monitor and Maintain the Pipeline (10 minutes)
1. Monitor Pipeline:
    1. Use the Databricks UI to monitor the pipeline runs.
    2. Check for any errors and ensure the pipeline is running smoothly.

2. Update and Maintain:
    1. Update the pipeline definitions as needed.
    2. Ensure the storage and compute resources are optimized for cost and performance.

## Step 7: Visualize the Data (5 minutes)
1. Create Dashboards:
    1. Use Databricks SQL or Power BI to create dashboards based on the aggregated data.
    2. Visualize real-time metrics and insights from the sensor data.

## Step 8: Clean Up Resources (5 minutes)
- Terminate the Cluster:
    1. Go back to the "Compute" page, select your cluster, and click "Terminate" to stop the cluster.

- Optional: Delete the Databricks Service:
    1. To avoid incurring further charges, consider deleting the Databricks workspace if this lab is not part of a larger project or learning path.

## Conclusion
By following these steps, you can set up a robust real-time ingestion and processing pipeline for sensor data using Delta Live Tables in Azure Databricks. This setup will allow you to process and analyze data in real-time, providing valuable insights and enabling timely decision-making.