Throughout the lifecycle of a scale set, you may need to deploy an updated version of your application. With the Custom Script Extension, you can reference an updated deploy script and then reapply the extension to your scale set. When the scale set was created in a previous step, the `--upgrade-policy-mode` was set to *automatic*. This setting allows the VM instances in the scale set to automatically update and apply the latest version of your application.

In your current shell, create a file named *customConfigv2.json* and paste the following configuration. This definition runs an updated *v2* version of the application install script:

```json
{
  "fileUris": ["https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/automate_nginx_v2.sh"],
  "commandToExecute": "./automate_nginx_v2.sh"
}
```

Apply the Custom Script Extension configuration to the VM instances in your scale set again with [az vmss extension set](/cli/azure/vmss/extension#set). The *customConfigv2.json* is used to apply the updated version of the application:

```azurecli-interactive
az vmss extension set \
    --publisher Microsoft.Azure.Extensions \
    --version 2.0 \
    --name CustomScript \
    --resource-group myResourceGroup \
    --vmss-name myScaleSet \
    --settings @customConfigv2.json
```

All VM instances in the scale set are automatically updated with the latest version of the sample web page.