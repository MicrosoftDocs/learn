In this unit, you'll use a script to deploy the existing *:::no-loc text="eShopOnContainers":::* app to AKS.

[!INCLUDE[Azure Cloud Shell instructions](../../includes/use-az-cloud-shell.md)]

## Run deployment script

Run the following command in the command shell. Be patient, as setup can take several minutes to complete. Continue reading while the script runs.

```bash
. <(wget -q -O - https://aka.ms/microservices-configuration-aspnet-core-setup)
```

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

The preceding command retrieves and runs a setup script from a GitHub repository. The script completes the following steps:

1. Installs the required version of the .NET Core SDK.
1. Clones the *:::no-loc text="eShopOnContainers":::* app from a GitHub repository.
1. Provisions AKS and Azure Container Registry (ACR) resources.
1. Launches the Cloud Shell editor to view the code.
1. Deploys the containers to a fully managed Kubernetes service in Azure, known as AKS.
1. Displays connection information upon completion.

[!INCLUDE[Instructions for restoring the default Cloud Shell configuration](../../includes/microservices/revert-cloud-shell-configuration.md)]

The script deploys a modified version of the *:::no-loc text="eShopOnContainers":::* [reference app](https://github.com/dotnet-architecture/eshoponcontainers). The solution architecture of the app is pictured in the following diagram:

:::image type="content" source="../../media/microservices/eshop-architecture.png" alt-text="Diagram showing the eShopOnContainers solution architecture." border="true" lightbox="../../media/microservices/eshop-architecture.png":::

This module focuses on implementing a configurable discount coupon feature in the *:::no-loc text="WebSPA":::* app. When the feature is disabled, the coupon service depicted in the preceding diagram isn't used. The deployment script takes several minutes to complete. While the script is running, continue to the next unit to review logging and monitoring concepts.

[!INCLUDE[A note about non-blocking script warnings](../../includes/microservices/non-blocking-warnings-note.md)]
