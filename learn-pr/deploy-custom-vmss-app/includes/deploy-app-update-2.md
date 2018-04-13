To update the app on your virtual machine scale set, you need to create another Custom Script Extension definition. For an updated defintion to successfully apply, the name or version of the scripts must be different from the previous defintion. A best practice is include a version number within the filename for your scripts. As the version number changes, the Custom Script Extension defintion also changes and successfully applies.

Create a file named *customConfig2.json* in the Azure Cloud Shell that defines what files to download and run. This definition runs an updated *v2* version of the application install script. To see a list of available editors and create the file, type `sensible-editor customConfigv2.json`. Paste the following template into the file:

```json
{
  "fileUris": ["https://raw.githubusercontent.com/iainfoulds/compute-automation-configurations/nodejs-app/nodejs-app/hello-world-v2.js",
    "https://raw.githubusercontent.com/iainfoulds/compute-automation-configurations/nodejs-app/nodejs-app/deploy-v2.sh"],
  "commandToExecute": "./deploy-v2.sh"
}
```

Apply the Custom Script Extension configuration to the VM instances in your scale set again with [az vmss extension set](/cli/azure/vmss/extension#set). The *customConfigv2.json* is used to apply the updated version of the application:

```azurecli
az vmss extension set \
    --publisher Microsoft.Azure.Extensions \
    --version 2.0 \
    --name CustomScript \
    --resource-group myResourceGroup \
    --vmss-name myScaleSet \
    --settings @customConfigv2.json
```

All VM instances in the scale set are automatically updated with the latest version of the sample web app.