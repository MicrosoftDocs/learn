A significant challenge for a fast-growing home improvement retailer like Tailwind Traders is that it generates high volume of data stored in relational, non-relational and other storage systems in both the cloud and on-premises. Management wants actionable business insights from this data as near real time as possible. Additionally, sales team wants to set up and roll out up-selling and cross-selling solutions. How will you create a large-scale data ingestion solution in the cloud? What Azure services and solutions will you adopt to help with the movement and transformation of data between various data stores and compute resources?

[Azure Data Factory](https://azure.microsoft.com/services/data-factory/) is a cloud-based ETL and data integration service that can help you create and schedule data-driven workflows (called pipelines) that can ingest data from disparate data stores. You can use Azure Data Factory to

- Orchestrate data movement.

- Transform data at scale.

 

**Data-driven workflows**

There are four major steps in creating and implementing a data-driven workflow in Azure Data Factory. 

1. **Connect and collect** – Data ingestion is the first step to collecting all the data from different sources into a centralized location.

2. **Transform and enrich** – Now you will use a compute service like Azure Databricks and Azure HDInsight Hadoop to transform the data

3. **Continuous integration and delivery (CI/CD) and publish** – Support for CI/CD through GitHub and Azure DevOps enables to deliver your ETL process incrementally before publishing the data to the analytics engine.

4. **Monitor** – Via the Azure portal, you can monitor the pipeline for scheduled activities and for any failures.

The following graphic shows Azure Data Factory orchestrating the ingestion of data from different data sources. Data is ingested into Storage Blob and stored in Azure Synapse Analytics. Analysis and Visualization components are also connected to Azure Data Factory. Azure data factory provides a common management interface for all of your data integration needs.

:::image type="content" source="../media/azure-data-factory-overview.png" alt-text="The Data Factory architecture.":::



## When to use Azure Data Factory

Let us evaluate Azure Data Factory against the following decision criteria:

- **Requirements for data integration** – Azure Data Factory serves two communities – Big data community and the Relational data warehousing community that uses SQL Server Integration Services (SSIS). Depending on your organization’s data needs you would set up pipelines in the cloud using Azure Data Factory that can access data from both cloud and on-premises data services. 

- **Coding resources** – If you prefer a graphical interface to set up pipelines, then Azure Data Factory authoring and monitoring tool is the right fit for your needs. Azure Data Factory provides a low code/no code process for working with data sources 

- **Support for multiple data sources** – Azure Data Factory supports 90+ connectors to integrate with disparate data sources. 

- **Serverless infrastructure –** There are advantages in using a fully managed, serverless solution for data integration - No need to maintain, configure or deploy servers, and the ability to scale with fluctuating workloads.

 
### Components of Azure Data Factory

:::image type="content" source="../media/data-factory-components.png" alt-text="Diagram showing pipeline, activities, data sets and linked services in Azure Data Factory.":::


Azure Data factory has the following components as shown in the image above that work together to provide the platform for data movement and data integration.

- **Pipelines and activities** - A logical grouping of activities that perform a task. An activity is a single processing step in a pipeline. Azure Data Factory supports data movement, data transformation, and control activities. 

- **Datasets** – These are data structures within your data stores. 

- **Linked services** - Define the required connection information needed for Azure Data Factory to connect to external resources.

- **Data Flows** - Data flows allow data engineers to develop data transformation logic without writing code. Data flow activities can be operationalized using existing Azure Data Factory scheduling, control, flow, and monitoring capabilities.

- **Integration Runtimes** – It is the bridge between the activity and linked Services objects. There are three types of Integration Runtime, including Azure, Self-hosted, and Azure-SSIS.

 

Let's review how ADF’s components are involved in a data preparation and movement scenario for Tailwind Traders. They have many different data sources to connect to and that data needs to be ingested and transformed through stored procedures that are run on the data. Finally, the data should be pushed to analytics platform for analysis. 

- In this scenario, Linked Service enables Tailwind Traders to ingest data from different sources and it stores connection strings to fire up compute services on demand.

- You can execute stored procedures for data transformation that happens through Linked Service in Azure SSIS, which is the integration runtime environment for Tailwind Traders.

- The datasets components are used by the activity object and the activity object contains the transformation logic.

- You can trigger the pipeline, which is all the activities grouped together.

- You can then use Data Factory to publish the final dataset to another linked service that is consumed by technologies such as Power BI or Machine Learning.
