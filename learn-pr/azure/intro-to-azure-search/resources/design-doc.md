# Module Design

## Title

Introduction to Azure Search

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- Azure

## Prerequisites

- Beginner-level experience with C#
- Familiarity with Azure Blob storage

## Summary

Use Azure Search to make your data searchable. Create a search index, import data and query the index from an application.

## Learning objectives

1. Create an Azure Search index
2. Import data to the index
3. Query the Azure Search index

## Chunk your content into subtasks

Identify the subtasks of *Introduction to Azure Search*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| Create an index in Azure Search | Providing a searchable index of content | Knowledge Check | 1 | Yes |
| Load data into Azure Search | Loading catalog data into Azure Search for cross property searching | Knowledge Check & Exercise | 2 |Yes |
| Search content with Azure Search | Working with Azure Search to find videos in the catalog | Exercise | 3 | Yes |
||||||

## Outline the units

1. **Introduction**

    You work for a fitness startup that publishes exercise videos. You're just getting started establishing your online presence and want to provide a searchable index of your video catalog. You have a number of videos in the catalog and want to search across a number of different properties, such as title, difficulty, length, and publication date.

1. **What is Azure Search?**

    List the content that will enable the learner to *Create an index in Azure Search*:

    - A brief introduction to Azure Search
        - Summary of Azure Search
        - What is Azure Cognitive Search

    - What is an Index in Azure Search
        - Index Design
        - Index Workflows
        - Storage Implications
        - Suggesters, Scoring, and Analyzers

    - Methods to create an index
        - Using the Azure portal
        - Using C#
        - Azure Search REST API

1. **Exercise - Create an Azure Search service in the Azure portal**

    - Focus here is to get the learner to use the Azure  portal to create an Azure Service in the sandbox resource group
    - Navigate to sandbox portal
    - Create Azure Search service
    - Explain parameters of the Create dialog
    - Explain the URL endpoint

1. **Index data with Azure Search**

    List the content that will enable the learner to *Index data with Azure Search*:

    - Loading data into Azure Search
        - Methods for importing data to Azure Search
        - Data Source Inputs
        - Index attributes
        - Data import monitoring and verification

    - Azure Search Index Maintenance
        - Rebuilding indexes
        - Handling large data volumes

    - Enhancing Azure Search indexes with AI
        - Overview of Cognitive Search

1. **Create an Azure Search index for your data in the Azure portal**

    List the steps that apply the learning content from previous unit:

    1. Introduce the actual data set we'll use - a corpus of fitness center data.
    1. Explain the data set
    1. Run through the process to create an index
    1. Run through the process to load data to an index
    1. Run through the process to rebuild an index

1. **Query data in an Azure Search index**

    List the content that will enable the learner to *Search content with Azure Search*:

    - Searching content using Azure Search
        - Query requests in an Azure Search
        - Query request Elements and Parsing

    - Query syntax
        - Simple Query Syntax
        - Full Lucene Query Syntax
        - Filtering and sorting data
        - Result handling

1. **Exercise - Query your data using the Search explorer in the Azure portal**

    - Show the learner how to:
         - Do a basic search for a term
         - Return top N results
         - Filter the query
         - Facet the query
         - Highlight search results

1. **Knowledge check**

    What types of questions will test *Create an Azure Search index*?

    - What is a suggester in Azure Search?
    - Which of the following data sources can be used as an input data source?
    - Which data structure is supported by Azure Search?

1. **Summary**

   *{How did you solve the problem in the initial scenario with the knowledge learned in the module?}*

    - Basics of Azure search to understand the concepts and construct an index.
    - Overview of the methods to import data into Azure Search.
    - Walk through how to query indexes, the syntax, and handling responses.

## Notes

- Use JSON blobs as the data source for the exercise. <https://docs.microsoft.com/azure/search/search-howto-index-json-blobs> Invent a small data structure for fitness videos with a few interesting properties of different types (string, int, date) and create a small corpus of documents to index.
- Use the [portal](https://docs.microsoft.com/azure/search/search-howto-index-json-blobs#use-the-portal) to import the data and set up the indexing, but give a brief overview in the conceptual section about how to do it in [C#](https://docs.microsoft.com/azure/search/search-howto-index-json-blobs#use-net-sdk).
- Do not use advanced features like AI or cognitive search. Briefly mention their existence and utility in the conceptual sections but do not focus on them and do not use them in the exercise.
- Creating a user experience/website is out of scope; show code and usage of the index from a simple console app only.
- Calling the search from an app is out of scope for this module. A module that teaches that for .NEt/Java/Node.js will be planned for the future.

## References

<https://docs.microsoft.com/azure/search/search-what-is-data-import>
<https://docs.microsoft.com/rest/api/searchservice/AddUpdate-or-Delete-Documents>
<https://docs.microsoft.com/dotnet/api/microsoft.azure.search.models.indexaction?view=azure-dotnet>
<https://docs.microsoft.com/dotnet/api/microsoft.azure.search.models.indexbatch?view=azure-dotnet>
