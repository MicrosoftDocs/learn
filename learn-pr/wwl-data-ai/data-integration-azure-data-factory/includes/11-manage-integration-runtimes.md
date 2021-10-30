In Azure Data Factory (ADF), an activity defines the action to be performed. A linked service defines a target data store or a compute service. An integration runtime provides the infrastructure for the activity and linked services. 

Integration Runtime (IR) is referenced by the linked service or activity to determine the compute environment for the activity, where it either runs or is dispatched from. An integration runtime ensures the runtime environment is in the most performant region nearest the target data store or compute service, meeting both security and compliance needs. 

In short, the IR is the compute infrastructure used by ADF. IR provides data integration capabilities across different network environments, including:

- **Data Flow**: Run a Data Flow in a managed Azure compute environment.
- **Data movement**: Copy data across data stores in a public network and data stores in a private network (on-premises or virtual private network). Data movement provides support for built-in connectors, format conversion, column mapping, and performant and scalable data transfer.
- **Activity dispatch**: Dispatch and monitor transformation activities running on a variety of compute services such as Azure Databricks, Azure HDInsight, Azure Machine Learning, Azure SQL Database, SQL Server, and more.
- **SSIS package execution**: Natively execute SQL Server Integration Services (SSIS) packages in a managed Azure compute environment.

Whenever an ADF instance is created, a default IR environment is created to support operations on cloud data stores and compute services in a public network. This can be viewed when the IR is set to Auto-Resolve.

## Integration Runtime types

ADF offers three types of IR:

- Azure
- Self-hosted
- Azure-SSIS

You should choose the type that best serves your data integration capabilities and network environment needs. You can explicitly define the IR type in the **connectVia** property. If this property is not defined, then the default IR is used, with the property set to Auto-Resolve.  

The capabilities and network support for each of the IR types are summarized as:

| **IR type** | **Public network** | **Private network** |
|-|-|-|
| Azure | Data Flow, Data movement, Activity dispatch | -- |
| Self-hosted | Data movement, Activity dispatch | Data movement, Activity dispatch |
| Azure-SSIS | SSIS package execution | SSIS package execution |

## Determining which Azure IR to use

A range of factors affect which IR that you will use. Use the following sections as a guide to help you select the right IR.

### Copy activity

Copy activity requires source and sink linked services to define the direction of data flow. The following logic is used to determine which IR instance is used to perform the copy:

- **Copying between two cloud data sources:** when both source and sink linked services are using Azure IR, ADF uses the regional Azure IR, if specified, or auto-determines the location of Azure IR if you chose the auto-resolve IR (default).

- **Copying between a cloud data source and a data source in private network:** if either source or sink linked service points to a self-hosted IR, the copy activity is run on that self-hosted IR. If both source and sink linked service point to a self-hosted IR, it must be the same IR.

- **Copying between two data sources in private network:** both the source and sink inked service must point to the same IR instance, and that IR is used to run the copy activity.

### Lookup and GetMetadata activity

Lookup and GetMetadata activity runs on the IR associated with the data store linked service.

### Transformation activity

Each transformation activity has a target compute Linked Service that points to an integration runtime. Transformation activity is dispatched from this IR instance.

### Data Flow activity

Data Flow activity is run on the IR associated with it.
