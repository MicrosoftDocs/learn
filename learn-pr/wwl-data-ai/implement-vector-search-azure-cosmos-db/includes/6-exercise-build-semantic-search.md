In this exercise, you implement vector similarity search using Azure Cosmos DB for NoSQL. Vector search enables semantic matching by comparing high-dimensional vector representations of text, finding relevant results even when exact terms don't match. You configure a container with vector embedding and indexing policies, load support tickets with pre-computed embeddings, and execute similarity queries using the **VectorDistance** function. This pattern provides a foundation for building AI applications that perform semantic search, such as finding similar support cases to help resolve customer issues faster.

Tasks performed in this exercise:

- Download project starter files and configure the deployment script
- Deploy an Azure Cosmos DB for NoSQL account with vector search capability
- Build Python functions for vector similarity search
- Create a container with vector embedding and indexing policies
- Test vector search using a Flask web application

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

<a href="https://go.microsoft.com/fwlink/?linkid=2350601" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
