In this module, you learned how to create an Azure Database for MySQL instance and how to use the Maven Plugin for Azure App Service. You also learned how to deploy a Java EE (Jakarta EE) application to JBoss EAP on Azure App Service and how to manage JBoss EAP.

## Clean up resources

In this module, you created resources by using your Azure subscription. You need to clean up these resources so that you don't continue to be charged for them. Run the following commands to delete all the resources:

```azurecli
az group delete --name <name of your MySQL resource>
az group delete --name <name of your JBoss EAP on Azure App Service resource>
```

Clear out any defaults configured with `az configure` that you no longer want to keep as defaults - for example, the default location configured in a previous unit.

```azurecli
az configure --defaults location=''
```

## Other resources

Use the following links to get more information about the topics in this module.

### Microsoft Azure

* [Azure App Service](/azure/app-service?WT.mc_id=java-14033-yoterada)
* [Monitor Azure App Service performance](/azure/azure-monitor/app/azure-web-apps?tabs=java&WT.mc_id=java-14033-yoterada)
* [Get started with autoscale in Azure](/azure/azure-monitor/platform/autoscale-get-started?WT.mc_id=java-14033-yoterada)
* [Deploy to App Service using GitHub Actions](/azure/app-service/deploy-github-actions?tabs=userlevel&WT.mc_id=java-14033-yoterada)
* [Integrate your app with an Azure virtual network](/azure/app-service/web-sites-integrate-with-vnet?WT.mc_id=java-14033-yoterada)
* [App Service pricing](https://azure.microsoft.com/pricing/details/app-service/linux?WT.mc_id=java-14033-yoterada)

### Java EE (Jakarta EE)

* [Jakarta EE](https://jakarta.ee/)
* [Jakarta RESTful Web Services](https://projects.eclipse.org/projects/ee4j.jaxrs)
* [Jakarta Persistence](https://projects.eclipse.org/projects/ee4j.jpa)
* [Jakarta JSON Binding](https://projects.eclipse.org/projects/ee4j.jsonb)
* [Jakarta Contexts and Dependency Injection](https://projects.eclipse.org/projects/ee4j.cdi)
* [Maven Plugin for Azure Web Apps](https://github.com/microsoft/azure-maven-plugins)

### MySQL

* [MySQL Community Edition](https://www.mysql.com/products/community/)
* [MySQL Connector/J](https://mvnrepository.com/artifact/mysql/mysql-connector-java)
* [MySQL Sample World Database Installation](https://dev.mysql.com/doc/world-setup/en/world-setup-installation.html)
* [Azure Database for MySQL](/azure/mysql?WT.mc_id=java-14033-yoterada)
* [Azure Database for MySQL - Flexible Server](/azure/mysql/flexible-server/overview?WT.mc_id=java-14033-yoterada)
