> [!IMPORTANT]
> This module creates Azure resources. If you don't plan to use this module again or if you don't complete the module, be sure to remove the created resources. Instructions for removing all resources are included at the end of the module.

This module assumes that you have Azure CLI installed. You can run commands from a Command Prompt window or Windows PowerShell. We recommend PowerShell.

The module also assumes that you have an Azure account. You need the Contributor and User Access Administrator roles on the Azure subscription, or Owner.

> [!IMPORTANT]
> If you belong to an organization, you might need to coordinate with your IT Team to create your Azure Active Directory (Azure AD) user account and grant the appropriate privileges. Also, guest accounts associated with your Azure subscription don't meet the minimum requirements. You must have a member account.

The ARM template logic has been integrated into a connection prefab that drives a data simulator.

## Download the solution and ARM template

In the previous unit, you cloned or downloaded [the repository from GitHub](https://aka.ms/mr-adt-mslearn).

## Sign in to Azure using Azure CLI

1. Locate the *azuredeploy.bicep* script that has been created for you. Typically, this file is in the root of the repository folder.
1. From the **Start** menu, open PowerShell. All Azure CLI commands run in your PowerShell console.
1. Change the current path to the location of the *azuredeploy.bicep* script you found in step 1.

   ```console
   cd <path for azuredeploy.bicep>
   ```

1. Sign in to Azure by using the [az login](/cli/azure/reference-index#az-login) command. This command opens a browser window and prompts for authentication.

   > [!NOTE]
   > If the command fails to open the appropriate browser window, use this command: `az login --use-device-code`. This device code flow returns a unique code. [Open the device sign-in page](https://aka.ms/devicelogin) in your browser and enter the code displayed in your terminal.

   :::image type="content" source="../media/az-login-results.png" alt-text="Screenshot of the output of the Windows PowerShell command running the az login command.":::

## Set variables in PowerShell

1. Set the `$projectname` variable. This value is the base unique name for the Azure resources that you create in this exercise. Extra random characters are appended to the project name. Make sure that your values are enclosed in double quotes.

   > [!NOTE]
   > Variables in PowerShell start with the `$` symbol.

   ```console
   $projectname="myproj"
   ```

   > [!IMPORTANT]
   > Your project name is a maximum of 14 characters. It can contain only lowercase letters, numbers, and the hyphen character.

1. Set the App Registration name, which can be a maximum of 14 characters. This value is the name of the application registration for your mixed reality app.

   ```console
   $appreg="myappreg"
   ```

## Create the App Registration

Run the following command to create a service principal and configure its access to Azure resources.

```console
az ad sp create-for-rbac --name ${appreg} --role Contributor --scopes /subscriptions/<SUBSCRIPTION-ID> > AppCredentials.txt
```

The output from this command is redirected from standard output to *AppCredentials.txt* text file. The command creates the file in the same directory where your run the command. Any errors that might occur are displayed in your PowerShell console. Open the file to retrieve the credentials to configure the telemetry simulator application later.

> [!NOTE]
> Be careful where you keep this file, because it contains credentials. Consider deleting the file after completing this learning path.

:::image type="content" source="../media/az-app-reg.png" alt-text="Screenshot of setting the app product and registration names and creating the app registration in PowerShell.":::

## Obtain the object ID of the App Registration and the user ID

1. Create and set a variable for the `ObjectID` in PowerShell by using the following command.

   ```console
   $objectid=$(az ad sp list --display-name ${appreg} --query [0].objectId --output tsv)
   ```

2. Validate that the variable contains a GUID by using the `echo` command. If not, examine your previous steps.

   ```console
   echo $objectid
   ```

3. Create and set a variable for the user ID.

   ```console
   $userid=$(az ad signed-in-user show --query objectId -o tsv)
   ```

4. Validate that the variable contains a GUID by using the `echo` command. If not, examine your previous steps.

   ```console
   echo $userid
   ```

   :::image type="content" source="../media/object-and-user-id.png" alt-text="Screenshot of using the Windows PowerShell environment to get the apps object and user ID.":::

## Create the Azure resource group

Create the resource group by using the [az group create](/cli/azure/group#az-group-create) command in PowerShell:

```console
az group create --name ${projectname}-rg --location eastus
```

Pay particular attention to the location. It must be `eastus`. This region is one of the valid regions for *Microsoft.SignalRService/SignalR* and *Microsoft.DigitalTwins/digitalTwinsInstances*.

## Deploy the ARM template to the newly created resource group

Deploy the supplied *bicep* file to your resource group and redirect the output to a text file called *ARM_deployment_out.txt*. This process can take 10-15 minutes to complete.

```console
az deployment group create --template-file azuredeploy.bicep --resource-group ${projectname}-rg `
   --parameters projectName=${projectname} userId=${userid} appRegObjectId=${objectid} `
   > ARM_deployment_out.txt
```

The file is for reference only. It isn't required for the rest of this module.

> [!NOTE]
> You might receive several WARNING messages regarding valid URI renaming that the output contains credentials and type availability. Review these warnings, but no immediate action is required. The warnings don't affect this module.

> [!TIP]
> If you need to re-create the Azure resources for any reason, be sure that you delete all previous instances of resources and resource groups.

## Install the Azure CLI extension

Install the *azure-iot* extension for the Azure CLI in PowerShell by using the [az extension](/cli/azure/extension#az-extension-add) command in PowerShell.

```console
az extension add --name azure-iot
```

This command downloads and installs the extension. If it's already installed, the command alerts you.

## Query Azure deployment for key configuration parameters

Query the Azure deployment by using the [az deployment group show](/cli/azure/deployment/group#az-deployment-group-show) command in PowerShell. This command redirects the output to a file named *Azure_config_settings.txt* in the same directory in which you run the command.

```console
az deployment group show --name azuredeploy --resource-group ${projectname}-rg `
   --query properties.outputs.importantInfo.value > Azure_config_settings.txt
```

## Query Azure deployment for resource group connection parameter

1. Use the [az iot hub connection-string show](/cli/azure/iot/hub/connection-string#az-iot-hub-connection-string-show) command to query the IoT hub for the resource group connection string parameter. You use this value later in the module. 

   ```console
   az iot hub connection-string show --resource-group ${projectname}-rg >> Azure_config_settings.txt
   ```

   The command redirects the output and appends it to the file named *Azure_config_settings.txt* in the same directory in which you run the command. You created this file in the previous section. The two `>` symbols indicate that the command appends rather than overwrites.

1. Confirm the contents of the output text file in PowerShell. This command displays several key configuration parameters for later use in this module.

   ```console
   get-content Azure_config_settings.txt
   ```

   :::image type="content" source="../media/query-azure-deployment-to-file.png" alt-text="Screenshot of running the get-content command in PowerShell." lightbox="../media/query-azure-deployment-to-file.png":::
