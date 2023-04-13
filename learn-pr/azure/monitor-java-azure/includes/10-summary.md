Congratulations! You've learned how to use monitoring for your Java applications on Azure.

To that end, you've done the following actions:

- Learned about the different forms of monitoring on Azure.

- Build and deploy a sample microservices application and configured it for application performance monitoring (APM).

- Monitored the application with Azure Application Insights.

- Learned how to monitor the entire solution.

## Clean up your Azure resources

In the preceding processes, you created Azure resources. If you don't expect to need these resources in the future, delete the resource group by running the following commands in Azure Cloud Shell:

```azurecli
az group delete --name <your Resource Group Name> --yes
```

### Delete your log analytics workspace

Deleting your resource group, will soft delete your Azure Log Analytics workspace. When soft deleting an Azure Log Analytics workspace, it gets into a soft-delete state to allow its recovery including data and connected agents within 14 days.
If you wish to rerun the setup script, and re-create your resources, either create a new workspace with a new name, or use the below command to permanently delete the old workspace:

```azurecli
az monitor log-analytics workspace delete --force true --resource-group <your Resource Group Name> --workspace-name <your log analytics workspace name>
```

## References

- [Azure monitor](/azure/azure-monitor?WT.mc_id=java-00000-ropreddy)

- [Azure Spring Apps Availability by Region](https://azure.microsoft.com/global-infrastructure/services/?products=spring-apps)

- [Azure Spring Apps locations and pricing](https://azure.microsoft.com/pricing/details/spring-apps?WT.mc_id=java-00000-ropreddy)

- [Azure Database for MySQL pricing](https://azure.microsoft.com/pricing/details/mysql/server?WT.mc_id=java-00000-ropreddy)

- [Monitoring in Azure Database for MySQL](/azure/mysql/concepts-monitoring?WT.mc_id=java-00000-ropreddy)

- [Application Insights for web pages](/azure/azure-monitor/app/javascript?WT.mc_id=java-00000-ropreddy)

- [KQL syntax](/azure/data-explorer/kql-quick-reference?WT.mc_id=java-00000-ropreddy)

- [Azure for Java developers](/azure/developer/java?WT.mc_id=java-00000-ropreddy)
