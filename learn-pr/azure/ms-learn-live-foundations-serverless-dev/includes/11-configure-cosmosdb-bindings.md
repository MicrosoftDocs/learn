## 💻 Exercise - Use an input binding to read from CosmosDB

Our API functions are using hardcoded mock data at the moment. 
You are now going to access the database to read actual product data.

## Objective

- Use an input binding to read product data from CosmosDB

## Instructions

- In Visual Studio Code, switch to the Azure tab in the sidebar
- Expand the “Functions” pane and find `GetProduct` function
- Right click the function and select “Add binding”
- Select "in" for the direction
- Select "Azure Cosmos DB"
- Enter "inputProduct" as the name for the binding
- Use "maindb" for the database name (this is if the instructions in our workshop module have been followed)
- Use "data" for the collection name
- Use "CONNECTION_STRING" for the connection string setting 
- If Visual Studio Code is logged in to the Azure user account it can retrieve the connection string directly, otherwise use the portal and get it there.
- Use "{productId}" for the Document ID
- Use "product" for the partition key value
- Leave SQL query empty

Explore function.json and check what has been generated. Notice how “{productId}” is the placeholder we used for the HTTP trigger. It will contain the product ID passed in via the URL route and forward it to the binding.

- Switch to index.ts of the function
- Locate the line where you declared the `loadedProduct` variable and assign data coming from CosmosDB instead of the hardcoded JSON.
- The `Context` object has a `bindings` property which contains the binding you configured earlier.

```typescript
// The product is read from the DB using an input binding.
// The name "inputProduct" is defined in function.json.
const loadedProduct = context.bindings.inputProduct;
```

- Switch to the `GetProducts` (plural) function
- Add a binding that retrieves all products and name it "inputProducts"
- Easiest way to do this is to copy the binding information from function.json of `GetProduct` (singular), remove the `id` property and paste it into the function.json file of `GetProducts`

{
```json
"type": "cosmosDB",
    "direction": "in",
    "name": "inputProducts",
    "databaseName": "maindb",
    "collectionName": "data",
    "connectionStringSetting": "CONNECTION_STRING",
    "partitionKey": "product"
}
```
