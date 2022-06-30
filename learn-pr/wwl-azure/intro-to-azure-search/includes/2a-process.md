![Infographic of indexing process.](../media/data-indexing-process.png)

A typical Azure Cognitive Search solution starts with a data source that contains the data artifacts you want to search. This could be a hierarchy of folders and files in Azure Storage, or data in a database such as Azure SQL Database or Azure Cosmos DB.

After extracting the basic data and metadata fields from the source, you can define a skillset that applies a sequence of AI skills to enrich the data. A comprehensive set of built-in skills is available, that use Azure Cognitive Services to derive new fields – for example by identifying entities in text, evaluating sentiment, or predicting appropriate captions for images.

An indexer is used to run the process of extracting the source data and applying the AI skills to iteratively build a hierarchical JSON structure of fields for each document.

The fields extracted by the indexer are persisted in an index, which can be searched by client applications. The fields are used for searching, filtering, and sorting to generate a set of results that can be displayed or otherwise used by the client application.

Optionally, you can also create a knowledge store, which stores output from an AI enrichment pipeline in tables and blobs in Azure Storage for independent analysis or downstream processing.