When you deploy an application across a scale set, you need a mechanism that makes it possible to update your application consistently, across all instances in the scale set. You can achieve this task by using a custom script extension.

In the shipping company scenario, you need a quick way to roll out updates to the application while minimizing disruption to the end users. A custom script extension is the ideal mechanism to perform this operation.

In this unit, you'll learn:

- What an Azure custom script extension is.
- How to use an Azure custom script extension.
- How to update a running application on a scale set.

## Azure custom script extensions

An Azure custom script extension enables you to download and run a script on an Azure virtual machine. You can also use a custom script extension with a virtual machine scale set, to perform the same tasks on all the virtual machines in the scale set. For example, you might use a custom script extension for performing post-deployment configuration. You can also use a custom script extension for software installation, or any other scriptable configuration or management task.

You can store custom scripts in Azure Storage, or GitHub. You can also add a custom script to a virtual machine using the Azure portal.

You can combine a custom script extension with Azure Resource Manager templates. This technique gives you a mechanism to run custom scripts as part of a templated deployment. You can find more information about this approach at  [Custom Script Extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/custom-script-windows) and [Use the Azure Custom Script Extension Version 2 with Linux virtual machines](https://docs.microsoft.com/azure/virtual-machines/extensions/custom-script-linux).

## Install an application across a scale set using a custom script extension

To use a custom script extension with the Azure CLI, you create a configuration file that defines the files to obtain and the commands to run. This file is in JSON format.  The example below shows a custom script configuration that downloads an application from a repository in  GitHub, and installs it on a host instance by running a script named *custom_application_v1.sh*:

```json
# yourConfigV1.json 
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v1.sh"],
  "commandToExecute": "./custom_application_v1.sh"
}
```

To deploy this configuration on the scale set, you use a custom script extension. The code below shows how to create a custom script extension for a virtual machine scale set using the Azure CLI. This command will cause the new app to be installed on the virtual machines across the scale set:

```powershell
az vmss extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group myResourceGroup \
  --vmss-name yourScaleSet \
  --settings @yourConfigV1.json
```

## Update an application across a scale set using a custom script extension

As well as installing a new app, you can use a custom script extension to update an existing app across a virtual machine scale set. You can reference an updated deployment script, and then reapply the extension to your scale set. For example, the JSON snippet below shows an example of a configuration that fetches a new version of an application and installs it:

````json
# yourConfigV2.json
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v2.sh"],
  "commandToExecute": "./custom_application_v2.sh"
}
````

You can then use the same `az vmss extension set` command shown previously to deploy the updated app, except that you reference the new configuration file:

```powershell
az vmss extension set \
    --publisher Microsoft.Azure.Extensions \
    --version 2.0 \
    --name CustomScript \
    --resource-group yourResourceGroup \
    --vmss-name yourScaleSet \
    --settings @yourConfigV2.json
```

The virtual machines are updated using the strategy defined by the upgrade policy for the scale set. You can specify this policy when you first create the scale set. The upgrade policy can have one of the following three modes:

- **Automatic**. The scale set makes no guarantees about when the virtual machines are upgraded. They could all be brought down and updated at the same time, causing a service outage.
- **Rolling**. The scale set rolls out the update in batches across the virtual machines in the scale set, with an optional pause to minimize or eliminate service outage. In this mode, different machines in the scale set might be running different versions of the app for a short while. This mode requires that you either add a health probe to the scale set, or apply the Application Health extension to the scale set. For more details, visit [Using Application Health extension with virtual machine scale sets](https://docs.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-health-extension).
- **Manual**. Existing virtual machines in the scale set aren't updated. All changes must be performed manually. This is the default mode.

To specify the upgrade policy mode when you provision a virtual machine scale set, use the `upgrade-policy-mode` option. The following code shows an example using the Azure CLI:  

```powershell
az vmss create \
  --resource-group MyResourceGroup \
  --name MyScaleSet \
  --image UbuntuLTS \
  --upgrade-policy-mode automatic \
  --admin-username azureuser \
  --generate-ssh-keys
```
