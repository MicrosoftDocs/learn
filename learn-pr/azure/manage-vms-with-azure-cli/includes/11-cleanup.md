You have created a new Linux VM, changed it's size, stopped and started it, and updated it's configuration with the Azure CLI.

## Cleanup

Now that we are finished with the VM, let's clean up the created resources. This is particularly important for compute and storage resources that will can continue to be billed against your account. 

You can delete individual resources with the `delete` command, but the easiest way to remove everything is with `az group delete`. Execute the following command in the Azure CLI:

```azurecli
az group delete --name ExerciseResources --no-wait
```

Answer "yes" to the prompt when it is shown, alternatively you can use the `--yes` parameter to auto-answer the prompt.

This deletes all of the resources associated with the resource group, and is guaranteed to deallocate them in the correct order. The `--no-wait` parameter keeps the CLI from blocking while the deletion takes place. You can omit it to wait for the resources to be deleted, or use the `az group wait -n ExerciseResources --deleted` command later in your script to wait for the deletion to complete.


## Further reading

* [Azure CLI Overview](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)
* [Azure CLI command reference](https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest)
