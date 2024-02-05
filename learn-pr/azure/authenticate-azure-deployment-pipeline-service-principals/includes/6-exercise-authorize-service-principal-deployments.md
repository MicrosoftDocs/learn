In the previous exercise, you created a service principal for your website's deployment pipeline, and you tested that you could sign in by using its key. Now you're ready to grant the service principal access to your Azure environment. In this exercise, you'll create a role assignment for the service principal, and then deploy a Bicep file by using the service principal.

During the process, you'll:

> [!div class="checklist"]
> * Sign in as your own user account.
> * Create a resource group for your company's website.
> * Create a role assignment to allow the service principal to deploy resources to the resource group.
> * Sign in as the service principal and deploy the Bicep file that creates your company's website resources.
> * Verify the deployment.
> * Clean up the resource group and service principal.

## Sign in as your user account

In the previous exercise, you signed in by using the service principal and then signed out. You need to sign in as your own user account again so that you can follow along with the next steps in this exercise.

::: zone pivot="cli"

1. In Visual Studio Code's Azure Cloud Shell (bash) terminal, sign in to Azure by running the following command: 

    ```azurecli
    az login
    ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

1. In Visual Studio Code's Azure Cloud Shell (PowerShell) terminal, sign in to Azure by running the following command:

    ```azurepowershell
    Connect-AzAccount
    ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a resource group

Now you'll create a resource group to contain the toy company's website resources.

::: zone pivot="cli"

1. Run this Azure CLI command in the Visual Studio Code terminal to create a resource group:

   ```azurecli
   az group create --name ToyWebsite --location eastus
   ```

2. Look at the JSON output from the previous command. It includes a property named `id`, which is the resource group's ID. Copy this somewhere safe. You'll use it soon.

::: zone-end

::: zone pivot="powershell"

1. Run this Azure PowerShell command in the Visual Studio Code terminal to create a resource group:

   ```azurepowershell
   New-AzResourceGroup -Name ToyWebsite -Location eastus
   ```

1. Look at the output from the previous command. It includes a property named `ResourceId`, which is the resource group's ID. Copy this somewhere safe. You'll use it soon.

::: zone-end

## Create a role assignment

For your website's deployment pipeline, you decide to create a role assignment with the following details:

- **Assignee**: The service principal that you created in the previous exercise.
- **Role**: The Contributor built-in role.
- **Scope**: The resource group that you created in the previous step.

::: zone pivot="cli"

Run the following Azure CLI command in the Visual Studio Code terminal to create the role assignment. Replace the placeholders with the values that you copied earlier.

```azurecli
az role assignment create \
  --assignee APPLICATION_ID \
  --role Contributor \
  --scope RESOURCE_GROUP_ID \
  --description "The deployment pipeline for the company's website needs to be able to create resources within the resource group."
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure CLI command in the Visual Studio Code terminal to create the role assignment. Replace the placeholders with the values that you copied earlier.

```azurepowershell
New-AzRoleAssignment `
  -ApplicationId APPLICATION_ID `
  -RoleDefinitionName Contributor `
  -Scope RESOURCE_GROUP_ID `
  -Description "The deployment pipeline for the company's website needs to be able to create resources within the resource group."
```

::: zone-end

## Create a Bicep file

You previously created a Bicep file that deploys your website's resources. Here, you save this file so that you can test it by using the service principal.

1. Create a new file called *main.bicep*.

1. Add the following content to the *main.bicep* file. You'll deploy the template soon.

   :::code language="bicep" source="code/6-template.bicep" :::

1. Save the changes to the file. You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

## Deploy the Bicep file by using the service principal

You don't currently have a deployment pipeline, so you'll simulate what a pipeline does to deploy your Bicep file. 

::: zone pivot="cli"

1. Run the following Azure CLI command in the Visual Studio Code terminal to sign in by using the service principal's credentials. Replace the placeholders with the values that you copied in the previous exercise.

   ```azurecli
   az login --service-principal \
     --username APPLICATION_ID \
     --password SERVICE_PRINCIPAL_KEY \
     --tenant TENANT_ID
   ```

1. Deploy the Bicep file by running the following Azure CLI command:

   ```azurecli
   az deployment group create \
     --resource-group ToyWebsite \
     --template-file main.bicep
   ```

   The deployment might take a minute or two to finish, and then you'll see a successful deployment.

::: zone-end

::: zone pivot="powershell"

1. Run the following Azure PowerShell command in the Visual Studio Code terminal to securely prompt you for the service principal's credentials. Use the service principal's application ID and key from the previous exercise for the username and password, respectively.

   ```azurepowershell
   $credential = Get-Credential
   ```

1. Run the following Azure PowerShell command in the Visual Studio Code terminal to sign in by using the service principal's credentials. Replace the `TENANT_ID` placeholder with the value that you copied earlier.

   ```azurepowershell
   Connect-AzAccount -ServicePrincipal `
     -Credential $credential `
     -Tenant TENANT_ID
   ```

1. Deploy the Bicep file by running the following Azure PowerShell command:

   ```azurepowershell
   New-AzResourceGroupDeployment -ResourceGroupName ToyWebsite -TemplateFile main.bicep
   ```

   The deployment might take a minute or two to finish, and then you'll see a successful deployment.

::: zone-end

## Verify the deployment

Use the Azure portal to inspect the resources that you deployed and to inspect the results of the deployment.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left pane, select **Resource groups**.

1. Select **ToyWebsite**.

1. Select **Deployments** to see the successful deployment.

    :::image type="content" source="../media/6-deployment-succeeded.png" alt-text="Screenshot of the Azure portal resource group Deployments pane, displaying the successful deployment." border="true":::

   You might also see a deployment named **Failure-Anomalies-Alert-Rule-Deployment**. Application Insights creates this deployment automatically.

1. Select the **main** deployment to see what resources were deployed, and then expand **Deployment details**. 
 
   In this case, the App Service plan, the app, and the Application Insights instance are listed.

    :::image type="content" source="../media/6-deployment-details.png" alt-text="Screenshot of the Azure portal deployments overview pane for the main deployment, with an App Service plan and app, and an Application Insights instance listed." border="true":::

   Notice that there's nothing unusual about this deployment. Even though a service principal initiated it, it's just like any other Bicep deployment.

## Clean up the resource group and service principal

You've successfully created a service principal and role assignment, and you've deployed your website's resources by using a Bicep file. You can now remove the resources that you created. 

::: zone pivot="cli"

1. Sign out of the service principal's account by using the following command:

   ```azurecli
   az logout
   ```

1. Sign back in to Azure with your own user account by running the following command: 

    ```azurecli
    az login
    ```

1. In the browser that opens, sign in to your Azure account.

1. Run the following Azure CLI command to delete the resource group, its contents, and the role assignment:

   ```azurecli
   az group delete --name ToyWebsite
   ```

   When you're prompted to confirm, enter `y`.

2. Run the following command to delete the service principal. Replace the `APPLICATION_ID` placeholder with the application ID that you copied in the previous exercise:

   ```azurecli
   az ad sp delete --id APPLICATION_ID
   ```

::: zone-end

::: zone pivot="powershell"

1. Sign out of the service principal's account by using the following command:

   ```azurepowershell
   Logout-AzAccount
   ```

1. Sign back in to Azure with your own user account by running the following command: 

    ```azurepowershell
    Connect-AzAccount
    ```

1. In the browser that opens, sign in to your Azure account.

1. Run the following Azure PowerShell command to delete the resource group, its contents, and the role assignment:

   ```azurepowershell
   Remove-AzResourceGroup -Name ToyWebsite
   ```

   When you're prompted to confirm, enter `y`.

1. Run the following command to delete the service principal. Replace the `APPLICATION_ID` placeholder with the application ID that you copied in the previous exercise:

   ```azurepowershell
   Remove-AzADServicePrincipal -ApplicationId APPLICATION_ID
   ```

   When you're prompted to confirm, enter `y`.

::: zone-end