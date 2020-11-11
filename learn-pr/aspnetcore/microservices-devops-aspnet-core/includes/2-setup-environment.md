In this unit, you'll use a script to deploy the existing *:::no-loc text="eShopOnContainers":::* app to Azure Kubernetes Service (AKS).

[!INCLUDE[Azure Cloud Shell instructions](../../includes/use-az-cloud-shell.md)]

## Run the deployment script

1. In a new browser window, fork the repository [github.com/MicrosoftDocs/mslearn-microservices-devops-aspnet-core](https://github.com/MicrosoftDocs/mslearn-microservices-devops-aspnet-core) to your own GitHub account. For instructions on forking, see [Forking Projects](https://guides.github.com/activities/forking).
1. Run the following command in the command shell. When prompted for **:::no-loc text="Repo URL":::**, enter the URL of your fork created in the first step.

    ```bash
    . <(wget -q -O - https://aka.ms/microservices-devops-aspnet-core-setup)
    ```

    [!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    The preceding command retrieves and runs a setup script from a GitHub repository. The script completes the following steps:

    * Installs the required version of the .NET Core SDK.
    * Clones the *:::no-loc text="eShopOnContainers":::* app from your fork of the GitHub repository.
    * Provisions AKS and Azure Container Registry (ACR) resources.
    * Launches the Cloud Shell editor to view the code.
    * Deploys the containers to AKS.
    * Displays connection information upon completion.

    [!INCLUDE[Instructions for restoring the default Cloud Shell configuration](../../includes/microservices/revert-cloud-shell-configuration.md)]

The script takes several minutes to complete. It deploys a modified version of the *:::no-loc text="eShopOnContainers":::* reference app. The solution architecture of the app is pictured in the following diagram:

:::image type="content" source="../../media/microservices/eshop-architecture.png" alt-text="eShopOnContainers solution architecture diagram" border="true" lightbox="../../media/microservices/eshop-architecture.png":::

This module focuses on adding CI/CD for the coupon service depicted in the preceding diagram.

[!INCLUDE[A note about non-blocking script warnings](../../includes/microservices/non-blocking-warnings-note.md)]
