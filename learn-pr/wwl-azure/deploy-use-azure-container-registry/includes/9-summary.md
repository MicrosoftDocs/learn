In this module, you learned how to:<br>

 -  Describe Azure Container Registry as a private registry service for building, storing, and managing container images and related artifacts.
 -  Create an Azure container registry instance with the Azure portal.
 -  Sign in to the registry instance using the Azure CLI on your local machine.
 -  Push an image to the registry instance.
 -  Remove the registry-tagged local image reference from your local Docker environment.
 -  View the image in your registry.
 -  Pull and run the container image from your container registry.

## Clean up resources

If you created a resource group solely for this module, delete it when you're finished. Replace `<resource-group-name>` with the name of that module-specific resource group. Don't use this command to delete shared or pre-existing resource groups. Deleting the resource group deletes the container registry and its stored images.

```azurecli
az group delete --name <resource-group-name> --yes --no-wait
```

If you used a shared or pre-existing resource group, don't delete the resource group. Instead, clean up only the registry or sample image content you created.

To delete the container registry and everything stored in it, replace `<registry-name>` and `<resource-group-name>` and run:

```azurecli
az acr delete --name <registry-name> --resource-group <resource-group-name> --yes
```

If you want to keep the registry but remove the sample repository, delete the `hello-world` repository:

If your registry uses ABAC repository permissions, deleting the sample repository requires `Container Registry Repository Contributor` or equivalent repository delete permission. If you only have `Container Registry Repository Writer`, use the untag option instead.

```azurecli
az acr repository delete --name <registry-name> --repository hello-world --yes
```

Deleting the repository removes all manifests and tags under `hello-world`. Layer data that isn't referenced by any other manifest can also be removed.

If you want to keep the repository and remove only the `v1` tag reference, untag the image:

```azurecli
az acr repository untag --name <registry-name> --image hello-world:v1
```

Untagging removes only the tag reference. It doesn't delete the manifest or layer data, and it doesn't free registry storage.

## Learn more

 -  [Azure free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn) \| [Azure free account FAQ](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn#FAQ)
 -  [Free account for Students](https://azure.microsoft.com/free/students/?cid=msft_learn) \| [Azure for students FAQ](/azure/education-hub/azure-dev-tools-teaching/program-faq#azure-for-students)
 -  [Create an Azure account](/learn/modules/create-an-azure-account/?azure-portal=true) module on Learn.
