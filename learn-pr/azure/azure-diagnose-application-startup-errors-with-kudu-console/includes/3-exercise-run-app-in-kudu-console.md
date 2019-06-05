Kudu is the engine behind GIT deployments in Azure Web Sites. IT admin handling the hotel and resort website, will be able handle any app startup errors using the Azure App Service diagnostic tool.

In this unit, we'll create the Azure web app with Azure Portal. We'll then examine application event log using kudu console and run the app in kudu console.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create an Azure web app

We'll start by creating a web app to monitor. Follow these steps:

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. In the left pane, select **Create a resource**.
1. In the **Search the Marketplace** box, enter **web app**, and then select Enter.
1. In the list of results, select **Web App**.
1. On the **Web App** blade, select **Create**.

## Configure the web app

You need to set up a name, a resource group, a location, and some other properties for your web app. Follow these steps:

1. In the **App name** box, enter a unique name for your app. For example, you could use **&lt;yourname&gt;hotelapp**. The name you choose must be unique within the .azurewebsites.net domain.
1. In the **Subscription** list, select **Concierge subscription**.
1. Under **Resource Group**, select **Use existing** and then select the sandbox resource group, <rgn>[Sandbox resource group]</rgn>.
1. Leave the default values for the **OS**, **Publish**, **App Service plan/Location**, and **Application Insights** options.
1. At the bottom of the blade, select **Create**.
1. When the web app is created, in the left pane, select **All resources**.
1. In the list of resources, select the web app you just created.
1. Scroll down on the **Overview** page. 

## Access the Application Event Log through Azure Portal

1. In the Azure Portal, open the app in **App Services**.
1. Select **Diagnose and solve problems**.
1. Select **Diagnose Tools** menu option.
1. Select **Application Events** under **Support Tools**.
1. Review the latest error provided by *IIS AspNetCoreModule* or *IIS AspNetCoreModule V2* in the **Source** column.

## Access the Application Event Log through Kudu Console

1. Under the **Development Tools** section, open **Advanced Tools**. 
1. Select the **Go** button. This opens Kudu Console in a new window.
1. Open **Debug Console** in the top navigation bar and select **CMD**.
1. Open **LogFiles** folder.
1. Examine the **eventlog.xml** file and scroll to the bottom to see the most recent events.

## Run the app in Kudu Console

You can run the app in Kudu Console Remote Execution Console to discover useful information that is not immediately visible in the Application Event Log.

1. Under the **Development Tools** section, open **Advanced Tools**. 
1. Select the **Go** button. This opens Kudu Console in a new window.
1. Open **Debug Console** in the top navigation bar and select **CMD**.

#### Test a 64-bit (x64) app

##### Current release

* If the app is a 64-bit (x64) [framework-dependent deployment](/dotnet/core/deploying/#framework-dependent-deployments-fdd):
  1. `cd D:\Program Files\dotnet`
  1. Run the app: `dotnet \home\site\wwwroot\{ASSEMBLY NAME}.dll`
* If the app is a [self-contained deployment](/dotnet/core/deploying/#self-contained-deployments-scd):
  1. `cd D:\home\site\wwwroot`
  1. Run the app: `{ASSEMBLY NAME}.exe`

The console output from the app, showing any errors, is piped to the Kudu console.

##### Framework-dependent deployment running on a preview release

*Requires installing the ASP.NET Core {VERSION} (x64) Runtime site extension.*

1. `cd D:\home\SiteExtensions\AspNetCoreRuntime.{X.Y}.x64` (`{X.Y}` is the runtime version)
1. Run the app: `dotnet \home\site\wwwroot\{ASSEMBLY NAME}.dll`

The console output from the app, showing any errors, is piped to the Kudu console.