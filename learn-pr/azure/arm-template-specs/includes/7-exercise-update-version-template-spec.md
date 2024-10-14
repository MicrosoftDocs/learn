Your Azure Cosmos DB template spec is now used throughout your organization to provision lots of new Azure Cosmos DB accounts. Accordingly, all of them are configured to use continuous backup.

Your security team recently reviewed the Azure Cosmos DB security capabilities. It decided that new accounts should use Microsoft Entra authentication and Azure Cosmos DB role-based access control.

In this exercise, you update your template spec with a new version that includes the updated authentication configuration.

During the process, you'll:

> [!div class="checklist"]
> * Update your template to reconfigure the backup policy.
> * Publish a new version of your template spec.
> * Verify that the template spec has been updated.
> * Test the new version of your template spec by deploying another Azure Cosmos DB account.

## Update the template

::: zone pivot="jsoncli,jsonpowershell"

1. In Visual Studio Code, open the *azuredeploy.json* file.

1. Update the *azuredeploy.json* file to include the following changes:

   :::code language="json" source="code/7-template.json" highlight="21-43, 45-48, 75-108" :::

1. Save the file.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

1. In Visual Studio Code, open the *main.bicep* file.

1. Update the *main.bicep* file to include the following changes:

   :::code language="bicep" source="code/7-template.bicep" highlight="9-22, 45-70" :::

1. Save the file.

::: zone-end

## Publish a new version of the template spec

::: zone pivot="biceppowershell,jsonpowershell"

Publish the template spec by using this Azure PowerShell cmdlet in the Visual Studio Code terminal:

::: zone-end

::: zone pivot="biceppowershell"

:::code language="azurepowershell" source="code/7-add-version.ps1" range="1-5, 7" :::

::: zone-end

::: zone pivot="jsonpowershell"

:::code language="azurepowershell" source="code/7-add-version.ps1" range="1-6" :::

::: zone-end

::: zone pivot="bicepcli,jsoncli"

Publish the template spec by using this Azure CLI command in the Visual Studio Code terminal:

::: zone-end

::: zone pivot="bicepcli"

:::code language="azurecli" source="code/7-add-version.sh" range="1-4, 6" :::

::: zone-end

::: zone pivot="jsoncli"

:::code language="azurecli" source="code/7-add-version.sh" range="1-5" :::

::: zone-end

## Verify the template spec

1. In your browser, go back to the Azure portal. Go to your resource group.

1. Select the template spec. Notice that the latest version is now listed as **2.0**.

   :::image type="content" source="../media/7-template-spec.png" alt-text="Screenshot of the Azure portal interface for the template spec, showing the latest version as 2.0." border="true":::

1. Select the **Versions** menu item. Notice that both versions are now listed.

   :::image type="content" source="../media/7-template-spec-versions.png" alt-text="Screenshot of the Azure portal interface for the template spec, showing the list of versions as 1.0 and 2.0." border="true":::

   Template spec versions enable you to go back to previous versions of your template spec if you need to.

## Deploy the new template spec version

::: zone pivot="biceppowershell,jsonpowershell"

1. Get the new template spec version's resource ID by running the following Azure PowerShell command:

   ```azurepowershell
   $templateSpecVersionResourceId = ( `
      Get-AzTemplateSpec `
         -ResourceGroupName <rgn>[sandbox resource group name]</rgn> `
         -Name ToyCosmosDBAccount `
         -Version 2.0 `
      ).Versions[0].Id
   ```

   Notice that you use the `Versions` property to get the template spec version's resource ID.

1. Your new template spec version has a parameter for the user principal ID. Use the following commands to get your own user account's principal ID:

   ```azurepowershell
   $token = (Get-AzAccessToken -ResourceUrl "https://graph.windows.net/").Token
   $userObjectId = (Invoke-RestMethod -Uri 'https://graph.windows.net/me?api-version=1.6' -Headers @{ 'Authorization' = "Bearer $token"}).objectID
   ```

   The commands use the Microsoft Graph API to query your own user profile.

1. Deploy the template spec by using this Azure PowerShell command in the Visual Studio Code terminal:

   ```azurepowershell
   New-AzResourceGroupDeployment `
     -TemplateSpecId $templateSpecVersionResourceId `
     -roleAssignmentPrincipalId $userObjectId
   ```

::: zone-end

::: zone pivot="bicepcli,jsoncli"

1. Get the template spec version's resource ID by running the following Azure CLI command:

   ```azurecli
   id=$(az ts show \
    --name ToyCosmosDBAccount \
    --resource-group "<rgn>[sandbox resource group name]</rgn>" \
    --version "2.0" \
    --query "id")
   ```

1. Deploy the template spec by using this Azure CLI command in the Visual Studio Code terminal:

   ```azurecli
   az deployment group create \
    --template-spec $id \
    --parameters roleAssignmentPrincipalId="d68d19b3-d7ef-4ae9-9ee4-90695a4e417d"
   ```

::: zone-end

The deployment can take a minute or two to finish.

## Verify the deployment

1. In your browser, go back to the Azure portal. Go to your resource group.

1. Next to **Deployments**, select **2 Succeeded**.

   :::image type="content" source="../media/7-deployment-succeeded.png" alt-text="Screenshot of the Azure portal interface for the resource group overview, with the deployments section showing that two succeeded." border="true":::

1. Select the most recent deployment.

   :::image type="content" source="../media/7-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with two deployments listed." border="true":::

1. Select **Deployment details** to expand it. Confirm that the resources for Azure Cosmos DB role-based access control are deployed.

   :::image type="content" source="../media/7-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with the Azure Cosmos DB resources listed." border="true":::
