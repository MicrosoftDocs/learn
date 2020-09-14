In this module, you:

- Created an AKS cluster with an initial e-commerce app.
- Configured permissions and secrets to support the GitHub Actions.
- Implemented a GitHub Actions CI/CD pipeline to deploy the change to AKS.
- Implemented a coupon service logging change.
- Rolled back the deployment to the previous version.

[!INCLUDE[de-provision your Azure resources](../../includes/microservices/remove-az-resources.md)]

## Remove Azure service principal

Earlier you created an Azure service principal, which allows GitHub to authenticate to each Azure resource. To remove the service principal, run the following script:

```bash
./deploy/k8s/cleanup-service-principal.sh
```

The preceding script:

- Uses the following Azure CLI command to return a list of service principal identifiers from Azure Active Directory:

    ```azurecli
    az ad sp list --show-mine --query "[?contains(displayName,'eshop-learn-sp')].appId" --output tsv
    ```

  The service principals are filtered to those identifiers:

  - Owned by the current user.
  - Containing the string `eshop-learn-sp` in the display name.
- Uses the `az ad sp delete` Azure CLI command to remove each matching service principal.

[!INCLUDE[revert the .NET Core SDK changes](../../includes/microservices/revert-dotnet-sdk-changes.md)]

[!INCLUDE[download files](../../includes/summary-download-cloud-drive.md)]

[!INCLUDE[reset the Azure Cloud Shell](../../includes/microservices/reset-az-cloud-shell.md)]

[!INCLUDE[learn more with these resources](../../includes/microservices/learn-more.md)]


