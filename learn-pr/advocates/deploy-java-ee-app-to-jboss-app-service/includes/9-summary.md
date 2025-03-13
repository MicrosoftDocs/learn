In this module, you learned how to create an Azure Database for MySQL instance and how to use the Maven Plugin for Azure App Service. You also learned how to deploy a Jakarta EE application to JBoss EAP on Azure App Service and how to manage JBoss EAP.

## Clean up resources

In this module, you created resources by using your Azure subscription. You need to clean up these resources so that you don't continue to be charged for them. Use the following steps to clean up your resources:

1. Use the following commands to delete all of the resources:

    ```azurecli
    az group delete --name <name-of-your-MySQL-resource>
    az group delete --name <name-of-your-JBoss-EAP-on-Azure-App-Service-resource>
    ```

1. Use the following command to clear out any defaults configured with `az configure` that you no longer want to keep:

    ```azurecli
    az configure --defaults location=''
    ```

   This command removes the default location configured in a previous unit.

## Other resources

### Microsoft Azure

- [Azure App Service](/azure/app-service)
- [Enable application monitoring in Azure App Service for .NET, Node.js, Python, and Java applications](/azure/azure-monitor/app/codeless-app-service?tabs=java).
- [Get started with autoscale in Azure](/azure/azure-monitor/platform/autoscale-get-started).
- [Deploy to App Service using GitHub Actions](/azure/app-service/deploy-github-actions?tabs=userlevel).
- [Integrate your app with an Azure virtual network](/azure/app-service/web-sites-integrate-with-vnet).
- [Azure App Service on Linux pricing](https://azure.microsoft.com/pricing/details/app-service/linux).

### Jakarta EE

- [Jakarta EE](https://jakarta.ee/)
- [Jakarta RESTful Web Services](https://projects.eclipse.org/projects/ee4j.rest).
- [Jakarta Persistence](https://projects.eclipse.org/projects/ee4j.jpa)
- [Jakarta JSON Binding](https://projects.eclipse.org/projects/ee4j.jsonb)
- [Jakarta Contexts and Dependency Injection](https://projects.eclipse.org/projects/ee4j.cdi).
- [Maven Plugin for Azure Services](https://github.com/microsoft/azure-maven-plugins).

### MySQL

- [MySQL Community Edition](https://www.mysql.com/products/community/).
- [MySQL Connector Java](https://mvnrepository.com/artifact/mysql/mysql-connector-java)
- [MySQL sample world database installation](https://dev.mysql.com/doc/world-setup/en/world-setup-installation.html).
- [Azure Database for MySQL](/azure/mysql?WT.mc_id=java-14033-yoterada).
- [What is Azure Database for MySQL - Flexible Server?](/azure/mysql/flexible-server/overview)
