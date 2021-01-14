In this unit, you'll enable app logging for the new fashions Azure Web App.

You're going to deploy a sample ASP.NET Core Web app from GitHub; this app includes code to generate various trace output messages. You'll then use the Azure portal to enable app logging for this app.

## Use Azure CLI to deploy a web app

In this step, to create an ASP.NET Web app using code from a GitHub repository, you're going to use Azure CLI commands. You will also create a new storage account, in the same region as the Web app, for log storage.

1. To set some variables, replacing  _\<your-local-Azure-region\>_, with the closest region to you from the following list, in the Cloud Shell, run the following commands.

   [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

   ```bash
   gitRepo=https://github.com/MicrosoftDocs/mslearn-capture-application-logs-app-service
   appName="contosofashions$RANDOM"
   appPlan="contosofashionsAppPlan"
   appLocation=<your-local-Azure-region>
   resourceGroup=<rgn>[sandbox resource group name]</rgn>
   storageAccount=sa$appName
   ```

1. To deploy the web app, in the Cloud Shell, run the following commands.

   ```azurecli
   az appservice plan create --name $appPlan --resource-group $resourceGroup --location $appLocation --sku FREE
   az webapp create --name $appName --resource-group $resourceGroup --plan $appPlan --deployment-source-url $gitRepo
   ```

1. Make a note of the random number suffix in your app name; this was generated to uniquely identify your app. The app may take several minutes to deploy.

1. To create a storage account, in the Cloud Shell, run the following command.

   ```azurecli
   az storage account create -n $storageAccount -g $resourceGroup -l $appLocation --sku Standard_LRS 
   ```

1. Before continuing with the exercise, wait until the commands have been completed.

### Enable logging using the Azure portal

In this step, you're going to use the Azure portal to enable app logging to the file system, and to Azure Blob storage. You'll start by checking that your Web app is running.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Portal toolbar, select **Subscriptions**, and in the directories list, select **Microsoft Learn Sandbox** (this is the directory associated with the _Concierge Subscription_).

1. On the Azure portal menu, or from the **Home** page, select **Resource groups**, and check that your sandbox resource group (_<rgn>[sandbox resource group name]</rgn>_) is listed.

1. On the Azure portal menu, select **App Services**.

1. In the **App Services** list, select **contosofashions\<_your-number_\>**.

1. In the **Overview** section, to open the home page for the **Contoso Fashions** website in a new browser tab, select the URL string (https&#58;//contosofashions\<_your-number_\>.azurewebsites.net).

You'll now set up the app logging.

1. Switch to the tab showing the Azure portal.

1. On the left-hand side, scroll down to the **Monitoring** section, and then select **App Service logs**.

1. Under **Application Logging (Filesystem)**, select **On**, and in the **Level** box, select **Error**.

1. Under **Application Logging (Blob)**, select **On**, and in the **Level** box, select **Verbose**.

1. Select **Storage Settings**, and on the **Storage Accounts** pane, select **sacontosofashions\<_your-number_\>**, where \<_your-number_\> is the number suffix you noted when you created your app.

    If it says **Storage not configured**, select that text, and follow the previous directions.

1. On the **Containers** pane, select **+ Container**, and in the **Name** box, enter **asplogs**, and then select **Create**.

1. Select **asplogs**, and then select **Select**.

1. In the **Retention Period (Days)** box, enter **5**.

1. To close the **logs** pane, and update the log settings, select **Save**.
