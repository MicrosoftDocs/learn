Create the Cosmos DB API for MongoDB resource then create the database and container.

## Create Cosmos DB API for MongoDB resource

1. Open Visual Studio Code.
1. To open the **Azure** pane, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. In the **Databases** section, right-click the **Concierge Subscription** subscription. 
1. 1.Select **Create server**. 
1. Use the following table to answer the creation steps:

    | Step | Value|
    | -- | -- |
    |Select an Azure Database Server.|Select **Azure CosmosDB for MongoDB API**.|
    |Account name|Enter `js-rentals-` and post pend the value with a random number like `3956`. The account name needs to be unique across Azure Cosmos DB resources, which the random number ensures. |
    |Select a capacity model.| Select **Serverless**.|
    |Select a resource group for new resources.|Select your Learn sandbox resource group. |
    |Location|Select a location geographically close to you.|

1. In the Azure pane, expand the **Databases** section's Learn subscription and wait until the resource is created before continuing. This may take a minute or two. 

## Create database and collection

1. In the Azure pane, expand the **Databases** section's Learn subscription and find the resource just created. It should be the only one. 
1. Right-click on the resource and select **Create Database**.
1. Enter a database name, such as  `js-rentals`.
1. Right-click on the new database name and select **Create Collection**.
1. Enter the collection name, such as `rental`.

## Import data into collection

This sample app provides JSON data to seed the collection.

1. In the **Azure** pane, expand the **Databases** section's Learn subscription and find the database's collection.
1. Right-click and select **Import Document into a Collection**. 
1. From your local computer, within your cloned version of the sample app, select the `./3-Add-cosmosdb-mongodb/data/fake-rentals.json` file.
1. Expand the collection to see the imported rental properties. 

## Does the web app work yet? 

The web app still works in the sense that it is running but it doesn't display database yet because the web app doesn't have the connection string in the app settings.

## Check your work

* The Cosmos DB resource is created, targeting MongoDB.
* The database is named `js-rentals`. The collection is named `rentals`.
* The sample data is uploaded to the database.