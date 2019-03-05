# Module Design (template)

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
1. Import data to the index
1. Query the index from an application

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
||||||

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You work for a fitness startup that publishes exercise videos. You are just getting started establishing your online presence and want to provide a searchable index of your video catalog. You have a number of videos in the catalog and want to be able to search across a number of different properties, such as title, difficulty, length and publication date.

1. **Learning-content unit title**

    List the content that will enable the learner to *subtask*:

    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

1. **Knowledge check**

    What types of questions will test *learning objective*?

    - Question type
    - Question type
    
1. **Exercise - exercise unit title**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

- Use JSON blobs as the data source for the exercise. https://docs.microsoft.com/en-us/azure/search/search-howto-index-json-blobs. Invent a small data structure for fitness videos with a few interesting properties of different types (string, int, date) and create a small corpus of documents to index.
- Use a *small* ASP.NET Core C# console app to demonstrate usage of the client library for searching an index. I will leave it up to the author to determine whether or not the app should be started from scratch or from some thin scaffolding.
- Do all development and running of the app in the Cloud Shell.
- Use the [portal](https://docs.microsoft.com/en-us/azure/search/search-howto-index-json-blobs#use-the-portal) to import the data and set up the indexing, but give a brief overview in the conceptual section about how to do it in [C#](https://docs.microsoft.com/en-us/azure/search/search-howto-index-json-blobs#use-net-sdk).
- Do not use advanced features like AI or cognitive search. Briefly mention their existence and utility in the conceptual sections but do not focus on them and do not use them in the exercise.
- Creating a user experience/website is out of scope; show code and usage of the index from a simple console app only.