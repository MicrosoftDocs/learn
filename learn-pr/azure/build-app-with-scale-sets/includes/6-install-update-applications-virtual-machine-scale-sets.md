When you deploy an application across a scale set, you need a mechanism that updates your application consistently, across all instances in the scale set. You achieve this outcome by using a custom script extension.

In the shipping company scenario, you need a quick way to roll out updates to the application while minimizing disruption to the end users. A custom script extension is an ideal solution.

In this unit, you'll learn how to use a custom script extension to update an application that runs on a scale set.

## What is an Azure custom script extension?

An Azure custom script extension downloads and runs a script on an Azure VM. It can automate the same tasks on all the VMs in a scale set.

Store your custom scripts in Azure Storage or in GitHub. To add one to a VM, you can use the Azure portal. To run custom scripts as part of a templated deployment, combine a custom script extension with Azure Resource Manager templates.

## Install an application across a scale set by using a custom script extension

To use a custom script extension with the Azure CLI, you create a configuration file that defines the files to get and the commands to run. This file is in JSON format.  

The following example shows a custom script configuration that downloads an application from a repository in GitHub and installs it on a host instance by running a script named `custom_application_v1.sh`:

```json
# yourConfigV1.json 
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v1.sh"],
  "commandToExecute": "./custom_application_v1.sh"
}
```

To deploy this configuration on the scale set, you use a custom script extension. The following code shows how to create a custom script extension for a virtual machine scale set by using the Azure CLI. This command installs the new app on the VMs across the scale set:

```azurecli
az vmss extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group myResourceGroup \
  --vmss-name yourScaleSet \
  --settings @yourConfigV1.json
```

## Update an application across a scale set by using a custom script extension

You can use a custom script extension to update an existing app across a virtual machine scale set. You reference an updated deployment script and then reapply the extension to your scale set. For example, the following JSON code shows a configuration that fetches a new version of an application and installs it:

````json
# yourConfigV2.json
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v2.sh"],
  "commandToExecute": "./custom_application_v2.sh"
}
````

Use the same `az vmss extension set` command shown previously to deploy the updated app. But this time, reference the new configuration file:

```azurecli
az vmss extension set \
    --publisher Microsoft.Azure.Extensions \
    --version 2.0 \
    --name CustomScript \
    --resource-group yourResourceGroup \
    --vmss-name yourScaleSet \
    --settings @yourConfigV2.json
```

The VMs are updated according to the upgrade policy for the scale set. You specify this policy when you first create the scale set. The upgrade policy can have one of the following three modes:

- **Automatic**: The scale set doesn't define when the VMs are upgraded. They could all update at the same time, causing a service outage.
- **Rolling**: The scale set rolls out the update in batches across the VMs in the scale set. An optional pause can minimize or eliminate a service outage. In this mode, machines in the scale set might run different versions of the app for a short time. This mode requires that you either add a health probe to the scale set or apply the application health extension to the scale set.
- **Manual**: Existing VMs in the scale set aren't updated. All changes must be done manually. This mode is the default.

To specify the upgrade policy mode when you provision a virtual machine scale set, use the `upgrade-policy-mode` option. The following code example uses the Azure CLI:  

```azurecli
az vmss create \
  --resource-group MyResourceGroup \
  --name MyScaleSet \
  --image UbuntuLTS \
  --upgrade-policy-mode automatic \
  --admin-username azureuser \
  --generate-ssh-keys
```
