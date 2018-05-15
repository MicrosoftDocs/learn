To see the updated version, refresh the site from the previous module in your browser. Notice the change in app output in the following screenshot:

![Updated app running on scale set](../../media/deploy-custom-vmss-app/updated-app-vmss.png)


## Clean up module resources
To clean up the scale set resources and Packer image that you created in this module, use `az group delete`. The `--yes` parameter confirms that you want to delete the resources without an additional prompt to do so. The `--no-wait` parameter returns control to the prompt without waiting for the operation to finish.

```azurecli
az group delete --name myResourceGroup --yes --no-wait
```