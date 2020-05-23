In this module, you: 

* Examined an existing ASP.NET Core microservices running in AKS.
* Implemented a new ASP.NET Core microservice and containerized it.
* Published the Docker image to ACR.
* Deployed the Docker container to the existing app in AKS.

## More about microservices

* Free e-book: [.NET Microservices: Architecture for Containerized .NET Applications](https://docs.microsoft.com/dotnet/architecture/microservices/)
* [Full eShopOnContainers reference app on GitHub](https://github.com/dotnet-architecture/eShopOnContainers)
* Video: [Implement microservices patterns with .NET Core and Docker containers](https://aka.ms/microservices-video)
    * Note: The above video is dated 2017 and does not reflect current .NET Core tooling. However, the architectural concepts and design patterns remain valid.

## Clean up Azure resources

> [!IMPORTANT]
> It is very important you deallocate the Azure resources used in this module so that you do not accrue unwanted charges.

To de-provision all of the resources created in this module, run the following command:

```azurecli
az group delete --name eshop-learn-rg --yes
```

The preceding command deletes the resource group containing the AKS and ACR resources. Additionally, another resource group containing infrastructure resources (such as IP addresses) was previously created on behalf of the AKS resource. This group and all resources contained within are also deleted when the AKS resource is deleted.

## Clean up Azure service principal

The initial setup script created an Azure service principal, which allows Azure resources to authenticate to each other. 

To remove the service principal, run the following script:

```bash
./deploy/k8s/cleanup-service-principal.sh
```

The preceding script:

* Uses the following Azure CLI command to return a list of service principal identifiers from AAD. The identifiers are filtered to those:
    * Owned by the current user.
    * Containing the string `eShop-Learn-AKS` in the display name.

    ```azurecli
    az ad sp list --show-mine --query "[?contains(displayName,'eShop-Learn-AKS')].appId" --output tsv
    ```

* Uses the `az ad sp delete` Azure CLI command to remove each matching service principal.

> [!NOTE]
> More than one service principal is expected if the setup script has been run more than once. Each time the setup script is run, it creates a new service principal.

[!INCLUDE[download files](../../includes/summary-download-clouddrive.md)]

## Learn more with a Channel 9 video series

- [.NET Core 101](https://channel9.msdn.com/Series/NET-Core-101/?WT.mc_id=Educationaldotnet-c9-scottha&azure-portal=true)
- [ASP.NET Core 101](https://channel9.msdn.com/Series/ASPNET-Core-101/?WT.mc_id=Educationaspnet-c9-niner&azure-portal=true)
