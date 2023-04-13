To understand the deployment process, this module provides an Express.js sample. You need to fork it on GitHub and then clone it to your local computer. After the source code is on your local computer, you'll deploy the app to Azure App Service from Visual Studio Code.

In this exercise, you'll:

* Fork the GitHub sample repository.
* Clone your fork to your local computer.
* Deploy the sample from your local computer to App Service.

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

## Browse the repository folders

The local project has several folders. Each folder represents a Learn module. The **2-Deploy-basic-app-to-azure** folder has the code that you'll deploy to App Service. Ignore the other folders for now.

1. Expand the **2-Deploy-basic-app-to-azure** folder to view the Express.js files.
1. Open `package.json` to understand what dependencies App Service installs as part of the app:

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

1. Notice that the `package.json` file has a `start` script used by the deployment process to start the app.

## Deploy the sample from your local computer to App Service

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. In the **Resources** section, find and expand the subscription's **App Service** node.
1. The app you created in the previous exercise, such as `jimb-rentals`, should be listed.
  
   If the app isn't listed, try the following steps:
  
   1. At the top of this Learn unit, check that you still have time for your sandbox.
   1. In Visual Studio Code, sign out of Azure. Then sign in again to make sure all subscriptions are displayed.
1. Right-click the app and select **Deploy to Web App**.
1. Browse to the subfolder **2-Deploy-basic-app-to-azure** and select it.
1. When you're asked if you want to deploy, select **Deploy**.
1. Select the **output window** option when it appears.
1. Notice that the deployment status appears with date/time stamps and actions.

1. The deployment is complete when you see something like the following lines in the **output** terminal:

    |Log lines|
    |--|
    |3:08:19 PM jimb-rentals: Deployment successful.|
    |3:08:29 PM: Deployment to "jimb-rentals" completed.|

## Check your work

The sample Express.js is successfully deployed to Azure. In this exercise:

* You forked and then cloned the GitHub sample repository.
* You deployed a subfolder of your local forked repository to App Service.
