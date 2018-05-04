You created live resources in this module. You may be billed for these resources depending on your account status and usage. In order to not incur any unexpected charges, it's important to get in the habit of deleting any resources that you are no longer using. 

Since you created a resource group for all of the resources you created in this module, deletion will be easy! Use the [az group delete][az-group-delete] command to remove the resource group, Cosmos DB, Azure Functions, Event Grid subscription, Storage Account, and all related resources.

```azurecli-interactive
az group delete --name $rg --yes --no-wait
```

<!-- Links - Internal -->
[az-group-delete]: /cli/azure/group#az_group_delete