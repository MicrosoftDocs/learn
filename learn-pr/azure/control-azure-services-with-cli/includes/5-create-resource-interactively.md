<!-- markdownlint-disable MD041 -->

In interactive mode, Azure CLI allows you to enter and run commands immediately.

In the Customer Relationship Management (CRM) example, the goal is to create three test
environments, each containing virtual machines (VMs). Use resource groups to ensure the VMs are
organized into separate environments:

- Unit testing
- Integration testing
- Acceptance testing

Since you only need to create the resource groups once, using Azure CLI interactively for this task
is a reasonable choice.

When you run a command in Azure CLI, it matches the command to a cmdlet and performs the requested
action.

## Example: How to create a resource group with Azure CLI

Let's perform a common task: creating a resource group. Resource groups help you manage related
resources collectively, and creating a new resource group is often one of the first tasks you
perform when starting a new Azure solution.

Here are the three steps you need to follow:

1. Connect to Azure using `az login`.

1. Work with Azure subscriptions using `az account`.

1. Work with resource groups using `az group`.

### 1 - Connect to Azure

When using a local installation of Azure CLI, you must authenticate before executing any
Azure CLI commands. The `az login` command prompts you for your Azure credentials and
then connects to your Azure subscription.

To connect interactively, you don't need to specify parameters:

```azurecli
az login
```

This command opens a prompt for your Azure credentials and establishes a connection to your Azure
subscription.

Here are some handy tips when authenticating to Azure with Azure CLI:

- If running the Azure CLI in Azure Cloud Shell ...
  - You are authenticated automatically.
  - You might need to change your default subscription.

- When running the Azure CLI through a local installation ...
  - You are prompted for your Azure credentials.
  - There is a subscription selector at time of login.

### 2 - Work with subscriptions

If you're new to Azure, you only have a single subscription. However, if you've been using Azure for
a while, you might have multiple subscriptions. Azure CLI allows you to configure which
subscription your commands are executed against.

You can only be active in one subscription at a time. Use the `az account show` reference command to determine
which subscription is currently active. If it's not the correct one, you can switch subscriptions
using the `az account set` reference command.

1. Get a list of all your subscriptions returning the results in a table:

   ```azurecli
   az account list --output table
   ```

1. Get just the current active subscription:

   ```azurecli
   az account show
   ```

1. Change your active subscription:

   ```azurecli
   az account set --subscription "00000000-0000-0000-0000-000000000000"
   ```

### 3 - Work with resource groups

When creating resources in Azure, you place them into a resource group for management purposes.

To create a resource group, use the `az group create` reference command. You must specify a name and a
location, and the name must be unique within your subscription. The location determines where the
metadata for your resource group is stored, which can be important for compliance reasons. Use the
`az account list-locations` command to determine the available locations.

> [!NOTE]
> If you are working in an Azure sandbox, it creates the resource group for you. If you prefer to
> work in your own subscription, use the following command.

The syntax for creating a resource group is:

```azurecli
az group create --name MyResourceGroup --location eastus
```

To retrieve a list of all resource groups in the active subscription, use the `az group list` command.

```azurecli
az group list
```

For a more concise view, you can return the list in a table:

```azurecli
az group list --output table
```

When you are developing and testing an Azure CLI script, it's best to create a resource group that contains a random ID in the name. Adding a random ID to your resource group name allows you to retest your code without having to wait for a prior resource group of the same name to be removed from Azure.

```azurecli
# Bash script
let "randomIdentifier=$RANDOM*$RANDOM"
location="eastus"
resourceGroup="msdocs-training-rg-$randomIdentifier"
az group create --name $resourceGroup --location $location --output json
```

## Example: Create an Azure Virtual Machine

Creating virtual machines (VMs) is a common task you can perform with Azure CLI.

The `az vm create` command is used to create a VM. This command has several parameters to handle the extensive configuration settings for a VM. Most parameters have reasonable default values, so you typically need to specify only five key items:

- **resource-group**: The resource group where the new VM is placed.
- **name**: The name of the VM in Azure.
- **location**: The geographic region where the VM is provisioned.
- **image**: The operating system image to use for the VM, typically a Linux distribution or Windows Server.
- **admin-username**: Administrator username for the VM. You'll be prompted to enter a password at the command line.

Here's a Bash script example:

```azurecli
# Bash variable block
rgName="myResourceGroupName"
vmname="myVMname"
username="azureuser"

# Create the VM
az vm create \
    --resource-group $rgName \
    --name $myVMname \
    --image Win2022AzureEditionCore \
    --public-ip-sku Standard \
    --admin-username $username 
```

## Example: Update the size of an Azure Virtual Machine

You can list the VMs in your subscription using the `az vm list` command. This command also supports retrieving a specific VM by specifying the **name** parameter.

Store the results of `az vm list` in a variable:

```azurecli
rgName="myResourceGroupName"
vmID=$(az vm list --resource-group $rgName \
    --query "[?name=='myVMname'].id" --output tsv)
echo $vmID
```

The contents of the `vmID` variable is an object you can interact with. For example, you can make
changes to your VM using the `az vm update` command:

```azurecli
# Bash variable block
rgName="myResourceGroupName"
vmName="myVMname"
newVMsize="Standard_DS3_v2"

# Get the VM ID
vmID=$(az vm list --resource-group $rgName \
    --query "[?name==$vmName].id" --output tsv)

# Update the VM size
az vm update --resource-group $rgName --ids $vmID --size $newVMsize

# Show the new properties of the VM
az vm show --resource-group $rgName --name $vmName
```

Using CLI in interactive mode is appropriate for one-off tasks. For example, you can create
and manage resource groups interactively if they're only created once during the lifetime of a
project. Interactive mode is often quicker and easier than writing a script for tasks that are
executed only once.






















*****************************************************************
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
