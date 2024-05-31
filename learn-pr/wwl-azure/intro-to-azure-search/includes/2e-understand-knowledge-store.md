A knowledge store is persistent storage of enriched content. The purpose of a knowledge store is to store the data generated from AI enrichment in a container. For example, you may want to save the results of an AI skillset that generates captions from images. 

![Infographic of knowledge store.](../media/knowledge-store-diagram.png)

Recall that skillsets move a document through a sequence of enrichments that invoke transformations, such as recognizing entities or translating text. The outcome can be a search index, or projections in a knowledge store. The two outputs, search index and knowledge store, are mutually exclusive products of the same pipeline; derived from the same inputs, but resulting in output that is structured, stored, and used in different applications.

While the focus of an Azure AI Search solution is usually to create a searchable index, you can also take advantage of its data extraction and enrichment capabilities to persist the enriched data in a knowledge store for further analysis or processing. 

A knowledge store can contain one or more of three types of projection of the extracted data:  
- Table projections are used to structure the extracted data in a relational schema for querying and visualization 
- Object projections are JSON documents that represent each data entity
- File projections are used to store extracted images in JPG format