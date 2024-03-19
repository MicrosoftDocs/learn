

Azure Synapse Studio provides a central location to host data and analytic capabilities for your business scenario. Synapse Studio enables you to do the following activities:

- Explore your data estate.
- Build data integration pipelines for managing data movement from multiple sources.
- Develop T-SQL scripts and notebooks to interact with the analytical engines.
- Monitor the workloads within the service.
- Manage the components of the service.

Synapse Studio is organized into hubs that are displayed on the left-hand side of the graphical UI. You can stay in the same workspace and navigate to the hub you need to perform each activity against your data.

## Synapse Studio Hubs

The different hubs available in Azure Synapse Studio from the left navigation pane enable different activities.

:::image type="content" source="../media/azure-synapse-studio-left-pane.png" alt-text="Screenshot of Azure Synapse Studio with the hubs in the left navigation that enable different activities.":::

### Home

The Home hub contains shortcuts to Azure services that enable you to ingest, explore and analyze, plus visualize your data with Power BI. Find links to resources such as the documentation and pricing page. The Home hub also displays your recently accessed and pinned resources.

### Data

Access the Data hub one of two ways. Select the **Explore** link in the **Home** hub, or select **Data** from the left navigation pane. In the data hub, you can access the following resources:

- provisioned dedicated SQL pool and serverless SQL databases in your workspace;
- external data sources, such as storage accounts and other linked services;
- previews of data tables and data files.

In this module's scenario, you navigate to the Data hub to manage the stored data from your SAP BW system and Cosmos DB.

### Develop

The Develop hub is where you manage SQL scripts, Synapse notebooks, and data flows. Access a gallery of Database templates, sample datasets, Notebooks, SQL Scripts and Pipelines to get started quickly. Get to the hub by selecting the **Analyze** icon on the home page or select **Develop** from the left navigation pane.

In this module's scenario, you use the Develop hub to move and analyze your data with SQL scripts for pipelines and machine learning.

### Integrate

The Integrate hub helps you manage data integration pipelines. If you're familiar with Azure Data Factory, then you feel at home, because the pipeline creation experience is the same as in Azure Data Factory. This hub eliminates the need to use Azure Data Factory separately for data movement and transformation pipelines.

In this module's scenario, you use the Integrate hub to build a pipeline to bring in the data with linked services and transform it for analysis.

### Monitor

Use the Monitor hub to view pipeline and trigger runs and view the status of your integration runtimes. You can also view Apache Spark jobs, SQL requests, and data flow debug activities. If you want to see the status of a job or activity, the Monitor hub is the place.

You don't need the Monitor hub for this module's scenario, but it can be used at any time to view job status, debug, or troubleshoot issues.

### Manage

The Manage hub enables you to perform some of the same actions as in the Azure portal, such as managing SQL and Spark pools. Use the Manage hub to manage linked services and integration runtimes or create pipeline triggers.

In this module's scenario, you use the Manage hub to set up linked services that help you access the SAP and Cosmos DB data, then bring the data into a SQL pool for analytics.

### Visualize

The Visualize hub enables you to link a Power BI workspace directly into the Synapse Studio. Open or create reports that can be shared with others.

In this module's scenario, you use the Visualize hub with Power BI to visualize data in the SQL pool.

## Summary

Azure Synapse Studio includes functional areas organized into hubs. Using the Manage hub, you can connect to the systems that contain your SAP and other data.
