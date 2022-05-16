At this point the app is deployed to Azure, but it is not working correctly. The app still works locally, so it's difficult to determine exactly what is causing the problem without further investigation. Visual Studio can easily help you solve this issue by attaching the debugger to the App Service process out on Azure.  The steps below will enable you to debug the app as though it is running locally.

> [!NOTE]
> Before attempting to attach the debugger, always make sure the state of your local code mirrors what was deployed to Azure. This ensures that the local symbol files and source code line up with the deployed app. In a real app, if you are using Git to manage your project, you'll want to check out the same commit or release that was deployed.

## Attach the debugger to the App Service

1) First, make sure you have successfully built your project at least one time. This will ensure the source code and any necessary compiled files are ready to go. If you application is running locally, make sure to stop the app.

2) From the main menu at the top of Visual Studio, select **Debug -> Attach to process**  to open the corresponding dialog. Using this window you can connect and attach to a variety of targets. In this case you will be connecting to the App Service instance you created in the previous step.

3) Select the **Connection Type** drop down and choose the **Microsoft Azure App Services** option.

4) Select **Find..** next to the **Connection Target** field. This will open a dialog that allows you to browse your Azure subscriptions and app services.

5) Locate and select the `GitHubBrowser123` App Service you created in the previous step, and then choose **OK**.

6) The `w3wp.exe` process should appear in the list of available processes to connect to, which is the main process of the Azure App Service that hosts the deployed application. Select that process and then choose **Attach** in the bottom right to connect the Visual Studio debugger.

:::image type="content" source="../media/visual-studio-remote-debug-attach-to-process.png" alt-text="A screenshot of the attach to process features.":::

7) The `OnGet` method inside of `Index.cshtml.cs` handles most of the logic for the app, so make sure to set a breakpoint on the first line of that method. However, when you set the breakpoint, the icon will display hollow with a warning symbol. When you mouse over the breakpoint, Visual Studio will display a message that the breakpoint cannot be hit for optimized code when the "Just my Code" setting is enabled. Essentially Visual Studio is not able to properly debug the app yet because the debugging symbols have not been loaded due to certain configurations.

## Ensure symbols are loaded

By default, Visual Studio deploys applications to Azure in release mode.  Release mode performs various optimizations during compilation and does not produce `.pdb` symbol files for debugging. There are two main ways of addressing this issue

### Option 1: Debug using local symbol files (preferred)
You can use local symbol files produced by building your source code to debug the app hosted in Azure, as long as the current build matches what was deployed.

You can see which symbols were loaded for the current debugging session by navigating to **Debug --> Windows --> Modules** from the top Visual Studio menu. This modules panel shows all of the relevant dlls for the application and whether the corresponding symbols were loaded. You can see that the the symbols for `GitHubBrowser.dll` were not loaded, which is the main DLL for our project.

:::image type="content" source="../media/visual-studio-remote-debug-modules-small.png" lightbox="../media/visual-studio-remote-debug-modules.png" alt-text="A screenshot of the debugging modules.":::

By default, Visual Studio only loads symbols for user code. In simplified terms, you can think of user code as code you have written, as opposed to DLLs that were provided by .NET or third party packages. Because the debugger is attached to optimized code running out in Azure, it doesn't recognize the project dll as user code.

You can resolve this issue by navigating to **Tools -> Options** from the top Visual Studio menu.  Under the **Debugging** section, make sure that "Enable Just My code** is unchecked, and then select **OK**.  Changing this setting will allow Visual Studio to browse its default search locations for symbol files that match the optimized code.

:::image type="content" source="../media/visual-studio-remote-debug-settings.png" alt-text="A screenshot of the Visual Studio debugging settings.":::

After the dialog closes, the **Modules** window should now show a value of **Symbols loaded** under the **Symbol Status** column for the project dll.  The breakpoint in the `OnGet` method should also now display as a solid red icon, indicating that Visual Studio is ready to debug like usual.

### Option 2: Redeploy the app in debug configuration

Another option for ensuring debugging symbols are loaded is to temporarily redeploy the app in Debug mode. This approach should be used with caution. Deploying to production in Debug mode can cause performance problems and other issues, since many optimizations are skipped. You should only use this approach if the app is not fully released yet, or the business conditions of your app allow you to do this safely. For example, for a low volume internal application this approach might work fine, but should not be used for high traffic public sites.

To deploy the app in debug mode, follow the steps below:

1) Navigate to the publishing profile view again by right clicking on the project node in the solution explorer and selecting publish.

2) On the publishing profile page, select the pencil icon next to the **Release** configuration value.

3) In the publishing dialog that opens, make sure to select the **Debug** value from the **Configuration** drop down menu. Click save to persist those changes.

4) On the publishing profile page, select Publish again to redeploy the app. This time the publishing workflow will build and deploy symbol files out to Azure with the rest of the application code. When you reattach to the Azure App Service process again, the symbol files will be loaded automatically.

## Troubleshoot the bug

Once your symbols have been loaded, you can now debug the Azure hosted app just like you would locally.  With the breakpoint set, enter a value of *dotnet* in the search box and then hit submit. Visual Studio will hit the break point inside the `OnGet` method.  The first time may take a moment to sync.

The code will first attempt to retrieve the `GitHubUrl` value using the `IConfiguration` service.  By default this service loads values from the `appsettings.json` file in the app. Press F10 or click the step over button on the Visual Studio debugging controls to move to the next line of code. However, if you mouse over the `githubUrl` variable, you'll find that the value is currently null.

This code worked fine locally, so why doesn't it work in Azure? You can open the `appsettings.json` file to investigate further.  Inside of this file there are a few configuration settings around logging - but no `GitHubUrl` value to be found.

In the solution explorer you may have noticed the `appsettings.json` file includes an arrow icon next to it. If you expand this arrow, you'll find a second file called `appsettings.Development.json`.  This file contains configurations that will only be applied while running during development. Open this file, and there you will find the `GitHubUrl` value, which is why the application works when running locally. Forgetting to set configurations for the production version of your hosted application in Azure is a common source of bugs.

:::image type="content" source="../media/visual-studio-remote-debug-github-url.png" alt-text="A screenshot of the application settings.":::

To solve the issue, simply copy the `GitHubUrl` key-value pair and paste it into the top level `appsettings.json` file. When the app is deployed to Azure again this new configuration value will travel with it in the `appsettings.json` file.

You can detach the debugger from the App Service by pressing the stop button at the top of Visual Studio, just like a local debugging session. Next, to redeploy the changes, right click on the project node in the solution explorer and choose **Publish** again.  On the publishing profile screen, all of the original deployment settings are still in place, so simply press **Publish** again to redeploy to Azure.

When the deployment completes, Visual Studio will launch a browser to display the app again. Enter *dotnet* into the search form again and press enter. A list of repositories will now load correctly.

Congratulations! You successfully solved a bug in your Azure App Service.