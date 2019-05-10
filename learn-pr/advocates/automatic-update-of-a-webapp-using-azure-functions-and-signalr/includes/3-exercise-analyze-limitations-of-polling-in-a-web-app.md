Before you begin, make sure you have the following software installed on your machine:

- [Node.js](https://nodejs.org/download/)
- [Visual Studio Code](https://code.visualstudio.com/download)
- [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) (latest version)
- [Visual Studio Code Azure Functions Extension](https://code.visualstudio.com/tutorials/functions-extension/getting-started#_install-the-extension)

To set up the prototype on your machine, clone the application from the following location:

```bash
git clone TODO_REPO_URL.git
```

> [!IMPORTANT]
> Do not run `npm install` until you have completed the steps that update the *local.settings.json*. There is a post-install script that sets up your database and adds some data to the database.

Next, run the following script in the Cloud Shell:

```bash
export RESOURCE_GROUP_NAME=<rgn>[sandbox resource group name]</rgn>
export COSMOSDB_ACCOUNT_NAME=msl-svrless-cosmos-$(openssl rand -hex 5)
export STORAGE_ACCOUNT_NAME=mslsvrlessstorage$(openssl rand -hex 5)
export SIGNALR_ACCOUNT_NAME=msl-svrless-signalr$(openssl rand -hex 5)

echo "Resource Group Name: $RESOURCE_GROUP_NAME"
echo "Cosmos DB Account Name: $COSMOSDB_ACCOUNT_NAME"
echo "Storage Account Name: $STORAGE_ACCOUNT_NAME"
echo "SignalR Account Name: $SIGNALR_ACCOUNT_NAME"
```

This script generates the resource group and account names used in this lesson. Take note of these values should your time in the Azure Cloud Shell time out and you need to reestablish the variables.

The following script uses these variables to create the Azure resources required for this lesson.

```bash
az cosmosdb create  \
  --name $COSMOSDB_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP_NAME

az storage account create \
  --name $STORAGE_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --kind StorageV2 \
  --sku Standard_LRS

az extension add -n signalr

az signalr create \
  --name $SIGNALR_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --sku Free_DS2 \
  --unit-count 1
```

## Update local settings

For the app to run, you need to add the connection strings and keys associated with your Azure Storage, Functions and database services to your local settings. Navigate to where you cloned the application and open the folder in Visual Studio Code. Open *local.settings.json* in the editor so you can update the file.

Run the following command to get the connection string for your storage account:

```shell
az storage account show-connection-string \
  -name $STORAGE_ACCOUNT_NAME \
  -resource-group $RESOURCE_GROUP_NAME \
  --query "connectionString" -o tsv
```

Copy the connection string from the terminal window and replace `<STORAGE_CONNECTION_STRING>` with the connection string in the terminal.

Next, get the Cosmos DB connection string by running this command:

```shell
az cosmosdb list-connection-strings  \
  --name $COSMOSDB_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" -o tsv
```

Replace the token `<COSMOSDB_CONNECTION_STRING>` with the Cosmos DB connection string.

You also need the Cosmos DB master key. Run this command to list the account's master key:

```shell
az cosmosdb list-keys \
    --name $COSMOSDB_ACCOUNT_NAME \
    --resource-group $RESOURCE_GROUP_NAME \
    --query primaryMasterKey -o tsv
```

Copy this key and replace the `<COSMOSDB_MASTER_KEY>` placeholder with the master key value.

Finally, you'll request the SignalR connection string by using this command:

```shell
az signalr key list \
  --name $SIGNALR_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --query primaryConnectionString -o tsv
```

Replace `<SIGNALR_CONNECTION_STRING>` with the value returned in the terminal.

## Run the application

In the terminal window, issue the following command to install dependencies and set up the database:

```bash
npm install
```

> [!NOTE]
> If there is a problem during the install process and the database is not correctly setup, you can run `npm run setup` to manually seed the database.

Press F5 to start debugging the function app.

Next, to run the web application on your machine, open a Visual Studio Code's integrated terminal and run the command `npm start`.

```bash
npm start
```

You can now navigate to *http://localhost:8080* to see the application in the browser.

![Beginning state of serverless web app](../media/serverless-app-beginning-state.png)
