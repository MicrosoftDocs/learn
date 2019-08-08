When you deploy an application across a scale set, you need a mechanism that updates your application consistently, across all instances in the scale set. You achieve this outcome by using a custom script extension.

In the shipping company scenario, you need a quick way to roll out updates to the application while minimizing disruption to the end users. A custom script extension is the ideal mechanism to do this operation.

In this unit, you'll learn how to use a custom script extension to update an application running on a scale set.

## What is an Azure custom script extension?

An Azure custom script extension downloads and runs a script on an Azure virtual machine. You can use a custom script extension with a virtual machine scale set, to automate the same tasks on all the virtual machines in the scale set.

You can store custom scripts in Azure Storage, or GitHub. Also, you could add a custom script to a virtual machine using the Azure portal.

A custom script extension can be combined with Azure Resource Manager templates. This technique offers a mechanism to run custom scripts as part of a templated deployment.

## Install an application across a scale set using a custom script extension

To use a custom script extension with the Azure CLI, you create a configuration file that defines the files to obtain, and the commands to run. This file is in JSON format.  The example below shows a custom script configuration that downloads an application from a repository in GitHub, and installs it on a host instance by running a script named *custom_application_v1.sh*:

```json
# yourConfigV1.json 
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v1.sh"],
  "commandToExecute": "./custom_application_v1.sh"
}
```

To deploy this configuration on the scale set, you use a custom script extension. The code below shows how to create a custom script extension for a virtual machine scale set using the Azure CLI. This command installs the new app on the virtual machines across the scale set:

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

You can use a custom script extension to update an existing app across a virtual machine scale set. You reference an updated deployment script, and then reapply the extension to your scale set. For example, the JSON snippet below shows an example of a configuration that fetches a new version of an application and installs it:

````json
# yourConfigV2.json
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v2.sh"],
  "commandToExecute": "./custom_application_v2.sh"
}
````

You then use the same `az vmss extension set` command shown previously to deploy the updated app, except that you reference the new configuration file:

```powershell
az vmss extension set \
    --publisher Microsoft.Azure.Extensions \
    --version 2.0 \
    --name CustomScript \
    --resource-group yourResourceGroup \
    --vmss-name yourScaleSet \
    --settings @yourConfigV2.json
```

The virtual machines are updated using the strategy defined by the upgrade policy for the scale set. You specify this policy when you first create the scale set. The upgrade policy can have one of the following three modes:

- **Automatic**. The scale set makes no guarantees about when the virtual machines are upgraded. They could all be brought down and updated at the same time, causing a service outage.
- **Rolling**. The scale set rolls out the update in batches across the virtual machines in the scale set – there's an optional pause to minimize or eliminate service outage. In this mode, machines in the scale set might be running different versions of the app for a short time. This mode requires that you either add a health probe to the scale set, or apply the Application Health extension to the scale set.
- **Manual**. Existing virtual machines in the scale set aren't updated. All changes must be done manually – this is the default mode.

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
