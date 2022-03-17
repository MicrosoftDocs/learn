In this exercise, you need to: 

* Create the App Service resource

As part of the resource creation, you will also create:
* An App Service Plan resource
* An Application Insights resource

## Create resource in Visual Studio Code

1. Open Visual Studio Code.
1. In Visual Studio Code, use the key combination to open the **Azure** sidebar: <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A<kbd>.
1. In the **App Service** section, right-click on the sandbox subscription name and select **Create New Web App... (Advanced)**. By selecting the advanced creation process, you can select all your choices.
1. Use the following table to answer the creation steps:

    | Step | Value|
    | -- | -- |
    |Globally unique name|To ensure global uniqueness and to have an easy URL (the name is part of the URL), choose a name like `YOUR-EMAIL-ALIAS-rentals`, for example `jimb-rentals`. The URL would be `https://jimb-rentals.azurewebsites.net/`.|
    |Resource group|Select the default.|
    |Runtime stack| Select one of the Node LTS versions.|
    |OS|Select **Linux**.|
    |Location|Select a location geographically close to you.|
    |App Service Plan|Create a new plan and select the default name.|
    |Pricing tier|Free|
    |Application Insights|Create a new resource and select the default name.|

1. When creation is finished. You'll see the new web app listed in the App Service section of the Azure sidebar. 
1. Expand the web app to see the subnodes:

    |Subnode|Purpose|
    |--|--|
    |Application Settings|Environment variables as name/value pairs|
    |Databases|If you create your database at the same time as you create your web app, the database is listed here. NOT USED IN THIS MODULE.|
    |Deployments|Shows a list of deployments. That is covered in the next exercise of this module.|
    |Files| Files deployed to your resource.|
    |Logs|This is where your running app's logs are stored. A common reason you would look at these logs is if you deploy an app that requires environment variables or npm modules to run but those aren't correctly specified. The app won't start up correctly.|
    |Deployment Slots|Typically used for versions of your app such as stage, test, etc. The original slot is always the product slot. Any additional slots use the original name then the slot name, such as `jimb-rentals-stage` and the name and slow become part of the URL, `https://jimb-rentals-stage.azurewebsites.net/`. Deployment slots require a product plan. NOT USED IN THIS MODULE.|

1. Expand the **Files** section to see the **hostingstart.html** file. 
1. Open the file. This is a basic HTML page that displays until you deploy the app. 

    **TIP**: When you're still working on your project and not quite ready to show it, create a new slot named `temporary` with a custom version of this file. The custom version can be branded. If you have deployment or app issues, you can swap over to the `Temporary` slot quickly while you resolve your issues. 

1. Expand the **Logs** section to see the various logs. This section will be more interesting after your first deployment.

## What did this exercise accomplish? 

* You created your web app, its plan, and the logging resource (Application Insights).
* You learned about the default HTML file and the deployment slots.