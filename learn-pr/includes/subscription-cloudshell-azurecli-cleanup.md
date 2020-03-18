## Cleanup resources

<!-- Standard resource group creation -->
::: zone pivot="personal-subscription"

The Azure resources that you created can incur ongoing costs. To avoid such costs, make sure to delete the resource group that contains all those resources with the following Azure CLI command:

```azurecli
az group delete --name learn-rg
```

::: zone-end

::: zone pivot="hosted-subscription"

The sandbox automatically cleans up your resources when you're finished with this module.

When you're working in your own subscription, it's a good idea at the end of a project to identify whether you still need the resources you created. Resources left running can cost you money. You can delete resources individually or delete the resource group to delete the entire set of resources.

::: zone-end