In this exercise, you compare and tune vector indexing strategies to optimize query performance in Azure Cosmos DB for NoSQL. Vector indexes significantly impact both search quality and Request Unit (RU) consumption. You create containers with three different index types—flat, quantizedFlat, and diskANN—load identical sample data, and run comparative searches to measure performance differences. This hands-on practice helps you select the right indexing strategy for your AI application's requirements.

Tasks performed in this exercise:

- Download project starter files and configure the deployment script
- Deploy an Azure Cosmos DB for NoSQL account with vector search capability
- Build Python functions for comparing vector index performance
- Create containers with flat, quantizedFlat, and diskANN indexes
- Test and compare index performance using a Flask web application

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

<a href="https://go.microsoft.com/fwlink/?linkid=2350800" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
