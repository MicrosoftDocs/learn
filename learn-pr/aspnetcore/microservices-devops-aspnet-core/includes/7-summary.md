In this module, you:

- Authenticated GitHub Actions to an Azure Container Registry instance.
- Stored sensitive information that GitHub Actions uses.
- Implemented a GitHub action to build the product service's container image in Container Registry.
- Modified the product service adding a new product to trigger a build.
- Implemented a GitHub action to deploy the product service container to the Azure Kubernetes Service (AKS) cluster.
- Rolled back the product service to the previous deployment.

## Remove Azure service principal

Earlier, you created an Entra service principal that allows GitHub to authenticate to Azure resources. To remove the service principal, you can use the Azure CLI.

1. Use the following Azure CLI command to return a list of service principal identifiers from Microsoft Entra ID:

   ```azurecli
   az ad sp list --show-mine --query "[?contains(displayName,'eShop')].appId" --output tsv
   ```

1. Filter the service principals to the following identifiers:

   - Owned by the current user.
   - Containing the string `eShop` in the display name.
   
1. Use the `az ad sp delete` Azure CLI command to remove each matching service principal.

1. Delete the Azure resource group `rg-eshop` to delete all the resources you created in previous units.

## Cleanup Codespace

You can delete the codespace on [GitHub](https://github.com/codespaces) under **By repository** where you see **MicrosoftDocs/mslearn-dotnet-cloudnative-devops**.

## Learn more about microservices

- [Architecting Cloud Native .NET Applications for Azure](/dotnet/architecture/cloud-native/)
- Video: [Implement microservices patterns with .NET and Docker containers](https://aka.ms/microservices-video)
