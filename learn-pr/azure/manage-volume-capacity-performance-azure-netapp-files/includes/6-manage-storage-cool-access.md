By using Azure NetApp Files [storage with cool access](https://learn.microsoft.com/azure/azure-netapp-files/cool-access-introduction), you can configure inactive data to move from Azure NetApp Files storage (hot tier) to an Azure storage account (cool tier). Cool access is suitable for infrequently accessed data and can reduce total storage cost.

The cool access feature allows you to configure a capacity pool with cool access.

Storage with cool access provides options for coolness period to optimize network transfer costs based on workload read and write patterns. This feature is provided at the volume level.

### Considerations

- No guarantee is provided for any maximum latency for client workload for any service tier.
- Although cool access is available for Standard, Premium, and Ultra service levels, billing for using the feature differs from hot tier charges.
- You can convert an existing capacity pool into a cool-access capacity pool to create cool-access volumes. After it is enabled, you can't convert the pool back to a non-cool-access pool.
- A cool-access capacity pool can contain both cool-access-enabled and cool-access-disabled volumes.
- To prevent data retrieval from cool tier to hot tier during sequential reads, set retrieval policy to **Default** or **Never**.
- After the capacity pool is configured for cool access volumes, the setting can't be disabled at the capacity pool level. You can still enable or disable cool access at the volume level.

### Register the feature to enable cool access

Azure NetApp Files storage with cool access is generally available. Before using cool access for the first time, register for the feature with the service level you intend to use.

1. Register the feature:

   `Register-AzProviderFeature -ProviderNamespace Microsoft.NetApp -FeatureName ANFCoolAccess`

2. Check registration status:

   `Get-AzProviderFeature -ProviderNamespace Microsoft.NetApp -FeatureName ANFCoolAccess`

You can also use [Azure CLI commands](https://learn.microsoft.com/cli/azure/feature) `az feature register` and `az feature show` to register and view registration status.

To learn about how to update Terraform-managed Azure resources outside of Terraform, see [Managing Azure resources outside of Terraform](https://learn.microsoft.com/azure/azure-netapp-files/terraform-manage-volume).