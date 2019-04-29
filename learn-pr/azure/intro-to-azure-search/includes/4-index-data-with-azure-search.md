As part of the drive to establishing your organization's online presence you need to implement Azure Search to enable rich search for the online video catalog. You have been tasked with loading data into an existing Azure Search instance so the catalog can be searched by title, difficulty, length, and publication date.

Now that the Azure Search service has been created, you'll look at how to load data into an index in Azure Search.

## Loading data into Azure Search

Azure Search lets you create empty indexes, in order for indexes to be queried data must be loaded. These queries run over the content loaded and saved to an index. There are two approaches for loading data into an index:

- **Programmatically**: This is known as pushing data into the index. A JSON data set is pushed to the Azure Search Index via either the REST API or the .Net SDK. This method is not supported by the portal but does have the most flexibility by offering no restriction on the data source type, or frequency of execution.

- **Use Azure Search indexer**: This is known as pulling data into the index. The Azure Search indexer crawls a supported data source and automatically loads data into the index via the use of an indexer. The indexer maps source fields to equivalent fields in the index and during execution data is transformed in JSON format.

## Methods for importing data to Azure Search

There are three methods to importing data into Azure Search, the indexer functionality embedded in the service is made available through the portal, the Azure Search Rest API and the .NET SDK.

**Azure portal**
Contained within the Azure Search Service dashboard in the Azure portal is an Import data wizard. The wizard imports data into the index by connecting to an external data source in the same subscription. The wizard crawls the data source for content and converts into JSON documents as part of the import to the index.

**Pushing data via the REST API or .NET SDK**
Data can be pushed to Azure Search via an API, this can be used to either load documents to an index individually or in batches. There is no option to push data in the portal. The APIs are:

- **REST API**: Add, Update, or Delete Documents
- **.NET SDK**: indexAction class or indexBatch class

## Data Source Inputs

Data sources used via the import data wizard in Azure search create a persistent data source connection to the external source. The supported data sources for the data source object are Azure SQL, Azure Cosmos DB, Azure Blob Storage, and Azure Table Storage (cognitive search pipelines aren't supported). The data sets must be flattened and only a single object (table, view, or data structure) can be imported at any one time.

## Index attributes

When using the Import data wizard in Azure Search as index is generated loaded with documents from the data source. These documents have attributes associated to them determining how the documents are returned in a query result set. These elements must be defined as if no attributes are set it's essentially like your index is empty.

The key attributes for the index are:

- **Key**: The unique id for each document. Must be a string and gets used for document lookup.
- **Retrievable**: Sets whether the field can be returned in a search result.
- **Filterable**: Sets whether the field can be used to filter queries.
- **Sortable**: Sets whether the field can be used to sort search results.
- **Facetable**: Sets whether the field can be used in a faceted navigation structure as part of user directed filtering.
- **Searchable**: Sets whether the field is full-text searchable.

## Data import monitoring and verification

When the data import wizard is pulling data into Azure Search the indexing progress can be monitored by clicking on the associated indexer in the indexers list. The document count will grow as documents are loaded to the index. In some instances, the portal page can take a few minutes to display up-to-date document counts. Once the index is ready for querying you can then use Search Explorer to verify the results. An index is ready when the first document is successfully loaded into it.

Search Explorer is available in the Azure portal and allows you to submit either simple or full Lucene queries to an index in your Azure Search service. The results are returned as JSON documents so its content and construction can be viewed in full. Query expressions can be used to limit which fields are returned. Filter expressions use the OData syntax.

## Azure Search Index Maintenance

In the Azure Search service are Usage and Monitoring sections that give you the option to view data about query metrics, resource usage, and quota availability. Log Analytics can also be configured to add additional reporting capabilities to your Search instance. These reports are useful to monitor search workloads to determine the correct service tier or if any replication or partitioning of the indexes is required.

## Rebuilding indexes

When using Azure Search, there will be instances that will require you to rebuild indexes. This is will be the case when developing an index. Rebuilding an index is the process to drop and recreate the physical data structure associated with the index. When an index is rebuilt all the stored fields are deleted and subsequently recreated based upon either the existing schema or a revised one. The index is then repopulated with data, which is either pushed to the index, or pulled from the supported external data source.

There are several conditions that will require an index to be rebuilt:

- A field definition is changed
- An analyzer is assigned to a field
- An analyzer definition is updated or deleted
- A field is added to a suggester
- A field is deleted
- The Azure search service service tier is changed.

Data refresh for an index runs as a background task, this allows you to add, delete, or update documents in the index with minimal disruption to queries. Although, as is the case for relational database table index, queries may take longer to complete. There are certain modifications that can be made to an index that do not result in an index rebuild:

- A new field is added to the index
- An existing field has the retrievable attribute set
- An existing field has the search analyzer set
- An index has a new analyzer definition set
- Scoring profiles have been added, updated, or deleted
- CORS settings have been added, updated, or deleted
- Synonym maps have been added, updated, or deleted

## Handling large data volumes

Working with large volumes of data is a regular occurrence in the modern organization particularly when working with data to be embedded into a search mechanism. This means that the default index process may not be feasible. Azure Search has features built-in to cater for larger data sets:

- **Batch Indexing**: The approach of processing multiple documents. A simple approach to large data in a single request. The payload submitted must be smaller than 16MB or 1000 documents.
- **Pricing Tiers**: Adding resources should always be part of the thought process. Scaling through the pricing tiers to increase performance is a simple option but costs increase with it. A solution could be to temporarily upgrade the pricing tier to handle the load and then adjust after the indexing is complete.
- **Indexers**: These are used to crawl external data sources. Indexers have inherent capabilities to handle large data, such as, scheduling to split index packets into manageable chunks or processing over several days and partitioning of data into smaller data sets to enable parallel index processing.

## Enhancing Azure Search indexes with AI

Azure Search has AI features embedded, it works by integrating with Azure Cognitive Services (Cognitive Search) to add skills such as image processing, content extraction, and natural language processing (NLP) to an indexing pipeline. This can make previously unsearchable or unstructured content more useable. Many Cognitive Services resources can be added to Azure Search, the algorithms add advanced data science capabilities to full-text search solutions that would otherwise not be available. For example, processing images for text representations so that images can be included in text searches.

## Overview of Cognitive Search

The cognitive skills contained within Azure Search are based upon the machine learning models available through the Cognitive Services APIs specifically the Text Analysis and Computer Vision APIs. The AI algorithms are added to indexing pipelines to enrich data processing. There are two tiers available **Free** which includes up to 20 enrichments and **Billable** for greater than 20 enrichments.

There are a selection of built-in cognitive skills based upon pre-trained machine learning models:

- **Key Phrase Extraction**: Evaluates unstructured text and returns a list of key phrases per record.
- **Language Detection**: Detects the language of the text input and returns a single language code for each document.
- **Entity Recognition**: Natural Language Processing over raw text including sentiment analysis, key phrase extraction, language detection and entity recognition. Entity recognition is things such as people, places, organizations in your text.
- **Text Merger**: Concatenation of text from several fields into one single field.
- **Text Split**: Splits text into several chunks based upon sentences or pages.
- **Sentiment**: Performs sentiment analysis on the text to indicate either positive or negative sentiment.
- **Image Analysis**: Extracts features from images based on image content such as captions, tags, landmarks or faces.
- **OCR**: Optical Character Recognition extracts printed or handwritten text contained within image files.
- **Shaper**: Consolidates several inputs into a complex type such as text and sentiment or combining first and last name into a single structure.

The cognitive search capabilities can also be extended by adding your own custom skills via the Custom Skill API which is currently in preview.

Try out what you have learned by loading data to an index in Azure Search using the portal.
