Here, you create an expression using template functions that creates a unique name per resource group by taking a prefix input and adding a hash of the resource group id. This results in storage account names similar to *dev2hu6sbtr5* or *staging5his8hgr67*.

This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## Create the Resource Manager template file

In the previous module, you created a Resource Manager template that deployed a Storage Account. You added parameters and an output to this file. Here, you start with that file, however, the output has been taken out to reduce the overhead.

1. Open Visual Studio Code and create a file called **azuredeploy.json**. If you have this file from the previous module, you can use that file.

1. Replace the contents of the file with the following.

    [!code-json[](code/starter.json)]

1. If you didn't complete the previous module, take a moment to review this file. Note the ```storageName``` parameter. This was used to pass in a unique name for the Storage Account.

## Create an expression to set a unique storage account name

Instead of passing in the name of the storage account, you change the parameter to take a prefix for the storage account name. This parameter will passed to the ```concat``` function in your expression.

1. In the parameters section, change ```storageName``` to **storagePrefix**.

1. Create the expression to set the unique storage account name. In the resources section, change the value of the ```name:``` and ```displayName:``` attributes from ```"[parameters('storageName')]"``` to **"[toLower(concat(parameters('storagePrefix'),uniqueString(resourceGroup().id)))]"**. This is the same expression you learned about in the previous unit. The file should now look like this.

    [!code-json[](code/function.json)]

## Deploy the Resource Manager template to Azure

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest) tools installed and that you are signing in to the same account that activated the sandbox.

### Sign in to Azure

1. From the terminal in Visual Studio Code, run this command to sign in to Azure. Running this command will open a browser that allows you to sign in to your account.

    ```azurecli
    az login
    ```

1. Once you are logged in, you see a list of the subscriptions associated with this account in the terminal. If you activated the sandbox, you see one called *Concierge Subscription*. You use this one for the rest of the exercise.
1. Set the default subscription for all of the Azure CLI commands you run in this session.

    ```azurecli
    az account set --subscription "Concierge Subscription"
    ```

> [!NOTE]
> If you have used more than one sandbox recently, there may be more than one *Concierge Subscription* listed. In this case, use the next two steps to set the default subscription. If the above command was successful, skip the next two steps.

1. Get the *Concierge Subscription* IDs.

   ```azurecli
    az account list \
      --refresh \
      --query "[?contains(name, 'Concierge Subscription')].id" \
      --output table
    ```

1. Set the default subscription using the subscription ID. Replace the *{your subscription ID}* with the latest Concierge Subscription ID.

    ```azurecli
    az account set --subscription {your subscription ID}
    ```

### Set the default resource group

1. Set the default resource group to the resource group created for you in the sandbox environment. This allows you to omit that parameter from the rest of the Azure CLI commands in this exercise.

    ```azurecli
    az configure --defaults group=<rgn>[sandbox resource group name]</rgn>
    ```

### Deploy the template to Azure

Deploy the template to Azure. You learned about the deployment commands in the previous module. Here, we are using the Azure CLI ```az deployment group create``` command.

1. Deploy the template using Azure CLI commands in the terminal. Remember to substitute {your-prefix} with a different string. For example, you could use **storage**.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addfunction-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters storagePrefix={your-prefix}
    ```

      In the top section of this code, you set Azure CLI variables for the path to the template file to deploy, and the name of this deployment. Then, you use the ```az deployment group create``` command to deploy the template to Azure.

1. You see ```Running...``` in the terminal. When that finishes, navigate to [Azure](https://portal.azure.com?azure-portal=true) and make sure you are in the sandbox subscription. To do that, select your avatar in the upper right corner of the page. Choose **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left side panel, choose *Resource groups*.
1. Select <rgn>[sandbox resource group name]</rgn>.
1. In the *Overview*, you see one deployment succeeded.

    :::image type="content" source="../media/3-deployment-succeeded.png" alt-text="Azure portal interface for the resource group overview with the deployments section showing one succeeded." border="true":::

1. Select *1 Succeeded* to see the details of the deployment.

    :::image type="content" source="../media/3-add-function.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

1. Select *addfunction* to see what resources were deployed.

    :::image type="content" source="../media/3-unique-storage-deploy.png" alt-text="Azure portal interface showing the storage account deployed." border="true":::

1. Leave the page open in your browser. You'll check on deployments again.
