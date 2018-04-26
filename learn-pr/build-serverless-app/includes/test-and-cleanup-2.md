## Testing your application
Now that you've built your app, you should be able to upload images and see the metadata that was tagged to the images by the Computer Vision API.

Browse to your application (you retrieved this URL in step one). Here is the command again if you don't have it handy:

```azurecli
az storage blob url -c $storageContainer --name index.html --account-name $storageAccount
```

Open the URL in your favorite web browser, and then upload an image into the application.  Then, select **Reload Images**. This will then rotate through all of the images you upload, and display the metadata.

## Cleaning up your environment

When you no longer need or want the serverless application that you built in this unit, use the [az group delete][az-group-delete] command to remove the resource group, Cosmos DB, Azure Functions, Event Grid subscription, Storage Account, and all related resources.

```azurecli
az group delete --name $rg --yes --no-wait
```

<!-- Links - Internal -->
[az-group-delete]: /cli/azure/group#az_group_delete