# Exercise 06 - Deploy workloads with Azure Databricks Workflows

## Objective
This exercise aims to develop your proficiency in designing, implementing, and automating a data pipeline using Azure Databricks.

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
        
## Step 3: Load Data (5 minutes)
- Import Data:
    1.  Navigate to "Catalog" in the sidebar, click "Add Data" and choose "Native Integrations > DBFS", and upload the [flights](../../Allfiles/Labs/01/flights.csv) file.
- Create a New Notebook:
    1. Within the Catalog Explorer, click on "Create" > "Notebook" (choose Python as the language).
    2. Attach the notebook to the cluster you created.

    ```python
        df = spark.read.csv("/FileStore/tables/flight_data.csv", header=True, inferSchema=True)
        display(df)
    ```

## Step 4: Data Processing (10 minutes)
- Data Cleaning:
    1. Handle missing values, remove duplicates, and filter out irrelevant records.
- Feature Engineering:
    1. Calculate new metrics such as 'On Time Percentage' and 'Average Delay' per airline and airport.

## Step 5: Data Analysis (10 minutes)
- Exploratory Data Analysis (EDA):
    1. Analyze trends and patterns in the data.
    2. Generate visualizations using Databricks’ built-in visualization tools or libraries like Matplotlib/Seaborn.
- Insight Generation:
    1. Identify the top 5 airlines and airports with the least and most delays.

## Step 6: Build and Schedule the Workflow (10 minutes)
- Define Jobs:
    1. Use the 'Jobs' tab to create new jobs that point to your notebook.
    2. Set up parameters and configure the job schedule using cron syntax.
- Triggering and Dependencies:
    1. Set dependencies so that some tasks are only run after successful completion of others.

## Step 7: Monitoring and Optimization (5 minutes)
- Monitor Job Runs:
    1. Use the 'Jobs' dashboard to monitor the status and performance of scheduled jobs.
    2. Analyze logs and metrics to optimize cluster performance.

## Step 8: Clean Up Resources (5 minutes)
- Terminate the Cluster:
    1. Go back to the "Clusters" page, select your cluster, and click "Terminate" to stop the cluster.
- Optional: Delete the Databricks Service:
    2. To avoid incurring further charges, consider deleting the Databricks workspace if this lab is not part of a larger project or learning path.

This exercise provides the ability to design, implement, and automate a data pipeline using Azure Databricks.