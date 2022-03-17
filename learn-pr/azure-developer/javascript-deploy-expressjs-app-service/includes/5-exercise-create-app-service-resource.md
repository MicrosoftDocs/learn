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
    |Globally unique name|To ensure global uniqueness and to have an easy URL (the name is part of the URL), choose a name like `YOUR-EMAIL-ALIAS-rentals`, for example `jimb-rentals`.|
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
    Application Settings: for environment variables
    * Databases: not used in this module
    * Deployments: that is covered in the next exercise of this module
    * Files: expand this section to see the **hostingstart.html** file. Open the file. This is a basic HTML page that displays until you deploy the app. 
    * Logs: this is where your running app's logs are stored. A common reason you would look at these logs is if you deploy an app that requires environment variables or npm modules to run but those aren't correctly specified. The app won't start up correctly


