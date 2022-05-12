In this exercise, you'll set up your local development environment. This isn't required to use the Azure cloud but is helpful for a better understanding of developing for Azure.

## Install required development tools

If you don't have Node.js and Visual Studio Code already on your local computer, install them now.

* [Node.js](https://nodejs.org/)
* [Visual Studio Code](https://code.visualstudio.com/download)

## Install Azure extensions

In Visual Studio Code, install the following extensions:

* [Azure App Service](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureappservice) - manage web app hosting 
* [MongoDB for VS Code](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode) - to access your local MongoDB database
* [Azure Databases](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-cosmosdb) - to access your remote Cosmos DB database
* [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) - dev containers include Node.js + MongoDB

## Download sample Express.js application

You can bring the sample application to your local computer in one of several ways:

* Download zipped GitHub repository
* Fork and clone GitHub repository

### [Download zipped repo](#tab/download-zip)

1. Open the [GitHub sample](https://github.com/Azure-Samples/msdocs-javascript-nodejs-server) `https://github.com/Azure-Samples/msdocs-javascript-nodejs-server` repository in a new browser tab or window.
1. Select the **Code** button, then select **Download ZIP**.
1. Find the downloaded zip file on your local computer.
1. Expand the contents. You may want to move it to a different location on your computer.

### [Clone repo](#tab/clone-repo)

1. Open the [GitHub sample](https://github.com/Azure-Samples/msdocs-javascript-nodejs-server) `https://github.com/Azure-Samples/msdocs-javascript-nodejs-server` repository in a new browser tab or window.
1. Select the **Fork** button to create your own fork of the sample repository.
1. In Visual Studio Code, select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Search for **Git: Clone** and select it.
1. Enter your fork's URL of the sample repository. It should look something like this example:

    |URL|
    |--|
    |https://github.com/YOUR-GITHUB-ALIAS/msdocs-javascript-nodejs-server|

---

## Open local sample 

1. Open Visual Studio then open the sample repository folder's subfolder **3-Add-cosmosdb-mongodb**.
1. Open an integrated terminal, and install the npm packages with the following command. 

    ```bash
    npm install
    ```

1. Run the following command to start the app.

    ```bash
    npm run start:dev
    ```

1. Open the app in a browser.

    ```
    http://localhost:8080
    ```

1. The error shows that the database is refusing the connection. This makes sense because there isn't a database yet. You'll fix that later in the module.

    :::image type="content" source="../media/browser-screenshot-local-app-start-without-database.png" alt-text="Screenshot of web app showing the MongoDB connection error.":::

1. Stop the application with <kbd>Ctrl</kbd> + <kbd>c</kbd>.

> [!Note]
> All files used in this module are in the **3-Add-cosmosdb-mongodb** folder of the sample repo. 

## Check your work

* The **3-Add-cosmosdb-mongodb** project is open in Visual Studio Code. 
* You've successfully run the web project, which returned a MongoDB connection error.
