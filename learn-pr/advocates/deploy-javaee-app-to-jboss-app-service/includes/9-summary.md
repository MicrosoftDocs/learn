In this module, you learned how to create `Azure DataBase for MySQL`, how to use the `Maven Plugin for Azure Web Apps` and how to deploy your Java EE (Jakarta EE) application to `JBoss EAP on Azure App Service` and how to manage JBoss EAP.

## Clean up resources

In this module, you created resources using your Azure subscription. You need to clean up these resources so that you'll not continue to be charged for them.
Run the following command to delete all the resources:

```azurecli
az group delete --name <name of your MySQL resource>
az group delete --name <name of your JBoss EAP on Azure App Service resource>
```

## Other Resources

### Microsoft Azure Related

* [Azure App Service](https://docs.microsoft.com/azure/app-service/)
* [Monitor Azure App Service performance](https://docs.microsoft.com/en-us/azure/azure-monitor/app/azure-web-apps?tabs=java)
* [Quickstart: Get started with Application Insights in a Java web project](https://docs.microsoft.com/azure/azure-monitor/app/java-get-started?tabs=maven)
* [Get started with Autoscale in Azure](https://docs.microsoft.com/azure/azure-monitor/platform/autoscale-get-started)
* [Deploy to App Service using GitHub Actions](https://docs.microsoft.com/azure/app-service/deploy-github-actions?tabs=userlevel)
* [Integrate your app with an Azure virtual network](https://docs.microsoft.com/azure/app-service/web-sites-integrate-with-vnet)
* [App Service pricing](https://azure.microsoft.com/pricing/details/app-service/linux/)

### Java EE (Jakarta EE) Related

* [Jakarta EE](https://jakarta.ee/)
* [Jakarta RESTful Web Services](https://projects.eclipse.org/projects/ee4j.jaxrs)
* [Jakarta Persistence](https://projects.eclipse.org/projects/ee4j.jpa)
* [Jakarta JSON Binding](http://json-b.net/)
* [Jakarta Contexts and Dependency Injection](https://projects.eclipse.org/projects/ee4j.cdi)
* [Maven Plugin for Azure Web Apps](https://github.com/microsoft/azure-maven-plugins)

### MySQL

* [MySQL Community Edition](https://www.mysql.com/products/community/)
* [MySQL Connector/J](https://mvnrepository.com/artifact/mysql/mysql-connector-java)
* [MySQL Sample World Database Installation](https://dev.mysql.com/doc/world-setup/en/world-setup-installation.html)
* [Azure Database for MySQL](https://docs.microsoft.com/azure/mysql/)
* [Azure Database for MySQL - Flexible Server](https://docs.microsoft.com/azure/mysql/flexible-server/overview)