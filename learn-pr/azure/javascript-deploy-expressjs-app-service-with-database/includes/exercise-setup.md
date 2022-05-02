In this exercise, you'll set up your local development environment. This isn't required to use the Azure cloud. 

## Install Node.js and Docker

If you don't have Node.js and Docker on your local computer, install them.

* [Node.js](https://nodejs.org/)
* [Docker](https://docs.docker.com/get-docker/) - to use a local MongoDB database

## Fork the GitHub sample repository

1. Open the [GitHub sample](https://github.com/Azure-Samples/msdocs-javascript-nodejs-server) `https://github.com/Azure-Samples/msdocs-javascript-nodejs-server` repository in a new browser tab or window.
1. Select the **Fork** button to create your own fork of the sample repository.

## Clone your fork to your local computer

1. In Visual Studio Code, select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Search for **Git: Clone** and select it.
1. Enter your fork's URL of the sample repository. It should look something like this example:

    |URL|
    |--|
    |https://github.com/YOUR-GITHUB-ALIAS/msdocs-javascript-nodejs-server|

1. Select a local folder on your computer.
1. When asked if you want to open the cloned repository, select **Open**.
1. Visual Studio Code reopens with your local fork of the sample repository.
1. In the Explorer, select the **3-Add-cosmosdb-mongodb** folder and select **Open in Integrated Terminal**.
1. Install the npm packages with the following command. 

    ```bash
    npm install
    ```

1. Close Visual Studio Code then reopen to the **3-Add-cosmosdb-mongodb** folder, so that this folder is the root of the File Explorer for Visual Studio Code. Keep Visual Studio open at this level for the rest of the module. 

> [!Note]
> All files used in this module are in the **3-Add-cosmosdb-mongodb** folder of the sample repo. 

## Sign in to the Learn sandbox

Select the **Sign in to activate sandbox** button to sign in. This step might include reviewing permissions. When you see **Sandbox activated!** with a time remaining on this page, this step is complete.

Make sure you use the same user account to sign in both of the following:
* Learn sandbox
* Azure, from Visual Studio Code.

## Find the subscription in Visual Studio Code

Find the free sandbox subscription in Visual Studio Code.

1. Open Visual Studio Code.
1. Select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Select **Azure: Sign Out**. When you sign in, the Learn sandbox tenant is available.
1. Select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Select **Azure: Sign In to Azure Cloud** to complete the sign-in process.
1. When the listing of Azure clouds appears, select **Azure Cloud**.
1. After the process is finished, your account appears in the bottom bar. An example is `Azure: youremail@mail.com`.
1. Select your account in the bottom bar and filter the list of subscriptions to the sandbox subscription.

    |Subscription name|Value|
    |--|--|
    |**Subscription name**|`Concierge Subscription`|
1. Enable the sandbox subscription **Concierge Subscription**. Clear any other subscription checkboxes so that you can focus while you complete this module.

## Install Azure extensions

In Visual Studio Code, install the following extensions:

* [Azure App Service](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureappservice)
* [MongoDB for VS Code](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode) - to access your local MongoDB database
* [Azure Databases](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-cosmosdb) - to access your remote Cosmos DB database
* [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) - dev containers include Node.js + MongoDB

## Check your work

* In Visual Studio Code, you're:
    * Signed into Azure.
    * File Explorer shows the root with package.json and other sample files
