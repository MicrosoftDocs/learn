Many integrated development environments and other tools can publish an ASP.NET Core app to various hosting environments. Behind the scenes, these tools are running the `dotnet publish` command with various options.

Your manager is evaluating Azure as an option for hosting your app, and they asked you to publish the app as a proof-of-concept. You need to publish the app on Azure. You've selected Azure App Service as the hosting environment because it's easy to use and supports ASP.NET Core apps.

In this exercise, you publish an ASP.NET Core app as a framework-dependent deployment for Azure.

> [!NOTE]
> This exercise is optional. If you don't have an Azure subscription, you can get a [free account](https://azure.microsoft.com/free/dotnet/) or skip this exercise. 

## Create an Azure App Service web app

In Azure App Service, a *web app* can be thought of as a single-application web server. You need to create an Azure App Service web app in which to deploy your ASP.NET Core app. Make sure you have the Azure Tools extension for Visual Studio Code installed.

1. In Visual Studio Code, press **Ctrl+Shift+A** to open the Azure Tools extension.
1. Sign in to your Azure subscription and directory if necessary.
1. Press **Ctrl+Shift+P** to open the command palette.
1. Search for and select **Azure App Service: Create New Web App...**. Do **NOT** select the **Advanced** option.

    :::image type="content" source="../media/create-web-app.png" alt-text="A screenshot of the command palette with the Create a New Web App option selected."  lightbox="../media/create-web-app.png":::

1. Select the subscription you want to use.
1. Enter a name for the web app. The name must be unique within Azure.
1. Select the correct .NET runtime stack.

    > [!TIP]
    > This usually corresponds to the version of the .NET SDK you're using. For example, if you're using .NET 8.0, you should select **.NET 8.0**. If you're not sure which runtime stack to use, check the `<TargetFramework>` element in the *MyWebApp.csproj* file.

1. Select the **Free (F1)** pricing tier.
1. After the extension finishes creating the web app, return to the Azure Tools extension. Note that the **App Services** node under your subscription now contains the new web app.

    :::image type="content" source="../media/app-services-list.png" alt-text="A screenshot of the Azure Tools extension listing the Azure App Service web app."  lightbox="../media/app-services-list.png":::

## Publish the app to Azure

Now that you've created the Azure App Service web app, you can publish the app to Azure.

1. Press **Ctrl+Shift+P** to open the command palette.
1. Search for and select **Azure App Service: Deploy to Web App...**.
1. Select the folder that contains your project.
1. When prompted, select **Add Config** to add a configuration file for the app.
1. Select the Azure subscription you used earlier.
1. Select the web app you created earlier.
1. When prompted, select **Deploy**.

    After a few moments, the app is published to Azure. In the **Terminal** window, you can see the output of the `publish-release` task. Note that the extension runs the `dotnet publish` command to create a framework-dependent deployment.

    :::image type="content" source="../media/azure-publish-output.png" alt-text="A screenshot of the terminal output featuring the dotnet publish command."  lightbox="../media/azure-publish-output.png":::

1. When prompted, select **Browse Website** to open the web app in a browser. Alternatively, press **Ctrl+Shift+P** and search for **Azure App Service: Browse Website** and follow the prompts.

    