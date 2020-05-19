In this unit, you'll use a script to deploy the existing eShopOnContainers app to AKS.

## Run deployment script

Run the following command in the command shell. Be patient, as setup can take a few minutes to complete.

```bash
. <(wget -q -O - https://aka.ms/microservices-aspnet-core-setup)
```

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

The preceding command retrieves and runs a setup script from a GitHub repository. The script completes the following steps:

* Clones the eShop project from a GitHub repository.
* Provisions an AKS and Azure Container Registry (ACR) resource.
* Launches the Cloud Shell Editor to view the code.
* Deploys the containers to AKS.
* Displays connection information upon completion

> [!NOTE]
> Non-blocking warnings are expected in the deployment process.

The app the script deploys is a smaller, modified version of the larger [eShop on Containers reference app](https://github.com/dotnet-architecture/eshoponcontainers). While the script is running, proceed to the next unit to review the eShopOnContainers architecture.
