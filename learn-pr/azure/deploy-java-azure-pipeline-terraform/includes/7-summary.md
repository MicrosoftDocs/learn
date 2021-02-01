Congratulations! You've used Terraform with GitHub Actions to create multiple pipelines.
You created an Azure App Service, MySQL database, and deployed a Spring Boot web application.

Your company wanted to learn how they could provision their existing Spring Boot Java web applications to Azure App Service.
You used the following steps:

1. You accessed a sample Spring Boot web application and configured it.

1. Provisioned a MySQL database, and an Azure App Service using Terraform and GitHub Actions.

1. Configured your GIT repository to use GitHub actions to build and deploy your application on demand.

You're confident that you can now recommend this architecture for your Spring Boot applications.

## Clean up resources

In the preceding steps, you created Azure resources. If you don't expect to need these resources in the future, delete the resource group by running the following commands in the Azure Cloud Shell:

```azurecli
az group delete --name <your Resource Group Name> --yes
```

```azurecli
az ad sp delete --id <your Service Principal Name>
```

> [!IMPORTANT]
> It's important that you de-provision the Azure resources and Service Principal used in this module to avoid accruing unwanted charges.

## Extra resources

For more information about Terraform on Azure. [Terraform on Azure documentation](https://docs.microsoft.com/en-us/azure/developer/terraform?WT.mc_id=java-12761-ropreddy&WT.mc_id=java-334475​​​​​​​-ropreddy).

For more information about using Azure with Java, see [Azure for Java developers](https://docs.microsoft.com/en-us/azure/developer/java?WT.mc_id=java-12761-ropreddy&WT.mc_id=java-334475​​​​​​​-ropreddy)

For more information about GitHub Actions with Azure App Service, see [Deploy to App Service using GitHub Actions](https://docs.microsoft.com/en-us/azure/app-service/deploy-github-actions?WT.mc_id=java-12761-ropreddy&WT.mc_id=java-334475​​​​​​​-ropreddy)
