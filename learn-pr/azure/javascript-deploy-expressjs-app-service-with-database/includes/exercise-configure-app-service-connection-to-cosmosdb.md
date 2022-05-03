Connect your current App Service resource to your new Cosmos DB resource.

## Copy your Cosmos DB connection string

1. In Visual Studio Code, open the Azure explorer, and expand your Cosmos DB in the **Databases** section.
1. Right-click the database and select **Copy Connection String**.
1. Still in the Azure explorer, expand the **App Service** and expand your resource.
1. Right-click **Application Settings** and select **Add New Setting**.
1. Enter the **App Setting Name** as `MONGODB_URI_CONNECTION_STRING`.
1. Paste the connection string.
1. Create the database and collection app settings using the same technique with the following table:

    |App setting name|Value|
    |--|--|
    |MONGODB_URI_DATABASE_NAME|js-rentals|
    |MONGODB_URI_COLLECTION_NAME|rentals|

## Use the web app

Open the app in a browser. 

1. In Visual Studio Code, in the Azure explorer, expand the **App Service** and expand your resource.
1. Right-click on your resource and select **Browse Website**.
1. Use the web app to add, edit, and delete rental properties. 

## Check your work

* Your Azure web app is connected to your Azure Cosmos DB database.