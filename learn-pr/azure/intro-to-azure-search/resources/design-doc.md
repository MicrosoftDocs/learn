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
3. Query the index from an application

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

2. **Create an index in Azure Search**

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

3. **Knowledge check**

    What types of questions will test *Create an Azure Search index*?

    - Which data structure is supported by Azure Search?
    - What is a suggester in Azure Search?
    - Why are analyzers important in Azure Search?

4. **Load data into Azure Search**

    List the content that will enable the learner to *Load data into Azure Search*:

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

5. **Exercise - Create an Index and load data into Azure Search using the portal**

    List the steps that apply the learning content from previous unit:

    1. Run a script in the Cloud Shell to create an azure search instance.
    2. git clone source code with sample data.
    3. Run through the process to create an index
    4. Run through the process to load data to an index
    5. Run through the process to rebuild an index

6. **Knowledge check**

    What types of questions will test *Import data to the index*?

    - Which of the following data sources can be used as an input data source?
    - What condition would result in an index rebuild?
    - What is the maximum payload size for a bulk upload operation?

7. **Search content with Azure Search**

    List the content that will enable the learner to *Search content with Azure Search*:

    - Searching content using Azure Search
        - Query requests in an Azure Search
        - Query request Elements and Parsing

    - Query syntax
        - Simple Query Syntax
        - Full Lucene Query Syntax
        - Filtering and sorting data
        - Result handling

8. **Exercise - Search content with Azure Search with C#**

    List the steps that apply the learning content from previous unit:

    1. Run a script in the Cloud Shell to create an azure search instance.
    2. git clone source code with sample data.
    3. Step through console application code constructs
    4. Run through result handling in the application code
    5. Run the sample application.

9. **Summary**

   *{How did you solve the problem in the initial scenario with the knowledge learned in the module?}*

    - Basics of Azure search to understand the concepts and construct an index.
    - Overview of the methods to import data into Azure Search.
    - Walk through how to query indexes, the syntax, and handling responses.

## Notes

- Use JSON blobs as the data source for the exercise. https://docs.microsoft.com/en-us/azure/search/search-howto-index-json-blobs. Invent a small data structure for fitness videos with a few interesting properties of different types (string, int, date) and create a small corpus of documents to index.
- Use a *small* ASP.NET Core C# console app to demonstrate usage of the client library for searching an index. I will leave it up to the author to determine whether or not the app should be started from scratch or from some thin scaffolding.
- Do all development and running of the app in the Cloud Shell.
- Use the [portal](https://docs.microsoft.com/en-us/azure/search/search-howto-index-json-blobs#use-the-portal) to import the data and set up the indexing, but give a brief overview in the conceptual section about how to do it in [C#](https://docs.microsoft.com/en-us/azure/search/search-howto-index-json-blobs#use-net-sdk).
- Do not use advanced features like AI or cognitive search. Briefly mention their existence and utility in the conceptual sections but do not focus on them and do not use them in the exercise.
- Creating a user experience/website is out of scope; show code and usage of the index from a simple console app only.
