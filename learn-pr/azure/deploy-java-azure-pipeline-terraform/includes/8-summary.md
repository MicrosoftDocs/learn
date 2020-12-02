Congratulations! You've used Terraform to provision an Azure App Service, MySQL database, and deployed a Spring Boot web application.

Your company wanted to learn how they could provision their existing Spring Boot Java web applications to Azure App Service. You used the following steps:

1. You accessed a sample Spring Boot web application and tested it locally

1. You use Terraform to provision a MySQL database, and an Azure App Service.

1. Once you verified that your resources were provisioned, you added the Maven Plugin for Azure App Service to your project and configured it interactively.

1. Configured your web application to use GitHub actions to deploy it on demand.

You're confident that you can recommend Terraform to provision your Spring Boot Java applications to Azure.

## Clean up resources

In the preceding steps, you created Azure resources. If you don't expect to need these resources in the future, either 'Terraform Destroy' or delete the resource group by running the following command in the Cloud Shell:

```bash
az group delete --name <your resource group name> --yes
```

This command may take a minute to run.

> [!IMPORTANT]
> It's important that you de-provision the Azure resources used in this module to avoid accruing unwanted charges.

## Additional resources

For more information about Terraform on Azure. [Terraform on Azure documentation](https://docs.microsoft.com/en-us/azure/developer/terraform/&WT.mc_id=java-00000-ropreddy).

For more information about using Azure with Java, see [Azure for Java developers](https://docs.microsoft.com/en-us/azure/developer/java/?WT.mc_id=java-00000-ropreddy)
