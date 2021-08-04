Congratulations! You've learned how to use autoscaling for your Java applications on Azure.

In this module, you learned how to:

- Create a Sample Autoscale architecture with Java

- Create scale rules

- Trigger scale actions

- Best practices for scaling Java applications on Azure.

## Autoscale recap

- A resource can have only *one* autoscale setting
- An autoscale setting can have one or more profiles and each profile can have one or more autoscale rules.
- An autoscale setting scales instances horizontally, which is *out* by increasing the instances and *in* by decreasing the number of instances.
  An autoscale setting has a maximum, minimum, and default value of instances.
- An autoscale job always reads the associated metric to scale by, checking if it has crossed the configured threshold for scale-out or scale-in. You can view a list of metrics that autoscale can scale by at Azure Monitor autoscaling common metrics.
- All thresholds are calculated at an instance level. For example, "scale out by one instance when average CPU > 80% when instance count is 2", means scale-out when the average CPU across all instances is greater than 80%.
- All autoscale failures are logged to the Activity Log. You can then configure an activity log alert so that you can be notified via email, SMS, or webhooks whenever there is an autoscale failure.
- Similarly, all successful scale actions are posted to the Activity Log. You can then configure an activity log alert so that you can be notified via email, SMS, or webhooks whenever there is a successful autoscale action. You can also configure email or webhook notifications to get notified for successful scale actions via the notifications tab on the autoscale setting.

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

- [Azure Spring Cloud Availability by Region](https://azure.microsoft.com/global-infrastructure/services/?products=spring-cloud?WT.mc_id=java-00000-ropreddy)

- [Azure Spring Cloud locations and pricing](https://azure.microsoft.com/pricing/details/spring-cloud?WT.mc_id=java-00000-ropreddy)

- [Azure Database for MySQL pricing](https://azure.microsoft.com/pricing/details/mysql/server?WT.mc_id=java-00000-ropreddy)

- [KQL syntax](/azure/data-explorer/kql-quick-reference?WT.mc_id=java-00000-ropreddy)

- [Azure for Java developers](/azure/developer/java?WT.mc_id=java-00000-ropreddy)

- [create an Activity Log Alert to monitor all autoscale engine operations on your subscription](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/monitor-autoscale-alert)

- [create an Activity Log Alert to monitor all failed autoscale scale in/scale out operations on your subscription](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/monitor-autoscale-failed-alert).
