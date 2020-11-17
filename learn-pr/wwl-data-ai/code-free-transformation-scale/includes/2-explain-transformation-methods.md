Just as Azure Data Factory provides a variety of methods for ingesting data, it also provides a range of methods to perform transformations. You can pick a method that matches the skillsets of your team or takes advantage of existing technologies that you already have in your data estate. There is also the opportunity to perform transformations without writing code at all using the Mapping Data Flow.

> [!VIDEO https://channel9.msdn.com/Shows/Learn-Azure/ADF-Transformation-Methods/player?format=ny]

## Transforming data using Mapping Data Flow

Mapping Data Flows provide an environment for building a wide range of data transformations visually without the need to use code. The resulting data flows that are created are subsequently executed on scaled-out Apache Spark clusters that are automatically provisioned when you execute the Mapping Data Flow. Mapping Data Flows also provides the capability to monitor the execution of the transformations so that you can view how the transformations are progressing, or to understand any errors that may occur

## Transforming data using compute resources

Azure Data Factory can also call on compute resources to transform data by a data platform service that may be better suited to the job. A great example of this is that Azure Data Factory can create a pipeline to an analytical data platform such as Spark pools in an Azure Synapse Analytics instance to perform a complex calculation using python. Another example could be to send data to an Azure SQL Database instance to execute a stored procedure using Transact-SQL. There is a wide range of compute resource, and the associated activities that they can perform as shown in the following table:

| Compute environment | activities |
| - | - |
| On-demand HDInsight cluster or your own HDInsight cluster | Hive, Pig, Spark, MapReduce, Hadoop Streaming |
| Azure Batch|  Custom activities |
| Azure Machine Learning Studio Machine | Learning activities: Batch Execution and Update Resource |
| Azure Machine Learning | Azure Machine Learning Execute Pipeline |
| Azure Machine Learning | Azure Machine Learning Execute Pipeline |
| Azure Data Lake Analytics | Data Lake Analytics U-SQL |
| Azure SQL, Azure SQL Data Warehouse, SQL Server | Stored Procedure |
| Azure Databricks | Notebook, Jar, Python |
| Azure Function | Azure Function activity |

## Transforming data using  SQL Server Integration Services (SSIS) packages

Many organizations have decades of development investment in SSIS packages that contain both ingestion and transformation logic from on-premises and cloud data stores. Azure Data Factory provides the ability to lift and shift existing SSIS workload, by creating an Azure-SSIS Integration Runtime to natively execute SSIS packages. Using Azure-SSIS Integration Runtime will enable you to deploy and manage your existing SSIS packages with little to no change using familiar tools such as SQL Server Data Tools (SSDT) and SQL Server Management Studio (SSMS), just like using SSIS on premises.


