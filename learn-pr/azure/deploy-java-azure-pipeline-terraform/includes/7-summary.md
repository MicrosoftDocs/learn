Congratulations! You've learned how to use Terraform with DevOps to create multiple pipelines.

::: zone pivot="github-actions"

You've created an Azure App Service application and a MySQL database, and you've deployed a Spring Boot web application.

Your company wanted to learn how to provision its existing Spring Boot Java web applications to Azure App Service.

To that end, you've done the following:

* You accessed and configured a sample Spring Boot web application.

* You provisioned a MySQL database and an Azure App Service application by using Terraform and GitHub Actions.

* You configured your GitHub repository to use GitHub Actions to build and deploy your application on demand.

You're now able to recommend this architecture for your Spring Boot applications.

## Clean up your resources

In the preceding processes, you created Azure resources. If you don't expect to need these resources in the future, delete the resource group by running the following commands in Azure Cloud Shell:

```azurecli
az group delete --name <your Resource Group Name> --yes
```

```azurecli
az ad sp delete --id <your Service Principal Name>
```

> [!IMPORTANT]
> To avoid accruing unwanted charges, you must deprovision the Azure resources and service principal that you used in this module.

## Additional resources

For more information about Terraform on Azure, see [Terraform on Azure documentation](https://docs.microsoft.com/azure/developer/terraform?WT.mc_id=java-12761-ropreddy&WT.mc_id=java-334475​​​​​​​-ropreddy).

For more information about using Azure with Java, see [Azure for Java developers](https://docs.microsoft.com/azure/developer/java?WT.mc_id=java-12761-ropreddy&WT.mc_id=java-334475​​​​​​​-ropreddy).

For more information about GitHub Actions with Azure App Service, see [Deploy to App Service using GitHub Actions](https://docs.microsoft.com/azure/app-service/deploy-github-actions?WT.mc_id=java-12761-ropreddy&WT.mc_id=java-334475​​​​​​​-ropreddy).

::: zone-end
