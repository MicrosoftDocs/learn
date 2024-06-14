In this exercise, you'll use the Azure Developer CLI to deploy the eShop .NET Aspire solution to Azure Container Apps.

> [!IMPORTANT]
> To complete this exercise, you'll need an Azure subscription. If you don't have a subscription, you can [create a free trial subscription](https://azure.microsoft.com/free/).

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

## Clone project

Let's use `git` to obtain a sample app, which doesn't yet use Azure Storage:

1. In the command line, browse to a folder of your choice where you can work with code.
1. Execute the following command to clone the **eShop** sample application:

    ```dotnetcli
    git clone -b aspire-azure-deployment https://github.com/MicrosoftDocs/mslearn-aspire-starter
    ```

1. Start Visual Studio, and select **Open a project or solution**.
1. Navigate to the folder where you cloned the project.
1. Double-click the **Start** folder, select the _eShop.azuredeployment.sln_ solution, and then select **Open**.
1. To start the app in debugging mode press <kbd>F5</kbd> or select **Debug > Start Debugging**.
1. If the **Start Docker Desktop** message appears, select **Yes**. The app starts and displays the .NET Aspire dashboard in a browser tab.
1. In the list of **Resources**, select one of the endpoints for the **webapp** project:

    :::image type="content" source="../media/dashboard-open-webapp.png" lightbox="../media/dashboard-open-webapp.png" alt-text="Screenshot showing the .NET Aspire dashboard with the location where you can access the endpoint for the webapp project.":::

1. When the web app's homepage appears, explore the site:

    :::image type="content" source="../media/webapp-homepage.png" lightbox="../media/webapp-homepage.png" alt-text="Screenshot showing the .NET Aspire web app homepage.":::

1. Close the web browser tabs and then close Visual Studio.

Now that you've seen the .NET Aspire solution running in your local development environment, with containers hosted in Docker, let's deploy the app to Azure Container Apps.

## Install the Azure Developer CLI

The Azure Developer CLI (`azd`) is a command line tool that you can use to deploy applications of many types from a development environment into an Azure subscription. `azd` includes new features that support the deployment of .NET Aspire cloud-native apps and all the containers that they require. Let's install that tool and use it to log into your Azure subscription:

1. In the command line, to install the Azure Developer CLI (`azd`) run this command:

    ```console
    winget install microsoft.azd
    ```

    > [!NOTE]
    > If you don't have `winget` installed, see [Use the winget tool to install and manage applications](/windows/package-manager/winget/)

1. To log into Azure, run this command, and then enter your Azure credentials:

    ```console
    azd auth logon
    ```

## Initialize the deployment

The first stage in a deployment is to use `azd` to inspect the .NET Aspire solution and create files that describe its content and configuration:

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

## Deploy the app to Azure Container Apps

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

1. `azd` provisions Azure resources. This process can take several minutes. When the deployment is complete, a **SUCCESS** message appears:

    ```console
      (✓) Done: Resource group: rg-aspireeshop
      (✓) Done: Container Registry: acru77k3ne4bclro
      (✓) Done: Log Analytics workspace: law-u77k3ne4bclro
      (✓) Done: Container Apps Environment: cae-u77k3ne4bclro

    Deploying services (azd deploy)

      (✓) Done: Deploying service catalog-api
      - Endpoint: https://catalog-api.internal.nicecliff-b7b30919.westus2.azurecontainerapps.io/

      (✓) Done: Deploying service catalog-db-mgr
      - Endpoint: https://catalog-db-mgr.internal.nicecliff-b7b30919.westus2.azurecontainerapps.io/

      (✓) Done: Deploying service postgres
      - Endpoint: https://postgres.internal.nicecliff-b7b30919.westus2.azurecontainerapps.io/

      (✓) Done: Deploying service webapp
      - Endpoint: https://webapp.internal.nicecliff-b7b30919.westus2.azurecontainerapps.io/

      Aspire Dashboard: https://aspire-dashboard.ext.nicecliff-b7b30919.westus2.azurecontainerapps.io

    SUCCESS: Your up workflow to provision and deploy to Azure completed in 4 minutes 35 seconds.
    ```

## Test the deployment

When the deployment is complete, you can examine the new resources in your Azure subscription and test the deployed .NET Aspire solution:

1. Start a browser and navigate to the [Azure portal](https://portal.azure.com/#home)
1. Sign into the subscription you chose in `azd`.
1. In the portal home page, select **Resource groups**.
1. Select the **rg-aspireeshop** resource group. The resource group includes a container registry, a container apps environment, and four container apps. Select the **webapp** container app:

    :::image type="content" source="../media/deployed-resources.png" lightbox="../media/deployed-resources.png" alt-text="Screenshot showing the Azure portal with resources necessary to run a .NET Aspire solution in a resource group.":::

1. In the navigation on the left, under **Settings**, select **Ingress**.
1. Next to **Ingress traffic**, select **Accepting traffic from anywhere** and then select **Save**.

    :::image type="content" source="../media/webapp-configure-ingress.png" lightbox="../media/webapp-configure-ingress.png" alt-text="Screenshot showing how to enable ingress for all traffic in the webapp container app.":::

1. When the change to the ingress configuration has been saved, in the navigation on the left, select **Overview**.
1. To the right of **.NET Aspire Dashboard**, select **Open dashboard**:

    :::image type="content" source="../media/azure-portal-open-dashboard.png" lightbox="../media/azure-portal-open-dashboard.png" alt-text="Screenshot showing how to open the .NET Aspire dashboard from the Azure portal.":::

1. The .NET Aspire dashboard, running in the Azure subscription opens. Select an endpoint for the **webapp** container:

    :::image type="content" source="../media/deployed-dashboard-open-webapp.png" lightbox="../media/deployed-dashboard-open-webapp.png" alt-text="Screenshot showing the .NET Aspire dashboard, deployed in an Azure subscription.":::

1. The web app is displayed. Notice that the site's URL indicates that it's running in Azure Container Apps.
1. When you're finished with the .NET Aspire solution, you can clean up your Azure subscription by deleting the **rg-aspireeshop** resource group.
