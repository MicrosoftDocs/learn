In this module, you: 

* Examined an existing ASP.NET Core microservices running in Azure Kubernetes Service (AKS).
* Implemented a new ASP.NET Core microservice and containerized it.
* Published the Docker image to Azure Container Registry (ACR).
* Deployed the Docker container to the existing app in AKS.

## Clean up Azure resources

> [!IMPORTANT]
> It is very important you deallocate the Azure resources used in this module so that you do not accrue unwanted charges.

To de-provision all of the resources created in this module, run the following command:

```azurecli
az group delete --name eshop-learn-rg --yes
```

The preceding command deletes the resource group containing the AKS and ACR resources. Additionally, another resource group containing infrastructure resources (such as IP addresses) was previously created on behalf of the AKS resource. This group and all resources contained within are also deleted when the AKS resource is deleted.

## Clean up Azure service principal

The initial setup script created an Azure service principal, which is required to allow Azure resources to authenticate to each other. 

To remove the service principal, run the following script:

```bash
./deploy/k8s/cleanup-service-principal.sh
```

The preceding script:

* Uses the `az ad sp list` command with the `--show-mine` flag to return a list of service principal IDs that match the following attributes:
    * Owned by the current user.
    * Contain the string `eShop-Learn-AKS` in the display name.
* Uses the `az ad sp delete` command to remove each matching service principal.

> [!NOTE]
> Only one service principal is expected in the list.

[!INCLUDE[download files](../../includes/summary-download-clouddrive.md)]

## Learn more with a Channel 9 video series

- [.NET Core 101](https://channel9.msdn.com/Series/NET-Core-101/?WT.mc_id=Educationaldotnet-c9-scottha&azure-portal=true)
- [ASP.NET Core 101](https://channel9.msdn.com/Series/ASPNET-Core-101/?WT.mc_id=Educationaspnet-c9-niner&azure-portal=true)
