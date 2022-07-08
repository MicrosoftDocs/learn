In this module, you: 

* Examined an existing ASP.NET Core microservice that runs in Azure Kubernetes Service (AKS).
* Implemented a new ASP.NET Core microservice, and containerized it.
* Published the Docker image to Azure Container Registry.
* Deployed the Docker container to the existing app in AKS.

[!INCLUDE[de-provision your Azure resources](../../includes/microservices/remove-az-resources.md)]

## Remove Azure service principal

The initial setup script created an Azure service principal, which allows Azure resources to authenticate to each other.

To remove the service principal, run the following script:

```bash
./cleanup-service-principal.sh
```

The preceding script:

* Uses the following Azure CLI command to return a list of service principal identifiers from Azure Active Directory. The identifiers are filtered to those:
  * Owned by the current user.
  * Containing the string `eShop-Learn-AKS` in the display name.

    ```azurecli
    az ad sp list --show-mine --query "[?contains(displayName,'eShop-Learn-AKS')].appId" --output tsv
    ```

* Uses the `az ad sp delete` Azure CLI command to remove each matching service principal.

> [!NOTE]
> More than one service principal is expected if the setup script has been run more than once. Each time the setup script is run, it creates a new service principal.

[!INCLUDE[learn more with these resources](../../includes/microservices/learn-more.md)]
