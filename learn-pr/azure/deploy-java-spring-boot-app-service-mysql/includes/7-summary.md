Congratulations! You've deployed a Spring Boot web application to Azure App Service.

Your company wanted to learn how to migrate its existing Spring Boot Java web applications to Azure App Service. You followed these steps:

1. Create a sample Spring Boot web application.

1. Create a MySQL database, connect your Spring Boot web application, and test it locally.

1. Verify that your application works successfully. 

1. Add Maven Plugin for Azure App Service to your project, and then configure it interactively.

1. Update your web application, redeploy it to Azure App Service, and test it in the cloud.

You're now confident that you can recommend migrating your SpringBoot Java application code to Azure.

## Enable diagnostic logging

Learn how Azure provides [built-in diagnostics to help with debugging](https://docs.microsoft.com/azure/app-service/troubleshoot-diagnostic-logs/?WT.mc_id=java-10785-ropreddy?azure-portal=true).

## Clean up resources

In this module, you created Azure resources in a resource group. If you won't need these resources later, delete the resource group from the portal. Or run the following command in Azure Cloud Shell.

```bash
az group delete --name <your resource group name> --yes
```

This command might take a minute to run.

> [!IMPORTANT]
> Deprovision the Azure resources you used in this module to avoid unwanted charges.

## Additional resources

For more information about Spring Data Java Database Connectivity (JDBC), see Spring's [reference documentation](https://docs.spring.io/spring-data/jdbc/docs/current/reference/html/#reference&WT.mc_id=java-10785-ropreddy?azure-portal=true).

For more information about Application Insights for monitoring, see [Azure Application Insights](https://docs.microsoft.com/azure/developer/java/spring-framework/configure-spring-boot-java-applicationinsights/?WT.mc_id=java-10785-ropreddy&azure-portal=true).

For more information about using Azure with Java, see [Azure for Java developers](https://docs.microsoft.com/azure/developer/java/?WT.mc_id=java-10785-ropreddy?azure-portal=true) and [Working with Azure DevOps and Java](https://docs.microsoft.com/azure/devops/pipelines/ecosystems/java?WT.mc_id=java-10785-ropreddy?azure-portal=true).

For more information about creating MySQL servers, see [Create an Azure Database for MySQL server by using the Azure portal](https://docs.microsoft.com/azure/mysql/quickstart-create-mysql-server-database-using-azure-portal/?WT.mc_id=java-10785-ropreddy?azure-portal=true).
