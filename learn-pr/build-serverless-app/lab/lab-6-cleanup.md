## Lab exercise 6 - Test & Cleanup

Now that everything is built and put together, you can upload images into your application and everything should be connected together.

## Test

Browse to your application (you retrieved this URL in step one). Here is the command again if you don't have it handy:

```azurecli
az storage blob url -c $storageContainer --name index.html --account-name $storageAccount
```

Open the URL in your favorite web browser, and then upload an image into the application.  Then, select **Reload Images**. This will then rotate through all of the images you upload, and display the meta data.

## Clean up 

When you no longer need or want the server-less application that you built in this module, use the [az group delete][az-group-delete] command to remove the resource group, Cosmos DB, Azure Functions, Event Grid subscription, Storage Account, and all related resources.

```azurecli
az group delete --name $rg --yes --no-wait
```

<!-- Links - Internal -->
[az-group-delete]: /cli/azure/group#az_group_delete