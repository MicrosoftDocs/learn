Your company wants to maximise the availability of it's exercise video content to it's customers. As part of establishing a greater online presence there is a need for an indexed and searchable catalog.

Your manager has asked you to to look at implementing this using Azure search in order to provide a seamless experience for your customers.

In this unit, you'll explore Azure Search in more detail, it's concepts and ways to create an Azure Search index.

## A brief introduction to Azure Search

Azure Search is a search-as-a-service solution available in Microsoft Azure enabling rich search experiences over a variety of content. Where ever your content is stored Azure Search is a powerful tool in the armory towards creating intuitive seamless search experiences for your customers.

Azure Search lets you create, manage and query indexes containing only your data with the ability to leverage AI-powered indexing for feature extraction from images, files, entities or key phrases. It's a Platform as a Service (PaaS) therefore infrastructure and availability are managed by Microsoft allowing your organization to benefit from not purchasing or managing server resources.

![Screenshot showing azure search logo](../media/2-what-is-azure-search.png)

## Summary of Azure Search

Search is an integral part of everyday life, especially considering the vast amounts of data generated in the modern ecosystem. Azure Search exists to compliment existing technologies and is essentially a programmable search engine managed service in Azure built on the same foundations as Bing. Azure Search is a fully managed and scalable solution provided by Microsoft with no infrastructure management in a highly available platform offering a 99.9% uptime SLA available for cloud and on-premises assets.

Azure Search comes with the following features:

- Data from any source, Azure Search accepts data from any source provided in JSON format with auto crawling support for Azure SQL Database, Azure Blob Storage and Azure Cosmos DB.
- Full text search and analysis, Azure Search offers Full text search capabilities supporting both simple query and full lucerne query syntax.
- AI powered searching, Azure Search has Cognitive AI capabilities built in for image and text analysis from raw content.
- It's Multi-lingual, Azure Search offers linguistic analysis for 56 languages to intelligently handle phonetic matching or language-specific linguistics.
- Geo-enabled, Azure Search incorporates Geo-search offering search results based on proximity to a physical location.
- Configurable user experience, Azure Search has several features to improve the user experience including autocomplete (preview), pagination and hit highlighting.
- Traffic analytics, Azure Search collects search analytics to help unlock insights from user search activity.

## What is Azure Cognitive Search

Azure Cognitive search is a feature in Azure Search utilizing Cognitive AI. It can be used to enrich your content for greater search capabilities in your Azure Search index. It works by using machine learning models from Cognitive Services APIs to extract text from unstructured data sources, such as images, and is implemented through adding cognitive skills to an existing indexing pipeline.

![Screenshot showing azure cognitive search architecure](../media/2-cogsearch-architecture.png)

Azure Cognitive Search comprises both Natural language and image processing skills including:

- Entity recognition
- Language detection
- Key phrase extraction
- Text manipulation
- Sentiment detection
- Optical Character Recognition (OCR)
- Facial detection
- Image interpretation
- Image recognition

Azure Cognitive Search can also be extended so that custom skills and custom processing can be integrated. Custom skills are currently in preview.

## What is an Index in Azure Search

In Azure Search an index can essentially be thought of as a table, it is a persistent collection of documents and other content used to enable search functionality. The documents within an index can be thought of as rows within a table, each document is a single unit of searchable data in the index.

When an index is created the Azure Search service creates the physical structures based upon the schema provided.

## Index Design

Index design is super important, a correctly designed index will yield better query results. In Azure Search designing an index it's key to remember the most effective indexes are an efficient data structure. 

An index in Azure search is comprised of various elements each pertaining to the make up of the index or the schema. The fields collection is usually the largest part of the index and includes attributes to determine field names, types and behavioral attributes, such as whether the index is searchable or filterable. An index also has a key field which must be a string field, the key field represents a unique identifier for each document within the index.

For further customization indexes also have additional elements suggesters, scoring profiles and analyzers.

   > [!NOTE]
   > The design of an index will also have implications on performance, scale and redundancy of your search service. It is important to develop a deployment strategy upfront before enabling a high throughput production service. More information can be found here [Search Performance Optimization](https://docs.microsoft.com/en-us/azure/search/search-performance-optimization)

## Index Workflows

A good practice for index design is to achieve this through an iterative workflow using a combination of tools to finalize the index design as quickly as possible:

- The first port of call is to identify if you can use an indexer. This depends on your data source, if your data is stored in one of the supported data sources (Azure SQL, Azure Cosmos DB, Azure Blob Storage, Azure Table Storage), you can use the Import Data Wizard to prototype and load data to an index.
- If your data source is not supported by the Import Data Wizard you can still create an index in the portal. This gives you the ability to add fields, data types and assign attributes.

![TODO - Screenshot showing index provisioned](../media/2-index-workflows.png)

- When the index is initially created all the physical structures of the index are created in the search service.
- Index schemas can be downloaded in JSON format using the Azure REST API and tested in an external tool, such as Postman. You may wish to do this if you want to edit or iterate a created index as this is best achieved through code rather than via the portal.
- The next step is to load data into the index, remember Azure Search only supports JSON documents.
- Finally you can query the index, analyse the results and if required iterate on the index schema until you see your desired results. This can be done using Search explorer.

It is key to drop and recreate indexes if you make material changes to field definitions this is because the index has a physical structure created in the service. You may find it faster to do this through code as working in the portal requires the index definition to be filled out for each rebuild.

## Storage Implications

Storage is always important and in Azure Search that is no different. It's important to remember that the attributes you choose or enable will have an impact on storage. Indexes supporting a full range of attributes will be substantially larger than just a full text index.

## Suggesters, Scoring, and Analyzers

Azure Search supports additional elements that expand upon the features available in an index:

- **Suggesters:** These are used to incorporate autocomplete or type-ahead queries in index searches. This can be enabled on a per field basis and is enabled in responses after a user inputs 3 characters.
- **Scoring:** This is the scoring profile of the index schema. The scoring profile lets you customize which results return higher in the returned query results of the index.
- **Analyzers:**  These are used to set the language analyzer for the field that processes text in a query string. Once set on a field in the index it cannot be changed unless the index is rebuilt.

## Methods to create an index

Azure Search indexes can be created in several ways:

- Using the portal, Azure Search includes a built-in index designer.
- Programmatically, Azure Search indexes can be created through code using C# or via the Azure Search Rest API.

## Using the Azure portal

Azure Search indexes can be created in the Azure portal using the index designer. Index creation in the portal is straight forward and consists of a few steps to provision the schema:

- Add an index through the designer, giving it a name.
- Add fields to the index, specifying the key field and field attributes.

The Import Data Wizard can also be used in the portal to create indexes although this is only if you are using a data source that supports indexers.

## Using "C#"

Azure search index can be created programmatically in C#. This is achieved using the .Net SDK. Index creation using this method is a case of following through a few simple tasks:

- Create a client object class for connecting to the search service.
- Create an index object for passing parameters to the Indexes.Create method
- Invoke the Indexes.Create method on the client object to send the index object to the serch service

Creating an index in Azure Search using C# requires you to obtain the URL endpoint and api key of the search service. These are then used to authenticate to the service when sending the create index request.

## Azure Search REST API

This article walks you through the process of creating, loading, and querying an Azure Search index using PowerShell and the Azure Search Service REST API. The index definition and searchable content is provided in the request body as well-formed JSON content.

Azure search index can also be created programmatically using the Azure Search Service REST API in tandem with PowerShell (Or Bash). This is achieved using a few simple tasks:

- Connect and authenticate to the Azure Search Service via a GET request, using the URL endpoint and api key.
- Create an index via a JSON schema using either a POST or PUT request, the create index request body must include an index name and a fields collection.

If the index creation has been successful you should see a **201 Created** status code.

Try out what you have learned by creating an Azure Search instance through the portal.