# Summary

In this module you: 

* Deployed and examined an existing ASP.NET Core microservice running in Azure Kubernetes Service (AKS).
* Created an ASP.NET Core microservice.
* Deployed the microservice to the existing application in AKS.

## Clean up Azure resources

> [!IMPORTANT]
> It is very important you deallocate the Azure resources used in this module so that you do not accrue unwanted charges.

To de-provision all of the resources created in this module, run the following command:

```azurecli
az group delete --name eshop-learn-rg --yes
```

The preceding command deletes the resource group containing the AKS and ACR resources. Additionally, another resource group containing infrastructure resources (such as IP addresses) was previously created on behalf of the AKS resource. This group and all resources contained within are also deleted.

%TODO% -- Cam (Me): Also explain how to remove the service principal. Can that be done easily from a script?

[!INCLUDE[download files](../../includes/summary-download.md)]

## Learn more with a Channel 9 video series

- [.NET Core 101](https://channel9.msdn.com/Series/NET-Core-101/?WT.mc_id=Educationaldotnet-c9-scottha&azure-portal=true)
- [ASP.NET Core 101](https://channel9.msdn.com/Series/ASPNET-Core-101/?WT.mc_id=Educationaspnet-c9-niner&azure-portal=true)
