In this exercise, you will create your own template using the built-in Azure Shell Code editor.  for your own template creation i suggest [VS Code](https://code.visualstudio.com/) and the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools).  Together, they provide language support, resource snippets, and resource autocompletion when writing your templates. In essence, they simplifies the process of writing the ARM template.  I highly suggest that you checkout the [quickstart](https://docs.microsoft.com/azure/azure-resource-manager/templates/quickstart-create-templates-use-visual-studio-code?tabs=CLI) exercise after this Learn module.

1. Open Visual Studio Code from the Azure shell provides here in the sandbox by using the following command.

```shell
    code azuredeploy.json
```

Copy and paste the following JSON into the editor:

```JSON
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "apiProfile": "",
    "parameters": {},
    "variables": {},
    "functions": [],
    "resources": [],
    "outputs": {}
}

```

2. From the **editor** menu, select **save** to save your changes and close editor return to shell.

    ![visual studio code in shell save first template](../media/save-template.gif)

  This template doesn't deploy any resources. We're starting with a blank template to get familiar with the required steps to deploy, while minimizing the chance of something going wrong.

  The JSON file has these elements:

- **$schema**: Specifies the location of the JSON schema file. The schema file describes the properties that are available within a template. For example, the schema defines **resources** as one of the valid properties for a template. Don't worry that the date for the schema is "2019-04-01". This schema version is up to date and includes all of the latest features. The schema date hasn't been changed because there have been no breaking changes since its introduction.
- **contentVersion**: Specifies the version of the template (such as 1.0.0.0). You can provide any value for this element. Use this value to document significant changes in your template. When deploying resources using the template, this value can be used to make sure that the right template is being used.
- **resources**: Contains the resources you want to deploy or update. Currently, it's empty, but you'll add resources later.

3. Now that you saved the template. Close the editor by either clicking on the ellipsis (upper right corner **...**) and select **Close Editor**, or use the keyboard shortcut **CTRL-Q**.
---
## Create resource group

When you deploy a template, you need to specify a resource group that will contain the resources. Before running the deployment command, you must create the resource group. However, in the sandbox provided here, you already have a resource group to target your deployments.

1. To get the name of the resource group in the sandbox, you can use an Azure CLI command. Type the code below in the sandbox to list the resource group name.

    ```shell
    az group list --query "[?contains(name, 'learn')]" -o table
    ```

1. In order to use the resource group name in the deployment, we will store it in a variable in the shell by using the command:

    ```shell
    RG=$(az group list --query "[?contains(name, 'learn')].name" -o tsv)
    ```

To verify that the command successfully, you can use the **echo** command in the shell to print out on screen the content of the $RG variable.

    ```shell
    echo $RG
    ```
If **echo $RG** does not return a valid resource group name, use the **az group list** command to get the listing of all resource groups in your sandbox and look for the name.

    ![visual studio code in shell save first template](../media/az-list.png)


## Deploy the template

To deploy the template using Azure CLI using the resource group created for you in the sandbox, you will use the code below and you will also give a name to the deployment with a date code so you can easily identify it in the deployment history, even if you deploy the same template multiple times over multiple days.

The code below, sets the variables for:

1. The template filename and location (in the same folder for us)
1. Today's date
1. A deployment name variable based on a string and today's date.

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="blanktemplate-"$today

az deployment group create \
  --name $DeploymentName \
  --resource-group $RG \
  --template-file $templateFile
```

The deployment command returns results in a JSON format. Look for `ProvisioningState` to see whether the deployment succeeded.


![Azure CLI deployment provisioning state](../media/deploy-succeed.png)

---

## Verify deployment

You can verify the deployment by exploring the resource group from the Azure portal.

1. Sign in to the sign into the [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. From the left menu, select **Resource groups**.

![Azure Portal menu](../media/portal-menu.png)

1. Select the resource group you used to deploy your blank template in the last procedure. The resource group will have a name similar to **learn-0ab1c234-d567-8e90-fabcd-12e34d56789f**. You will not see any resource deployed within that resource group since our template had no resources.

1. Notice in the upper right of the overview, the status of the deployment is displayed. Select **1 Succeeded**.

   ![View deployment status](../media/portal-verify-deployment.png)

1. You see a history of the deployments for the resource group. Select the deployment that is contains  **blanktemplate** and the deployment date as part of the name.

   ![Select deployment](../media/portal-verify-blanktemplate.png)

1. You see a summary of the deployment. In this case, there's not a lot to see because no resources were deployed. Later in this series you might find it helpful to review the summary in the deployment history. Notice on the left you can view inputs, outputs, and the template used during deployment.

   ![View deployment summary](../media/Template-deploy-details.png)
