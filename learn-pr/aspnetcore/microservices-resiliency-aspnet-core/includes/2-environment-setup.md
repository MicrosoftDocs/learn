In this unit, you'll use a script to deploy the existing *:::no-loc text="eShopOnContainers":::* app to AKS.

[!INCLUDE[Azure Cloud Shell instructions](../../includes/use-az-cloud-shell.md)]

## Run deployment script

Run the following command in the command shell:

```bash
. <(wget -q -O - https://aka.ms/microservices-resiliency-aspnet-core-setup)
```

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

The preceding command retrieves and runs a setup script from a GitHub repository. The script completes the following steps:

* Installs the required version of the .NET Core SDK.
* Installs the Linkerd CLI.
* Clones the *:::no-loc text="eShopOnContainers":::* app from a GitHub repository.
* Provisions AKS and Azure Container Registry (ACR) resources.
* Launches the Cloud Shell editor to view the code.
* Deploys the containers to a fully managed Kubernetes service in Azure, known as AKS.
* Displays connection information upon completion.

[!INCLUDE [Instructions for restoring the default Cloud Shell configuration](../../includes/microservices/revert-cloud-shell-configuration.md)]

The script deploys a modified version of the *:::no-loc text="eShopOnContainers":::* [reference app](https://github.com/dotnet-architecture/eshoponcontainers). The solution architecture of the app is pictured in the following diagram:

:::image type="content" source="../../media/microservices/eshop-architecture.png" alt-text="eShopOnContainers solution architecture diagram" border="true" lightbox="../../media/microservices/eshop-architecture.png":::

This module focuses on adding resiliency to the coupon service depicted in the preceding diagram.

The script takes several minutes to complete. While the script is running, continue to the next unit to review resiliency concepts.

[!INCLUDE [A note about non-blocking script warnings](../../includes/microservices/non-blocking-warnings-note.md)]
