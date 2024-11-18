Monitoring data transformation in Fabric involves tracking the ingestion, processing, analysis, and transformation of data from various streaming sources through a no-code experience. It includes automatically taking actions based on detected patterns. Visualizing data in a central hub for better decision-making, and real-time detection and monitoring with notifications can also help achieve this. In Fabric Data Factory, monitoring ensures smooth and efficient data pipeline runs and dataflows by tracking key metrics like run status, duration, and errors, and setting up alerts and reviewing logs to optimize performance.

## Monitoring Data Transformation in Fabric Real-Time Intelligence

Monitoring data transformation in Fabric Real-Time Intelligence involves several key components and processes. Here's a breakdown to help you explain to it to your learners:

1. **Ingest and Process**: Fabric's Real-Time Intelligence allows organizations to ingest and process data from various streaming sources such as Advanced Messaging Queuing Protocol (AMQP), Kafka, and Azure Event Hubs. This is done through a no-code experience that includes event processing and routing to different Fabric entities like Eventhouse and Reflex.

2. **Analyze and Transform**: Once the data is ingested, it's stored in a time series database with unlimited scale. Fabric provides tools for transformation on read of complicated data structures, and Copilot can be used to generate queries. This step is crucial for turning raw data into meaningful insights.

3. **Act**: Fabric's Real-Time Intelligence can automatically take actions when specific patterns or conditions are detected in the data. This action can include triggering notifications or other actions based on the analyzed data.

4. **Real-Time Hub**: The Real-Time Hub in Fabric serves as a central point to access and visualize all internal and external, first-, and third-party streaming data. This hub enables faster and more accurate decision-making by providing a comprehensive view of the data.

5. **Data Activator**: This component provides real-time detection and monitoring of data. It can trigger notifications and actions when it finds specified patterns in the data, all within a no-code experience.

### Key Components Table

| Component          | Description                                                                 |
|--------------------|-----------------------------------------------------------------------------|
| Ingest and Process | Ingest data from various streaming sources and process it through a no-code experience. |
| Analyze and Transform | Store data in a time series database and transform it using tools and Copilot-generated queries. |
| Act                | Automatically take actions based on detected patterns or conditions in the data. |
| Real-Time Hub      | Central point to access and visualize all streaming data for better decision-making. |
| Data Activator     | Real-time detection and monitoring of data, triggering notifications and actions. |

## Monitoring Data Transformation Tasks in Fabric Data Factory

Monitoring your data transformation tasks in Fabric Data Factory is crucial to ensure that your data pipelines run smoothly and efficiently. This guide helps you understand how to monitor pipeline runs and dataflows effectively.

### Data Transformation Activities

Microsoft Fabric supports the following transformation activities that can be added either individually or chained with another activity.

For more information, see the data transformation activities article.

| Data Transformation Activity | Compute Environment |
|------------------------------|---------------------|
| Copy data                    | Compute manager by Microsoft Fabric |
| Dataflow Gen2                | Compute manager by Microsoft Fabric |
| Delete data                  | Compute manager by Microsoft Fabric |
| Fabric Notebook              | Apache Spark clusters managed by Microsoft Fabric |
| HDInsight activity           | Apache Spark clusters managed by Microsoft Fabric |
| Spark Job Definition         | Apache Spark clusters managed by Microsoft Fabric |
| Stored Procedure             | Azure SQL, Azure Synapse Analytics, or SQL Server |
| SQL script                   | Azure SQL, Azure Synapse Analytics, or SQL Server |

> **Note**  
> There is a default soft limit of maximum 80 activities per pipeline, which includes inner activities for containers.

### **1. Overview of Monitoring in Fabric Data Factory**

Fabric Data Factory provides robust monitoring capabilities to track the progress and performance of your data transformation tasks. You can monitor both pipeline runs and dataflows to ensure that your data is being processed as expected.

### **2. Monitoring Pipeline Runs**

Pipeline runs are the execution instances of your data pipelines. Monitoring these runs helps you identify any issues or bottlenecks in your data processing workflows.

**Key Metrics to Monitor:**

- **Run Status:** Indicates whether the pipeline run succeeded, failed, or is in progress.
- **Duration:** The time taken for the pipeline runs to complete.
- **Activity Runs:** Details of each activity within the pipeline, including status and duration.

**How to Monitor Pipeline Runs:**

1. Navigate to the **Monitor** tab in Fabric Data Factory.
2. Select **Pipeline Runs** to view the list of recent pipeline executions.
3. Use filters to narrow down the results based on status, time range, or pipeline name.
4. Select on a specific pipeline run to view detailed information about each activity within the pipeline.

### **3. Monitoring Dataflows**

Dataflows are used to transform and prepare data for further analysis. Monitoring dataflows ensures that your data transformations are executed correctly and efficiently.

**Key Metrics to Monitor:**

- **Refresh Status:** Indicates whether the dataflow refresh succeeded, failed, or is in progress.
- **Refresh Duration:** The time taken for the dataflow refreshes to complete.
- **Error Details:** Information about any errors encountered during the dataflow refresh.

**How to Monitor Dataflows:**

1. Navigate to the **Monitor** tab in Fabric Data Factory.
2. Select **Dataflows** to view the list of recent dataflow refreshes.
3. Use filters to narrow down the results based on status, time range, or dataflow name.
4. Select on a specific dataflow refresh to view detailed information about the refresh process and any errors encountered.

### **4. Best Practices for Monitoring**

- **Set Up Alerts:** Configure alerts to notify you of any failures or issues in your pipeline runs or dataflows.
- **Regularly Review Logs:** Regularly review the logs and metrics to identify any patterns or recurring issues.
- **Optimize Performance:** Use the monitoring data to optimize the performance of your data pipelines and dataflows.
