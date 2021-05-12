> [!NOTE]
> This exercise requires an Azure subscription. If you don't have an Azure subscription, you can get a [free subscription](https://azure.microsoft.com/free/?azure-portal=true).

TODO scenario

> [!div class="checklist"]
> * TODO

## Prerequisites

To complete this exercise, you'll need:

- An Azure subscription.
- Management groups to be enabled on your Azure tenant.
- Permission to deploy Azure Policy resources to a management group.

## Create a management group

If you don't have a test management group to work within, create a new management group for this exercise. If you already have a management group you can deploy test resources into, you can skip these steps.

TODO

## Get the management group ID

TODO

## Create a Bicep file to deploy to a management group

1. Open Visual Studio Code, and create a new file called *main.bicep*. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select File > Save, or use the <kbd>Ctrl+S</kbd> keyboard shortcut (<kbd>⌘+S</kbd> on macOS). Make sure you remember where you save the file - for example, you might want to create a **scripts** folder to save it in.

1. Add the following content into the file. You'll deploy the template soon. It's a good idea to type this in yourself instead of copying and pasting, so that you can see how the tooling helps you to write your Bicep files.

   :::code language="bicep" source="code/4-template.bicep" range="1" :::

   Note that this line of code tells Bicep that your template is going to be deployed at a management group scope.

## Add a policy definition and assignment

TODO

### Deploy the template to Azure

::: zone pivot="cli"

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

```azurecli
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
deploymentName="new-mg"

az deployment mg create \
    --TODO \
    --name $deploymentName \
    --location westus \
    --template-file $templateFile
```

::: zone-end

::: zone pivot="powershell"

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$templateFile = "main.bicep"
$deploymentName = "new-mg"

New-AzManagementGroupDeployment `
  -TODO $TODO `
  -Name $deploymentName `
  -Location westus `
  -TemplateFile $templateFile
```

::: zone-end

Notice that, like with subscription deployments, you're explicitly specifying a name and location for the deployment metadata.

The deployment might take a minute or two to complete, and then you'll see a successful deployment.

## Verify the deployment

You can view subscription-scoped deployments in the Azure portal. This can be helpful to verify that the deployment has finished successfully and to inspect the results.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left-side panel, select **Management groups**. TODO not in left panel

1. Select the management group you're using.

TODO check below

1. At the top of the left menu, in the **Search** box, enter **Deployments** and select the **Deployments** menu item.

    :::image type="content" source="../media/4-search.png" alt-text="Screenshot of the Azure portal interface showing the search field and the Deployments menu item." border="true":::

1. Select the deployment called **new-subscription** to see what resources were deployed.

   :::image type="content" source="../media/4-deployment-list.png" alt-text="Screenshot of the Azure portal interface showing the list of deployments." border="true":::

1. Select **Deployment details** to expand it. In this case, the two Azure Policy resources are listed.

    :::image type="content" source="../media/4-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment." border="true":::
