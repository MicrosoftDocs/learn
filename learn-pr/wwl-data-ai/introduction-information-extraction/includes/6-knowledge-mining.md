Knowledge mining solutions provide automated information extraction from large volumes of often unstructured data. A foundational knowledge mining solution is search, the process of retrieving relevant information from a large dataset in response to a user query. AI-powered information extraction supports improvements in what is searchable in a search index.

In AI-powered information extraction for search, content first moves through **Document cracking**. Document cracking describes opening document formats like PDFs to extract the contents as ASCII text for analysis and indexing.

The contents then move through **AI enrichment**, which implements AI on your original content to extract more information. Examples of AI enrichment include adding captions to a photo and evaluating text sentiment. AI enriched content can be sent to a **knowledge store**, which persists output from an AI enrichment pipeline for independent analysis or downstream processing.  

The resulting data is serialized as JSON data. The JSON populates the *search index*. The populated **search index**  can be explored through queries. When users make a search query such as "coffee", the search engine looks for that information in the search index. A search index has a structure similar to a table, known as the index *schema*. A typical search index schema contains *fields*, the field's data type (such as string), and *field attributes*. The fields store searchable text, and the field attributes allow for actions such as filtering and sorting. Below is an example of a search index schema: 

![A screenshot of the structure of an index schema in json including key phrases and image tags.](../media/json-index-example.png)

A result is a search solution which typically includes the following components:

|**Component** | **Function**|
|-|-|
|API Layer | Accepts user queries and routes them to the search engine.|
|Query Processor| Parses and interprets the query.|
|Search Strategies| Determines how to search—e.g., keyword, semantic, vector, or hybrid.|
|Execution Engine| Executes the query across the search index. AI-powered information extraction adds to the data that is searchable.|
|Result Aggregator| Combines results from multiple sources into a unified list.|
|Ranking Engine| Sorts results based on relevance, freshness, popularity, or AI signals.|
|Response Formatter| Formats the results for display in the user interface.|