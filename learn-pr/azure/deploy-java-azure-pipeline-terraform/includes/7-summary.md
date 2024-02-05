Congratulations! You've learned how to use Terraform to create automated pipelines.

You created an Azure App Service application and a MySQL database, then you deployed a Spring Boot web application.

Your company wanted to learn how to provision its existing Spring Boot Java web applications to Azure App Service.

To that end:

* You accessed and configured a sample Spring Boot web application.

* You provisioned a MySQL database and an Azure App Service application by using Terraform and an automated workflow.

* You configured your GitHub repository to use an automated workflow to build and deploy your application on demand.

You're now able to recommend this architecture for your Spring Boot applications.

## Clean up your Azure resources

In the course of this module, you created Azure resources. If you don't expect to need these resources in the future, delete the resource group by running the following command in Azure Cloud Shell:

```azurecli
az group delete --name <your Resource Group Name> --yes
```

If you created a Service Principal, delete the Service Principal by running the following command in Azure Cloud Shell:

```azurecli
az ad sp delete --id <your Service Principal Name>
```

> [!IMPORTANT]
> To avoid accruing unwanted charges, you must remove the Azure resources, Service Principal, and automated workflows you used in this module.

## Additional resources

For more information about Terraform on Azure, see [Terraform on Azure documentation](/azure/developer/terraform?WT.mc_id=java-12761-ropreddy&WT.mc_id=java-334475​​​​​​​-ropreddy).

For more information about using Azure with Java, see [Azure for Java developers](/azure/developer/java?WT.mc_id=java-12761-ropreddy&WT.mc_id=java-334475​​​​​​​-ropreddy).

For more information about GitHub Actions with Azure App Service, see [Deploy to App Service using GitHub Actions](/azure/app-service/deploy-github-actions?WT.mc_id=java-12761-ropreddy&WT.mc_id=java-334475​​​​​​​-ropreddy).
