# Title

Upload, download, and manage data with Azure Storage Explorer

## Role(s)

- Solution Architect
- Administrator

## Level

- Beginner

## Product(s)

- Azure Storage Explorer
- Azure Storage account
- Azure Cosmos DB
- Azure Data Lake

## Prerequisites

- Basic knowledge of Azure Storage, Cosmos DB, and Data Lake
- Ability to install software locally

## Summary

Azure Storage Explorer allows you to quickly view all the storage services under your account and navigate, read, and edit data stored in those services through a user-friendly graphical interface.

## Learning objectives

1. Identify the features of Azure Storage Explorer
1. Install Azure Storage Explorer
1. Use Azure Storage Explorer to connect to Azure storage services and manipulate stored data

## Chunk your content into subtasks

Identify the subtasks of *Upload, download, and manage data with Azure Storage Explorer*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Connect Azure Storage Explorer to a storage account | "... which writes data to Azure storage..." | Exercise | Use Azure Storage Explorer to connect to Azure storage services | Yes |
| Connect Azure Storage Explorer to Cosmos DB and Data Lake | "... which writes data to ... Cosmos DB and Azure Data Lake." | Exercise | Use Azure Storage Explorer to connect to Azure storage services | Yes |

## Outline the units

1. **Introduction**

    Suppose you work for an enterprise that has developed a Customer Relationship Management (CRM) application, which writes data to Azure storage, Cosmos DB and Azure Data Lake. Your engineers occasionally need to view stored data, upload new data, and administer these storage services. They'd like to have a user-friendly GUI tool for these manual activities.

1. **Connect Azure Storage Explorer to a storage account**

    List the content that will enable the learner to *Connect Azure Storage Explorer to a storage account*:

    - Choose when to use Azure Storage Explorer
        - What is Azure Storage Explorer?
        - Manage multiple storage accounts in multiple subscriptions
        - Manage storage in Azure Stack
        - Manage storage in local emulators
        - Manage data in Cosmos DB and Azure Data Lake
    - Connect to an Azure subscription 
        - Connect by adding an Azure Account
        - Connect by using a shared access signature URI
        - Connect by using a storage account name and key

1. **Exercise - Connect Azure Storage Explorer to a storage account**

    List the steps, which apply the learning content from previous unit:

    1. Download Azure Storage Explorer from https://azure.microsoft.com/features/storage-explorer/
    1. Run the installation wizard
    1. Start Storage Explorer and connect to an Azure Account
    1. Create a blob in an Azure Storage account
    1. Create a queue in an Azure Storage account

1. **Connect Azure Storage Explorer to Cosmos DB and Data Lake**

    List the content that will enable the learner to *Connect Azure Storage Explorer to Cosmos DB and Data Lake*:

    - Use Storage Explorer to manage Cosmos DB
        - Connect by using a connection string
        - Create, update, and delete Cosmos DB databases and collections
        - Create, update, and delete documents in Cosmos DB
        - Create, update, and delete a Graph database.
    - Use Storage Explorer to manage Azure Data Lake
        - Connect to a Data Lake Storage Gen2 account
        - Create a container
        - Upload and view blobs

1. **Exercise - Connect Azure Storage Explorer to Cosmos DB and Data Lake**

    List the steps, which apply the learning content from previous unit:

    1. Connect to Cosmos DB by using a connection string
    1. Create a Cosmos DB database and collection
    1. Create documents in Cosmos DB
    1. Connect to a Data Lake Storage Gen2 account
    1. Create a container
    1. Upload and view blobs

1. **Summary**

    Your Customer Relationship Management (CRM) application is a complex system that stores data in Azure Storage, Cosmos DB, and Azure Data Lake. You wanted to find an easy-to-use tool that your engineers could use to administer the data in the different locations in Azure. The Storage Explorer is a GUI tool that you can use to explore and edit data in all those locations in your Azure subscription.

    You can explore your Azure data with many different tools, depending on its location and your preference. For example, the Azure portal includes a web-based interface that presents the contents of Azure Storage account, or you can use the Azure CLI at the command line. The Azure Storage Explorer is the only desktop GUI tool that can investigate and edit data in Azure Storage, Cosmos DB, and Azure Data Lake.

    *[(Summary guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-module-summary-unit)*

## Notes

This module should cover the main features of Storage Explorer, go through a quick install, then exercises that demonstrate connecting to the various resources. Use a template to deploy the resources needed by Storage Explorer in Azure.

- I have been using this sandbox as a base: https://docs.microsoft.com/en-us/learn/modules/access-data-with-cosmos-db-and-sql-api/2-setup-cosmosdb?source=learn

- The sandbox will need to allow Azure Storage Explorer to create in a Storage account, a Blob container, a queue, a Cosmos DB and a Data Lake.  Otherwise you won't be able complete some of the exercises.
