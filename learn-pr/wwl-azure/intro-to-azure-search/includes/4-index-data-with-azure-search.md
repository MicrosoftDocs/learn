A good practice for index design is to use an iterative workflow. Below is a summary of how to use the Azure portal and pull method to create an index: 

1. Create an Azure Cognitive Search resource in the portal. 
2. Store content into one of the supported data sources: 
    - Azure SQL Database
    - SQL Server on an Azure VM
    - Cosmos DB
    - Azure Blob storage
    - Azure Table storage
3. Move data from the data source into the index. Remember Azure Cognitive Search only supports JSON search documents. If the content moving into the index is not in JSON it must be exported to JSON. You can use the Azure portal to create an index. The portal has an Import data wizard to add fields, data types and assign behaviors to the index. 
4. Query the index, analyze the results, and if necessary iterate on the index schema.
5. Use the Search explorer on the Azure portal to test searches in real time.

## Making changes to an index

You have to drop and recreate indexes if you need to make changes to field definitions. Adding new fields is supported, with all existing documents having null values. You'll find it faster using a code-based approach to iterate your designs, as working in the portal requires the index to be deleted, recreated, and the schema details to be manually filled out.

An approach to updating an index without affecting your users is to create a new index under a different name. You can use the same indexer and data source. After importing data, you can switch your app to use the new index.

## Enhance Azure Cognitive Search indexes with skills

Azure Cognitive Search has embedded AI. It works by using Azure Cognitive Services (specifically, Cognitive Search) to add Skillsets that include image processing, content extraction, or natural language processing (NLP). This makes it possible to index previously unsearchable, or unstructured content.

Image analyses skills range from OCR, to facial and landmark recognition, to analyzing an image for visual characteristics. Any text that can be lifted from an image becomes searchable in a search index. You can also perform sentiment analysis on text comments to look for customers having negative experiences. There are also skills that can detect language and perform text translation.

