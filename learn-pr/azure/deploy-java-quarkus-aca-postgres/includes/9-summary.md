Congratulations! You've deployed a Quarkus web application to Azure Container Apps.

Your company wanted to learn how to migrate its existing Quarkus applications to Azure Container Apps. You followed these steps:

1. Create a sample Quarkus web application.

1. Create a PostgreSQL database, connect your Quarkus web application, and test it locally.

1. Verify that your application works successfully. 

1. Add Maven Plugin for Azure Container Apps to your project, and then configure it interactively.

1. Update your web application, redeploy it to Azure Container Apps, and test it in the cloud.

You're now confident that you can recommend migrating your Quarkus application code to Azure.

## Enable diagnostic logging

Learn how Azure provides [built-in diagnostics to help with debugging](/azure/app-service/troubleshoot-diagnostic-logs/?WT.mc_id=java-10785-ropreddy&azure-portal=true).

## Clean up resources

In this module, you created Azure resources in a resource group. If you won't need these resources later, delete the resource group from the portal. Or run the following command in Azure Cloud Shell.

```bash
az group delete --name <your resource group name> --yes
```

This command might take a minute to run.

> [!IMPORTANT]
> Deprovision the Azure resources you used in this module to avoid unwanted charges.

## Additional resources

For more information about Quarkus, see [Quarkus guides](https://quarkus.io/guides).

For more information about Azure Container Apps, [Azure Container Apps](https://azure.microsoft.com/products/container-apps).

For more information about PostgreSQL servers on Azure, see [Azure Database for PostgreSQL documentation](/azure/postgresql/).

For more information about Hibernate ORM with Panache, see [Hibernate ORM with Panache](https://quarkus.io/guides/hibernate-orm-panache).

For more information about Application Insights for monitoring, see [Azure Application Insights](/azure/developer/java/spring-framework/configure-spring-boot-java-applicationinsights/?azure-portal=true&WT.mc_id=java-10785-ropreddy).

For more information about using Azure with Java, see [Azure for Java developers](/azure/developer/java).

For more information about comparing java options on Azure, see [Compare Java application hosting options on Azure](/azure/architecture/guide/technology-choices/service-for-java-comparison).
