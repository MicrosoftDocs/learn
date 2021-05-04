### Sign in to Azure

1. From the terminal in Visual Studio Code, run the following command to sign in to Azure. Running this command will open a browser that allows you to sign in to your account.

    ```powershell
    Connect-AzAccount
    ```

1. After you're signed in, you see a list of the subscriptions associated with this account in the terminal. If you activated the sandbox, the Concierge Subscription should be in this list.
1. Get the subscription ID. The following command will list your subscriptions and their IDs in a easy-to-read table format. The subscription ID is the second column. Look for `Concierge Subscription` and copy the second column. It will look something like `cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0`.

    ```powershell
    Get-AzSubscription
    ```

1. Change your active subscription to the Concierge Subscription. Be sure to substitute `{Your subscription ID}` with the ID of the Concierge Subscription that you got in the previous command.

    ```powershell
    $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $context
    ```

### Set the default resource group

You now need to set the resource group created for you in the sandbox as the default resource group. To perform that operation, you first need to get the resource group name by using the following command:

```powershell
Get-AzResourceGroup
```

In this command, use the resource name that you got from the previous command. (It will look like something like `learn-a73131a1-b618-48b8-af70-21af7ca420c4`.) This command allows you to omit that parameter from the rest of the Azure PowerShell commands in this exercise.

> [!NOTE]
> Normally, when you use a PowerShell or Azure CLI command to deploy a template, you need to specify the target resource group name.  In the exercise in this module, we're bypassing this requirement by setting the context of our deployment. We're specifying our sandbox resource group name in the next step by using the [Set-AzDefault](https://docs.microsoft.com/powershell/module/az.accounts/set-azdefault?view=azps-4.5.0&azure-portal=true) PowerShell command.

```powershell
Set-AzDefault -ResourceGroupName {Resource Group Name}
```

## Deploy a linked template

In this exercise, we'll review and deploy a template that includes two linked templates.

1. To add a linked template to your ARM template, add a `Microsoft.Resources/deployments` resource and the `templateLink` property configured with the location of the template.

1. In the following sample template, notice that two variables define remote or external templates located in a GitHub repo:

    - [linked-template](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-storage-account-create/azuredeploy.json)
    - [linked-template-2](https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json)

    Review the template and note the `"type": "Microsoft.Resources/deployments"` sections that define where and how the linked templates will be deployed.

    The first linked template deploys a storage account. It consumes the parent parameters and deploys the storage template.

    The second linked template is configured to depend on the storage deployment, and to deploy a virtual network template.

    ```json
    {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "name": {
            "type": "string",
            "defaultValue": "linkeddemo001"
        }
    },
    "variables": {
        "linked-template": "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-storage-account-create/azuredeploy.json",
        "linked-template-2": "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"
    },
    "resources": [
        {
            "name": "storage",
            "type": "Microsoft.Resources/deployments",
            "apiVersion": "2019-10-01",
            "properties": {
                "mode": "Incremental",
                "templateLink": {
                    "uri": "[variables('linked-template')]",
                    "contentVersion": "1.0.0.0"
                },
                "parameters": {
                    "location": { "value": "[resourceGroup().location]" }
                }
            }
        },
        {
            "name": "identity",
            "type": "Microsoft.Resources/deployments",
            "apiVersion": "2019-10-01",
            "dependsOn": [
                "[resourceId('Microsoft.Resources/deployments','storage')]"
            ],
            "properties": {
                "mode": "Incremental",
                "templateLink": {
                    "uri": "[variables('linked-template-2')]",
                    "contentVersion": "1.0.0.0"
                }
            }
        }
    ],
    "outputs": {}
    }
    ```

1. Copy and paste the content of the preceding template into a file in a local directory. Use `C:\JSON\linkedtemplate.json`, for example.

1. After you've saved the file locally, use the following PowerShell command to deploy it at the resource group level that we talked about in the last unit. Namely, use [New-AzResourceGroupDeployment](https://docs.microsoft.com/powershell/module/az.resources/new-azresourcegroupdeployment?view=azps-4.4.0&azure-portal=true).

    ```powershell
        $templateFile="C:\JSON\linkedtemplate.json"
        $today=Get-Date -Format "MM-dd-yyyy"
        $DeploymentName="DeployLinkedTemplate-"+"$today"

        New-AzResourceGroupDeployment `
        -Name $DeploymentName `
        -TemplateFile $templateFile
    ```

    After it finishes, you should have results like this:

    :::image type="content" source="../../media/6-linked-template-results.png" alt-text="Results from deploying linked template.":::

1. Validate the results:

    1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription. To do that, select your avatar in the upper-right corner of the page. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.
    1. On the left panel, select **Resource groups**.
    1. Select <rgn>[sandbox resource group name]</rgn>.
    1. In the **Overview** area, you see that the deployment has succeeded. Select **3 Succeeded** to see the details of the deployment. (There might be more completed deployments, depending on whether you performed the previous unit's exercises.)

    :::image type="content" source="../../media/7-portal-deployment-details.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status.":::

    Notice that you deployed one template, but three are listed on the deployment pane of the portal. Those three deployments correspond to the main template and the two linked templates.

    :::image type="content" source="../../media/7-portal-deployment-listing.png" alt-text="Azure portal interface for the specific deployment with no resources listed.":::
