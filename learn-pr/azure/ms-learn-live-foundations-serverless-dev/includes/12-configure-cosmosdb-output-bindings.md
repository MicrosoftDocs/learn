## 💻 Exercise - Use an output binding to write to CosmosDB

Output bindings are declared similarly to input bindings.
Depending on the type of binding, different parameters can and must be set.
The main difference however is the declaration of the setting “direction” to “out”.

## Objective

- Use an output binding to write product data into CosmosDB

## Instructions

- In Visual Studio Code, switch to the Azure tab in the sidebar
- Expand the “Functions” pane and find `CreateProduct` function
- Right click the function and select “Add binding”
- Select "out" for the direction
- Select "Azure Cosmos DB"
- Enter "outputProduct" as the name for the binding
- Use "maindb" for the database name (this is if the instructions in our workshop module have been followed)
- Use "data" for the collection name
- Use "CONNECTION_STRING" for the connection string setting 
- If Visual Studio Code is logged in to the Azure user account it can retrieve the connection string directly, otherwise use the portal and get it there.
- Leave the Document ID empty
- Use "product" for the partition key value
- Leave SQL query empty

Explore function.json and check what has been generated. 

- Switch to index.ts of the function
- Unlike input bindings, where we can read our data from using the Context object, output bindings use a different approach and are assigned as part of the return statement of a function. 
- Change the function's return type from `Promise<void>` to `Promise<any>`
- Add a return statement that includes both, the HTTP response **and** the product data that's supposed to go back to CosmosDB using the binding name `outputProduct`.

```typescript
return {
    // "res" is the name of the HTTP binding
    res: {
        status: 200,
        headers: { "Content-Type": "application/json" },
        body: { product: productToCreate }
    },
    // "outputProduct" is the name of the binding we created to return data to CosmosDB
    outputProduct: productToCreate
}
```

- Switch to the `UpdateProduct` function
- Copy the binding information from `CreateProduct`'s function.json over - they are identical
- Switch to index.ts and adjust the return type of the function and the return statement.

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

Test the function endpoints and use the CosmosDB Data Explorer in Azure portal to verify products are getting updated.
