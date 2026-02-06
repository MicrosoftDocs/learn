In this exercise, you create an Azure Cosmos DB for NoSQL database that serves as a document store for retrieval-augmented generation (RAG) applications. The database stores chunked documents with metadata that an AI application can retrieve to provide context to language models. You design a schema optimized for document retrieval, build Python functions that store and query document chunks, and test the complete workflow using a Flask web application. This pattern provides a foundation for building AI applications that ground language model responses in your organization's documents.

Tasks performed in this exercise:

- Download project starter files and configure the deployment script
- Deploy an Azure Cosmos DB for NoSQL account with a database and container
- Build Python functions for storing and retrieving document chunks
- Test the RAG functions using a Flask web application
- Query document context using the Cosmos DB SQL API

This exercise takes approximately **30** minutes to complete.

## Before you start

To complete the exercise, you need:

- An Azure subscription with the permissions to deploy the necessary Azure services. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli).
- [Python 3.12](https://www.python.org/downloads/) or greater.

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2350700" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
