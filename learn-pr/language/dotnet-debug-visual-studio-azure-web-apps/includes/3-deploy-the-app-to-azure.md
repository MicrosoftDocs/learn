In order to work through a remote debugging exercise with App Service you will first need to deploy an application to Azure. For this scenario you can either deploy your own app or clone the sample GitHub project below.

```Bash
    git clone "https://..."
```

The sample project uses Razor Pages to display an RSS feed from the official Microsoft blog in a table. Most of the relevant code for the app can be found in the `OnGet` method inside the `Index.cshtml.cs` file. The code essentially pulls the URL of the RSS feed from the `appsettings.json` file, retrieves the feed using an XmlReader, and then maps it to friendly list for display.  Those items are then rendered using a foreach loop and a table in the `Index.cshtml` file.

You can start the app locally by pressing the run button inside of Visual Studio. The feed should load and display correctly and give you an idea of what the app should look like when it's running.

Next you need to deploy the app to Azure so others can view the RSS feed as well. You can deploy the app using the steps below.

1) Right click on the the project node in the solution explorer, and then select **Publish**.

2) In the publishing dialog, select **Azure** as the Target, and then select **Next**.

3) On the **Specific Target** step, select **Azure App Service (Windows)**, and then choose **Next**.

4) For the **App Service** step, make sure you are signed into the correct Azure Account and then select the subscription you would like to deploy to. Next, create a new app service instance by selecting the green **+** icon.

5) In the new app service dialog, enter the following values:

    * **Name**: Enter `GitHubBrowserXXX`, where `XXX` are three random numbers of your choosing.  This ensures your App Service name and domain will be unique across Azure.

    * **Subscription name**: Select the subscription you would like to use for your new App Service instance.

    * **Resource Group**: Select an existing resource group, or select **New...** and enter a name of `RemoteDebuggingExample` for the resource group name.

    * **Hosting Plan**: Select an existing hosting plan, or choose **New...** and enter a name of `RemoteDebuggingPlan`.
    
    Finally, select **Create** to close the dialog, and Visual Studio will take a moment to create the App Service instance for you.

6) Once the App Service is created, select the new instance, and then choose Finish.

7) Visual Studio will display a summary view of the publishing profile.  Select **Publish** in the upper right corner to deploy your app to Azure. This process may take a moment to complete.

When the deployment finishes Visual Studio will launch a web browser to the home page of your app. However, in the case of our sample app, you will actually see an error page. This page loaded fine locally, but does not appear to work correctly on Azure.

In the next exercise, you'll learn how to use the **Attach to process** remote debugging feature to track down the cause of this bug.