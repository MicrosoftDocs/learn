The first step to creating an Azure AI Search solution is to provision an Azure AI Search resource. Once the Azure AI Search resource is created, you can manage components of your service from the resource *Overview* page in the portal. 

![Image of the overview page of an Azure AI Search resource.](../media/azure-search-portal.png) 

Before you begin, identify your **data source**. You may also create an *Azure Storage* object to contain your original data. 

You can use one of several methods to create your search solution: 

- Azure portal's Import data wizard 
- with the REST API
- with a software development kit (SDK)

We will focus on the method using the portal below.

### Using the Azure portal's Import data wizard

Contained within the Azure AI Search service in Azure portal is the Import data wizard, which automates processes in the Azure portal to create various objects needed for the search engine. 

A unique aspect of working with the Azure portal's Import data wizard is that it defines the search index and runs the indexer. You can see it in action when creating any of the following objects using the Azure portal:

- **Data Source**: Persists connection information to source data, including credentials. A data source object is used exclusively with indexers.
- **Index**: Physical data structure used for full text search and other queries.
- **Indexer**: A configuration object specifying a data source, target index, an optional AI skillset, optional schedule, and optional configuration settings for error handling and base-64 encoding.
- **Skillset**: A complete set of instructions for manipulating, transforming, and shaping content, including analyzing and extracting information from image files. Except for very simple and limited structures, it includes a reference to an Azure AI services resource that provides enrichment.
- **Knowledge store**: Stores output from an AI enrichment pipeline in tables and blobs in Azure Storage for independent analysis or downstream processing.
