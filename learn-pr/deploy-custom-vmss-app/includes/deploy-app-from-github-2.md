To use the Azure Custom Script Extension, you provide the location of files to be downloaded, and then a command to execute. This tutorial shows a simple example that does the following:

- Copies files from a GitHub repo
- Runs a script to move the files to the required location
- Start a basic Node.js app. 

For more complex applications, the script could clone a GitHub or other source control repo, then run local build tools such as Grunt or Maven.

First, create a file named *customConfig.json* in the Azure Cloud Shell that defines what files to download and run. To see a list of available editors and create the file, type `sensible-editor customConfig.json`. Paste the following JSON into the file:

```json
{
  "fileUris": ["https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/nodejs-app/hello-world-v1.js",
    "https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/nodejs-app/nginx",
    "https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/nodejs-app/deploy-v1.sh"],
  "commandToExecute": "./deploy-v1.sh"
}
```

As you can see from the preceding configuration file, we define three files to download to our VM instances: 

- *hello-world-v1.js* is a basic Node.js app that outputs the hostname of the VM instance.
- *nginx* defines a basic NGINX reverse proxy for the Node.js app to be presented on TCP port 80 via NGINX.
- *deploy-v1.sh* runs some bash commands to move the files to required locations, sets the appropriate file permissions and then starts the Node.js application. Notice that we've appended a version number to the end of this script file name. We'll get back to that in the next unit. 

Apply the Custom Script Extension configuration to the VM instances in your scale set with [az vmss extension set](/cli/azure/vmss/extension#set). The following example applies the *customConfig.json* configuration to the *myScaleSet* VM instances in the resource group named *myResourceGroup*:

```azurecli-interactive
az vmss extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group myResourceGroup \
  --vmss-name myScaleSet \
  --settings @customConfig.json
```

Each VM instance in the scale set downloads the files from GitHub and runs the install script. As the VM extension is applied to the scale set, if the scale set is scaled up, the new VM instances automatically apply the same Custom Script Extension definition and install the required application.