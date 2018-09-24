Next, let's use the Azure CLI to create a resource group, and then to deploy a web app into this resource group.

[!include[](../../../includes/azure-sandbox-activate.md)]

### Using a resource group

When you are working with your own machine and Azure subscription you will need to first login to Azure using the `az login` command. This is unnecessary with the Cloud Shell environment.

Next, you would normally create a resource group for all your related Azure resources with an `az group create` command, but for these exercises one has been created for you. Use **<rgn>[sandbox resource group name]</rgn>** for your resource group.

1. You can ask the Azure CLI to list all your resource groups in a table. There should just be one while you are in the free Azure sandbox.

    ```azurecli
    az group list --output table
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. As you do more Azure development, you can end up with several resource groups. If you have several items in the group list, you can filter the return values by adding a `--query` option. Try this command:

    ```azurecli
    az group list --query "[?name == '<rgn>[sandbox resource group name]</rgn>']"
    ```

    The query is formated using **JMESPath** which is a standard query language for JSON requests. You can learn more about this powerful filter language at <http://jmespath.org/>. We also cover queries in more depth in the **Manage VMs with the Azure CLI** module.

### Steps to create a service plan

When you run Web Apps, using the Azure App Service, you pay for the Azure compute resources used by the app, and this depends on the App Service plan associated with your Web Apps. Service plans determine the region used for the app datacenter, number of VMs used, and pricing tier.

1. Create an App Service plan to run your app. The following command does not specify a pricing tier or VM instance details, so by default, you'll get a **Basic** plan with 1 **Small** VM instance.

    > [!WARNING]
    > The name of the app and plan must be _unique_, so add a suffix to the name and replace the `<unique>` text in the command below with a set of numbers, your initials, or some other piece of text to make sure it's unique in all of Azure.

    For the `--location` parameter, use one of the below location values.

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

    ```azurecli
    az appservice plan create --name popupappplan-<unique> --resource-group <rgn>[sandbox resource group name]</rgn> --location <location>
    ```

    This command can take several minutes to complete.

1. Verify that the service plan was created successfully by listing all your plans in a table.

    ```azurecli
    az appservice plan list --output table
    ```

### Steps to create a web app

Next, you'll create the web app in your service plan. You can deploy the code at the same time, but for our example, we'll do this as separate steps.

1. Create the web app, supply the name of the plan you created above. **Just like the plan, the app name must be unique**, replace the `<unique>` marker with some text to make the name globally unique.

    ```azurecli
    az webapp create --name popupwebapp-<unique> --resource-group <rgn>[sandbox resource group name]</rgn> --plan popupappplan-<unique>
    ```

1. Verify that the app was created successfully by listing all your apps in a table.

    ```azurecli
    az webapp list --output table
    ```

1. Make a note of the **DefaultHostName** listed in the table; this is the reachable web address for the new website. Azure will make your website available through the unique app name in the `azurewebsites.net` domain. For example, if my app name was "popupwebapp-mslearn123", then my website URL would be: `http://popupwebapp-mslearn123.azurewebsites.net`.

1. Your site has a "QuickStart" page created by Azure that you can see either in a browser, or with CURL, just use the **DefaultHostName**:

    ```bash
    curl popupwebapp-<unique>.azurewebsites.net
    ```
    
### Steps to deploy code from GitHub

1. The final step is to deploy code from a GitHub repository to the web app. Let's use a simple PHP page available in the Azure Samples Github repository that displays "HelloWorld!" when it executes. Make sure to use the web app name you created.

    ```azurecli
    az webapp deployment source config --name popupwebapp-<unique> --resource-group <rgn>[sandbox resource group name]</rgn> --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration
    ```

1. Once it's deployed, hit your site again with a browser or CURL.

    ```bash
    curl popupwebapp-<unique>.azurewebsites.net
    ```
    
    The page displays "Hello World!"

    ```output
    Hello World!
    ```

This exercise demonstrated a typical pattern for an interactive Azure CLI session. You first used a standard command to create a new resource group. You then used a set of commands to deploy a resource (in this example, a web app) into this resource group. This set of commands could easily be combined into a shell script, and executed every time you need to create the same resource.