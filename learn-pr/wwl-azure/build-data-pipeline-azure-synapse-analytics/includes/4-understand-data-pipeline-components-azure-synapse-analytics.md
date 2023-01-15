
### Top-level concepts

An Azure subscription might have one or more Azure Data Factory instances (or data factories). Azure Data Factory is composed of below key components.

In Azure Data Factory, data movement refers to the process of moving data from one location to another, and it is a key component of data integration. There are several concepts that are important to understand when working with data movement in Azure Data Factory:

1. **Data Movement Activities**: These are the building blocks of data pipelines in Azure Data Factory. Data movement activities are used to extract data from various sources, transform data, and load data into various destinations. Some examples of data movement activities include: 
   
- Copy activity: This activity is used to copy data from one location to another.
- HDInsightHive activity: This activity is used to run Hive queries on HDInsight clusters.
- Lookup activity: This activity is used to look up data in a specified dataset.
- Web activity: This activity is used to make HTTP requests to external web services.

1. **Data Flows**: Data flows are a new feature in Azure Data Factory that allows data engineers to create and manage data transformation tasks using a visual, code-free interface. Data flows are built using a set of pre-built transformations and can be used to perform complex data transformation tasks such as filtering, pivoting, and aggregating data.

2. **Data Integration Runtime**: The Data Integration Runtime (IR) is a component of Azure Data Factory that is responsible for executing data movement activities and data flows. There are two types of IR:

- Azure-SSIS IR: This is a fully-managed cloud-based version of the SQL Server Integration Services (SSIS) runtime that allows data engineers to execute SSIS packages in the cloud.
- Self-hosted IR: This is an on-premises version of the IR that allows data engineers to execute data movement activities and data flows on an on-premises machine.

1. **Connections**: Connections are used to connect to various data sources and destinations in Azure Data Factory. Connection strings are used to authenticate with these data sources and destinations.

2. **Data Stitching**: Data stitching is a new feature in Azure Data Factory that allows data engineers to create, schedule, and manage data pipelines that move data between different regions, accounts, and subscriptions. This enables organizations to move data across different environments and geographies, enabling them to perform analytics and reporting on a global scale.

3. **Data Integration Patterns**: Azure Data Factory supports several data integration patterns, such as:

- Simple data movement: This pattern is used to move data from one location to another with minimal transformation.
- ELT (Extract, Load, Transform): This pattern is used to move data from various sources into a central location and perform data transformation tasks in the destination.
- ELT with Staging: This pattern is used to move data from various sources into a staging area, perform data transformation tasks in the staging area, and then move the transformed data to a final destination.

1. **Data Management**: Azure Data Factory provides several features to help manage data, such as data lineage, data catalog, data audit, and data compliance. Data lineage helps to track the flow of data from source to destination, data catalog helps to discover, understand and govern data and data audit and compliance helps to meet regulatory and compliance requirements.

By understanding these concepts, data engineers can effectively use Azure Data Factory to move data between different locations and perform complex data transformation tasks.


![Code free ETL swim lanes overview.](../media/4-code-free-etl-swimlanes.png)
### Pipeline

Azure Synapse Pipelines and data factory pipeline are a logical grouping of activities that together perform a specific task in Synapse Pipelines or Azure Data Factory. Pipelines are used to move data from various sources to various destinations and perform data transformation tasks. Pipelines are the building blocks of data integration in Azure Data Factory and are used to create, schedule, and manage data movement and data transformation tasks.

A pipeline is composed of one or more activities, which are the building blocks of data integration. Each activity performs a specific task, such as copying data, running a Hive query, or performing a data transformation. Pipelines can be triggered on a schedule, on demand, or by an event.

Data engineers can use the visual interface to create, schedule and manage data pipelines, or use the Synapse Pipeline and Azure Data Factory SDKs to create, schedule and manage pipelines programmatically.

Pipelines are used to automate data movement and data transformation tasks, which is critical for data integration. Data engineers can use pipelines to create a series of activities that move data from various sources to various destinations, and perform data transformation tasks, such as filtering, pivoting, and aggregating data. Pipelines are also used to schedule and automate data pipelines, which enables organizations to perform data integration tasks on a regular schedule.

### Mapping data flows

Azure Synapse Mapping Data Flows are a feature of Azure Synapse Analytics (formerly known as Azure Data Factory) that allow data engineers to create and manage data transformation tasks using a visual, code-free interface. Mapping Data Flows are built using a set of pre-built transformations and can be used to perform complex data transformation tasks such as filtering, pivoting, and aggregating data, with a focus on big data transformation.

Mapping Data Flows allow data engineers to visually create, test and debug data transformation tasks, and then publish them as executable data flows. Data engineers can also use code to create custom data flows using various languages such as C#, Python, and SQL.

Mapping Data Flows use a feature called "schema-on-read" which allows data engineers to define the schema of the data after it is read, this allows data engineers to process data in a more flexible way, and also allows them to handle semi-structured and unstructured data.

Mapping Data Flows are built on top of the Apache Spark engine, which allows for big data processing and analytics, and can handle large volumes of data and perform complex data transformations in a distributed and parallel way, this makes it suitable for big data scenarios.

Azure Synapse Mapping Data Flows also enables data engineers to easily integrate with other Azure services such as Azure Machine Learning, Azure Stream Analytics, and Power BI, making it a powerful tool for big data integration and analytics in the Azure ecosystem.


### Activity

An Azure Synapse Pipeline activity is a building block of a pipeline in Azure Synapse Analytics. It represents a specific task that is executed as part of a pipeline. Activities are linked together in a pipeline to create a series of tasks that move data from various sources to various destinations and perform data transformation tasks.

There are several types of activities available in Azure Synapse Analytics such as:

1. **Data Movement Activities**: These activities are used to move data from various sources to various destinations. Examples of data movement activities include:

- Copy activity: This activity is used to copy data from one location to another.
- HDInsightHive activity: This activity is used to run Hive queries on HDInsight clusters.
- Web activity: This activity is used to make HTTP requests to external web services.

1. **Data Transformation Activities**: These activities are used to perform data transformation tasks such as filtering, pivoting, and aggregating data. Examples of data transformation activities include:

- Lookup activity: This activity is used to look up data in a specified dataset.
- Mapping data flow activity: This activity is used to perform data transformation tasks using a visual, code-free interface.
- Execute SSIS package activity: This activity is used to execute SQL Server Integration Services (SSIS) packages.

1. **Control Flow Activities**: These activities are used to control the flow of execution within a pipeline. Examples of control flow activities include:

- ForEach activity: This activity is used to iterate through a collection of items.
- If-else activity: This activity is used to branch the pipeline execution based on a condition.

1. **Data Management Activities**: These activities are used to manage data such as data lineage, data catalog, data audit, and data compliance. Examples of data management activities include:

- Dataflow activity: This activity is used to create, schedule, and manage dataflow, which helps to track the flow of data from source to destination.
- Data management activity: This activity is used to discover, understand and govern data and data audit and compliance helps to meet regulatory and compliance requirements.

### Datasets

Azure Synapse Pipeline and Azure Data Factory datasets are used to represent the data that is used as input or output in an Azure Synapse Analytics (formerly known as Azure Data Factory) pipeline. 

**Azure Synapse Pipeline and Azure Data Factory Datasets** are used to represent the data that is used as input or output in an Azure Synapse Pipeline. They define the structure of the data and the location of the data. Azure Synapse Pipeline Datasets can be used to represent data stored in various sources such as Azure Blob storage, Azure Data Lake Storage, Azure SQL Database, and more.

Both Azure Synapse Pipeline and Azure Data Factory datasets are used by activities in a pipeline to determine the data that will be used as input or output. Data engineers can use the Azure Data Factory visual interface or the Azure Data Factory SDKs to create, schedule, and manage datasets programmatically.

Datasets are used to automate data movement and data transformation tasks, which is critical for data integration. Data engineers can use datasets to create a series of activities that move data from various sources to various destinations, and perform data transformation tasks, such as filtering, pivoting, and aggregating data. Datasets are also used to schedule and automate data pipelines, which enables organizations to perform data integration tasks on a regular schedule.

### Linked services

Azure Synapse Pipeline Linked Services are used in Azure Synapse Analytics to connect to different types of data stores or services. A linked service defines the connection information required for a pipeline to connect to a specific data store or service. 

Linked services are used by activities in a pipeline to determine the data that will be used as input or output. Data engineers can use the Azure Data Factory visual interface or the Azure Data Factory SDKs to create, schedule, and manage linked services programmatically.

There are several types of linked services available in Azure Synapse Analytics such as:

1. **Azure Blob Storage linked service**: This linked service is used to connect to an Azure Blob storage account.

2. **Azure Data Lake Storage linked service**: This linked service is used to connect to an Azure Data Lake Storage account.

3. **Azure SQL Database linked service**: This linked service is used to connect to an Azure SQL Database.

4. **Azure Cosmos DB linked service**: This linked service is used to connect to an Azure Cosmos DB account.

5. **Azure Event Hubs linked service**: This linked service is used to connect to an Azure Event Hubs namespace.

6. **Azure Data Factory linked service**: This linked service is used to connect to an Azure Data Factory.

7. **Power BI linked service**: This linked service is used to connect to Power BI for data visualization.

Linked services are used to automate data movement and data transformation tasks, which is critical for data integration. Data engineers can use linked services to create a series of activities that move data from various sources to various destinations, and perform data transformation tasks, such as filtering, pivoting, and aggregating data. Linked services are also used to schedule and automate data pipelines, which enables organizations to perform data integration tasks on a regular schedule.


### Triggers

Triggers represent the unit of processing that determines when a pipeline execution needs to be kicked off. There are different types of triggers for different types of events.

### Pipeline runs

A pipeline run is an instance of the pipeline execution. Pipeline runs are typically instantiated by passing the arguments to the parameters that are defined in pipelines. The arguments can be passed manually or within the trigger definition.

### Parameters

Parameters are key-value pairs of read-only configuration.  Parameters are defined in the pipeline. The arguments for the defined parameters are passed during execution from the run context that was created by a trigger or a pipeline that was executed manually. Activities within the pipeline consume the parameter values.

A dataset is a strongly typed parameter and a reusable and referenceable entity. An activity can reference datasets and can consume the properties that are defined in the dataset definition.

A linked service is also a strongly typed parameter that contains the connection information to either a data store or a compute environment. It is also a reusable and referenceable entity.

### Control flow

Control flow is an orchestration of pipeline activities that includes chaining activities in a sequence, branching, defining parameters at the pipeline level, and passing arguments while invoking the pipeline on-demand or from a trigger. It also includes custom-state passing and looping containers, that is, For-each iterators.

### Variables
Variables can be used inside of pipelines to store temporary values and can also be used in conjunction with parameters to enable passing values between pipelines, data flows, and other activities.