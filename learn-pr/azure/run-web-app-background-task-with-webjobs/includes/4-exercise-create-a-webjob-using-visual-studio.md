Developers can use Visual Studio 2017 to create a WebJob within a web app solution.

You want to begin building a WebJob for the luxury watch dealer’s site and to satisfy their request for the WebJob to run in the same web app as the production web site.

Here, you will create a web app from a template and then add a WebJob project to the same solution. This structure enables you to manage the web app and the WebJob as a single unit in source control systems.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create a storage account

The WebJob that you will create in this unit will write messages to a queue in an Azure Storage account. We'll start by creating that account, as well as a resource group to put it in.

Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true). Use the Cloud Shell (top-right **>_** inside a box) to run the following commands. In the `az group create` command, replace `<location>` with an Azure region name of your choosing. You can list all available regions with `az account list-locations --query [].name`.

When the last command completes, make a note of the storage account name it created. This will also store the connection string for the storage account in a shell variable, which we'll use shortly.

```azurecli
STORAGE_ACCOUNT_NAME=mslearnwebjobs$RANDOM

az group create --name mslearn-webjobs --location <location>

az storage account create \
    --name $STORAGE_ACCOUNT_NAME \
    --resource-group mslearn-webjobs

STORAGE_ACCOUNT_CONNSTR=$(az storage account show-connection-string --name $STORAGE_ACCOUNT_NAME --query connectionString --output tsv)

echo "Created storage account $STORAGE_ACCOUNT_NAME"
```

## Create a project

Next, use Visual Studio 2017 to create and publish a web app. This will represent the already-deployed production website in our watch-retailer scenario.

1. From the top menu bar in Visual Studio, select **File** > **New** > **Project**.
1. In the **New Project** dialog box, on the left-hand pane, expand **Visual C#** and then select **Web**.
1. In the center pane, click **ASP.NET Web Application (.NET Framework)**.
1. At the bottom of the dialog box, in the **Name** field, enter **WatchesWebApp**.
1. Click the **OK** button to create your project.
1. In the **ASP.NET Web Application** dialog box, you will see a selection of starting templates. For this exercise, select **MVC**, and then click **OK** to create your project.

    :::image type="content" source="../media/4-new-web-app.PNG" alt-text="New Project Dialog." loc-scope="aspnet"::: <!-- APEX13 -->

## Publish To Azure

You've now created a web application from the sample template and it is running locally. The next step is to publish the app to Azure.

1. Ensure that your copy of Visual Studio is logged into the account you have used to log in to Microsoft Learn. This will ensure that the sandbox subscription is available for publishing.
1. Right-click the **WatchesWebApp** project in Solution Explorer and select **Publish**.
1. Select **App Service** as the publish target, select **Create New**, and then click **Publish**.
1. In the **Create App Service** dialog, enter a name for your web application, and make a note of it for later. You can accept the default name. This name must be globally unique. For **Subscription**, select the subscription in which you created the mslearn-webjobs resource group. Select the resource group as well, then click **Create**.
1. When the deployment is complete, Visual Studio will open a new browser tab. After a short wait, the new web app will be displayed.

## Configure the web app

In this unit, you'll create a continuous WebJob. Continuous WebJobs require the **Always On** setting to be enabled on the web app that hosts them to ensure that they continue running.

Our WebJob's code will also need the connection string for our storage account. WebJobs have access to the same configuration settings as the web app that hosts them, so we can configure the connection string as a setting on the web app.

Run the following commands in the Cloud Shell window to configure the new web app.

```azurecli
WEB_APP_ID=$(az webapp list --resource-group mslearn-webjobs --query [0].id --output tsv)

az webapp config set --id $WEB_APP_ID --always-on true

az webapp config connection-string set --id $WEB_APP_ID --connection-string-type Custom --settings StorageAccount=$STORAGE_ACCOUNT_CONNSTR
```

## Add a WebJobs Project

Now, we'll add a WebJob to the web app solution in Visual Studio:

1. In Visual Studio, right-click the  **WatchesWebApp** project, click **Add**, and then select **New Azure WebJob Project**.
1. Change the project name to **StockCheckWebJob** and then click **OK**. The new project that has been created is a C# console application. The configuration has been added to the web application to automatically publish it as a WebJob whenever the application is published to Azure.
1. In the **Solution Explorer**, in the **StockCheckWebJob** project, double-click **Program.cs**.
1. Comment out all the code inside the `Main()` method. This code, created by the Visual Studio WebJobs template, uses the WebJobs SDK which you will use later on in this module. The first version of the WebJob you will create here will have no dependencies on the WebJobs SDK and is intended to show that there are no special requirements or dependencies needed for programs to be published as WebJobs.
1. Right-click the StockCheckWebJob project in Solution Explorer, select **Add** > **Reference**, and add a reference to **System.Configuration**.
1. At the top of the **Program.cs** code file, add these `using` statements:

    ```csharp
    using System.Configuration;
    using System.Threading;
    using Microsoft.WindowsAzure.Storage;
    using Microsoft.WindowsAzure.Storage.Queue;
    ```

## Complete the WebJobs project code

In our WebJob, we'll use the Azure Storage SDK to create queue messages in our storage account on a set interval. Once we have deployed the app as a WebJob, we can look at our storage account and see the output as evidence that our job is running.

1. Add the following code to the `Main()` method, below the code you commented out earlier. This code creates a new queue named `stockchecks` in the storage account and writes a new message into it every 30 seconds.

    ```csharp
    var queue = CloudStorageAccount.Parse(ConfigurationManager.ConnectionStrings["StorageAccount"].ConnectionString)
        .CreateCloudQueueClient()
        .GetQueueReference("stockchecks");

    queue.CreateIfNotExists();

    while (true)
    {
        var timestamp = DateTimeOffset.UtcNow.ToString("s");

        var message = new CloudQueueMessage($"Stock check at {timestamp} completed");
        queue.AddMessage(message);

        Thread.Sleep(TimeSpan.FromSeconds(30));
    }
    ```

## Publish the WebJob

Now that the code is complete, you can re-publish the application and the WebJob will be published along with it.

1. In the Visual Studio **Solution Explorer**, right-click the WatchesWebApp project (not the StockCheckWebJob project), and select **Publish**.
1. In the WatchesWebApp window that appears, select **Publish** to publish the web app again.

## Test the WebJob

The WebJob that you just published creates messages in queue storage on a schedule. Let's confirm that it's been deployed and check that it works:

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true), and search for and select your web app.
1. Under **Settings**, click **WebJobs**. You should see your WebJob in the list with a status of Running.
1. Navigate back to **All resources** and select the storage account created at the beginning of this exercise. Select **Queues** from the navigation menu.
1. The list should display a single queue, named `stockchecks`, created by the WebJob. If you select it, you'll see the messages that the WebJob is creating, one every 30 seconds.
