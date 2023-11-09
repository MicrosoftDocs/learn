Before using an indexer to create an index, you'll first need to make your data available in a supported data source. Supported data sources include:

- Cosmos DB (SQL API)
- Azure SQL (database, managed instance, and SQL Server on an Azure VM)
- Azure Storage (Blob Storage, Table Storage, ADLS Gen2)

### Using the Azure portal's Import data wizard

Once your data is in an Azure data source, you can begin using Azure Cognitive Search. Contained within the Azure Cognitive Search service in Azure portal is the Import data wizard, which automates processes in the Azure portal to create various objects needed for the search engine. You can see it in action when creating any of the following objects using the Azure portal:

- **Data Source**: Persists connection information to source data, including credentials. A data source object is used exclusively with indexers.
- **Index**: Physical data structure used for full text search and other queries.
- **Indexer**: A configuration object specifying a data source, target index, an optional AI skillset, optional schedule, and optional configuration settings for error handling and base-64 encoding.
- **Skillset**: A complete set of instructions for manipulating, transforming, and shaping content, including analyzing and extracting information from image files. Except for very simple and limited structures, it includes a reference to an Azure AI services resource that provides enrichment.
- **Knowledge store**: Stores output from an AI enrichment pipeline in tables and blobs in Azure Storage for independent analysis or downstream processing.

To use Azure Cognitive Search, you'll need an Azure Cognitive Search resource. You can create a resource in the Azure portal. Once the resource is created, you can manage components of your service from the resource *Overview* page in the portal. 

![Image of the overview page of an Azure Cognitive Search resource.](../media/azure-search-portal.png) 

You can build Azure search indexes using the Azure portal or programmatically with the REST API or software development kits (SDKs). 



