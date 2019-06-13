Kudu is the engine behind GIT deployments in Azure Web Sites. IT admin handling the hotel and resort website, will be able handle any app startup errors using the Azure App Service diagnostic tool.

In this unit, we'll create the Azure web app with Azure Portal. We'll then examine application event log using kudu console and run the app in kudu console.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create an Azure web app

We'll start by creating a web app to monitor. Follow these steps:

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. In the left pane, select **Create a resource**.
1. In the **Search the Marketplace** box, enter **web app**, and then select Enter.
1. In the list of results, select **Web App**.

## Configure the web app

You need to set up a name, a resource group, a location, and some other properties for your web app. Follow these steps:

1. In the **Subscription** list, select **Concierge subscription**.
1. Under **Resource Group**, select existing sandbox resource group from the drop down, <rgn>[Sandbox resource group]</rgn>.
1. In the **App name** box, enter a unique name for your app. For example, you could use **&lt;yourname&gt;HotelApp**. The name you choose must be unique within the `.azurewebsites.net` domain.
1. Leave the default values for **Publish** field.
1. Select *`.NET Core 2.2`* for Runtime stack.
1. Select **Windows** for Operating System.
1. Use the default selection for **Region** and **Plan**
1. Select **Standard S1** for **Sku and size** options.
1. Optional - In the **Monitoring** tab, select **No** for **Enable Application Insights**.
1. At the bottom of the blade, select **Review and Create**.
1. Review the summary screen details and select **Create**.
1. When the web app is created, in the left pane, select **All resources**.
1. In the list of resources, select the web app you just created.
1. Scroll to the left of the **Overview** page.
1. To preview your new web app's default content, click on the URL in the top right of the web app overview page. If you see a placeholder web page, it means you have successfully created the web app.