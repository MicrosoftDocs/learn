In this Learn module, you'll integrate a web app with MongoDB and deploy to Azure. **Azure Cosmos DB API for MongoDB** provides a MongoDB compatible layer. You can use your favorite npm client packages for MongoDB and store your data on Azure.

## Example scenario

Suppose you're a web developer or DevOps engineer who needs to deploy a data web app to Azure. You're an experienced developer, but you're new to Azure.

You'll learn how to deploy and configure the Azure database resource you need to deploy a data web app. The data web app is a rental property app used by a company to help its employees relocate when needed. The app displays rental properties and property information.

:::image type="content" source="../media/rental-app-website-browser.png" alt-text="Screenshot of web browser that shows the main listings of a rental app.":::

The rental property data web app is built with Express.js and MongoDB. The user interface is created with simple JavaScript and served from the Express.js server in order to focus on the core lesson of Azure service creation, configuration, and deployment. 

The entire source code is provided as part of this module. You won't be required to change the code.

## What will you be doing?

You'll deploy an Express.js app to Azure App Service, then create the database in Cosmos DB and configure the connection between the web app and the database. In order to understand each piece, the module includes a typical developer journey.

These steps include:

- Use an Azure subscription - the free Learn sandbox subscription is provided with no credit card needed.
- Set up local development environment with the sample project and local database.
- Create Azure web app resources and deploy web app.
- Create database resource and upload data.
- Configure the web app to connect to the database.

## What is the main goal?

By the end of this module, you'll be able to create and integrate a MongoDB database, using Cosmos DB API for MongoDB, into an Express.js web app and configure your App Service resource to use that database.