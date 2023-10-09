Congratulations! You've learned about autoscaling for your Java applications on Azure.

## Summary of what you learned

In this module, you learned about:

- Creating a Sample Autoscale architecture with Azure Spring Apps.

- Investigating the sample scale rules.

- Triggering scale actions.

- Best practices for scaling Java applications on Azure.

## Clean up your Azure resources

In the preceding processes, you created Azure resources. If you don't expect to need these resources in the future, delete the resource group by running the following commands in Azure Cloud Shell:

```azurecli
az group delete --name <your Resource Group Name> --yes
```

### Delete your log analytics workspace

Deleting your resource group will soft delete your Azure Log Analytics workspace. When soft deleting an Azure Log Analytics workspace, it gets into a soft-delete state to allow its recovery, including data and connected agents, within 14 days. If you wish to rerun the setup script and re-create your resources, either create a new workspace with a new name or use the below command to permanently delete the old workspace:

```azurecli
az monitor log-analytics workspace delete --force true --resource-group <your Resource Group Name> --workspace-name <your log analytics workspace name>
```

## References

- [Get started with Autoscale in Azure](/azure/azure-monitor/platform/autoscale-get-started?WT.mc_id=java-00000-ropreddy)

- [Azure Spring Apps Availability by Region](https://azure.microsoft.com/global-infrastructure/services/)

- [Azure Spring Apps locations and pricing](https://azure.microsoft.com/pricing/details/spring-cloud?WT.mc_id=java-00000-ropreddy)

- [Azure Database for MySQL pricing](https://azure.microsoft.com/pricing/details/mysql/server?WT.mc_id=java-00000-ropreddy)

- [KQL syntax](/azure/data-explorer/kql-quick-reference?WT.mc_id=java-00000-ropreddy)

- [Azure for Java developers](/azure/developer/java?WT.mc_id=java-00000-ropreddy)

- [Create an Activity Log Alert to monitor all autoscale engine operations on your subscription](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/monitor-autoscale-alert)

- [Create an Activity Log Alert to monitor all failed autoscale scale in/scale out operations on your subscription](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/monitor-autoscale-failed-alert).

- [Troubleshooting Azure autoscale](/azure/azure-monitor/autoscale/autoscale-troubleshoot?WT.mc_id=java-00000-ropreddy)
