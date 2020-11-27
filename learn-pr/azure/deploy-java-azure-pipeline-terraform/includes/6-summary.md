Congratulations! You've used Terraform to provision an Azure App Service, MySQL database, and deployed a SpringBoot web application.

Your company wanted to learn how they could provision their existing Spring Boot Java web applications to Azure App Service. You used the following steps:

1. You accessed a sample Spring Boot web application and tested it locally

1. You provisioned a MySQL database, and an Azure App Service.

1. Once you verified that your resources were provisioned, you added the Maven Plugin for Azure App Service to your project and configured it interactively.

1. You updated your web application, redeployed it to Azure App Service, and tested it in the cloud.

You're confident that you can recommend Terraform to provision your SpringBoot Java applications to Azure.

## Get Log Stream

Learn how Azure provides built-in diagnostics to assist with debugging in [this](https://docs.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs/?WT.mc_id=java-10785-ropreddy) article.

## Clean up resources

In the preceding steps, you created Azure resources in a resource group. If you don't expect to need these resources in the future, delete the resource group from portal, or by running the following command in the Cloud Shell:

```bash
az group delete --name <your resource group name> --yes
```

This command may take a minute to run.

> [!IMPORTANT]
> It's important that you de-provision the Azure resources used in this module to avoid accruing unwanted charges.

## Additional resources

For more information about Spring Data JDBC, see Spring's [reference documentation](https://docs.spring.io/spring-data/jdbc/docs/current/reference/html/#reference&WT.mc_id=java-10785-ropreddy).

For more information about Azure Application Insights Spring Boot Starter for monitoring, see [Azure Application insights](https://docs.microsoft.com/en-us/azure/developer/java/spring-framework/configure-spring-boot-java-applicationinsights/?WT.mc_id=java-10785-ropreddy)

For more information about using Azure with Java, see [Azure for Java developers](https://docs.microsoft.com/en-us/azure/developer/java/?WT.mc_id=java-10785-ropreddy) and [Working with Azure Pipelines and Java](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/java?WT.mc_id=java-10785-ropreddy).

You can read more detailed information about creating MySQL servers in [Create an Azure Database for MySQL server by using the Azure portal](https://docs.microsoft.com/en-us/azure/mysql/quickstart-create-mysql-server-database-using-azure-portal/?WT.mc_id=java-10785-ropreddy).
