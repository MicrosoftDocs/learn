In this exercise, you deploy an Azure Database for PostgreSQL instance and optimize it for vector search workloads. You create test data with vector embeddings, analyze baseline performance, build and compare IVFFlat and HNSW indexes, and tune search parameters. These techniques are essential for production AI applications that require fast similarity search across large datasets.

Tasks performed in this exercise:

- Download project starter files and configure the deployment script
- Deploy an Azure Database for PostgreSQL Flexible Server with Microsoft Entra authentication
- Create a test dataset with vector embeddings
- Analyze baseline vector search performance without indexes
- Create and compare IVFFlat and HNSW vector indexes
- Tune index parameters to balance speed and recall

This exercise takes approximately **30** minutes to complete.

## Before you start

To complete the exercise, you need:

- An Azure subscription with the permissions to deploy the necessary Azure services. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli).
- [PostgreSQL command-line tools](https://www.postgresql.org/download/) (**psql**)

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2348919" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
