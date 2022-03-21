In this exercise, you need to: 

* Fork the GitHub sample repository
* Clone your fork to your local computer
* Deploy the sample from your local computer to App Service

## Fork the GitHub sample repository

1. Open the [GitHub sample](https://github.com/Azure-Samples/msdocs-javascript-nodejs-server), `https://github.com/Azure-Samples/msdocs-javascript-nodejs-server`, repository in a new browser tab or window.
1. Find and select the **Fork** button. 

## Clone your fork to your local computer

1. In Visual Studio Code, open the Command palette with <kbd>Cntl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>.
1. Search for `Git: Clone` and select it. 
1. Enter your fork's URL of the sample repository. It should look something like:

    ```console
    https://github.com/YOUR-GITHUB-ALIAS/msdocs-javascript-nodejs-server
    ```

1. Select a local folder on your computer to clone your fork.
1. When you are asked if you want to open the cloned repository, select **Open**. 

    The code is local on your computer. 

## Browse the repository folders

The local project has several folders, each representing a Learn module. The `2-Deploy-basic-app-to-azure` is the code that you will deploy to Azure App Service. Ignore the other folders for now.

1. Open the `2-Deploy-basic-app-to-azure` to view the Express.js files.
1. Open the `package.json` to understand what files the App Service will install as part of the app:

    ```json
    {
      "name": "msdocs-javascript-nodejs-server",
      "version": "0.0.1",
      "type": "module",
      "scripts": {
        "start": "cross-env-shell DEBUG=express:* node index.js",
        "format": "prettier --write ."
      },
      "dependencies": {
        "body-parser": "^1.19.2",
        "cross-env": "^7.0.3",
        "ejs": "^3.1.6",
        "express": "^4.17.2",
        "http-errors": "^2.0.0",
        "method-override": "^3.0.0",
        "multer": "^1.4.4",
        "prettier": "^2.5.1",
        "uuid": "^8.3.2"
      }
    }
    ```

1. Notice that the `package.json` file has a `start` script and dependencies. The deployment process uses the package.json to install the dependencies and start the project. 

## Deploy the sample from your local computer to App Service

1. In Visual Studio Code, open the Azure side bar.
1. In the side bar, select the App Service, find and expand the repository and resource group:

    * **Subscription name**: `Concierge Subscription`
    * **Resource group name**: `<rgn>Sandbox resource group ID</rgn>` 

1. Find the app your created in the previous exercise, such as `jimb-rentals`.
1. Right-click the app and select **Deploy to Web App...*.
1. Browse to and select the subfolder `2-Deploy-basic-app-to-azure`.
1. When asked if you are sure you want to deploy, select **Deploy**.
1. When the notification displays with the option to check **output window**, select it.
1. The deployment status displays with datetime stamps and actions. 

1. When you see something like the following lines in the **output** terminal, the deployment is complete: 

    ```console
    3:08:19 PM jimb-rentals: Deployment successful.
    3:08:29 PM: Deployment to "jimb-rentals" completed.
    ```


## What did this exercise accomplish? 

* You forked then cloned the GitHub sample repository.
* You deployed a subfolder of your local forked repository.
