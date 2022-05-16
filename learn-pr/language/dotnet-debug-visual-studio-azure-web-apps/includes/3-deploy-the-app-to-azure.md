In order to work through a remote debugging exercise with App Service you will first need to deploy an application to Azure. For this scenario you can either deploy your own app or clone the sample GitHub project below.

```Bash
    git clone "https://..."
```

The sample Razor Pages project allows users to search for GitHub repositories by organization using a simple form.  The results are displayed in a table after they press submit. Most of the relevant code for the app can be found in the `OnGet` method inside the `Index.cshtml.cs` file. The code pulls the GitHub API URL from the `appsettings.development.json` file when the app runs and makes an HTTP request using the submitted search term as a parameter.  Those items are then rendered using a foreach loop and a table in the `Index.cshtml` file.

You can start the app locally by pressing the run button inside of Visual Studio. The app should load correctly and present a form to use for search queries. For example, you can search *dotnet* in the form input to browse repos for that GitHub organization to get an idea of what the results should look like.

:::image type="content" source="../media/visual-studio-remote-debug-app.png" alt-text="A screenshot of the sample app.":::

Next you need to deploy the app to Azure so others can use your app to browse repositories. You can deploy the app using the steps below.

1) Right click on the the project node in the solution explorer, and then select **Publish**.

    :::image type="content" source="../media/visual-studio-remote-debug-publish.png" alt-text="A screenshot of the publishing option in Visual Studio.":::

2) In the publishing dialog, select **Azure** as the Target, and then select **Next**.

3) On the **Specific Target** step, select **Azure App Service (Windows)**, and then choose **Next**.

4) For the **App Service** step, make sure you are signed into the correct Azure Account in the upper right of the dialog and then select the subscription you would like to deploy to. Next, create a new app service instance by selecting the green **+** icon.

5) In the new app service dialog, enter the following values:

    * **Name**: Enter `GitHubBrowser123`, where `123` are three random numbers of your choosing.  This ensures your App Service name and domain will be unique across Azure.

    * **Subscription name**: Select the subscription you would like to use for your new App Service instance.

    * **Resource Group**: Select **New...** and enter a name of `mslearn-github-browser` for the resource group name.

    * **Hosting Plan**: Select **New...** and enter a name of `mslearn-github-browser-plan`.
    
    Finally, select **Create** to close the dialog, and Visual Studio will take a moment to create the App Service instance for you.

    :::image type="content" source="../media/visual-studio-remote-debug-create-app-service.png" alt-text="A screenshot of the create app service workflow.":::

6) Once the App Service is created, select the new instance, and then choose Finish.

7) Visual Studio will display a summary view of the publishing profile.  Select **Publish** in the upper right corner to deploy your app to Azure. This process may take a moment to complete.

    :::image type="content" source="../media/visual-studio-remote-debug-publish-profile.png" alt-text="A screenshot of the publishing profile.":::

When the deployment finishes Visual Studio will launch a web browser to the home page of your app. At first it appears that everything is working correctly. However, when you try to search *dotnet* again, you will receive an error page instead of the table of results.  This error did not happen locally, and you can use Visual Studio to figure out why.

:::image type="content" source="../media/visual-studio-remote-debug-error.png" alt-text="A screenshot of the application error.":::

## Enable remote debugging

Before you can debug with Visual Studio you must enable the remote debugging feature on the App Service. This setting will allow the Visual Studio debugger to connect to the main App Service web hosting process.

1) Locate your deployed application in the Azure portal. You can do this by browsing to the **App Services** page and then selecting the **GitHubBrowser123** app.  You can also search for the App Service instance directly by name in the search bar at the top.

    :::image type="content" source="../media/visual-studio-remote-debug-azure-search.png"  alt-text="A screenshot of Azure search." :::

2) On the App Service settings page, select **Configuration** on the left navigation, and then switch to the **General Settings** tab. Towards the bottom of the page, make sure to set the **Remote Debugging** feature to **On** and select **Visual Studio 2022** as the **Remote Visual Studio version**.

    :::image type="content" source="../media/visual-studio-remote-debug-azure-settings-small.png"  alt-text="A screenshot of the application error." lightbox="../media/visual-studio-remote-debug-azure-settings.png":::

Your app service instance now supports remote debugging through Visual Studio.
