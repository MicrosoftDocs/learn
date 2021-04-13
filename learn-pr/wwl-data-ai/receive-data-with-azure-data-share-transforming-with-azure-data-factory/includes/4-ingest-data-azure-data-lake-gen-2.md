In order to start creating a pipeline, we first need to set up linked services in Azure Data Factory. Linked services define the connection information for data factory to the external resources you want to connect with, for example an Azure SQL Database or Azure Data Lake Storage. 

The connection to the data source and dataset that is linked to that linked service, represents the data structure. For example, an Azure Data Lake Storage linked service will specify the connection string to the Azure Data Lake Storage account. 

The connection string can be passed through to Azure Data Factory by creating a linked service.

The purpose of linked services, is to represent and show data store as well as compute resources that need to be hosted for the execution of a pipeline or activity.  

Using the code-free User Experience of Azure Data Factory from the Azure portal makes it easy for the non-coder to develop linked services. 

Currently, Azure Data Factory supports over 85 of these connectors in which we are going to use 3. 

In order to ingest data from a resource, you can use an Azure Data Factory pipeline with a copy activity that can ingest, for example one table from the Azure SQL DB into an ADLS Gen 2 storage account. It is imperative to understand that you add pipelines in Azure Data Factory, configure the dataset, and debug the pipeline in ADF. 

A pipeline in Azure Data Factory is a logical grouping of activities such as copy in order to perform a task. The activity defines the operation that you’re performing on the data (therefore, a copy means copying the same data to another data store). 

The dataset that you’re using is pointing to the data that you’re going to use from the linked service. 

Therefore, if you have linked a SQL DB, which contains a database, which contains tables, you can select the table that you want to copy.

In doing so, the data from that table will be copied to an Azure Data Lake storage Account. 

