At this point the app is deployed to Azure, but it isn't functioning correctly. The app still works locally, so it's difficult to determine exactly what is causing the problem without further investigation. Visual Studio can easily help you solve this issue by attaching the debugger to the App Service process out on Azure. The steps below will enable you to debug the app as though it's running locally.

> [!NOTE]
> Before attempting to attach the debugger, always make sure the state of your local code mirrors what was deployed to Azure. This ensures that the local symbol files and source code line up with the deployed app. In a real app, if you are using Git to manage your project, you'll want to check out the same commit or release that was deployed.

## Attach the debugger to the App Service

1) First, make sure you have successfully built your project at least one time. A successful build ensures the source code and any necessary compiled files are ready to go. If your application is running locally, make sure to stop the app.

2) From the main menu at the top of Visual Studio, select **Debug -> Attach to process** to open the corresponding dialog. Using this window you can connect and attach to different targets. In this case, you'll be connecting to the App Service instance you created in the previous step.

3) Select the **Connection Type** drop down and choose the **Microsoft Azure App Services** option.

4) Select **Find..** next to the **Connection Target** field to open a dialog that allows you to browse your Azure subscriptions and app services.

5) Locate and select the `GitHubBrowser123` App Service you created in the previous step, and then choose **OK**.

6) The `w3wp.exe` process should appear in the list of available processes to connect to, which is the main process of the Azure App Service that hosts the deployed application. Select that process and then choose **Attach** in the bottom right to connect the Visual Studio debugger.

    :::image type="content" source="../media/visual-studio-remote-debug-attach-to-process.png" alt-text="A screenshot of the attach to process features.":::

7) The `OnGet` method inside of `Index.cshtml.cs` handles most of the logic for the app, so make sure to set a breakpoint on the first line of that method. However, when you set the breakpoint, the icon will display hollow with a warning symbol. When you mouse over the breakpoint, Visual Studio will display a message that the breakpoint can't be hit for optimized code when the "Just my Code" setting is enabled. Essentially Visual Studio isn't able to properly debug the app yet because the debugging symbols haven't been loaded due to certain configurations.

## Ensure symbols are loaded

You can use the local symbol files produced by building your source code to debug the app hosted in Azure, as long as the current build matches what was deployed.

1) Investigate which symbols were loaded for the current debugging session by navigating to **Debug --> Windows --> Modules** from the top Visual Studio menu. The modules panel shows all of the relevant `.dll` files for the application and whether the corresponding symbols were loaded. You can see that the symbols for `GitHubBrowser.dll` weren't loaded, which is the main `.dll` file for the project.

    :::image type="content" source="../media/visual-studio-remote-debug-modules-small.png" lightbox="../media/visual-studio-remote-debug-modules.png" alt-text="A screenshot of the debugging modules.":::
    
    By default, Visual Studio only loads symbols for user code. In simplified terms, you can think of user code as code you've written, as opposed to DLLs that were provided by .NET or third party packages. Because the debugger is attached to optimized release code running out in Azure, it doesn't recognize the project dll as user code, so you'll fix that next.

2) Navigate to **Debug -> Options** from the top Visual Studio menu. Make sure that "Enable Just My code** is unchecked, and then select **OK**. Changing this setting will allow Visual Studio to browse its default search locations for symbol files that match the optimized code.

    :::image type="content" source="../media/visual-studio-remote-debug-settings.png" alt-text="A screenshot of the Visual Studio debugging settings.":::

    After the dialog closes, the **Modules** window should now show a value of **Symbols loaded** under the **Symbol Status** column for the project dll. The breakpoint in the `OnGet` method should also now display as a solid red icon, indicating that Visual Studio is ready to debug like usual.
    
    > [!NOTE]
    > If you receive a timeout error message from Visual Studio while working through this exercise, you can always simply reconnect to the app service instance using the same steps you used earlier.

## Troubleshoot the bug

Once your symbols have loaded, you can debug the Azure hosted app just like you would locally. 

1) With the breakpoint set, enter a value of *dotnet* in the app search box and then hit submit. Visual Studio will hit the break point inside the `OnGet` method. The first time may take a moment to sync. The code will attempt to retrieve the `GitHubUrl` value using the `IConfiguration` service. By default the configuration service loads values from the `appsettings.json` file in the app. 

2) Use the step over button on the Visual Studio debugging controls to move to the next line of code. If you mouse over the `githubUrl` variable, you'll find that the value is currently null. This code worked fine locally, so why is the value null in Azure?

3) Open the `appsettings.json` file to investigate further. Inside of this file there are a few configuration settings around logging - but no `GitHubUrl` value to be found.

4) In the solution explorer, you may have noticed the `appsettings.json` file includes an arrow icon next to it. Expand this arrow to find a second file called `appsettings.Development.json`. This file contains configurations that will only be applied while running during development.

5) Open the `appsettings.Development.json` file, and there you'll discover the `GitHubUrl` value, which is why the application works when running locally. Forgetting to set configurations for the production version of your hosted application in Azure is a common source of bugs.

    :::image type="content" source="../media/visual-studio-remote-debug-github-url.png" alt-text="A screenshot of the application settings.":::

6) Copy the `GitHubUrl` key-value pair and paste it into the top level `appsettings.json` file. The new configuration value will travel with it in the `appsettings.json` file when the app is deployed to Azure again.

7) You can detach the debugger from the App Service by pressing the stop button at the top of Visual Studio, just like a local debugging session. 

8) To redeploy the changes you made, right click on the project node in the solution explorer and choose **Publish** again. 

9) On the publishing profile screen, all of the original deployment settings are still in place, so press **Publish** again to redeploy to Azure.

10) When the deployment completes, Visual Studio will launch a browser to display the app again. Enter *dotnet* into the search form again and press enter. A list of repositories will now load correctly.

    Congratulations! You successfully solved a bug in your Azure App Service using Visual Studio.
