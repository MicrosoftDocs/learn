Congratulations! You've deployed to a Spring Boot Web App to Azure App Service.

Your company wanted to learn how they could migrate their existing Spring Boot Java web apps to Azure App Service. You used the following steps:

1. You created a sample Spring Boot web app.

1. You created a MySQL database, connected your Spring Boot web app, and tested it locally.

1. Once you verified that your application was working successfully, you added the Maven Plugin for Azure App Service to your project and configured it interactively.

1. You updated your web app, redeployed it to Azure App Service, and tested it in the cloud.

You're confident that you can recommend migrating your SpringBoot Java application code to Azure.

## Get Log Stream

Learn how Azure provides built-in diagnostics to assist with debugging in [this](/azure/app-service/troubleshoot-diagnostic-logs) article.

## Clean up resources

In the preceding steps, you created Azure resources in a resource group. If you don't expect to need these resources in the future, delete the resource group from portal, or by running the following command in the Cloud Shell:

```bash
az group delete --name <your resource group name> --yes
```

This command may take a minute to run.

> [!IMPORTANT]
> It's important that you de-provision the Azure resources used in this module to avoid accruing unwanted charges.

## Additional resources

For more information about Spring Data JDBC, see Spring's [reference documentation](https://docs.spring.io/spring-data/jdbc/docs/current/reference/html/#reference).

For more information about Azure Application Insights Spring Boot Starter for monitoring, see [Azure Application insights](https://docs.microsoft.com/en-us/azure/developer/java/spring-framework/configure-spring-boot-java-applicationinsights)

For more information about using Azure with Java, see [Azure for Java developers](../index.yml) and [Working with Azure DevOps and Java](/azure/devops/).

You can read more detailed information about creating MySQL servers in [Create an Azure Database for MySQL server by using the Azure portal](/azure/mysql/quickstart-create-mysql-server-database-using-azure-portal).
