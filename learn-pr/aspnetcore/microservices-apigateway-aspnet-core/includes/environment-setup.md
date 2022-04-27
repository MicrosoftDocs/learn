In this unit, you'll use a script to deploy the existing *:::no-loc text="eShopOnContainers":::* app to Azure Kubernetes Service (AKS). AKS is a fully managed Kubernetes service in Azure.

[!INCLUDE[Azure Cloud Shell instructions](../../includes/use-az-cloud-shell.md)]

## Run the deployment script

Run the following command in the command shell. Be patient, because setup can take several minutes to complete. Continue reading while the script runs.

```bash
. <(wget -q -O - https://aka.ms/microservices-apigateway-aspnet-core-setup)
```

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

The preceding command retrieves and runs a setup script from a GitHub repository. The script completes the following steps:

1. Installs the required version of the .NET SDK.
1. Clones the *:::no-loc text="eShopOnContainers":::* app from a GitHub repository.
1. Provisions AKS and Azure Container Registry resources.
1. Opens the Cloud Shell editor to view the code.
1. Deploys the containers to AKS.
1. Displays connection information upon completion.

[!INCLUDE[Instructions for restoring the default Cloud Shell configuration](../../includes/microservices/revert-cloud-shell-configuration.md)]

The script deploys a modified version of the *:::no-loc text="eShopOnContainers":::* [reference app](https://github.com/dotnet-architecture/eshoponcontainers). The following diagram shows the solution architecture of the app:

:::image type="content" source="../../media/microservices/eshop-architecture.png" alt-text="Diagram that shows the eShopOnContainers solution architecture." border="true" lightbox="../../media/microservices/eshop-architecture.png":::

This module explores data services implemented in the *:::no-loc text="eShopOnContainers":::* app. The deployment script takes several minutes to complete. While the script is running, continue to the next unit to review concepts about microservices data stores.

[!INCLUDE[A note about nonblocking script warnings](../../includes/microservices/non-blocking-warnings-note.md)]