Run a local MongoDB server to develop your data application. 

## Start a local database


<!--
Select a process based on your operating system.
# [Windows - Cosmos DB emulator](#tab/windows)

1. [Download](https://aka.ms/cosmosdb-emulator) and install the Cosmos DB emulator. You may need to restart your computer.
1. Start a Windows command prompt or terminal as an administrator.
1. In the terminal, start the emulator with the following command:

    ```terminal
    Microsoft.Azure.Cosmos.Emulator.exe /EnableMongoDbEndpoint /Key=C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw== /DataPath=%LocalAppdata%\CosmosDBEmulator
    ```

    The key is only for the emulator and will not work for connections to the Azure Cloud.

1. When it is started, it appears in the System tray. 
1. In the System tray, open the emulator and select **Open Data Explorer**.
1. In the emulator, select the **Quickstart** tab and copy the **Mongo Connection String**. 
1. Paste this connection string into the `.env` file for the **MONGODB_URI_CONNECTION_STRING** variable.

# [macOS/Linux - MongoDB dev container](#tab/macos-linux)
-->
1. In Visual Studio Code, select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Search for **Remote-Containers: Reopen in Container**. 
1. Wait until the web and database containers are started and the integrated terminal shows the container's prompt.
1. Paste the following connection string into the `.env` file for the **MONGODB_URI_CONNECTION_STRING** variable. 

    |MongoDB container connection string|
    |--|
    |mongodb://127.0.0.1:27017|

<!--
---
-->

## Set the database name and collection

In Visual Studio Code, open the `.env` file and add the database name and collection name:

|Name|Value|
|--|--|
|MONGODB_URI_DATABASE_NAME|`js-rentals`|
|MONGODB_URI_COLLECTION_NAME|`rentals`|


## Upload sample data to local database

The sample comes with 6 rental properties of information. Select a process based on your operating system to upload the data.

1. In Visual Studio Code, select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Search for **Remote-Containers: Reopen in Container**. 
1. Wait until the web and database containers are started and the integrated terminal shows the container's prompt.
1. Paste the following connection string into the `.env` file for the **MONGODB_URI_CONNECTION_STRING** variable. 

## Run local web app

Start the local web app to verify it connects to the database:

```bash
npm start
```


## Check your work

* The local MongoDB container is running.
* The sample data is uploaded.

