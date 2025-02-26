At this point, the app is deployed to Azure, but it isn't functioning correctly. The app still works locally, so it's difficult to determine exactly what's causing the problem without further investigation. Visual Studio can easily help you solve this issue by attaching the debugger to the App Service process out on Azure. This exercise allows you to debug the app as though it's running locally.

> [!NOTE]
> Before attempting to attach the debugger, always make sure the state of your local code matches what was deployed to Azure. This ensures that the local symbol files and source code line up with the deployed app. In a real app, if you're using Git to manage your project, you'll want to check out the same commit or release that was deployed.

## Configure debugging settings

Make sure you complete the following steps in Visual Studio before debugging an app in Azure to ensure success.

1. First, make sure you've successfully built your project at least one time. A successful build ensures the source code and any necessary compiled files are ready to go. If your application is running locally, make sure to stop the app.

1. Navigate to **Debug > Options** from the top Visual Studio menu. Make sure that **Enable Just My code** is unchecked, then select **OK**.

    Changing this setting allows Visual Studio to debug the optimized code deployed to Azure using the necessary symbol files from your local `bin` folder. Symbol files are used by the debugger as a bridge between compiled, executing code and the source code in Visual Studio, which is why it's important that your local source code matched the deploy app.

    :::image type="content" source="../media/visual-studio-remote-debug-settings.png" alt-text="A screenshot of the Visual Studio debugging settings.":::

## Attach the debugger to the App Service

1. From the main menu at the top of Visual Studio, select **Debug > Attach to process** to open the corresponding dialog. Using this window, you can connect and attach to different targets. In this case, you'll connect to the App Service instance you created in the previous step.

1. Select the **Connection Type** drop-down and choose the **Microsoft Azure App Services** option.

1. Select the **Find...** button next to the **Connection Target** field to open a dialog that allows you to browse your Azure subscriptions and app services.

1. Locate and select the `GitHubBrowser123` App Service you created in the previous step and choose **OK**.

1. The `w3wp.exe` process should appear in the list of available processes to which to connect, which is the main process of the Azure App Service that hosts the deployed application. Select that process, then choose **Attach** in the bottom right to connect the Visual Studio debugger.

    :::image type="content" source="../media/visual-studio-remote-debug-attach-to-process.png" alt-text="A screenshot of the attach to process features.":::

1. In `Index.cshtml.cs`, go to the first line of the `OnPost` method, and set a breakpoint in that method by clicking in the left margin (or right-click and choose **Breakpoint** > **Insert breakpoint**).

   The `OnPost` method inside of `Index.cshtml.cs` handles most of the logic for the app.

1. Optionally, you can also verify that Visual Studio has loaded the symbol files for your debugging session. Navigate to **Debug > Windows > Modules** to open the modules window. This window should indicate that the symbol files were successfully loaded for the GitHub browser `.dll` file after the **Just my code** configuration changes you made earlier.

    :::image type="content" source="../media/visual-studio-symbol-files.png" alt-text="A screenshot of the symbol files window.":::

## Troubleshoot the bug

Once your symbols have loaded, you can debug the Azure hosted app just like you would locally.

1. With the breakpoint set in Visual Studio, switch to the app in the browser, enter a value of *dotnet* in the app search box, and then hit **Submit**. Visual Studio will hit the breakpoint inside the `OnPost` method. The first time might take a moment to sync. The code will attempt to retrieve the `GitHubUrl` value using the `IConfiguration` service. By default, the configuration service loads values from the `appsettings.json` file in the app.

1. Use the step over button on the Visual Studio debugging controls (or press **F10**) to move to the line of code that creates the `searchUrl`. Place your mouse cursor over the `githubUrl` variable above it, you'll find that the value is currently null. This code worked fine locally, so why is the value null in Azure?

1. Open the `appsettings.json` file to investigate further. There are a few configuration settings in this file around logging, but no `GitHubUrl` value to be found.

1. Open the `appsettings.Development.json` file.

    When you set up the sample project, you updated the configuration settings in `appsettings.Development.json`. This file contains configurations that will only be applied while running during development, not when deployed to Azure. Forgetting to set configurations for the production version of your hosted application in Azure is a common source of bugs.

    :::image type="content" source="../media/visual-studio-remote-debug-github-url.png" alt-text="A screenshot of the application development settings.":::

1. Copy the `GitHubUrl` key-value pair from `appsettings.Development.json` and paste it into the top level `appsettings.json` file so that the two files match. The new configuration value will travel with it in the `appsettings.json` file when the app is deployed to Azure again.

    The `appsettings.json` file should look something like this.

    :::image type="content" source="../media/visual-studio-remote-debug-github-url-copied.png" alt-text="A screenshot of the application settings.":::

1. Detach the debugger from the App Service by pressing the **Stop** button at the top of Visual Studio, just like a local debugging session.

1. To redeploy the changes you made, right-click the project node in the Solution Explorer and choose **Publish** again.

1. On the publishing profile screen, all of the original deployment settings are still in place, so select **Publish** again to redeploy to Azure.

1. When the deployment completes, Visual Studio will launch a browser to display the app again. Enter *dotnet* into the search form again and press enter. A list of repositories will now load correctly.

    Congratulations! You successfully solved a bug in your Azure App Service using Visual Studio.
