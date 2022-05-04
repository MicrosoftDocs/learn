In this unit, setup the local development environment for MongoDB. While it isn't required that you have a local database when using Azure Cosmos DB API for MongoDB, it is a common practice. 

## Developing with local or remote databases

This module uses a local database for local development. This is beneficial because:
* It doesn't incur any cost.
* It doesn't usually require any special security configuration initially to use.
* You can develop your Express.js application without the need for cloud resources.

The sample application expects MongoDB 4.2+.

## Installing a local MongoDB server

You can use a local MongoDB server as one of the following:

* Install MongoDB on your local computer.
* Use a MongoDB container on your local computer

## Install MongoDB on your local computer

You can install MongoDB Community edition locally then connect to the local server from Visual Studio. When you install locally, then start MongoDB.

## Use a MongoDB container on your local computer

The Visual Studio Code **Node.js + MongoDB** dev container allows you to run both the Express.js app and the database in separate containers. You expose the ports for each container (8080 for web, 27017 for MongoDB) to access the containers from your local (_host_) computer.

You can start up the container from Visual Studio Code, with the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)  extension. 

You can upload data into the container's MongoDB server on the dev container, and work with the data using the [MongoDB for VS Code](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode) extension.

## Adding MongoDB to an Express.js app

In order to add MongoDB to a Node.js app, such as Express.js, the complete connection requires:

* Connection data: adding the MongoDB connection string, database name and collection name to the app in the `.env` file. You complete this step in the next exercise.
* NPM package: Adding an appropriate npm package to connect to your remote MongoDB database. This module uses the native MongoDB driver, specified in the package.json file. 
* JavaScript code: Adding MongoDB API code to your Express.js app. This code is already provided for you. 

## MongoDB connection data

Connection data for this sample app is contained in the `.env` file. You need to set the following values to connect the Express.js data web app to a database:

* MONGODB_URI_CONNECTION_STRING=mongodb://127.0.0.1:27017
* MONGODB_URI_DATABASE_NAME=js-rentals
* MONGODB_URI_COLLECTION_NAME-rentals
