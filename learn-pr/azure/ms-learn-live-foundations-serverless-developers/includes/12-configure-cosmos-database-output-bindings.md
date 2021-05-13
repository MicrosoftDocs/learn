Output bindings are declared similarly to input bindings.
Depending on the type of binding, different parameters are required.
The main difference, however, is the declaration of the setting *direction* to *out*.

## Objective

- Use an output binding to write product data into Cosmos DB.

## Instructions

To use an output binding to write product data into Cosmos DB:

1. In Visual Studio Code, switch to the Azure tab in the sidebar.

1. Expand the **Functions** pane, and find the `CreateProduct` function.

1. Right-click the function, and select **Add binding**.

1. Select **out** for the direction.

1. Select **Azure Cosmos DB**.

1. Enter *outputProduct* as the name for the binding.

1. Enter *maindb* for the database name.

1. Enter *data* for the collection name.

1. Enter *false* because the database and collection already exist.

1. Enter *CONNECTION_STRING* for the connection string setting.

    If Visual Studio Code is logged in to the Azure user account, it can retrieve the connection string directly, otherwise use the portal and get it there.

1. Enter *product* for the partition key value.

1. Leave throughput empty.

    Explore function.json and check what has been generated.

1. Switch to index.ts of the function.

    Unlike input bindings, where we can read our data from using the context object, output bindings use a different approach, and are assigned as part of the return statement of a function.

1. Change the function's return type from `Promise<void>` to `Promise<any>`.

1. Add a return statement that includes both the HTTP response **and** the product data that's supposed to go back to Cosmos DB using the binding name `outputProduct`.

    ```typescript
    return {
        // "res" is the name of the HTTP binding
        res: {
            status: 200,
            headers: { "Content-Type": "application/json" },
            body: { product: productToCreate }
        },
        // "outputProduct" is the name of the binding we created to return data to Cosmos DB
        outputProduct: productToCreate
    }
    ```

1. Switch to the `UpdateProduct` function.

1. Copy and paste the binding information from `CreateProduct`'s function.json - they are identical.

1. Switch to index.ts and adjust the return type of the function and the return statement.

    ```typescript
    return {
        res: {
            status: 200,
            headers: { "Content-Type": "application/json" },
            body: { product: productToUpdate }
        },
        outputProduct: productToUpdate
    }
    ```

Test the function endpoints and use the Cosmos DB Data Explorer in the Azure portal to verify products are getting updated.
