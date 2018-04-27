## Testing your application
Now that you've built your app, you should be able to upload images and see the metadata that was tagged to the images by the Computer Vision API.

Browse to your application (you retrieved this URL in step one). Here is the command again if you don't have it handy:

```azurecli
az storage blob url -c $storageContainer --name index.html --account-name $storageAccount
```

Open the URL in your favorite web browser, and then upload an image into the application.  Then, select **Reload Images**. This will then rotate through all of the images you upload, and display the metadata.

## Cleaning up your environment

You created live resources in this module. You may be billed for these resources depending on your account status and usage. In order to not incur any unexpected charges, it's important to get in the habit of deleting any resources that you are no longer using. 

Since you created a resource group for all of the resources you created in this module, deletion will be easy! Use the [az group delete][az-group-delete] command to remove the resource group, Cosmos DB, Azure Functions, Event Grid subscription, Storage Account, and all related resources.

```azurecli
az group delete --name $rg --yes --no-wait
```

<!-- Links - Internal -->
[az-group-delete]: /cli/azure/group#az_group_delete