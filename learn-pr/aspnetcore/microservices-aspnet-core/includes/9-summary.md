In this module, you: 

* Examined an existing ASP.NET Core microservice that runs in Azure Kubernetes Service (AKS).
* Implemented a new ASP.NET Core microservice, and containerized it.
* Published the Docker image to Azure Container Registry.
* Deployed the Docker container to the existing app in AKS.

## Remove Azure resources

> [!IMPORTANT]
> It's important that you de-provision the Azure resources used in this module to avoid accruing unwanted charges.

To de-provision all of the resources created in this module, run the following command:

```azurecli
az group delete --name eshop-learn-rg --yes
```

The preceding command deletes the resource group containing the AKS and Azure Container Registry resources. Another resource group that contains infrastructure resources (such as IP addresses) was previously created on behalf of the AKS resource. This group, and all resources contained within, are also deleted when the AKS resource is deleted.

## Revert .NET Core SDK changes

The setup script installs a newer version of the .NET Core SDK, alongside the default SDK version of Cloud Shell. You can choose to keep this configuration. To revert to your prior configuration, run the following commands:

```bash
cp ~/.bashrc.bak.microservices-aspnet-core ~/.bashrc
```

The preceding command restores your prior *:::no-loc text=".bashrc":::* profile startup file from a backup saved by the setup script.

[!INCLUDE[download files](../../includes/summary-download-cloud-drive.md)]

## Reset Azure Cloud Shell

The scripts used in this module make temporary changes to your Cloud Shell preferences. You don't need to reset your configuration if the scripts ran as intended. If you want to reset your Cloud Shell to its default configuration, see the [documentation on deleting personal data](/azure/cloud-shell/troubleshooting#delete).

## Learn more about microservices

* Free e-book: [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices/)
* [Full eShopOnContainers reference app on GitHub](https://github.com/dotnet-architecture/eShopOnContainers)
* Video: [Implement microservices patterns with .NET Core and Docker containers](https://aka.ms/microservices-video)
  * Note: The above video doesn't reflect current .NET Core tooling. However, the architectural concepts and design patterns remain valid.

## Learn more about .NET

* [.NET Core 101](https://channel9.msdn.com/Series/NET-Core-101/?WT.mc_id=Educationaldotnet-c9-scottha&azure-portal=true)
* [ASP.NET Core 101](https://channel9.msdn.com/Series/ASPNET-Core-101/?WT.mc_id=Educationaspnet-c9-niner&azure-portal=true)
