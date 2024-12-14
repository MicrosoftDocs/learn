In this module, you learned how to create a Java web application, how to use the Maven Plugin for Azure Web Apps, and how to deploy your application to Azure App Service.

## Clean up resources

In this module, you created resources using your Azure subscription. You need to clean up these resources to avoid unnecessary charges. Run the following command to delete all the resources.

```azurecli
az group delete --name <resource-group-name>
```

### Java-related resources

* [Azure App Service](/azure/app-service/)
* [Continuous deployment with custom containers in Azure App Service](/azure/app-service/deploy-ci-cd-custom-container?tabs=acr&pivots=container-linux)
* [Monitor Azure App Service performance](/azure/azure-monitor/app/azure-web-apps?tabs=java)
* [Get started with Autoscale in Azure](/azure/azure-monitor/platform/autoscale-get-started)
* [Deploy to App Service using GitHub Actions](/azure/app-service/deploy-github-actions?tabs=userlevel)
* [Integrate your app with an Azure virtual network](/azure/app-service/web-sites-integrate-with-vnet)
* [Azure App Service Hybrid Connections](/azure/app-service/app-service-hybrid-connections)
* [App Service pricing](https://azure.microsoft.com/pricing/details/app-service/linux/)
* [Maven Plugin for Azure Web Apps](https://github.com/microsoft/azure-maven-plugins)
