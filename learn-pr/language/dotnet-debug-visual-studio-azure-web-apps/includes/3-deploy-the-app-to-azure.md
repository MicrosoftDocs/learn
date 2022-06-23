In order to work through a remote debugging exercise with App Service, you'll first need to deploy an application to Azure. The Razor Pages sample app provided below allows users to search for GitHub repositories by organization. However, the app also contains a subtle bug that you will troubleshoot using Visual Studio after it has been deployed.

## Set up the sample app

1) Clone the app from GitHub using the following command:

    ```Bash
    git clone "https://github.com/MicrosoftDocs/mslearn-dotnet-debug-visual-studio-app-service.git"
    ```

2) Inside the root folder of the cloned project, double click on `GitHubBrowser.sln` to open the app in Visual Studio.

3) You can start the app locally by pressing the run button at the top of Visual Studio. The app should load in the browser and present a form to use for search queries. For example, search *dotnet* to browse repos for that GitHub organization to get an idea of what the results should look like.

    :::image type="content" source="../media/visual-studio-remote-debug-app.png" alt-text="A screenshot of the sample app.":::


Most of the relevant code for the app can be found in the `OnGet` method inside the `Index.cshtml.cs` file. The code pulls the GitHub API URL from the `appsettings.Development.json` file when the app runs and makes an HTTP request using the submitted search term as a parameter. The items returned from the API are then rendered using a foreach loop and a table in the `Index.cshtml` file.

## Deploy the app to Azure

Next you need to deploy the app to Azure so others can use it to browse repositories. You can deploy the app using Visual Studio and the steps below.

> [!NOTE]
> If you are using the Learn sandbox, you may need to log out and log in again inside of Visual Studio for your subscription information to refresh. You can manage your account by clicking on the name icon in the upper right of Visual Studio. Make sure you are logged into the account you used to create the sandbox.

:::image type="content" source="../media/visual-studio-remote-account.png" alt-text="A screenshot of the account settings icon.":::

1) Right click on the project node in the solution explorer, and then select **Publish**.

    :::image type="content" source="../media/visual-studio-remote-debug-publish.png" alt-text="A screenshot of the publishing option in Visual Studio.":::

2) In the publishing dialog, select **Azure** as the Target, and then select **Next**.

3) On the **Specific Target** step, select **Azure App Service (Windows)**, and then choose **Next**.

4) For the **App Service** step, make sure you're signed into the correct Azure Account in the upper right of the dialog.  and then select the subscription you would like to deploy to. 

5) Next, create a new app service instance by selecting the green **+** icon. In the new app service dialog, enter the following values:

    | Setting | Value  |
    | --- | --- |
    | **Name** |  Enter `GitHubBrowser123`, where `123` are three random numbers of your choosing to ensure your App Service name and domain is unique across Azure. |
    | **Subscription name** | If you are using the Learn sandbox environment, select the `Concierge Subscription`, otherwise select your own. Remember, you may need to log out and in again if you don't see the sandbox subscription as an option. |
    | **Resource group** | Choose the <rgn>[sandbox resource group name]</rgn> if you are using the sandbox, or select **New...** to create your own new group with a name such as `mslearn-github-browser`. |
    | **Hosting plan** | If you are using the Learn sandbox, leave the default value.  If you are using your own subscription, select **New...** and enter a name of `mslearn-github-browser-plan` and choose your instance size. |

    :::image type="content" source="../media/visual-studio-remote-debug-create-app-service.png" alt-text="A screenshot of the create app service workflow.":::

6) Select **Create** to close the dialog, and Visual Studio will take a moment to create the App Service instance for you.

7) Once the App Service is created, select the new instance, and then choose Finish.

8) Visual Studio will display a summary view of the publishing profile. Select **Publish** in the upper right corner to deploy your app to Azure. This process may take a moment to complete.

    :::image type="content" source="../media/visual-studio-remote-debug-publish-profile.png" alt-text="A screenshot of the publishing profile.":::

When the deployment finishes Visual Studio will launch a web browser to the home page of your app. At first, it appears that everything is working correctly. However, when you try to search *dotnet* again, you'll receive an error page instead of the table of results. This error didn't happen locally, and you can use Visual Studio to figure out why.

:::image type="content" source="../media/visual-studio-remote-debug-error.png" alt-text="A screenshot of the application error.":::

## Enable remote debugging

Before you can debug this issue with Visual Studio, you must enable the remote debugging feature on the App Service. This setting will allow the Visual Studio debugger to connect to the main App Service web hosting process.

1) Locate your deployed application in the Azure portal. You can find your app by browsing to the **App Services** page and then selecting the **GitHubBrowser123** app.  You can also search for the App Service instance directly by name in the search bar at the top.

    :::image type="content" source="../media/visual-studio-remote-debug-azure-search.png"  alt-text="A screenshot of Azure search." :::

2) On the App Service settings page, select **Configuration** on the left navigation, and then switch to the **General Settings** tab. 

3) Towards the bottom of the page, make sure to set the **Remote Debugging** feature to **On** and select **Visual Studio 2022** as the **Remote Visual Studio version**.

    :::image type="content" source="../media/visual-studio-remote-debug-azure-settings-small.png"  alt-text="A screenshot of the Azure remote debugging settings." lightbox="../media/visual-studio-remote-debug-azure-settings.png":::

Your app service instance now supports remote debugging through Visual Studio.
