Our API functions are using hardcoded mock data at the moment. You are now going to access the database to read actual product data.

## Objective

- Use an input binding to read product data from Cosmos DB.

## Instructions

To use an input binding to read product data from Cosmos DB:

1. Our functions interact with a Cosmos DB database. Node.js supports Cosmos DB through an additional package. In your terminal, switch to the folder containing the functions project, and run the following command.

    `npm install @azure/cosmos`

1. While we're already here, let's also add another Node.js package that enables our functions app to read configuration parameters from either a local configuration file or from Azure's application settings. In your terminal, switch to the folder containing the functions project, and run the following command.

    `npm install @types/node`

1. With the packages in place, we can now start accessing our data. In Visual Studio Code, switch to the Azure tab in the sidebar.

1. Expand the **Functions** pane, and find `GetProduct` function.

1. Right-click the function, and select **Add binding**.

1. Select **in** for the direction.

1. Select **Azure Cosmos DB**.

1. Enter *inputProduct* as the name for the binding.

1. Enter *maindb* for the database name.

1. Enter *data* for the collection name.

1. Enter *CONNECTION_STRING* for the connection string setting.

1. If Visual Studio Code is logged in to the Azure user account, it can retrieve the connection string directly; otherwise, use the portal and get it there.

1. Enter *{productId}* for the Document ID.

1. Enter *product* for the partition key value.

1. Leave SQL query empty.

    Explore function.json and check what has been generated. Notice how *{productId}* is the placeholder we used for the HTTP trigger. It will contain the product ID passed in via the URL route, and forward it to the binding.

1. Switch to index.ts of the function.

1. Locate the line where you declared the `loadedProduct` variable, and assign data coming from Cosmos DB instead of the hardcoded JSON.

    The `Context` object has a `bindings` property that contains the binding you previously configured.

    ```typescript
    // The product is read from the DB using an input binding.
    // The name "inputProduct" is defined in function.json.
    const loadedProduct = context.bindings.inputProduct;
    ```

1. Switch to the `GetProducts` (plural) function.

1. Add a binding that retrieves all products and name it *inputProducts*.

    The easiest way to do this is to copy the binding information from function.json of `GetProduct` (singular), remove the `id` property, and paste it into the function.json file of `GetProducts`.

    ```json
    {
        "type": "cosmosDB",
        "direction": "in",
        "name": "inputProducts",
        "databaseName": "maindb",
        "collectionName": "data",
        "connectionStringSetting": "CONNECTION_STRING",
        "partitionKey": "product"
    }
    ```
