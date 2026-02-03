In this exercise, you build a product similarity search application using Azure Database for PostgreSQL and the pgvector extension. You enable vector storage capabilities, create a database schema for products with embeddings, load sample data through a Flask web application, and perform similarity searches to find related products. This pattern provides a foundation for building recommendation systems, semantic search features, and other AI-powered applications.

Tasks performed in this exercise:

- Download project starter files and configure the deployment script
- Deploy an Azure Database for PostgreSQL Flexible Server with Microsoft Entra authentication
- Complete the Flask application code while the server deploys
- Enable the pgvector extension and create the products table schema
- Run the Flask application to load products and perform similarity searches
- Add new products and observe how similarity results change

This exercise takes approximately **30** minutes to complete.

## Before you start

To complete the exercise, you need:

- An Azure subscription with the permissions to deploy the necessary Azure services. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli).
- [Python 3.12](https://www.python.org/downloads/) or greater.
- [PostgreSQL command-line tools](https://www.postgresql.org/download/) (**psql**)


## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2348708" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
