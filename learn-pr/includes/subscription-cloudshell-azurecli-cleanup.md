## Cleanup resources

<!-- Standard resource group creation -->
::: zone pivot="personal-subscription"

The Azure resources that you created can incur ongoing costs. Make sure to delete the resource group that contains all those resources with the following Azure CLI command in the Cloud Shell. This will deallocate and remove all the created resources from your subscription.

```azurecli
az group delete --name learn-resources
```

::: zone-end

::: zone pivot="hosted-subscription"

The sandbox automatically cleans up your resources when you're finished with this module.

When you're working in your own subscription, it's a good idea at the end of a project to identify whether you still need the resources you created. Resources left running can cost you money. You can delete resources individually or delete the resource group to delete the entire set of resources.

::: zone-end