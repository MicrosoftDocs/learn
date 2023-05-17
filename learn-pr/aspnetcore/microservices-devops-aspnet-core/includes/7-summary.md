In this module, you:

- Authenticated GitHub Actions to an Azure Container Registry instance.
- Stored sensitive information that GitHub Actions uses.
- Implemented a GitHub action to build the coupon service's container image in Container Registry.
- Modified the coupon service code to trigger a build.
- Implemented a GitHub action to deploy the coupon service container to the Azure Kubernetes Service (AKS) cluster.
- Modified the coupon service's Helm chart to trigger a deployment to AKS.
- Reverted the coupon service to the previous deployment.

[!INCLUDE[de-provision your Azure resources](../../includes/microservices/remove-az-resources.md)]

## Remove Azure service principal

Earlier, you created an Azure Active Directory (Azure AD) service principal, which allows GitHub to authenticate to each Azure resource. To remove the service principal, run the following script:

```bash
./cleanup-service-principal.sh
```

The *cleanup-service-principal.sh* script:

1. Uses the following Azure CLI command to return a list of service principal identifiers from Azure AD:

   ```azurecli
   az ad sp list --show-mine --query "[?contains(displayName,'eshop-learn-sp')].appId" --output tsv
   ```

1. Filters the service principals to the following identifiers:

   - Owned by the current user.
   - Containing the string `eshop-learn-sp` in the display name.
   
1. Uses the `az ad sp delete` Azure CLI command to remove each matching service principal.

[!INCLUDE[learn more with these resources](../../includes/microservices/learn-more.md)]
