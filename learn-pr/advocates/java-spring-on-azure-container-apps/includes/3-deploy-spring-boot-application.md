This section guides you through deploying a Spring Boot application to Azure Container Apps. We cover packaging the application, setting up the Azure environment, and pushing the  application to Azure Container Apps.

## Setup

To sign in to the latest version of Azure CLI, use the following steps, and follow the prompts to complete the authentication process:

1. Use the following command to sign in to Azure CLI:

    # [Bash](#tab/bash)

    ```bash
    az login
    ```

    # [Azure PowerShell](#tab/azure-powershell)

    ```azurepowershell
    Connect-AzAccount
    ```

    ---

1. To ensure you're running the latest version of the CLI, use the following upgrade command:

    # [Bash](#tab/bash)

    ```bash
    az upgrade
    ```

    # [Azure PowerShell](#tab/azure-powershell)

    ```azurepowershell
    Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
    ```

    ---

Next, install or update the Azure Container Apps extension for the CLI by using the following command or commands, depending on whether you use Bash or Powershell. If you receive errors about missing parameters when you run `az containerapp` commands in Azure CLI, be sure you have the latest version of the Azure Container Apps extension installed.

# [Bash](#tab/bash)

```bash
az extension add --name containerapp --upgrade
```

# [Azure PowerShell](#tab/azure-powershell)

```azurepowershell
Install-Module -Name Az.App
Update-Module -Name Az.App
```

---

Now that the current extension or module is installed, register the `Microsoft.App` and `Microsoft.OperationalInsights` namespaces by using the following commands:

# [Bash](#tab/bash)

```bash
az provider register --namespace Microsoft.App
az provider register --namespace Microsoft.OperationalInsights
```

# [Azure PowerShell](#tab/azure-powershell)

```azurepowershell
Register-AzResourceProvider -ProviderNamespace Microsoft.App
Register-AzResourceProvider -ProviderNamespace Microsoft.OperationalInsights
```

---

## Create environment variables

Now that your Azure CLI setup is complete, you can define the environment variables that are used throughout this article by using the following commands:

# [Bash](#tab/bash)

```bash
export RESOURCE_GROUP="petclinic-containerapps"
export LOCATION="canadacentral"
export ENVIRONMENT="env-petclinic-containerapps"
export APP_NAME="petclinic"
```

# [Azure PowerShell](#tab/azure-powershell)

```azurepowershell
$RESOURCE_GROUP = "petclinic-containerapps"
$LOCATION = "canadacentral"
$ENVIRONMENT = "env-petclinic-containerapps"
$APP_NAME = "petclinic"
```

---

## Locate the sample code

Since we have already prepared the code sample in the last chapter, make sure that your are now in the **azure-container-apps-java-samples/spring-petclinic/spring-petclinic** directory of the project.

## Build and deploy the container app

Build and deploy your first Spring Boot app with the `containerapp up` command, which does the following:

- Creates the resource group.
- Creates an Azure container registry.
- Builds the container image and pushes it to the registry.
- Creates the Container Apps environment with a Log Analytics workspace.
- Creates and deploys the container app using the built container image.

The `containerapp up` command uses the Dockerfile in the root of the repository to build the container image. In the following code example, the `..` (dot dot) tells `containerapp up` to run the Dockerfile in the folder one level up.

# [Bash](#tab/bash)

```bash
az containerapp up \
    --resource-group $RESOURCE_GROUP\
    --name $APP_NAME \
    --location $LOCATION \
    --environment $ENVIRONMENT \
    --source ..
```

# [Azure PowerShell](#tab/azure-powershell)

```azurepowershell
az containerapp up `
    --resource-group $RESOURCE_GROUP `
    --name $APP_NAME `
    --location $LOCATION `
    --environment $ENVIRONMENT `
    --source ..
```

---

## Verify deployment

Once your deployment is done, you should be able to see a success message with the project endpoint printed in the console. You can open the URL to verify your project deployed to Azure.

:::image type="content" source="../media/deployment-success.png" alt-text="Diagram of the deployment verification." lightbox="../media/deployment-success.png":::
