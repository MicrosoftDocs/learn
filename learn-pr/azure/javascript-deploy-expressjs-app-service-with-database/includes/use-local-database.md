In this unit, setup the local development environment for an Express.js app integrated with MongoDB.

## Developing with local or remote databases

This module uses a local database for local development. This is beneficial because it doesn't incur any cost and doesn't usually require any special security configuration. 

You can develop your Express.js application without the need for cloud resources and know that your work isn't impacting a production database.

## Requirements for local development

To develop the Express.js app with integration to a MongoDB database, your local development environment needs to have:

* Node.js and Visual Studio Code.
* Local MongoDB data storage. 
    * For Windows, use the Cosmos DB emulator.
    * For macOS/Linux, use the MongoDB dev container. This requires Docker. 

## Windows - Cosmos DB emulator

For Windows operating system users, use the Cosmos DB emulator. You can upload data into the emulator, work with the data from your Express.js via a connection string, and [migrate data](https://github.com/azure/azure-documentdb-datamigrationtool) from the emulator to Cosmos DB when you are ready. 

### How does the Cosmos DB emulator work?

The Azure Cosmos DB Emulator provides a high-fidelity emulation of the Azure Cosmos DB service. It supports equivalent functionality as the Azure Cosmos DB, which includes creating data, querying data, provisioning and scaling containers. 

Functionality that relies on the Azure infrastructure like global replication, single-digit millisecond latency for reads/writes, and tunable consistency levels are not applicable when you use the emulator.

### Moving data between the emulator and Cosmos DB

If you need to move data between the local emulator and Cosmos DB, use the [Azure Cosmos DB Data Migration Tool](https://github.com/azure/azure-documentdb-datamigrationtool). 

## macOS/Linux - MongDB dev container

For macOS and Linux users, use dev containers on your local computer. The Visual Studio Code **Node.js + MongoDB** dev container allows you to run both the Express.js app and the database in separate but linked containers. You expose the ports for each container (8080 for web, 27017 for MongoDB) to access the containers from your host computer

You can start up the container from Visual Studio Code, with the [Remote - Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers). 

You can upload data into the MongoDB server on the dev container, work with the data from your Express.js via a connection string, and [migrate data](https://github.com/azure/azure-documentdb-datamigrationtool) from the container to Cosmos DB when you are ready.

Use the Azure Cosmos DB emulator while you locally develop your JavaScript application. 

## Adding MongoDB to an Express.js app

In order to add MongoDB to a Node.js app, such as Express.js, the complete connection requires:

* Connection data: adding the MongoDB connection string, database name and collection name to the app.
* NPM package: Adding an appropriate npm package to connect to your remote MongoDB database. This module uses the native MongoDB driver, specified in the package.json file. 
* JavaScript code: Adding MongoDB API code to your Express.js app. This code is already provided for you. 

## MongoDB connection data

Connection data for this sample app is contained in the `.env` file. You need to set the following values to connect the Express.js data web app to a database:

* MONGODB_URI_CONNECTION_STRING
* MONGODB_URI_DATABASE_NAME
* MONGODB_URI_COLLECTION_NAME
