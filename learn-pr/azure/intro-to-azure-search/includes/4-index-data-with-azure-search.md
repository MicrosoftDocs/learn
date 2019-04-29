As part of the drive to establishing your organization's online presence, you need to implement Azure Search to enable rich search for the online video catalog. You'll be loading data into an existing Azure Search instance so customers can search the catalog by title, difficulty, length, and publication date.

Now that the Azure Search service has been created, you'll look at how to load data into an index in Azure Search.

## Loading data into Azure Search

Azure Search lets you create empty indexes, in order for indexes to be queried data must be loaded. These queries run over the content loaded and saved to an index. There are two approaches for loading data into an index:

- **Programmatically**: Known as pushing data into the index. A JSON data set is pushed to the Azure Search Index via either the REST API or the .Net SDK. Pushing data has the most flexibility as it has no restrictions on the data source type, or frequency of execution.

- **Use Azure Search indexer**: Known as pulling data into the index. The Azure Search indexer crawls a supported data source and automatically loads data into the index via the use of an indexer. The indexer maps source fields to their matching fields in the index. The indexer transforms the imported data into a JSON format.

### Methods for importing data to Azure Search

There are three methods to importing data into Azure Search, the indexer functionality embedded in the service is made available through the portal, the Azure Search REST API, and the .NET SDK.

**Azure portal**

Contained within the Azure Search Service dashboard in the Azure portal is an Import data wizard. The wizard imports data into the index by connecting to an external data source in the same subscription. The wizard crawls the data source for content and converts it into JSON documents to be imported into the index.

**Pushing data via the REST API or .NET SDK**

Data can be pushed to Azure Search via an API, this can be used to either load documents individually or in batches up to 1000 documents. There's no option to push data in the portal. The APIs available are:

- **REST API**: Add, Update, or Delete Documents
- **.NET SDK**: indexAction class, or indexBatch class

### Data Source Inputs

Data sources imported via the data wizard in Azure Search create a persistent data source connection to the external source. The supported data sources are Azure SQL databases, Azure Cosmos DB, Azure Blob Storage, and Azure Table Storage (cognitive search pipelines aren't supported). The data must be flattened into a single object (table, view, or data structure) so it can be imported.

### Index attributes

An index is generated loaded with documents from the data source when using the Import data wizard. These documents have attributes associated to them determining how the documents are returned in a query result. These elements must be defined, as if no attributes are set, it's as if your index is empty.

The key attributes for the index are:

- **Key**: The unique id for each document. Must be a string and gets used for document lookups.
- **Retrievable**: Sets whether the field can be returned in a search result.
- **Filterable**: Sets whether the field can be used to filter queries.
- **Sortable**: Sets whether the field can be used to sort search results.
- **Facetable**: Sets whether the field can be used in a faceted navigation structure as part of user directed filtering.
- **Searchable**: Sets whether the field is full-text searchable.

### Data import monitoring and verification

The indexing progress can be monitored by clicking on the associated indexer in the indexers list. The document count will grow as documents are loaded to the index. In some instances, the portal page can take a few minutes to display up-to-date document counts. Once the index is ready for querying, you can then use Search Explorer to verify the results. An index is ready when the first document is successfully loaded.

Search Explorer is available in the Azure portal and allows you to submit queries to your Azure Search service. The results are returned as JSON documents. Query expressions can be used to limit which fields are returned. You can write OData expressions if you need to filter the result set.

## Azure Search Index Maintenance

Usage and Monitoring sections give you the option to view data about query metrics, resource usage, and quota availability. Log Analytics can also be configured to add additional reporting capabilities to your Search instance. These reports are useful to monitor search workloads to work out the correct service tier, or if any replication, or partitioning of the indexes is required.

### Rebuilding indexes

When using Azure Search, there will be situations that will require you to rebuild indexes. This will be the case when developing an index. Rebuilding an index is the process to drop and recreate the physical data structure associated with the index. When an index is rebuilt, all the stored fields are deleted and then recreated based upon revised schema. The index is then repopulated with data, which is either pushed to the index, or pulled from the supported external data source.

There are several conditions that will require an index to be rebuilt:

- A field definition is changed
- An analyzer is assigned to a field
- An analyzer definition is updated or deleted
- A field is added to a suggester
- A field is deleted
- The Azure Search service tier is changed

Data refresh for an index runs as a background task, this allows you to add, delete, or update documents in the index with minimal disruption to queries. As is the case for relational database table indexes, queries may take longer to complete. There are certain modifications that can be made to an index that don't result in an index rebuild:

- A new field is added to the index
- An existing field has the retrievable attribute set
- An existing field has the search analyzer set
- An index has a new analyzer definition set
- Scoring profiles have been added, updated, or deleted
- CORS settings have been added, updated, or deleted
- Synonym maps have been added, updated, or deleted

### Handling large data volumes

Working with large volumes of data is a regular occurrence in the modern organization particularly when working with data to be embedded into a search mechanism. The default index process may not be feasible with large volumes of data. So Azure Search includes features to cater for such situations:

- **Batch Indexing**: The approach of processing multiple documents. A simple approach to large data in a single request. The payload submitted must be smaller than 16MB or 1000 documents.
- **Pricing Tiers**: Adding resources should always be part of the thought process. Scaling through the pricing tiers to increase performance is a simple option but costs will increase. One solution is to temporarily upgrade the tier to handle the increased load, and then reduce the tier after indexing is complete.
- **Indexers**: Used to crawl external data sources. Indexers have inherent capabilities to handle large data, such as, scheduling to split index packets into manageable chunks, and partitioning of data into smaller data sets to enable parallel index processing.

## Enhancing Azure Search indexes with AI

Azure Search has AI features embedded, it works by using Azure Cognitive Services (Cognitive Search) to add skills that include image processing, content extraction, or natural language processing (NLP). This enables previously unsearchable, or unstructured content, more useable. Many Cognitive Services resources can be added to Azure Search, the algorithms add advanced data science capabilities to full-text search solutions that would otherwise not be available. For example, processing images for text representations so that customers can search for text in images.

### Overview of Cognitive Search

The cognitive skills contained within Azure Search are based upon the machine learning models available through the Cognitive Services APIs, specifically the Text Analysis, and Computer Vision APIs. The AI algorithms are added to indexing pipelines to enrich data processing. There are two tiers available, **Free** which includes up to 20 enrichments, and **Billable** that enables you to make use of more than 20 enrichments.

There is a selection of built-in cognitive skills based upon pre-trained machine learning models:

- **Key Phrase Extraction**: Evaluates unstructured text and returns a list of key phrases per record.
- **Language Detection**: Detects the language of the text input and returns a single language code for each document.
- **Entity Recognition**: Natural Language Processing over raw text including key phrase extraction, language detection, and entity recognition. Entity recognition can identify people, places, and organizations in your text.
- **Text Merger**: Concatenation of text from several fields into one single field.
- **Text Split**: Splits text into several chunks based upon sentences or pages.
- **Sentiment**: Enables sentiment analysis on the text to indicate either positive, or negative, sentiment.
- **Image Analysis**: Extracts features from images based on image content including as captions, tags, landmarks, or faces.
- **OCR**: Optical Character Recognition extracts printed or handwritten text contained within images.
- **Shaper**: Consolidates several inputs into a complex type such as text and sentiment, or combining a first and last name into a single structure.

The cognitive search capabilities can also be extended by adding your own custom skills, via the Custom Skill API, which is currently in preview.