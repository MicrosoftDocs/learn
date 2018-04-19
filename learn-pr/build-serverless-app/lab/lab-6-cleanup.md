## Lab exercise 6 - Cleanup

When you no longer need or want the server-less application that you built in this module, use the [az group delete][az-group-delete] command to remove the resource group, Cosmos DB, Azure Functions, Event Grid subscription, Storage Account, and all related resources.

```azurecli
az group delete --name $rg --yes --no-wait
```

<!-- Links - Internal -->
[az-group-delete]: /cli/azure/group#az_group_delete