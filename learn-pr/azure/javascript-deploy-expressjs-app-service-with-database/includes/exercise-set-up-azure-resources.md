Create the Azure web app and monitoring resources. The Cosmos DB resource is created later in this module.

## Sign in to the Learn sandbox

Select the **Sign in to activate sandbox** button (above) to sign in. This step might include reviewing permissions. When you see **Sandbox activated!** with a time remaining on this page, this step is complete.

Make sure you use the same user account to sign in both of the following:
* Learn sandbox
* Azure, from Visual Studio Code.

The following Learn sandbox information may be useful to troubleshoot connection issues that may occur as you continue through the module:

|Name|Value|
|--|--|
|Azure cloud|AzureCloud|
|Tenant|604c1504-c6a3-4080-81aa-b33091104187|
|Subscription name|Concierge Subscription|
|Subscription Id|2e3431a6-9673-485f-a9d9-2296d848d530|

## Find the subscription in Visual Studio Code

Find the free sandbox subscription in Visual Studio Code.

1. Open Visual Studio Code.
1. Select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Select **Azure: Select Tenant**. 
1. Select **Enter custom tenant** and copy the tenant from the previous table and paste it into the box in Visual Studio Code.
1. The notification box displays letting you know you need to sign out to switch tenants. Select **Sign out**.
1. Select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Select **Azure: Sign In to Azure Cloud** to complete the sign-in process.
1. If a listing of Azure clouds appears, select **Azure Cloud**.
1. After the process is finished, your account appears in the bottom bar. An example is `Azure: youremail@mail.com`.
1. Select your account in the bottom bar and filter the list of subscriptions.
1. Enable the sandbox subscription **Concierge Subscription**. Clear any other subscription checkboxes so that you can focus while you complete this module.

## Create the resource from Visual Studio Code

1. Open Visual Studio Code.
1. To open the **Azure** pane on the left, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. In the **App Service** section, right-click the sandbox subscription name. Select **Create New Web App (Advanced)**. By selecting the advanced creation process, you can select _all_ your choices.
1. Use the following table to answer the creation steps:

    | Step | Value|
    | -- | -- |
    |Globally unique name|Prepend your email alias to the string `-rentals`. An example is `jimb-rentals`.|
    |Resource group|Select the default.|
    |Runtime stack| Select one of the Node LTS versions.|
    |OS|Select **Linux**.|
    |Location|Select a location geographically close to you.|
    |App Service plan|Create a new plan and select the default name.|
    |Pricing tier|Confirm the tier is Free, F1.|
    |Application Insights|Create a new Application Insights resource and select the default name.|

1. When you're finished, the new web app appears in the **App Service** section of the **Azure** pane on the left.
1. Expand the web app to see the subnodes:

    |Subnode|Purpose|
    |--|--|
    |Application settings|Environment variables as name/value pairs. <br><br>Expand this node and notice the `APPINSIGHTS_INSTRUMENTATIONKEY` key stored as the Application Insights key. This key is useful when you add custom logging with the `applicationinsights` npm package.<br><br> Notice that `SCM_DO_BUILD_DURING_DEPLOYMENT` is created and set to true. This setting allows your Linux or Node.js deployment to install npm dependencies.|
    |Databases|If you create your database at the same time as you create your web app, the database is listed here. *This feature isn't used in this module.*|
    |Deployments|Shows a list of deployments. Deployments are covered in the next exercise of this module.|
    |Files| Files deployed to your resource. Before you deploy your app, the `hostingstart.html` file is returned for any requests.|
    |Logs|This location is where your running app's logs are stored. You might look at these logs if you deploy an app that requires environment variables or npm modules to run but they aren't correctly specified. The app won't start up correctly.|
    |Deployment slots|*This feature isn't used in this module.*|


## Enable Application Insights logging

When you created the resource, you also created and connected Application Insights, but it isn't enabled.

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. In the **App Service** section, right-click your App Service resource. Select **Open in Portal**.
1. In the web browser, select **Settings** > **Application Insights**.
1. Select **Turn on Application Insights**.
1. Select **Apply** to send metrics and log collections to Application Insights.

## Deploy the sample from your local computer to App Service

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. In the **App Service** section, find and expand the subscription's App Service resource.
1. The app you created in the previous exercise, such as `jimb-rentals`, should be listed.
   
   If the app isn't listed, try the following steps:
   
   1. At the top of this Learn unit, check that you still have time for your sandbox.
   1. In Visual Studio Code, sign out of Azure. Then sign in again to make sure all subscriptions are displayed.
1. Right-click the app and select **Deploy to Web App**.
1. Select the **3-Add-cosmosdb-mongodb** and select it.
1. When you're asked if you want to deploy, select **Deploy**.
1. Select the **output window** option when it appears.
1. Notice that the deployment status appears with date/time stamps and actions.

1. The deployment is complete when you see something like the following lines in the **output** terminal:

    |Log lines|
    |--|
    |3:08:19 PM jimb-rentals: Deployment successful.|
    |3:08:29 PM: Deployment to "jimb-rentals" completed.|

## View your web app

1. In Visual Studio Code, using the **Azure** pane, right-click the **js-rentals** web app and select **Browse website**.
1. The deployed web app opens in a browser. The web app should display the same error message that the database isn't connected. This is the correct state of the app.

## Check your work

The sample application is deployed to the Azure cloud. 

* The web app resource is created.
* The web app displays in a browser. 