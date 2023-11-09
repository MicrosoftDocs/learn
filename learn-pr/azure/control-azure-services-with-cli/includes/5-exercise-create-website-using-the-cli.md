Next, let's use the Azure CLI to create a resource group, then deploy a web app into that resource group.

[!INCLUDE[Azure Sandbox regions note](../../../includes/azure-sandbox-regions-first-mention-note.md)]

### Use a resource group

When you're working with your own machine and Azure subscription, you need to sign in to Azure using the `az login` command. However, signing in is unnecessary when you're using the browser-based Cloud Shell sandbox environment.

Next, you'd normally create a resource group for all your related Azure resources with an `az group create` command, but for this exercise, the following resource group has been created for you: **<rgn>[sandbox resource group name]</rgn>**.

> [!NOTE]
> For this exercise, we're using East US as the region. If you encounter an issue when you create the app service plan, select a different region from the preceding list.

1. Your first step in this exercise is to create several variables to use in later commands:

   ```bash
   export RESOURCE_GROUP=<rgn>[sandbox resource group name]</rgn>
   export AZURE_REGION=eastus
   export AZURE_APP_PLAN=popupappplan-$RANDOM
   export AZURE_WEB_APP=popupwebapp-$RANDOM
   ```

1. You can ask the Azure CLI to list all your resource groups in a table. There should just be one while you're in the free Azure sandbox:

   ```azurecli
   az group list --output table
   ```

   [!INCLUDE[Copy paste tip](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. As you do more Azure development, you can end up with several resource groups. If you have several items in the group list, you can filter the return values by adding a `--query` option. Try the following command:

   ```azurecli
   az group list --query "[?name == '$RESOURCE_GROUP']"
   ```

   The query is formatted using **JMESPath**, which is a standard query language for JSON requests. You can learn more about this powerful filter language at <http://jmespath.org/>. We also cover queries in more depth in the [**Manage VMs with the Azure CLI**](/training/modules/manage-virtual-machines-with-azure-cli/) module.

### Steps to create a service plan

When you run Web Apps using the Azure App Service, you pay for the Azure compute resources that the app uses and the resource costs depend on the App Service plan associated with your Web Apps. Service plans determine the region used for the app datacenter, number of VMs used, and pricing tier.

1. Create an App Service plan to run your app. The following command specifies the free pricing tier, but you can run `az appservice plan create --help` to see the other pricing tiers.

   > [!NOTE]
   > The app and plan names must be _unique_ in all of Azure. The variables that you created earlier will assign random values as suffixes to make sure they're unique. However, if you receive an error when you're creating any resources, you should run the commands listed earlier to reset all of the variables with new random values.
   >
   > If you receive an error about the resource group, run the commands listed earlier with a different resource group value.

   ```azurecli
   az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE
   ```

   This command can take several minutes to complete.

1. Verify that the service plan was created successfully by listing all your plans in a table:

   ```azurecli
   az appservice plan list --output table
   ```

   You should get a response like the following example:

   ```output
   Kind    Location    MaximumNumberOfWorkers    Name                NumberOfSites    ResourceGroup                               Status
   ------  ----------  ------------------------  ------------------  ---------------  ------------------------------------------  --------
   app     East US     3                         popupappplan-54321  0                Learn-12345678-1234-1234-1234-123456789abc  Ready
   ```

### Create a web app

Next, create the web app in your service plan. You can deploy the code at the same time, but for our example, we'll create the web app and deploy the code as separate steps.

1. To create the web app, supply the web app name and the name of the app plan you created previously. Just like the app plan name, the web app name must be unique. The variables that you created earlier assign random values that should be sufficient for this exercise. This command can take a few moments to complete.

   ```azurecli
   az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN
   ```

1. Verify that the app was created successfully by listing all your apps in a table:

   ```azurecli
   az webapp list --output table
   ```

   You should get a response like the following example:

   ```output
   Name               Location    State    ResourceGroup                               DefaultHostName                      AppServicePlan
   -----------------  ----------  -------  ------------------------------------------  -----------------------------------  ------------------
   popupwebapp-12345  East US  Running  Learn-12345678-1234-1234-1234-123456789abc  popupwebapp-12345.azurewebsites.net  popupappplan-54321
   ```

   Make a note of the **DefaultHostName** listed in the table; this address is the URL for the new website. Azure makes your website available through the unique app name in the `azurewebsites.net` domain. For example, if your app name was "popupwebapp-12345", then your website URL would be: `http://popupwebapp-12345.azurewebsites.net`. You can also use the following script to return the HTTP address:

   ```bash
   site="http://$AZURE_WEB_APP.azurewebsites.net"
   echo $site
   ```

1. To get the default HTML for the sample app, use CURL with the DefaultHostName:

    ```bash
    curl $AZURE_WEB_APP.azurewebsites.net
    ```

   You should get a response like the following example:

   ```output
   <!DOCTYPE html><html lang="en"><head><meta charset="utf-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><meta http-equiv="X-UA-Compatible" content="IE=edge"/><title>Microsoft Azure App Service - Welcome</title><link rel="shortcut icon" href="https://appservice.azureedge.net/images/app-service/v4/favicon.ico" type="image/x-icon"/><link href="https://appservice.azureedge.net/css/app-service/v4/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous"/><style>html, body{height: 100%; background-color: #ffffff; color: #000000; font-size: 13px;}*{border-radius: 0 !important;}</style> ... (continued)
   ```

### Deploy code from GitHub

1. The final step is to deploy code from a GitHub repository to the web app. Let's use a basic PHP page available in the Azure Samples GitHub repository that displays "Hello World!" when it executes. Make sure to use the web app name you created. This command can take a few moments to complete.

   ```azurecli
   az webapp deployment source config --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration
   ```

1. Once it's deployed, hit your site again with a browser or CURL:

   ```bash
   curl $AZURE_WEB_APP.azurewebsites.net
   ```

   The page displays "Hello World!"

   ```output
   Hello World!
   ```

This exercise demonstrated a typical pattern for an interactive Azure CLI session. You first used a standard command to create a new resource group. You then used a set of commands to deploy a resource (in this example, a web app) into this resource group. You could easily combine this set of commands into a shell script and execute it every time you need to create the same resource.
