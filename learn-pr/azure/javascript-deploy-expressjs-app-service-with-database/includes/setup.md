In this section, you need to setup the web app.

## Express.js local and remote development

The sample app is provided for you. You need to fork the GitHub repository, then clone your fork to bring a copy of the sample application to your local computer. To access the local Express.js app, use port 8080 in the URL. For example, this sample application's URL is: `http://localhost:8080/`.

## Use Visual Studio Code dev container

In order to use the MongoDB database, this module uses the Visual Studio Code dev container for Node.js + MongoDB. This allows you to quickly use a MongoDB locally without having to understand how to correctly install it. 

The result of this dev container is that once it is started, you won't need to understand how it works in order to develop your web app and have access to your local MongoDB database. 

To access the web app and database, the sample app has already configured the `./.devcontainer/devcontainer.json` file's **forwardPorts** setting to forward the 8080 and 27017 ports to your local host computer.

## Learn sandbox 

The Learn sandbox allows you to create and use Azure resources with no cost to you and without any credit card. The Learn sandbox is contained in a separate tenant. Once you have access to that tenant, you can create the Azure resources used in this module. 

## Visual Studio Code extensions

To create and manage those Azure resources and your local MongoDB database, install Visual Studio Code extensions. This allows you to manage those resources from within Visual Studio Code. 

