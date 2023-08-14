In this exercise, you deploy a sample ASP.NET Core Web app from GitHub, which has the code required to generate trace output messages. Then, you use the Azure portal to enable app logging for the app.

## Use Azure CLI to deploy a web app

In this task, you use Azure CLI to create an ASP.NET Web app using code from a GitHub repository. You also create a new storage account in the same region as the Web app, for log storage.

1. Let's set some variables, so we can use them throughout the rest of the exercise. Run the following commands in Azure Cloud Shell, replacing  _\<your-local-Azure-region\>_, with the region closest to you from the following list.

   [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

   ```bash
   gitRepo=https://github.com/MicrosoftDocs/mslearn-capture-application-logs-app-service
   appName="contosofashions$RANDOM"
   appPlan="contosofashionsAppPlan"
   resourceGroup=<rgn>[sandbox resource group name]</rgn>
   storageAccount=sa$appName
   appLocation=<your-local-Azure-region>
   ```

1. Run the following commands to deploy the web app.

   ```azurecli
   az appservice plan create --name $appPlan --resource-group $resourceGroup --location $appLocation --sku FREE
   az webapp create --name $appName --resource-group $resourceGroup --plan $appPlan --deployment-source-url $gitRepo
   ```

    The app may take several minutes to deploy.

1. Make a note of your app name, including the random number that was generated to uniquely identify your app. It should resemble something like: `contosofashions13642.azurewebsites.net`.

1. Run the following command to create a storage account.

   ```azurecli
   az storage account create -n $storageAccount -g $resourceGroup -l $appLocation --sku Standard_LRS 
   ```

Wait for the command to complete, and then continue with this exercise.

### Enable logging using the Azure portal

In this task, you use the Azure portal to enable app logging for the file system and Azure Blob storage. Start by verifying that your Web app is running.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account used to activate the sandbox.

1. On the Azure portal **Home** page, in the **Navigate** section, select **Subscriptions**. The **Subscriptions** pane for your *Microsoft Learn Sandbox* appears.

1. In the **Subscription name** list, select **Concierge Subscription**. The **Concierge Subscription** pane appears.

1. Select **Resources**. The list of resources, in the **Resource group** column should show your sandbox resource group (_<rgn>[sandbox resource group name]</rgn>_).

1. On the Azure portal menu, or from the **Home** page, select **App Services**. The **App Services** pane appears.

1. Select **contosofashionsNNNNN**, where NNNNN represents the random number generated for your app. The Overview pane for your App Service appears.

1. In the **Essentials** section, copy the **default domain** and paste it in a new browser tab (For example, https&#58;//contosofashionsNNNNN.azurewebsites.net). The home page for *Contoso Fashions* should appear.

   Let's set up app logging.

1. In the Azure portal, in the *App Services* menu, scroll down to **Monitoring**, and then select **App Service logs**. The **App Service logs** pane appears.

1. Under **Application Logging (Filesystem)**, select **On**, and in the **Level** box dropdown list, select **Error**.

1. Under **Application Logging (Blob)**, select **On**, and in the **Level** box dropdown list, select **Verbose**.

1. Select the link under **Storage Containers**. The **Storage accounts** pane appears. 

    > [!NOTE]
    > If a notification **Storage not configured** appears, select that text, and complete the previous 3 steps.

1. In the Name list, select **sacontosofashionsNNNN**, where NNNN is the number you noted when you created your app. The **Containers** pane appears.

1. In the command bar, select **Container**. The **New container** pane appears.

1. In the **Name** box, enter *asplogs*, and then select **Create**.

1. In the **Containers** pane, select **asplogs**, and then choose **Select**. The **App Service logs** pane appears.

1. In the **Retention Period (Days)** box, enter **5**.

1. In the command bar, select **Save** to update the log settings and close the **logs** pane.
