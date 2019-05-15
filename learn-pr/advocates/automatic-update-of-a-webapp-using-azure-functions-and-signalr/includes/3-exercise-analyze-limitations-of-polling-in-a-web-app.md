Before you begin, make sure you have the following software installed on your machine:

- [Node.js](https://nodejs.org/download/)
- [Visual Studio Code](https://code.visualstudio.com/download)
- [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) (latest version)
- [Azure Functions extension for Visual Studio Code](https://code.visualstudio.com/tutorials/functions-extension/getting-started#_install-the-extension)
- [Azure Storage extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestorage)

## Download sample app code
1. Run the following command on your local machine to clone the app from GitHub.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-advocates.azure-functions-and-signalr.git
    ```

    > [!IMPORTANT]
    > Do not run `npm install` until you have completed the steps that update the *local.settings.json*. There is a post-install script that sets up your database and adds some data to the database.

2. The as-is state of the app is located in the **start** folder. Make sure you are in that folder for the remainder of this module. 

## Create a Storage account

We'll need a storage account for our Azure Functions logic and for our web app when we deploy it to the cloud later in the module. 

1.  Execute the following command in the Cloud Shell to define a name for our Azure Storage account.

    ```bash
    export STORAGE_ACCOUNT_NAME=mslsigrstorage$(openssl rand -hex 5)
    echo "Storage Account Name: $STORAGE_ACCOUNT_NAME"
    ```

    Keep note of  this  account name for the remainder of the module. 

1. Run the following `az storage account create` command in the Cloud Shell to create a storage account for your function and static website.

    ```bash
    az storage account create \
      --name $STORAGE_ACCOUNT_NAME \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --kind StorageV2 \
      --sku Standard_LRS
    ```

    It can take a few minutes to create a storage account. Wait for this step to finish before proceeding.

## Create a Cosmos DB account

We want to store stock prices in a Cosmos DB database, so let's set that up in our sandbox account here. 

1. Execute the following command in the Cloud Shell to define a name for our CosmosDB account.

    ```bash
    export COSMOSDB_ACCOUNT_NAME=msl-sigr-cosmos-$(openssl rand -hex 5)
    echo "Cosmos DB Account Name: $COSMOSDB_ACCOUNT_NAME"
    ```

    Remember this  account name for the remainder of the module. 

1. Run the following `az cosmosdb create` command in the Cloud Shell to create a new Cosmos DB account in our sandbox resource group. 

    ```bash
    az cosmosdb create  \
      --name $COSMOSDB_ACCOUNT_NAME \
      --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    It can take a few minutes to create a Cosmos DB account. Wait for this step to finish before proceeding.

## Create a SignalR account
We need to add a SignalR account to our sandbox subscription. The first step is to add the SignalR extension to the Azure Command Line Interface (CLI). 

1. To allow access to SignalR, add the extension by running the following command in  the Cloud Shell.

    ```bash
    az extension add -n signalr
    ```

1.  Execute the following command in the Cloud Shell to define a name for our Azure Storage account.

    ```bash
    export SIGNALR_ACCOUNT_NAME=msl-sigr-signalr$(openssl rand -hex 5)
    echo "SignalR Account Name: $SIGNALR_ACCOUNT_NAME"
    ```

    Keep note of  this  account name for the remainder of the module. 

1. Run the following command in the Cloud Shell to create a new SignalR account in the sandbox resource group.

    ```bash
    az signalr create \
      --name $SIGNALR_ACCOUNT_NAME \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --sku Free_DS2 \
      --unit-count 1
    ```

## Update local settings

For the app to run, you need to add the connection strings and keys associated with your Azure Storage, Functions and database services to your local settings. 

1. Run the following commands in the Cloud Shell  to get the connection strings for the resources we created in this exercise.

    ```bash
    STORAGE_CONNECTION_STRING=$(az storage account show-connection-string \
      --name $STORAGE_ACCOUNT_NAME \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query "connectionString" -o tsv)

    COSMOSDB_CONNECTION_STRING=$(az cosmosdb list-connection-strings  \
      --name $COSMOSDB_ACCOUNT_NAME \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" -o tsv)

    COSMOSDB_MASTER_KEY=$(az cosmosdb list-keys \
    --name $COSMOSDB_ACCOUNT_NAME \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --query primaryMasterKey -o tsv)

    SIGNALR_CONNECTION_STRING=$(az signalr key list \
      --name $SIGNALR_ACCOUNT_NAME \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query primaryConnectionString -o tsv)

    echo "<STORAGE_CONNECTION_STRING> = $STORAGE_CONNECTION_STRING"
    echo "<COSMOSDB_CONNECTION_STRING> = $COSMOSDB_CONNECTION_STRING"
    echo "<COSMOSDB_MASTER_KEY> = $COSMOSDB_MASTER_KEY"
    echo "<SIGNALR_CONNECTION_STRING> = $SIGNALR_CONNECTION_STRING"
    ```

1. Navigate to where you cloned the application and open the **start** folder in Visual Studio Code. Open **local.settings.json** in the editor so you can update the file.

1. In **local.settings.json**, update the variables `AzureWebJobsStorage`, `AzureCosmosDBConnectionString`, `AzureCosmosDBMasterKey` and `AzureSignalRConnectionString` with the values listed in the Cloud Shell and save the file.

## Run the application

1. In the VS Code terminal window, run the following command to install dependencies and set up the database:

    ```bash
    npm install
    ```

    > [!NOTE]
    > If there is a problem during the install process and the database is not correctly setup, you can run `npm run setup` to manually seed the database.

1. Press F5 to start debugging the function app.

1. To run the web application on your machine, open a Visual Studio Code's integrated terminal and run the command `npm start`.

    ```bash
    npm start
    ```

1. Navigate to *http://localhost:8080* to see the application in the browser.

    ![Beginning state of serverless web app](../media/serverless-app-beginning-state.png)


1. Return to Visual Studio Code and enter the the following command in the integrated terminal to update the stock prices. Observe that the values in the browser updates after a few seconds too. 

    ```bash
    npm run update
    ```
<!-- REVIEW - I would add in an instruction here to tell the learner how to update the  ABC stock price or add another one to the database, so we can see an update happening. I might be tempted to increase the polling delay so we can really see how polling has the potential to delay updates reaching the client -->