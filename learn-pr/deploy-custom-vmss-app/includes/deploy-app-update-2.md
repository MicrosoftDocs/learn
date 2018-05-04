To update the app on your virtual machine scale set, you need to create another Custom Script Extension definition. In order to apply this update successfully to the scale set, make sure the name or version of the script is different from the previous script definition. A best practice is to include a version number in the file name for your scripts. As the version number changes, the Custom Script Extension definition also changes.

Create a file named *customConfigv2.json* in Azure Cloud Shell that defines what files to download and run. Paste the following template into the file:

```json
{
  "fileUris": ["https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/nodejs-app/hello-world-v2.js",
    "https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/nodejs-app/deploy-v2.sh"],
  "commandToExecute": "./deploy-v2.sh"
}
```
The preceding JSON definition specifies an updated version of the application installation script, *deploy-v2.sh*. The definition also specifies an updated version of our app, *hello-world-v2.js*.

To see a list of available editors and create the file, enter `sensible-editor customConfigv2.json`. 

Apply the updated Custom Script Extension configuration to the VM instances in your scale set by using the [az vmss extension set](/cli/azure/vmss/extension#set) command again as follows:

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