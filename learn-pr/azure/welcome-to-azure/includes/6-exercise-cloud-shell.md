The Azure portal offers a convenient user interface to search, install, and access the various Azure offerings available. You'll find, however, some of these tasks are repetitive and are candidates for automation using a command-line enabled interface.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## What is Azure Cloud Shell?

Azure Cloud Shell is a browser-based command-line experience for managing and developing Azure resources. Think of Cloud Shell as an interactive console that you run in the cloud.

Cloud Shell provides two experiences to choose from, Bash and PowerShell. Both include access to the Azure command-line interface called Azure CLI.

You can use any Azure management interface, including the Azure portal, Azure CLI, and Azure PowerShell, to manage any kind Azure resource. For learning purposes, here you'll use the Azure CLI to start and stop the WordPress site we created earlier.

Suppose you have several websites deployed and want to stop or start each of these websites without accessing each App service individually using the portal. This is an easy task that you can convert into a script using Cloud Shell and Azure CLI.

> [!IMPORTANT]
> This exercise uses the WordPress website you created in the  **Exercise - Create a Website** unit. Please make sure you've completed that exercise before continuing.

Accessing the Cloud Shell from within the Azure portal is done using the Cloud Shell icon. Click this icon to launch the interactive Cloud and when prompted, choose the Bash command-line experience.

![Screenshot showing icon to access cloud shell](../media/6-access-cloud-shell.png)

[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

> [!NOTE]
> On Microsoft Learn, you'll often see sample output, like the output shown above. We show you these examples so you can compare them to the output you see. However, it's just an example, so don't enter it into the Cloud Shell session.

1. Our first step is to make sure that we work with the correct Azure subscription before we change any settings. We'll use the `az account list` list command. By default, the command returns a *json* string. We'll format the output to make this information easier to work with. Run the following command.

    ```bash
    az account list --output table
    ```

    Copy the `SubscriptionId` that matches the Azure subscription you're using to run the exercises.

1. Run the `az account set --subscription` to set the subscription context.

    ```bash
    az account set --subscription xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx
    ```

1. Recall that we used a resource group called **learn-wordpress-blog-rg** when we created our website. However, if you ever need to list all the resource groups in a subscription, then you'll run the `az list groups` command.

    ```bash
    az group list --output table
    ```

    Copy the resource group you want to inspect, in our case **learn-wordpress-blog-rg**.

1. Next, we'll list all the resources in the **learn-wordpress-blog-rg** using the `az resource list` command. The command will return a list of resources. By specifying, `--resource-type` we can filter the result to include only the resource information related to websites.

    Run the following command.


    ```bash
    az resource list --resource-group learn-wordpress-blog-rg --resource-type Microsoft.Web/sites
    ```

    Here an example of the command's output::

    ```bash
    {
    "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx/resourceGroups/learn-wordpress-blog-rg/providers/Microsoft.Web/sites/BlogFor",
    "identity": null,
    "kind": "app",
    "location": "centralus",
    "managedBy": null,
    "name": "BlogFor",
    "plan": null,
    "properties": null,
    "resourceGroup": "learn-wordpress-blog-rg",
    "sku": null,
    "tags": null,
    "type": "Microsoft.Web/sites"
    }
    ```

    Copy the value of ID. We'll use it in the next steps to first stop and then start our website.

1. We'll use the `az webapp stop --id ` to stop the web application running in our App Service. Run the following command to stop the web app. Make sure to replace the example ID value with the value you copied earlier. In our example to command would look like the following snippet:

    ```bash
    az webapp stop --id "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx/resourceGroups/learn-wordpress-blog-rg/providers/Microsoft.Web/sites/BlogFor"
    ```

1. Open the website in a new browser tab. You'll find the URL to the site in the overview of the App service in the portal. You'll see a message in your browser that reads:

    ![Screenshot showing pre-configured WordPress website](../media/6-stopped-site.png)

1. Finally, let's start the web app by running the `az webapp start --id ` command. Run the following command to start the web app. Make sure to replace the example ID value with the value you copied earlier. In our example to command would look like the following snippet:

    ```bash
    az webapp start --id "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx/resourceGroups/learn-wordpress-blog-rg/providers/Microsoft.Web/sites/BlogFor"
    ```

1. Switch back to the tab for your website and refresh the page. Your website will be available after a couple of seconds.
