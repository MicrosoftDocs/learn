Connect your App Service resource to your Cosmos DB resource with a connection string.

## Copy your Cosmos DB connection string

1. In Visual Studio Code, open the **Azure** pane by selecting <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. Expand your Cosmos DB in the **Databases** section.
1. Right-click the database and select **Copy Connection String**.
1. Still in the Azure explorer, expand the **App Service** and expand your resource.
1. Right-click **Application Settings** and select **Add New Setting**.
1. Use the following table to create the 3 required app settings:

    |App setting name|Value|
    |--|--|
    |MONGODB_URI_CONNECTION_STRING|Paste your connection string.|
    |MONGODB_URI_DATABASE_NAME|`js-rentals`|
    |MONGODB_URI_COLLECTION_NAME|`rentals`|

## Use the web app

Open the app in a browser. 

1. In Visual Studio Code, in the Azure explorer, expand the **App Service** and expand your resource.
1. Right-click on your resource and select **Browse Website**.
1. Use the web app to add, edit, and delete rental properties. 

## Check your work

* Your Azure web app is connected to your Azure Cosmos DB database.