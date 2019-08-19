In this unit, you will enable application logging for the new fashions Azure Web App.

::: zone pivot="csharp"

## ASP.NET

You're going to deploy a sample ASP.NET Core Web app from GitHub; this app includes code to generate various trace output messages. You'll then use the Azure portal to enable application logging for this app.

## Use Azure CLI to deploy a web app

In this step, you're going to use Azure CLI commands to create an ASP.NET Web app using code from a GitHub repository. You will also create a new storage account, in the same region as the Web app, for log storage.

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Run the following commands in the Cloud Shell to set some variables, replacing  _\<your-local-Azure-region\>_, with the closest region to you from the following list.
   [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

   ```bash
   gitRepo=https://github.com/MicrosoftDocs/mslearn-capture-application-logs-app-service
   appName="contosofashions$RANDOM"
   appPlan="contosofashionsAppPlan"
   appLocation=<your-local-Azure-region>
   resourceGroup=<rgn>[sandbox resource group name]</rgn>
   storageAccount=sa$appName
   ```

1. Run the following commands in the Cloud Shell to deploy the web app.

   ```azurecli
   az appservice plan create --name $appPlan --resource-group $resourceGroup --location $appLocation --sku FREE
   az webapp create --name $appName --resource-group $resourceGroup --plan $appPlan --deployment-source-url $gitRepo
   ```

1. Make a note of the random number suffix in your app name; this was generated to uniquely identify your app. The app may take several minutes to deploy.

1. Run the following command in the Cloud Shell to create a storage account.

   ```azurecli
   az storage account create -n $storageAccount -g $resourceGroup -l $appLocation --sku Standard_LRS 
   ```

1. Wait until the commands have completed before continuing with the exercise.

### Enable logging using the Azure portal

In this step, you're going to use the Azure portal to enable application logging to the file system, and to Azure Blob storage. You'll start by checking that your Web app is running.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. On the Portal toolbar, click the **Global subscription filter (Directory + subscription)** button, and in the directories list, select **Microsoft Learn Sandbox** (this is the directory associated with the _Concierge Subscription_).
1. Click **Resource groups** in the sidebar menu on the left, and check that your sandbox resource group (_<rgn>[sandbox resource group name]</rgn>_) is listed.
1. Click **App Services** in the sidebar menu on the left.
1. In the **App Services** list, click **contosofashions\<_your-number_\>**, and then in the **Overview** section, click on the URL string (https&#58;//contosofashions\<_your-number\ >.azurewebsites.net) to open the home page for the **Contoso Fashions** website in a new browser tab.

You'll now set up the application logging.

1. Switch to the tab showing the Azure portal.
1. In the **App Service** blade, scroll down to the **Monitoring** section, and then click **Diagnostics logs**.
1. Under **Application logging (Filesystem)**, click **On**, and in the **Level** box, click **Error**.
1. Under **Application logging (Blob)**, click **On**, and in the **Level** box, click **Verbose**.
1. Click **Storage Settings**, and on the **Storage Accounts** blade, click **sacontosofashions\<_your-number_\>**, where \<_your-number_\> is the number suffix you noted when you created your app.
1. On the **Containers** blade, click **+ Container**, and in the **Name** box, type **asp logs**, and then click **OK**.
1. Click **asplogs**, and then click **Select**.
1. In the **Retention Period (Days)** box, type **5**.
1. Click **Save** to close the **Diagnostics logs** blade, and update the log settings.


::: zone-end

::: zone pivot="javascript"

##  Node.js

You're going to deploy a sample Node.js app from GitHub; this app includes code to generate various console output messages. You'll then use the Azure portal to enable application logging for this app.

### Use Azure CLI to deploy a web app

In this step, you're going to use Azure CLI commands to create a Node.js Web app using code from a GitHub repository. 
<!-- TODO App code is currently in a personal repo, so needs to be moved to a Learn repo. -->

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Run the following commands in the Cloud Shell to set some variables, replacing  _\<your-local-Azure-region\>_, with the closest region to you from the following list.
   [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

   ```azurecli
   # Replace the following URL with a public GitHub repo URL
   gitRepo=https://github.com/MicrosoftDocs/mslearn-capture-application-logs-app-service
   appName="contosofashions$RANDOM"
   appPlan="contosofashionsAppPlan"
   appLocation=<your-local-Azure-region>
   resourceGroup=<rgn>[sandbox resource group name]</rgn>
   ```

1. Run the following commands in the Cloud Shell to deploy the web app.

   ```azurecli
   az appservice plan create --name $appPlan --resource-group $resourceGroup --location $appLocation --sku FREE --is-linux
   az webapp create --name $appName --resource-group $resourceGroup --plan $appPlan --runtime "node|6.10" --deployment-source-url $gitRepo
   ```

1. Make a note of the random number suffix in your app name; this was generated to uniquely identify your app.

1. Wait until the commands have completed before continuing with the exercise.

### Enable logging using the Azure portal

In this step, you're going to use the Azure portal to enable application logging to the file system. You'll start by checking that your Web app is running.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. On the Portal toolbar, click the **Global subscription filter (Directory + subscription)** button, and in the directories list, select **Microsoft Learn Sandbox** (this is the directory associated with the _Concierge Subscription_).
1. Click **Resource groups** in the sidebar menu on the left, and check that your sandbox resource group (_<rgn>[sandbox resource group name]</rgn>_) is listed.
1. Click **App Services** in the sidebar menu on the left.
1. In the **App Services** list, click **contosofashions\<_your-number_\>**, and then in the **Overview** section, click on the URL string (https&#58;//contosofashions\<_your-number\ >.azurewebsites.net) to open the home page for the **Contoso Fashions** website in a new browser tab.

You'll now set up the application logging.

1. Switch to the tab showing the Azure portal.
1. In the **App Service** blade, scroll down to the **Monitoring** section, and then click **Diagnostics logs**.
1. Under **Application logging**, click **File System**, and in the **Retention Period (Days)** box, type **5**.
1. Click **Save** to close the **Diagnostics logs** blade, and update the log settings.

::: zone-end



