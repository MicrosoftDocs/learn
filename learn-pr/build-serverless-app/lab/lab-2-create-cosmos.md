## Lab exercise 2 - Create Cosmos DB

In this step you are going to create a Cosmos DB to house all of the meta data about the images.

1. Enter an ID: **myCosmosID**
    Must be unique
2. Select the API: **Azure Table**
3. Use existing resource group
4. Location
5. Select **Create**

## Grant access to Azure functions to your Cosmos DB

1. Select Access control (IAM)
2. Select Add
3. Select **Contributor** in the Role dropdown
4. Select **Function App** in the Assign access to dropdown
5. Select your subscription.
6. Select the resource group you created in the first lab.
7. Select the functions app.
8. **Save**