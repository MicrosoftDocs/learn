Create a file named *customConfig.json* and paste the following configuration:

```json
{
  "fileUris": ["https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/automate_nginx.sh"],
  "commandToExecute": "./automate_nginx.sh"
}
```

Apply the Custom Script Extension configuration to the VM instances in your scale set with [az vmss extension set](/cli/azure/vmss/extension#set). The following example applies the *customConfig.json* configuration to the *myScaleSet* VM instances in the resource group named *myResourceGroup*:

```azurecli
az vmss extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group myResourceGroup \
  --vmss-name myScaleSet \
  --settings @customConfig.json
```

Each VM instance in the scale set downloads and runs the script from GitHub. In a more complex example, multiple application components and files could be installed. If the scale set is scaled up, the new VM instances automatically apply the same Custom Script Extension definition and install the required application.