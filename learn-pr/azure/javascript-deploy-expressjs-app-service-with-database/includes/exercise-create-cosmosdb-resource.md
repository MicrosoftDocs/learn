Create the Cosmos DB API for MongoDB resource then create the database and container.NET

## Create Cosmos DB API for MongoDB resource

1. Open Visual Studio Code.
1. To open the **Azure** pane on the left, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. In the **Databases** section, right-click the sandbox subscription name. Select **Create server**. 
1. Use the following table to answer the creation steps:

    | Step | Value|
    | -- | -- |
    |Select an Azure Database Server.|Select **Azure CosmosDB for MongoDB API**.|
    |Account name|Enter `js-rentals-` and post pend the value with a random number like `3956`. The account name needs to be unique across Azure Cosmos DB resources. |
    |Select a capacity model.| Select **Serverless**.|
    |Select a resource group for new resources.|Select your Learn sandbox resource group. |
    |Location|Select a location geographically close to you.|

1. In the Azure pane, expand the **Databases** section's Learn subscription and wait until the resource is created before continuing. This may take a minute or two. 

## Create database and collection

1. In the Azure pane, expand the **Databases** section's Learn subscription and find the new resource. It should be the only one. 
1. Right-click on the resource and select **Create Database**.
1. Enter a database name, such as  `js-rentals`.
1. Right-click on the new database name and select **Create Collection**.
1. Enter the collection name, such as `rental-properties`.

You'll set these values in the Express.js project `.env` file later in the module.

## Import data into collection

This sample app provides JSON data to seed the collection.

1. In the **Azure** pane, expand the **Databases** section's Learn subscription and find the database's collection.
1. Right-click and select **Import Document into a Collection**. 
1. From your local computer, within your cloned version of the sample app, select the `./3-Add-cosmosdb-mongodb/data/fake-rentals.json` file.
1. Expand the collection to see the imported rental properties. 

## Check your work

* The Cosmos DB resource is created, targeting MongoDB.
* The database is named `js-rentals`. The collection is named `rentals`.
* The sample data is uploaded to the database.