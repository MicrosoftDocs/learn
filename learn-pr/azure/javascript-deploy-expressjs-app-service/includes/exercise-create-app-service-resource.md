When you create your own instance of an Azure service, it's called a resource. Before you create your resource, you need to know information like the pricing tier and the Azure geographical region of the cloud.

In this exercise, you'll create an Azure App Service resource.

As part of the resource creation, these resources are created for you:

* An App Service plan resource.
* An Azure Monitor (Azure Application Insights) resource.

## Create the resource from Visual Studio Code

1. Open Visual Studio Code.
1. To open the **Azure** pane on the left, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. In the **Resources** section, right-click the sandbox subscription name. 
1. Right-click on **App Services** and select **Create New Web App (Advanced)**. By selecting the advanced creation process.
1. Use the following table to answer the creation steps:

    | Step | Value|
    | -- | -- |
    |Globally unique name|Prepend your email alias to the string `-rentals`. An example is `jimb-rentals`.|
    |Resource group|Select the default.|
    |Runtime stack| Select one of the Node LTS versions.|
    |OS|Select **Linux**.|
    |Location|Select a location geographically close to you.|
    |App Service plan|Create a new plan and select the default name.|
    |Pricing tier|Confirm the tier is Free.|
    |Application Insights|Create a new Application Insights resource and select the default name.|

1. When you're finished, the new web app appears in the **Resources > App Service** node of the **Azure** pane on the left.
1. Expand the web app to see the subnodes:

    |Subnode|Purpose|
    |--|--|
    |Application settings|Environment variables as name/value pairs. <br><br>Expand this node and notice the `APPINSIGHTS_INSTRUMENTATIONKEY` key stored as the Application Insights key. This key is useful when you add custom logging with the `applicationinsights` npm package.<br><br> Notice that `SCM_DO_BUILD_DURING_DEPLOYMENT` is created and set to *true*. This setting allows your Linux or Node.js deployment to install npm dependencies.|
    |Databases|If you create your database at the same time as you create your web app, the database is listed here. *This feature isn't used in this module.*|
    |Deployments|Shows a list of deployments. Deployments are covered in the next exercise of this module.|
    |Files| Files deployed to your resource. Before you deploy your app, the `hostingstart.html` file is returned for any requests.|
    |Logs|This location is where your running app's logs are stored. You might look at these logs if you deploy an app that requires environment variables or npm modules to run but they aren't correctly specified. The app won't start up correctly.|
    |WebJobs|WebJobs are not available for Linus Apps.|
    |Deployment slots|*This feature isn't used in this module.*|

1. Expand the **Files** section to see the **hostingstart.html** file.
1. Open the file. This file is a basic HTML page that appears until you deploy the app.

    > [!TIP]
    > When you're still working on your project and not ready to show it, create a new slot named `temporary` with a custom version of this file. The custom version can be branded. If you have deployment or app issues, you can switch to the `temporary` slot while you resolve your issues.

1. Expand the **Logs** section to see the various logs. This section will be more interesting after your first deployment.

## Enable Application Insights logging

When you created the resource, you also created and connected Application Insights, but it isn't enabled.

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. In the **App Service** section, right-click your App Service resource. Select **Open in Portal**.
1. In the web browser, select **Settings** > **Application Insights**.
1. Select **Turn on Application Insights**.
1. Select **Apply** to send metrics and log collections to Application Insights.

## Check your work

Now you have an App Service plan with a single App Service instance and its monitoring resource. Before you deploy your own app, your resource's default app is available at the public URL. In this exercise:

* You created your web app, its plan, and the logging resource (Application Insights).
* You reviewed the default HTML file.
* You enabled logging to Application Insights.
