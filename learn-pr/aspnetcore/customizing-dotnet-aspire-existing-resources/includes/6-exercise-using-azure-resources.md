In this exercise, you'll configure the eShop application to use Azure Cache for Redis and Application Insights when it is deployed to Azure. You'll also deploy the .NET Aspire solution to your Azure subscription.

> [!IMPORTANT]
> To complete this exercise, you'll need an Azure subscription. If you don't have a subscription, you can [create a free trial subscription](https://azure.microsoft.com/en-us/free/).

## Install prerequisites

The prerequisites for .NET Aspire are:

- .NET 8
- Visual Studio 2022 Preview
- Docker Desktop or Podman
- .NET Aspire workload in Visual Studio

If you've already got these packages installed, you can skip ahead to begin working with Azure Storage.

### Install .NET 8

Follow this [.NET 8](https://dotnet.microsoft.com/download/dotnet/8.0) link, and select the correct installer for your operating system. For example, if you're using Windows 11, and a modern processor, select the x64 .NET 8 SDK for Windows.

After the download is complete, run the installer and follow the instructions. In a terminal window, run the following command to verify that the installation was successful:

```powershell
dotnet --version
```

You should see the version number of the .NET SDK you installed. For example:

```console
8.0.300
```

### Install Visual Studio 2022 Preview

Follow this [Visual Studio 2022 Preview](https://visualstudio.microsoft.com/vs/preview/) link, and select **Download Preview**. After the download is complete, run the installer and follow the instructions.

### Install Docker Desktop

Follow this [Docker Desktop](https://www.docker.com/products/docker-desktop/) link, and select the correct installer for your operating system. After the download is complete, run the installer and follow the instructions. For the best performance and compatibility, use the WSL 2 backend.

Open the Docker Desktop application and accept the service agreement.

### Install the .NET Aspire workload in Visual Studio

Install the .NET Aspire workload using the .NET CLI:

1. Open a terminal.
1. Update .NET workloads with this command:

    ```dotnetcli
    dotnet workload update
    ```

    You should see a message that the workloads are updated successfully.

    ```console
    No workloads installed for this feature band. To update workloads installed with earlier SDK versions, include the --from-previous-sdk option.
    Updated advertising manifest microsoft.net.sdk.ios.
    Updated advertising manifest microsoft.net.workload.mono.toolchain.net6.
    Updated advertising manifest microsoft.net.sdk.android.
    Updated advertising manifest microsoft.net.workload.emscripten.net7.
    Updated advertising manifest microsoft.net.workload.emscripten.net6.
    Updated advertising manifest microsoft.net.sdk.macos.
    Updated advertising manifest microsoft.net.workload.emscripten.current.
    Updated advertising manifest microsoft.net.workload.mono.toolchain.current.
    Updated advertising manifest microsoft.net.sdk.maui.
    Updated advertising manifest microsoft.net.workload.mono.toolchain.net7.
    Updated advertising manifest microsoft.net.sdk.maccatalyst.
    Updated advertising manifest microsoft.net.sdk.tvos.
    Updated advertising manifest microsoft.net.sdk.aspire.
    No workloads installed for this feature band. To update workloads installed with earlier SDK versions, include the --from-previous-sdk option.
    
    Successfully updated workload(s): .
    ```

1. Install the .NET Aspire workload with this command:

    ```dotnetcli
    dotnet workload install aspire
    ```

    You should see a message that the .NET Aspire workload has been installed.

    ```console
    Installing Aspire.Hosting.Sdk.Msi.x64 ...... Done
    Installing Aspire.ProjectTemplates.Msi.x64 ..... Done
    Installing Aspire.Hosting.Orchestration.win-x64.Msi.x64 ............. Done
    Installing Aspire.Hosting.Msi.x64 ..... Done
    Installing Aspire.Dashboard.Sdk.win-x64.Msi.x64 ....... Done
    
    Successfully installed workload(s) aspire.
    ```

1. Verify that the .NET Aspire workload is installed with this command:

    ```dotnetcli
    dotnet workload list
    ```

    You should see the details of the .NET Aspire workload.

    ```console
    Installed Workload Id      Manifest Version      Installation Source
    --------------------------------------------------------------------------------
    aspire                     8.0.1/8.0.100         SDK 8.0.300, VS 17.11.34929.205

    Use `dotnet workload search` to find additional workloads to install.
    ```

## Clone the sample solution

Let's use `git` to obtain a sample app to deploy:

1. In the command line, browse to a folder of your choice where you can work with code.
1. Execute the following command to clone the **eShop** sample application:

    ```dotnetcli
    git clone -b aspire-azure-deployment https://github.com/MicrosoftDocs/mslearn-aspire-starter
    ```

1. Open Visual Studio and then select **Open a project or solution**.
1. Browse to the folder where you cloned the sample solution, then in the _start_ folder select _eShop.azureresources.sln_ and then select **Open**.
1. To start the app in debugging mode press <kbd>F5</kbd> or select **Debug > Start Debugging**.
1. If the **Start Docker Desktop** message appears, select **Yes**. The app starts and displays the .NET Aspire dashboard in a browser tab.
1. Notice that there is a container named **redis**. This container hosts the output cache for the **webapp** microservice.

    :::image type="content" source="../media/local-dashboard-redis-container.png" lightbox="../media/local-dashboard-redis-container.png" alt-text="Screenshot showing the .NET Aspire dashboard with the Redis container highlighted.":::

1. Close the web browser tabs and in Visual Studio stop debugging.

## Configure the cache to use Azure Cache for Redis

When you deploy the eShop to Azure, you want to use Azure Cache for Redis to host the output cache, so that you don't have to managed a caching container. Let's set that up:

1. In Visual Studio, in the **Solution Explorer**, right-click the **eShop.AppHost** project, point to **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **redis**.
1. Select **Aspire.Hosting.Azure.Redis** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In the **eShop.AppHost** project, open the _Program.cs_ file.
1. Locate the following line of code:

    ```csharp
    var redis = builder.AddRedis("redis");
    ```

1. Modify that line of code to match this line:

    ```csharp
    var redis = builder.AddRedis("redis")
        .PublishAsAzureRedis();
    ```

> [!NOTE]
> The solution already has code that passes the cache service to the web app project. The web app project uses it as an output cache for the _Catalog.razor_ page. The changes you've made ensure that the deployed app will use Azure Cache for Redis, not a Redis container.

## Configure the app host to deploy Application Insights

You want the deployed eShop to send telemetry data to Azure Application Insights. Let's start by configuring the app host project:

1. In Visual Studio, in the **Solution Explorer**, right-click the **eShop.AppHost** project, point to **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **insights**.
1. Select **Aspire.Hosting.Azure.ApplicationInsights** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In the **eShop.AppHost** project, open the _Program.cs_ file.
1. Locate the following line of code:

    ```csharp
    var builder = DistributedApplication.CreateBuilder(args);
    ```

1. Immediately after that line, add the following line of code:

    ```csharp
    var insights = builder.AddAzureApplicationInsights("AppInsights");
    ```

1. Locate the following line of code, which adds the Catalog API project:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb);
    ```

1. To pass the Application Insights service to the Catalog API, modify that line of code to match this line:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb)
        .WithReference(insights);
    ```

1. Locate the following line of code, which adds the Web App project:

    ```csharp
    builder.AddProject<WebApp>("webapp")
        .WithReference(catalogApi)
        .WithReference(redis);
    ```

1. To pass the Application Insights service to the Web App, modify that line of code to match this line:

    ```csharp
    builder.AddProject<WebApp>("webapp")
        .WithReference(catalogApi)
        .WithReference(redis)
        .WithReference(insights);
    ```

## Configure the solution to send telemetry to Application Insights

The changes that you've made to the app host project deploy a new instance of Application Insights to Azure when you deploy the .NET Aspire solution. However, you must also configure the solution to send telemetry to that instance. Let's do that now:

1. In Visual Studio, in the **Solution Explorer**, right-click the **eShop.ServiceDefaults** project, and then select **Manage NuGet packages**.
1. Select the **Browse** tab.
1. In the search textbox, type **Azure.Monitor.OpenTelemetry**.
1. Select **Azure.Monitor.OpenTelemetry.AspNetCode** package, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, expand the **eShop.ServiceDefaults** project and then double-click the _HostingExtensions.cs_ file.
1. Locate the following code in the `AddOpenTelemetryExporters` method:

    ```csharp
    if (useOtlpExporter)
    {
        builder.Services.AddOpenTelemetry().UseOtlpExporter();
    }
    ```

1. Immediately after that code, add the following code:

    ```csharp
    if (!string.IsNullOrEmpty(builder.Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"]))
    {
        builder.Services.AddOpenTelemetry().UseAzureMonitor();
    }
    ```

## Install the Azure Developer CLI

We'll use the Azure Developer CLI (`azd`) to deploy our completed application:

1. In the command line, to install the Azure Developer CLI (`azd`) run this command:

    ```console
    winget install microsoft.azd
    ```

    > [!NOTE]
    > If you don't have `winget` installed, see [Use the winget tool to install and manage applications](/windows/package-manager/winget/)

1. To log into Azure, run this command, and then enter your Azure credentials:

    ```console
    azd auth login
    ```

## Initialize the deployment

Before you can deploy, use `azd` to inspect the .NET Aspire solution and create manifest files:

1. In the command line, change into the directory where you cloned the sample application.
1. To navigate into the app host project, use this command:

    ```console
    cd Start\eShop.AppHost
    ```

1. To start the initialization, run this command:


    ```console
    azd init
    ```

1. `azd` starts asks you how to initialize the app. Press <kbd>Enter</kbd> to use code in the current directory.

    ```console
    Initializing an app to run on Azure (azd init)

    ? How do you want to initialize your app?  [Use arrows to move, type to filter]
    > Use code in the current directory
      Select a template
    ```

1. `azd` scans the code in the current directory, detects .NET Aspire, and asks you to confirm that you want to continue. Press <kbd>Enter</kbd>:

    ```console
    Detected services:

      .NET (Aspire)
      Detected in: C:\Users\Admin\source\repos\eShop.AppHost\eShop.AppHost.csproj

    azd will generate the files necessary to host your app on Azure using Azure Container Apps.

    ? Select an option  [Use arrows to move, type to filter]
    > Confirm and continue initializing my app
      Cancel and exit
    ```

1. When `azd` prompts you for a new environment name, type **aspireeshop** and then press <kbd>Enter</kbd>.
1. `azd` generates the necessary files and completes the initialization:

    ```console
    Generating files to run your app on Azure:

      (✓) Done: Generating ./azure.yaml
      (✓) Done: Generating ./next-steps.md

    SUCCESS: Your app is ready for the cloud!
    You can provision and deploy your app to Azure by running the azd up command in this directory. For more information on configuring your app, see ./next-steps.md
    ```

## Deploy the eShop

Now that you have initialized `azd`, you can continue with the deployment to Azure:

1. To start the deployment, run this command:

    ```console
    azd up
    ```

1. `azd` analyzes the app and prompts you to choose an Azure subscription. Use the arrow keys to select the correct subscription and then press <kbd>Enter</kbd>:

    ```console
    ? Select an Azure Subscription to use:  [Use arrows to move, type to filter]
    >  1. Pay-As-You-Go
    ```

1. `azd` prompts you to choose an Azure location. Choose a location near you and then press <kbd>Enter</kbd>:

    ```console
    ? Select an Azure location to use:  [Use arrows to move, type to filter]
      46. (US) East US STG (eastusstg)
      47. (US) North Central US (northcentralus)
      48. (US) South Central US (southcentralus)
      49. (US) West Central US (westcentralus)
      50. (US) West US (westus)
    > 51. (US) West US 2 (westus2)
      52. (US) West US 3 (westus3)
    ```

1. `azd` provisions Azure resources. This process can take around 40 minutes. When the deployment is complete, a **SUCCESS** message appears:

    ```console
    Packaging services (azd package)

    Provisioning Azure resources (azd provision)
    Provisioning Azure resources can take some time.

    Subscription: Pay-As-You-Go
    Location: West US 2

      You can view detailed progress in the Azure Portal:
      https://portal.azure.com/#view/HubsExtension/DeploymentDetailsBlade/~/overview/providers%2FMicrosoft.Resources%2Fdeployments%2Faspireeshop

      (✓) Done: Resource group: rg-aspireeshop
      (✓) Done: Log Analytics workspace: law-u77k3ne4bclro
      (✓) Done: Container Registry: acru77k3ne4bclro
      (✓) Done: Key Vault: kvb6088994u77k3ne4bclro
      (✓) Done: Container Apps Environment: cae-u77k3ne4bclro
      (✓) Done: Application Insights: myapplicationinsightsu77
      (✓) Done: Cache for Redis: redisu77k3ne4bclro

    Deploying services (azd deploy)

      (✓) Done: Deploying service catalog-api
      - Endpoint: https://catalog-api.internal.proudpebble-4accbcad.westus2.azurecontainerapps.io/

      (✓) Done: Deploying service catalog-db-mgr
      - Endpoint: https://catalog-db-mgr.internal.proudpebble-4accbcad.westus2.azurecontainerapps.io/

      (✓) Done: Deploying service postgres
      - Endpoint: https://postgres.internal.proudpebble-4accbcad.westus2.azurecontainerapps.io/

      (✓) Done: Deploying service webapp
      - Endpoint: https://webapp.internal.proudpebble-4accbcad.westus2.azurecontainerapps.io/

      Aspire Dashboard: https://aspire-dashboard.ext.proudpebble-4accbcad.westus2.azurecontainerapps.io

    SUCCESS: Your up workflow to provision and deploy to Azure completed in 38 minutes 13 seconds.
    ```

## Test the deployment

When the deployment is complete, you can examine the new resources in your Azure subscription and test the deployed .NET Aspire solution:

1. Start a browser and navigate to the [Azure portal](https://portal.azure.com/#home)
1. Sign into the subscription you chose in `azd`.
1. In the portal home page, select **Resource groups**.
1. Select the **rg-aspireeshop** resource group. The resource group includes a container registry, a container apps environment, and four container apps. Select the **webapp** container app:

    :::image type="content" source="../media/deploy-resource-group.png" lightbox="../media/deploy-resource-group.png" alt-text="Screenshot showing the resources for the eShop deployed in an Azure resource group.":::

1. Select the **webapp** container app.
1. In the navigation on the left, under **Settings**, select **Ingress**.
1. Next to **Ingress traffic**, select **Accept traffic from anywhere**, and then select **Save**.

    :::image type="content" source="../media/configure-ingress.png" lightbox="../media/configure-ingress.png" alt-text="Screenshot showing how to configure ingress for the web app.":::

1. In the navigation on the left, select **Overview**, and then select the **Application Url**. The eShop homepage opens in a new browser tab.
1. Explore some products and brands in the eShop.
1. Switch back to the browser tab that displays the Azure Portal and then browse to the **rg-aspireeshop** resource group.
1. In the list of resources, select the **Application Insights** instance.
1. The graphs on the home page show data about user requests. In the navigation on the left, under **Investigate**, select **Application map**. The map displays the PostgreSQL database, two container apps, and a Redis cache.

    :::image type="content" source="../media/deployed-application-map.png" lightbox="../media/deployed-application-map.png" alt-text="Screenshot showing the eShop mapped in Application Insights.":::

1. You can explore other displays in Application Insights. When you are finished, you can clean up your Azure subscription by deleting the **rg-aspireeshop** resource group.