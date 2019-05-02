<!-- REVIEW Please rework all learning unit intros to adhere to https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format -->

Companies can add fully featured search experiences for their customers by integrating Azure Search services into the organizations. 

Your company wants to maximize the availability of its exercise video content to its customers. As part of establishing a greater online presence there's a need for an indexed and searchable video catalog. Your manager has asked you to look at implementing Azure search to provide a better search experience for your customers.

In this unit, you'll explore all the features of Azure Search, its concepts and how to create an Azure Search index.

## A brief introduction to Azure Search
![The Azure search logo](../media/2-what-is-azure-search.png)

Azure Search is a service that enables rich search experience over different kinds of content. The Azure Search service uses AI-powered indexing to allow apps and website to search over a unified index. You need to decided what data should be imported into the index, and setup indexers to pull that data into it. Wherever your content is stored, Azure Search is a powerful tool that can add intuitive search experiences for your customers.

Azure Search lets you create, manage, and query search indexes. The results only contain your data, searches looking in images, files, entities, or key phrases. It's a Platform as a Service (PaaS) so Microsoft manages the infrastructure and availability, allowing your organization to benefit without the need to purchase or manage additional hardware resources.

### What can Azure Search do?

Search is part of everyday life, especially considering the vast amounts of data generated in the modern interconnected world. Azure Search exists to compliment existing technologies and provides a programmable search engine in Azure built on the same foundations as Bing. Azure Search is a highly available platform offering a 99.9% uptime SLA available for cloud and on-premises assets.

Azure Search comes with the following features:

- **Data from any source**: Azure Search accepts data from any source provided in JSON format, with auto crawling support for Azure SQL Database, Azure Blob Storage, and Azure Cosmos DB.
- **Full text search and analysis**: Azure Search offers full text search capabilities supporting both simple query and full lucerne query syntax.
- **AI powered search**: Azure Search has Cognitive AI capabilities built in for image and text analysis from raw content.
- **Multi-lingual**: Azure Search offers linguistic analysis for 56 languages to intelligently handle phonetic matching or language-specific linguistics.
- **Geo-enabled**: Azure Search incorporates Geo-search offering search results based on proximity to a physical location.
- **Configurable user experience**: Azure Search has several features to improve the user experience including autocomplete (preview), pagination and hit highlighting.
- **Traffic analytics**: Azure Search collects search analytics to help unlock insights from user search activity.

### What is Azure Cognitive Search?

Azure Cognitive search is a feature in Azure Search that uses Cognitive AI. It can enrich your content for greater search capabilities in your Azure Search index. It uses machine learning models from Cognitive Services APIs to extract text from unstructured data sources, such as images, and is implemented by adding cognitive skills to an existing indexing pipeline.

![Screenshot showing azure cognitive search architecture](../media/2-cogsearch-architecture.png)

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

Azure Cognitive Search can be extended, so that custom skills, and custom processing, can be integrated. Custom skills are currently in preview.

## Azure Search indexes

In Azure Search, an index is a persistent collection of JSON documents and other content used to enable search functionality. The documents within an index can be thought of as rows in a table, each document is a single unit of searchable data in the index. In your company, the index will contain a document for each video in the catalog. The index defines the structure of the data in these documents. For each field in the document, the index stores its name, the data type, and it also stores how the index should process the field. Is the field searchable? Can the field be sorted?





<!-- REVIEW Expand on this; it is not enough to paint a clear picture of what an index is, what it does, or how it's used. What do the documents represent? Where do they come from? -->

When an index is created, the Azure Search service creates the physical structures based upon the schema provided.

### Index Design

![Screenshot showing an example index with different fields](../media/2-index-workflows.png)

Index design is important, a correctly designed index will give better query results. In Azure Search, when designing an index it's key to remember the most effective indexes are an efficient data structure. <!-- REVIEW What does this mean, and how does someone design an index correctly? This module needs to deliver more insight, intuition and understanding about how to use Azure Search. -->

An index in Azure Search is made up of a collection of fields, each field has attributes. <!-- REVIEW Please refine this description; the definition just given a couple sentences back is that an index is a collection of documents --> One of these keys will be defined as the key field, in the example above it's the id field. The key field is a string that is a unique identifier for the document within the index.

Further customization to an index is achieved by using additional properties. <!-- REVIEW Please better define these items and give some insight about when you'd use them and how they're used. -->

- **Suggesters**: used to incorporate autocomplete or type-ahead queries in index searches. Suggesters can be enabled on a per field basis and returns responses after a user inputs three characters
- **Scoring**: lets you customize which results to have them return higher in the query results
- **Analyzers**: are used to set the language analyzer for the field that processes text in a query. Once set on a field in the index, it can't be changed unless the index is rebuilt

   > [!NOTE]
   > The design of an index will also have implications on performance, scale and redundancy of your search service. It is important to develop a deployment strategy upfront before enabling a high throughput production service. More information can be found in docs [Search Performance Optimization](https://docs.microsoft.com/en-us/azure/search/search-performance-optimization). <!-- REVIEW Please move links like these to the Additional Resources section at the end-->

### Index Workflows

A good practice for index design is to use an iterative workflow. Combining tools to complete the index design as quickly as possible:

- Depending on your data source, you could automate part of the index creation. Using the Import Data Wizard to prototype and load data to an index if your data is stored in one of the supported data sources (Azure SQL, Azure Cosmos DB, Azure Blob Storage, or Azure Table Storage).
- If your data source is not supported by the Import Data Wizard, you can still create an index manually in the portal. This gives you the ability to add fields, data types and assign attributes.
- When the index is initially created all the physical structures of the index are created in the search service.
- Index schemas can be downloaded in JSON format using the Azure REST API and tested in an external tool, such as Postman. You may wish to do this if you want to edit or iterate on a created index.
- The next step is to load data into the index, remember Azure Search only supports JSON documents.
- Finally you can query the index, analyze the results and if necessary iterate on the index schema until you see your desired results.
- Use the Search explorer on the Azure portal to see your results in real-time.

Remember to drop and recreate indexes if you make material changes to field definitions. This is because the index has a physical structure created in the service. You'll find it faster using code, as working in the portal requires the index definition to be manually filled out for each rebuild.

### Storage Implications

Storage is always important and in Azure Search it's no different. Remember that the attributes you choose, or enable, will have an impact on storage. Indexes supporting a full range of attributes will be substantially larger than just a full text index.

## How to create an index

Azure Search indexes can be created in several ways:

- Using the portal, Azure Search includes a built-in index designer
- Programmatically, Azure Search indexes can be created through code using the C# .NET SDK
- Azure Search REST API, can be used to manage indexes and documents

#### Using the Azure portal

Azure Search indexes can be created in the Azure portal using the index designer. Index creation in the portal is straight forward and consists of a few steps to provision the schema:

- Add an index through the designer, giving it a name
- Add fields to the index, specifying the key field and field attributes

The Import Data Wizard can be used in the portal to create indexes if you're using a data source that's supported.

#### Using C#

Azure search index can be created programmatically in C#. This is achieved using the .Net SDK. Index creation using this method is a case of following through a few simple tasks:

- Create a client object class for connecting to the search service
- Create an index object for passing parameters to the Indexes
- Create method on the client object to send the index object to the search service

Creating an index in Azure Search using C# requires you to obtain the URL endpoint and API key of the search service. These are then used to authenticate to the service when sending the create index requests.

#### Azure Search REST API

<!-- REVIEW Rework this to primarily be about PowerShell and the CLI; very few people interact directly the REST interface -->

You can use PowerShell and the Azure Search Service REST API to manage a search index. The index definition and searchable content are provided in the request body as well-formed JSON content.

Azure search index can also be created programmatically using the Azure Search Service REST API in tandem with PowerShell (or Bash). This is achieved by:

- Connect and authenticate to the Azure Search Service via a GET request, using the URL endpoint and API key
- Create an index via a JSON schema using either a POST or PUT request, the create index request body must include an index name and fields

If the index creation has been successful, you'll see a **201 Created** status code.
