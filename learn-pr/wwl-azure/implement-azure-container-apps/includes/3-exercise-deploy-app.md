

In this exercise you create a secure Container Apps environment and deploy container app.

## Prerequisites

* An **Azure account** with an active subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free)

## Prepare your environment

1. Sign in to the [Azure portal](https://portal.azure.com) and open the Cloud Shell.

    :::image type="content" source="../media/cloud-shell-menu.png" alt-text="Screenshot showing the location of Cloud Shell launch button.":::

1. After the shell opens be sure to select the **Bash** environment.

    :::image type="content" source="../media/shell-bash-selection.png" alt-text="Screenshot showing the location of the shell selection.":::

1. Install the Azure Container Apps extension for the CLI.

    ```bash
    az extension add --name containerapp --upgrade
    ```

1. Register the `Microsoft.App` namespace. 

    ```bash
    az provider register --namespace Microsoft.App
    ```

    > [!NOTE]
    > Azure Container Apps resources have migrated from the Microsoft.Web namespace to the Microsoft.App namespace.

1. Register the `Microsoft.OperationalInsights` provider for the Azure Monitor Log Analytics workspace if you haven't used it before.

    ```bash
    az provider register --namespace Microsoft.OperationalInsights
    ```

    > [!NOTE]
    > Registering the `Microsoft.App` namespace and `Microsoft.OperationalInsights` can each take a few minutes to complete. 

1. Set environment variables used later in this exercise. Replace `<location>` with a region near you.

    ```bash
    myRG=az204-appcont-rg
    myLocation=<location>
    myAppContEnv=az204-env-$RANDOM
    ```

1. Create the resource group for your container app.

    ```bash
    az group create \
        --name $myRG \
        --location $myLocation
    ```

With the CLI upgraded and a new resource group available, you can create a Container Apps environment and deploy your container app.

## Create an environment

An environment in Azure Container Apps creates a secure boundary around a group of container apps. Container Apps deployed to the same environment are deployed in the same virtual network and write logs to the same Log Analytics workspace.

1. Create an environment by using the `az containerapp env create` command.

    ```bash
    az containerapp env create \
        --name $myAppContEnv \
        --resource-group $myRG \
        --location $myLocation
    ```

## Create a container app

After the container app environment finishes deployment, you can deploy a container image to Azure Container Apps.

1. Deploy a sample app container image by using the `containerapp create` command.

    ```bash
    az containerapp create \
        --name my-container-app \
        --resource-group $myRG \
        --environment $myAppContEnv \
        --image mcr.microsoft.com/azuredocs/containerapps-helloworld:latest \
        --target-port 80 \
        --ingress 'external' \
        --query properties.configuration.ingress.fqdn
    ```

    By setting `--ingress` to `external`, you make the container app available to public requests. The command returns a link to access your app.

## Verify deployment

Select the link returned by the `az containerapp create` command to verify the container app is running. 

:::image type="content" source="../media/azure-container-apps-exercise.png" alt-text="Screenshot showing the sample app running in a browser.":::


## Clean up resources

When no longer needed, you can use the `az group delete` command to remove the resource group, the container app, and other resources stored there.

```bash
az group delete --name $myRG
```
