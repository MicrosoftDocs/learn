This section guides you through deploying a Spring Boot application to Azure Container Apps. We cover packaging the application, setting up the Azure environment, and pushing the application to Azure Container Apps.

## Setup

To sign in to the latest version of the Azure CLI, use the following steps, and follow the prompts to complete the authentication process:

1. Use the following command to sign in to the Azure CLI:

    ### [Bash](#tab/bash)

    ```azurecli
    az login
    ```

    ### [PowerShell](#tab/powershell)

    ```azurepowershell
    Connect-AzAccount
    ```

    ---

1. Use the following upgrade command to ensure you're running the latest version of the Azure CLI:

    ### [Bash](#tab/bash)

    ```azurecli
    az upgrade
    ```

    ### [PowerShell](#tab/powershell)

    ```powershell
    Install-Module -Name Az -Scope CurrentUser `
    -Repository PSGallery -Force
    ```

    ---

Next, install or update the Azure Container Apps extension for the CLI, and register the `Microsoft.App` and `Microsoft.OperationalInsights` namespaces by using the following steps:

> [!IMPORTANT]
> If you receive errors about missing parameters when you run `az containerapp` commands in the Azure CLI, be sure you have the latest version of the Azure Container Apps extension installed.

1. First, install or update the Azure Container Apps extension by using the following command - or commands, depending on whether you're using the Azure CLI or Azure PowerShell:

    ### [Bash](#tab/bash)

    ```azurecli
    az extension add --name containerapp --upgrade
    ```

    ### [PowerShell](#tab/powershell)

    ```powershell
    Install-Module -Name Az.App
    Update-Module -Name Az.App
    ```

    ---

1. Now that the current extension or module is installed, register the `Microsoft.App` and `Microsoft.OperationalInsights` namespaces by using the following commands:

    ### [Bash](#tab/bash)

    ```azurecli
    az provider register --namespace Microsoft.App
    az provider register --namespace Microsoft.OperationalInsights
    ```

    ### [PowerShell](#tab/powershell)

    ```azurepowershell
    Register-AzResourceProvider -ProviderNamespace Microsoft.App
    Register-AzResourceProvider -ProviderNamespace Microsoft.OperationalInsights
    ```

    ---

## Create environment variables

Now that your Azure CLI setup is set up, define the environment variables needed throughout this article by using the following commands:

### [Bash](#tab/bash)

```bash
export RESOURCE_GROUP="petclinic-containerapps"
export LOCATION="canadacentral"
export ENVIRONMENT="env-petclinic-containerapps"
export APP_NAME="petclinic"
```

### [PowerShell](#tab/powershell)

```powershell
$Env:RESOURCE_GROUP = "petclinic-containerapps"
$Env:LOCATION = "canadacentral"
$Env:ENVIRONMENT = "env-petclinic-containerapps"
$Env:APP_NAME = "petclinic"
```

---

## Locate the sample code

Since you already prepared the code sample in the last chapter, make sure that you're now in the **azure-container-apps-java-samples/spring-petclinic/spring-petclinic** directory of the project.

## Build and deploy the container app

Next, build and deploy your first Spring Boot app with the `containerapp up` command, which accomplishes the following tasks:

- Creates the resource group.
- Creates an Azure container registry.
- Builds the container image and pushes it to the registry.
- Creates the Container Apps environment with a Log Analytics workspace.
- Creates and deploys the container app using the built container image.

The `containerapp up` command uses the Dockerfile in the root of the repository to build the container image. Use the following code example to build the container image, where the `..` (dot dot) tells the `containerapp up` command to run the Dockerfile in the folder one level up:

### [Bash](#tab/bash)

```azurecli
az containerapp up \
    --resource-group $RESOURCE_GROUP\
    --name $APP_NAME \
    --location $LOCATION \
    --environment $ENVIRONMENT \
    --source ..
```

### [PowerShell](#tab/powershell)

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

Once your deployment is done, you should be able to see a success message with the project endpoint printed in the console. You can open the URL to verify that your project deployed to Azure.

```output
Run ID: cxl was successful after 3m30s
Creating Containerapp petclinic in resource group petclinic-containerapps

Container app created. Access your app at https://petclinic.wonderful

Your container app petclinic has been created and deployed! Congrats!

Browse to your container app at: http://petclinic.wonderful

Stream logs for your container with: az containerapp logs show -n petclinic -g petclinic-containerapps

See full output using: az containerapp show -n petclinic -g petclinic-containerapps
```
