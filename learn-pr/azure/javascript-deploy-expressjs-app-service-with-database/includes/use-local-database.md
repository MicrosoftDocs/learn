Use the Azure Cosmos DB emulator while you locally develop your JavaScript application. 

## Adding MongoDB to an Express.js app

In order to add MongoDB to a Node.js app, such as Express.js, the complete connection requires:

* Connection data: adding the MongoDB connection string, database name and collection name to the app. You'll complete this step next.
* NPM package: Adding an appropriate npm package to connect to your remote MongoDB database. This module uses the native MongoDB driver, specified in the package.json file. 
* JavaScript code: Adding MongoDB API code to your Express.js app. This code is already provided for you. 

## MongoDB connection data

Connection data for this sample app is contained in the `.env` file. You need to set the following values to connect the Express.js data web app to a database:

* MONGODB_URI_CONNECTION_STRING
* MONGODB_URI_DATABASE_NAME
* MONGODB_URI_COLLECTION_NAME

## Develop MongoDB apps locally

You can develop apps locally with MongoDB without having to install a MongoDB server if use use Windows or you use Docker containers. The following table lists some of your choices.

|OS|Tools|
|--|--|
| Windows |[Azure Cosmos DB Emulator](/azure/cosmos-db/local-emulator)<br>[Visual Studio Code dev container](https://code.visualstudio.com/docs/remote/create-dev-container#_automate-dev-container-creation)|
| Linux/macOS|[Windows container for Cosmos DB emulator](/azure/cosmos-db/local-emulator-on-docker-windows?tabs=cli)<br>[Visual Studio Code dev container](https://code.visualstudio.com/docs/remote/create-dev-container#_automate-dev-container-creation)|

## Azure Cosmos DB Emulator 

The [Azure Cosmos DB Emulator](/azure/cosmos-db/local-emulator) for Windows provides a local environment that emulates the Azure Cosmos DB API for MongoDB for development purposes. Using the Azure Cosmos DB Emulator, you can develop and test your application locally, without creating an Azure subscription or incurring any costs. 

## Docker containers

If you don't use Windows, you can still have a local MongoDB database with one of the following choices, both rely on your local computer supporting Docker containers:

* [Windows container for Cosmos DB emulator](/azure/cosmos-db/local-emulator-on-docker-windows?tabs=cli)
* [Visual Studio Code dev container](https://code.visualstudio.com/docs/remote/create-dev-container#_automate-dev-container-creation) for Node.js and Mongo DB. This option starts both the Express.js app and the MongoDB in containers. You will need to open the ports for each environment to interact with both from your local computer:
    * Express.js port for sample application: 8080
    * MongoDB port: 27017 

## How does the Cosmos DB emulator work?

The Azure Cosmos DB Emulator provides a high-fidelity emulation of the Azure Cosmos DB service. It supports equivalent functionality as the Azure Cosmos DB, which includes creating data, querying data, provisioning and scaling containers. 

Functionality that relies on the Azure infrastructure like global replication, single-digit millisecond latency for reads/writes, and tunable consistency levels are not applicable when you use the emulator.

## Moving data between the emulator and Cosmos DB

If you need to move data between the local emulator and Cosmos DB, use the [Azure Cosmos DB Data Migration Tool](https://github.com/azure/azure-documentdb-datamigrationtool). 