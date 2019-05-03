By integrating Azure Search services into the organizations apps and websites, companies can add fully featured search experiences for their customers. 

Your company wants to maximize the availability of its exercise video content to its customers. As part of establishing a greater online presence there's a need for an indexed and searchable video catalog. Your manager has asked you to look at implementing Azure search to provide a better search experience for your customers.

In this unit, you'll explore all the features of Azure Search, its concepts and how to create an Azure Search index.

## A brief introduction to Azure Search
![The Azure search logo](../media/2-what-is-azure-search.png)

Azure Search is a service that enables rich search experience over different kinds of content. The Azure Search service uses AI-powered indexing to allow apps, and websites, to search over a unified index. You decide what data is imported into the index, and setup indexers to pull that data into it, or push JSON formatted documents manually. Wherever your content is stored, once imported, Azure Search becomes a powerful tool that can add intuitive search experiences for your customers.

Azure Search lets you create, manage, and query search indexes. The results only contain your data, searches can read images, files, entities, or key phrases. It's a Platform as a Service (PaaS) so Microsoft manages the infrastructure and availability, allowing your organization to benefit without the need to purchase or manage additional hardware resources.

### What can Azure Search do?

Search is part of everyday life, especially considering the vast amounts of data generated in the modern interconnected world. Azure Search exists to compliment existing technologies and provides a programmable search engine built on the same foundations as Bing. Azure Search is a highly available platform offering a 99.9% uptime SLA available for cloud and on-premises assets.

Azure Search comes with the following features:

- **Data from any source**: Azure Search accepts data from any source provided in JSON format, with auto crawling support for data in Azure.
- **Full text search and analysis**: Azure Search offers full text search capabilities supporting both simple query and full lucerne query syntax.
- **AI powered search**: Azure Search has Cognitive AI capabilities built in for image and text analysis from raw content.
- **Multi-lingual**: Azure Search offers linguistic analysis for 56 languages to intelligently handle phonetic matching or language-specific linguistics.
- **Geo-enabled**: Azure Search incorporates Geo-search offering search results based on proximity to a physical location.
- **Configurable user experience**: Azure Search has several features to improve the user experience including autocomplete (preview), pagination and hit highlighting.
- **Traffic analytics**: Azure Search collects search analytics to help unlock insights from user search activity.

### What is Azure Cognitive Search?

Azure Cognitive search is a feature in Azure Search that uses Cognitive AI. It can enrich your content for greater search capabilities in your Azure Search index using machine learning models from Cognitive Services APIs. The feature can extract text from unstructured data sources, such as images, and is implemented by adding cognitive skills to an existing indexing pipeline.

![Screenshot showing azure cognitive search architecture](../media/2-cogsearch-architecture.png)

Azure Cognitive Search includes both Natural language and image-processing skills including:

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

Your company is interested in using these features in the future, but want you to focus on creating a simple search experience, supported by the existing video catalog your development team has created.

## Azure Search indexes

In Azure Search, an index is a persistent collection of JSON documents and other content used to enable search functionality. The documents within an index can be thought of as rows in a table, each document is a single unit of searchable data in the index. In your company, the index will contain a document for each video in your catalog. The index includes a definition the structure of the data in these documents, in its schema. For each field in the document, the index schema stores its name, the data type, and it also stores what behaviors are supported for the field. Is the field searchable? Can the field be sorted?

A quick way to create an index schema is to use the Azure portal to import data from a supported data source, currently:

- Azure SQL Database
- SQL Server on an Azure VM
- Cosmos DB
- Azure Blob storage
- Azure Table storage

When you import data from one of these sources, the Azure Search service automatically parses the data and populates a target index schema. A step in the import process allows you correctly set the data types, and specify the behaviors you'd like for each field. Using this approach to create your index schema also results in an indexer being automatically created. This indexer can then be run to initially load your search documents. Then, when new videos are created, or the data changes for existing videos, the indexer can be run again to update your index.

If you don't use this approach, you'll need to manually create your index, and create the indexer to load your JSON documents into the Search index.

### Index Design

![Screenshot showing an example index with different fields](../media/2-index-workflows.png)

Index design is important, if you forget to set a required behavior on a field, the only way to get that feature is to rebuild the index. When designing an index, it's key to remember the most effective indexes use only the behaviors that are needed. The smaller an index is, the faster it can return results.

During the design process, keep in mind the data your users will be searching, and how they may want to filter, or sort the results. Indexes consist of the following components:

- **Fields**: all the largest component in an index. Fields need to have a name, type, and have the behaviors defined for each of them

- **Scoring profiles**: lets you customize results to have certain documents return higher in the query results

- **Cross-Origin Resource Sharing**: browsers prevent cross-origin requests for security reasons. Enable this option if you need your index to be queried via JavaScrip from different urls. You can choose to lock down access to the index using a white list of origins, or allow all origins access.

#### Field Behaviors

All indexes require a unique text field to be defined as the primary key.

When creating your index, you need to choose the behaviors each field supports. The available options depend on what type of data is stored in the field:

- **Retrievable**: can this field be returned in the search results
- **Filterable**: can this field be used in filter expressions
- **Sortable**: can this field be sorted on in order by queries
- **Facetable**: can this field be used to group results to enable facted navigation of the results
- **Searchable**: only available on text fields. Can this field be searched against
- **Analyzer to use**: only available on text fields. You choose the language analyzer for the field that processes text in a query.
- **Suggester**: used to incorporate autocomplete or type-ahead queries in index searches. With this selected, a webpage can use asynchronous JavaScript to offer both suggestions or offer autocomplete functionality.

Storage considerations are always important, and in Azure Search it's no different. Remember that the behaviors you enable will have an impact on the size of storage required to store the index. Indexes supporting a full range of attributes will be substantially larger than just a searchable text index on a single field. Over time, as more documents are added to the index its size will grow.

### Index Workflows

A good practice for index design is to use an iterative workflow. Combining tools to complete the index design as quickly as possible:

1. Use the Import Data wizard to prototype and load data to an index if your data is stored in one of the supported data sources.
1. If your data source is not supported by the Import Data wizard, create an index manually in the portal. The portal has an interface to add fields, data types and assign behaviors.
1. The Index schemas can now be downloaded in JSON format. If you need to iterate on the index, you must now do that with a code-based approach.
1. The next step is to load data into the index, remember Azure Search only supports JSON documents.
1. Finally you can query the index, analyze the results, and if necessary iterate on the index schema until it's correct.
1. Use the Search explorer on the Azure portal to test searches in real time.

Remember you have to drop and recreate indexes if you need to make changes to field definitions. Adding new fields is supported, with all existing documents having null values. You'll find it faster using a code-based approach to iterate your designs, as working in the portal requires the index to be deleted, recreated, and the schema details to be manually filled out.

## How to create an index

Azure Search indexes can be created in several ways:

- Using the portal, Azure Search includes a built-in index designer
- Programmatically, Azure Search indexes can be created through code using the C# .NET SDK
- Azure Search REST API, can be used to manage indexes and documents

#### Using the Azure portal

Azure Search indexes can be created in the Azure portal using the index designer. Index creation in the portal is straight forward and consists of a few steps to provision the schema:

- Add an index through the designer, giving it a name
- Add fields to the index, specifying the key field and field attributes

The Import Data wizard can be used in the portal to create indexes if you're using a data source that's supported.

#### Using C#

Azure search index can be created programmatically in C#. This is achieved using the .Net SDK. Index creation using this method is a case of following through a few simple tasks:

- Create a `SearchServiceClient` object class for connecting to the search service
- Create an `Index` object
- Call the `Indexes.Create` method to send the `Index` object to the search service

Creating an index in Azure Search using C# requires you to obtain the URL endpoint and API key of the search service. These are then used to authenticate to the service when sending the create index requests.

#### Azure Search REST API

You can use PowerShell, or bash, to call the Azure Search Service REST API to manage your search service. The index definition and searchable content are provided in the request body as well-formed JSON content.

To use the Azure CLI, you'll first need to have created the Search service. In the portal, make a note of the Search service endpoint URL and the primary admin key.

The steps are then:

- Create an object to store the header for the REST API call.

    ```powershell
    $headers = @{
       'api-key' = '<your-admin-api-key>'
       'Content-Type' = 'application/json'
       'Accept' = 'application/json' }
    ```

- Test the details are correct by trying to connect to the API with `Invoke-RestMethod`.

    ```powershell
    Invoke-RestMethod -Uri <your-search-url> -Headers $headers | ConvertTo-Json
    ```

- Create an object to store the index schema definition of your index.

    ```powershell
    $body = @"
    {
        "name": "video-catalog",  
        "fields": [
            {"name": "id", "type": "Edm.String", "key": true, "searchable": false, "sortable": false, "facetable": false},
            {"name": "title", "type": "Edm.String", "filterable": false, "sortable": false, "facetable": false, "analyzer": "en.microsoft"},
            {"name": "difficulty", "type": "Edm.Int32"},
            {"name": "length", "type": "Edm.DateTimeOffset", "facetable": false},
            {"name": "publication", "type": "Edm.DateTimeOffset", "facetable": false},
            {"name": "size", "type": "Edm.Int32"}
        ],
        "suggesters": [  
        {  
           "name": "northwindsuggester",  
           "searchMode": "analyzingInfixMatching",  
           "sourceFields": ["title"]  
        }  
        ]
    }
    "
    ```

- Create a URL for the REST API endpoint, add the index name to the end of the Search service URL.

    ```powershell
    $url = "https://<your search service name>.search.windows.net/indexes/video-catalog?api-version=2019-05-01"
    ```

- Create the index using `Invoke-RestMethod`.

    ```powershell
    Invoke-RestMethod -Uri $url -Headers $headers -Method Put -Body $body | ConvertTo-Json
    ```

You have created in index using the REST API. You can load your search documents using the same approach, calling the appropriate REST endpoints.