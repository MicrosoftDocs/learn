Azure Data Factory can accommodate organizations that are embarking on data integration projects from the differing starting point. It's rare for a data migration project to be a green field project. Typically, many data integration workflows must consider existing pipelines that have been created on previous projects, with different dependencies and using different technologies. To that end, there are various ingestion methods that can be used to extract data from a variety of sources. 

## Ingesting data using the Copy Activity
Use this method to build code-free data ingestion pipelines that don’t require any transformation during the extraction of the data. The Copy Activity has support for over 100 native connectors. This method can suit green field projects that have a simple method of extraction to an intermediary data store. An example of ingesting data using the Copy Activity can include extracting data from multiple source database systems and outputting the data to files in a data lake store. The benefit of this ingestion method is that they're simple to create, but they aren't able to deal with sophisticated transformations or business logic.

## Ingesting data using compute resources
Azure Data Factory can call on compute resources to process data by a data platform service that may be better suited to the job. A great example of this is that Azure Data Factory can create a pipeline to a compute platform such as an Azure Databricks cluster to perform a complex calculation, which generates new data. This data is then ingested back into the pipeline for further downstream processing. The table below outlines various computing resources and their associated capabilities:

| Compute environment                                       | activities                                    |
| --------------------------------------------------------- | --------------------------------------------- |
| On-demand HDInsight cluster or your own HDInsight cluster | Hive, Pig, Spark, MapReduce, Hadoop Streaming |
| Azure Batch                                               | Custom activities                             |
| Azure Machine Learning                                    | Azure Machine Learning Execute Pipeline       |
| Azure SQL, Azure Synapse Analytics, SQL Server            | Stored Procedure                              |
| Azure Databricks                                          | Notebook, Jar, Python                         |
| Azure Function                                            | Azure Function activity                       |

## Ingesting data using SSIS packages
Many organizations have decades of development investment in SQL Server Integration Services (SSIS) packages that contain both ingestion and transformation logic from on-premises and cloud data stores. Azure Data Factory provides the ability to lift and shift existing SSIS workload, by creating an Azure-SSIS Integration Runtime to natively execute SSIS packages, and will enable you to deploy and manage your existing SSIS packages with little to no change using familiar tools such as SQL Server Data Tools (SSDT) and SQL Server Management Studio (SSMS), just like using SSIS on-premises.
