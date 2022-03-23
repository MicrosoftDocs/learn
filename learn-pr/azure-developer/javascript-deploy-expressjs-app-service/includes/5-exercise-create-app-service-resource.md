## Your tasks

In this exercise, you need to: 

* Create the App Service resource.

As part of the resource creation, these resources are created for you:
* An App Service Plan resource.
* An Application Insights resource.

## Create the resource from Visual Studio Code

1. Open Visual Studio Code.
1. In Visual Studio Code, use the key combination to open the **Azure** sidebar: <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. In the **App Service** section, right-click on the sandbox subscription name and select **Create New Web App... (Advanced)**. By selecting the advanced creation process, you can select _all_ of your choices.
1. Use the following table to answer the creation steps:

    | Step | Value|
    | -- | -- |
    |Globally unique name|Prepend your email alias to the string `-rentals`. For example, `jimb-rentals`.|
    |Resource group|Select the default.|
    |Runtime stack| Select one of the Node LTS versions.|
    |OS|Select **Linux**.|
    |Location|Select a location geographically close to you.|
    |App Service Plan|Create a new plan and select the default name.|
    |Pricing tier|Free|
    |Application Insights|Create a new Application Insights resource and select the default name.|

1. When creation is finished. You'll see the new web app listed in the App Service section of the Azure sidebar. 
1. Expand the web app to see the subnodes:

    |Subnode|Purpose|
    |--|--|
    |Application Settings|Environment variables as name/value pairs. <br><br>Expand this node and notice the `APPINSIGHTS_INSTRUMENTATIONKEY` key stored the Application Insights key. This is useful when you add custom logging with the `applicationinsights` npm package.<br><br> Notice the `SCM_DO_BUILD_DURING_DEPLOYMENT` is created and set to true. This setting allows your Linux/Node.js deployment to install npm dependencies.|
    |Databases|If you create your database at the same time as you create your web app, the database is listed here. NOT USED IN THIS MODULE.|
    |Deployments|Shows a list of deployments. That is covered in the next exercise of this module.|
    |Files| Files deployed to your resource. Before you deploy your app, there's one file, `hostingstart.html`, which is returned for any requests.|
    |Logs|This is where your running app's logs are stored. A common reason you would look at these logs is if you deploy an app that requires environment variables or npm modules to run but those aren't correctly specified. The app won't start up correctly.|
    |Deployment Slots|NOT USED IN THIS MODULE DUE TO LIMITATIONS OF LEARN SANDBOX PRICING TIER.|

1. Expand the **Files** section to see the **hostingstart.html** file. 
1. Open the file. This is a basic HTML page that displays until you deploy the app. 

    **TIP**: When you're still working on your project and not ready to show it, create a new slot named `temporary` with a custom version of this file. The custom version can be branded. If you have deployment or app issues, you can swap over to the `Temporary` slot quickly while you resolve your issues. 

1. Expand the **Logs** section to see the various logs. This section will be more interesting after your first deployment.

## Enable Application Insights logging

When you created the resource, you also created and connected Application Insights but it isn't enabled. 

1. In Visual Studio Code, open the Azure side bar: <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. In the App Service section, right-click your App Service resource, and select **Open in Portal**.
1. In the web browser, select **Settings > Application Insights**.
1. Select **Turn on Application Insights**.
1. Select  **Apply** to send metrics and log collections to Application Insights.

## What did this exercise accomplish? 

* You created your web app, its plan, and the logging resource (Application Insights).
* You reviewed the default HTML file.
* You enabled logging to Application Insights.