::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=34b7bae6-a431-42e3-b584-ff7814c2c6fe]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Microsoft Azure is a cloud platform for applications and IT infrastructure. It includes many services to support cloud solutions, including transactional and analytical data workloads.

Some of the most commonly used cloud services for data are described below.

> [!NOTE]
> This article covers only some of the most commonly used data services for modern transactional and analytical solutions. Additional services are also available. As a beginner, you don't need to memorize every service—the goal is to gain awareness of the types of tools available and the roles that use them.
>
> Throughout this unit, you encounter the terms **PaaS** (platform-as-a-service) and **SaaS** (software-as-a-service). These are cloud delivery models: **PaaS** means Microsoft manages the underlying infrastructure (servers, patching, backups) so you focus on your data and applications. **SaaS** means the entire product is delivered as a ready-to-use service over the internet—no installation or infrastructure management required.

## Azure SQL

![Logo for Azure SQL and its family of relational database services.](../media/azure-sql.png) *Azure SQL* is the collective name for a family of relational database solutions based on the Microsoft SQL Server database engine. Specific Azure SQL services include:

- **Azure SQL Database** – a fully managed platform-as-a-service (PaaS) database hosted in Azure.
- **Azure SQL Managed Instance** – a hosted instance of SQL Server with automated maintenance, which allows more flexible configuration than Azure SQL DB but with more administrative responsibility for the owner.
- **Azure SQL VM** – a virtual machine with an installation of SQL Server, allowing maximum configurability with full management responsibility.

Database administrators typically provision and manage Azure SQL database systems to support line of business (LOB) applications that need to store transactional data.

Data engineers may use Azure SQL database systems as sources for data pipelines that perform *extract*, *transform*, and *load* (ETL) operations to ingest the transactional data into an analytical system.

Data analysts may query Azure SQL databases directly to create reports, though in large organizations the data is generally combined with data from other sources in an analytical data store to support enterprise analytics.

Microsoft Copilot in Azure can help database administrators and developers generate T-SQL queries and troubleshoot Azure SQL Database using natural language.

## Open-source databases in Azure

![Logos for Azure Database for MySQL and Azure Database for PostgreSQL.](../media/azure-database.png) Azure includes managed services for popular open-source relational database systems, including:

- **Azure Database for MySQL** - a simple-to-use open-source database management system that is commonly used in *Linux*, *Apache*, *MySQL*, and *PHP* (LAMP) stack apps.
- **Azure Database for PostgreSQL** - a hybrid relational-object database. You can store data in relational tables, but a PostgreSQL database also enables you to store custom data types, with their own nonrelational properties.

As with Azure SQL database systems, open-source relational databases are managed by database administrators to support transactional applications, and provide a data source for data engineers building pipelines for analytical solutions and data analysts creating reports.

## Azure Cosmos DB

![Logo for Azure Cosmos DB and its globally distributed NoSQL database service.](../media/cosmos-db.png) Azure Cosmos DB is a global-scale nonrelational (*NoSQL*) database system that supports multiple application programming interfaces (APIs), enabling you to store and manage data as JSON documents, key-value pairs, column-families, and graphs.

In some organizations, Cosmos DB instances may be provisioned and managed by a database administrator; though often software developers manage NoSQL data storage as part of the overall application architecture. Data engineers often need to integrate Cosmos DB data sources into enterprise analytical solutions that support modeling and reporting by data analysts.

The Azure Cosmos DB extension for Visual Studio Code includes an AI-assisted query advisor (preview) that developers can use to generate and explain queries using natural language.

## Azure Storage

![Logo for Azure Storage and its cloud storage services.](../media/azure-storage.png) Azure Storage is a core Azure service that enables you to store data in:
 - **Blob containers** - scalable, cost-effective storage for binary files.
 - **File shares** - network file shares such as you typically find in corporate networks.
 - **Tables** - key-value storage for applications that need to read and write data values quickly.

 Data engineers use Azure Storage to host *data lakes* - blob storage with a hierarchical namespace that enables files to be organized in folders in a distributed file system.

## Azure Data Factory

![Logo for Azure Data Factory and its data integration service.](../media/azure-data-factory.png) Azure Data Factory is an Azure service that enables you to define and schedule data pipelines to transfer and transform data. You can integrate your pipelines with other Azure services, enabling you to ingest data from cloud data stores, process the data using cloud-based compute, and persist the results in another data store.

Azure Data Factory is used by data engineers to build *extract*, *transform*, and *load* (ETL) solutions that populate analytical data stores with data from transactional systems across the organization. Data Factory is also built into **Microsoft Fabric** as **Fabric Data Factory**, the next generation of Azure Data Factory. Fabric Data Factory pipelines work directly with OneLake and other Fabric items.

## Microsoft Fabric
![Logo for Microsoft Fabric and its unified analytics platform.](../media/microsoft-fabric.png) Microsoft Fabric is Microsoft's unified software-as-a-service (SaaS) analytics platform. It brings data engineering, data warehousing, real-time analytics, data science, and Power BI together in a single browser-based workspace on top of one shared storage layer called **OneLake**. You don't manage servers or clusters—you create workspaces and items, and Microsoft runs the infrastructure.

Within Microsoft Fabric, data professionals work with integrated capabilities including:

- Data ingestion and ETL with **Fabric Data Factory**
- Data lakehouse analytics with **Fabric Lakehouse**
- Data warehouse analytics with **Fabric Warehouse**
- Data science and machine learning
- Real-Time Intelligence for streaming data
- Data visualization with **Power BI**
- Databases (SQL database and Cosmos DB in Fabric)
- Data governance and management

Data engineers can use Microsoft Fabric to create a unified data analytics solution that combines data ingestion pipelines, data warehouses, real-time analytics, business intelligence, and AI-powered insights—all centrally stored in OneLake.

Microsoft Fabric includes Copilot features that data professionals can use to build pipelines, write SQL, generate notebook code, and explore data using natural language.

## Microsoft Fabric IQ

![Logo for Microsoft Fabric representing the Fabric IQ workload.](../media/microsoft-fabric.png) Fabric IQ provides context on business entities and data. The IQ workload in Microsoft Fabric builds on OneLake and Power BI semantic models so that people, tools, and AI agents share the same definitions for concepts like *Customer*, *Order*, or *Product*.

> [!NOTE]
> The IQ workload and its ontology item are in preview.

## Power BI

![Logo for Power BI and its business intelligence platform.](../media/power-bi.png)Power BI is Microsoft's business intelligence and data visualization platform. Data analysts use Power BI to connect to data sources, build interactive reports and dashboards, and share insights across their organization.

Power BI is available as a standalone service and is also built into Microsoft Fabric, where it works alongside data engineering and warehouse capabilities in the same workspace. In Fabric, Power BI connects to data through **semantic models**—structured analytical layers that define measures, relationships, and business logic.

Power BI includes built-in AI features that data analysts can use to summarize reports, suggest visualizations, generate DAX measures, and create written narratives from data using natural language.

## Azure Databricks

![Logo for Azure Databricks and its Apache Spark analytics platform.](../media/azure-databricks.png) Azure Databricks is a cloud analytics platform built on Apache Spark. It's optimized for large-scale data engineering, data science, and SQL analytics over open lakehouse formats—primarily **Delta Lake**. It's a managed service in Azure and is a common choice for teams that need code-first Spark and notebook-based workflows.

Data engineers can use existing Databricks and Spark skills to create analytical data stores in Azure Databricks.

Data analysts can use the native notebook support in Azure Databricks to query and visualize data in an easy-to-use web-based interface.

Azure Databricks includes built-in AI features that data engineers and analysts can use to write Spark code, generate SQL queries, and explain complex notebook logic using natural language.

## Azure Stream Analytics

![Logo for Azure Stream Analytics and its stream processing service.](../media/stream-analytics.png) Azure Stream Analytics is a real-time stream processing engine that captures a stream of data from an input, applies a query to extract and manipulate data from the input stream, and writes the results to an output for analysis or further processing.

Data engineers can incorporate Azure Stream Analytics into data analytics architectures that capture streaming data for ingestion into an analytical data store or for real-time visualization.

## Azure Data Explorer

![Logo for Azure Data Explorer and its data analytics platform.](../media/azure-data-explorer.png) Azure Data Explorer is a fully managed, standalone, big data analytics platform that offers high-performance querying of log and telemetry data.

Data analysts can use Azure Data Explorer to query and analyze data that includes a timestamp attribute, such as is typically found in log files and *Internet-of-things* (IoT) telemetry data.

## Microsoft Purview

![Logo for Microsoft Purview and its data governance solution.](../media/azure-purview.png) Microsoft Purview provides a solution for enterprise-wide data governance and discoverability. You can use Microsoft Purview to create a map of your data and track data lineage across multiple data sources and systems, enabling you to find trustworthy data for analysis and reporting.

Data engineers can use Microsoft Purview to enforce data governance across the enterprise and ensure the integrity of data used to support analytical workloads.

## Microsoft Foundry

![Logo for Microsoft Foundry and its enterprise AI platform.](../media/microsoft-foundry.png) Microsoft Foundry is Microsoft's unified Azure platform-as-a-service (PaaS) for enterprise AI operations, model builders, and application development. It provides the tools, model access, and infrastructure that AI engineers—and developers more broadly—use to design, test, and deploy intelligent solutions, including chat-over-your-data applications, multi-agent workflows, and automated AI pipelines integrated with Azure data services.

::: zone-end
