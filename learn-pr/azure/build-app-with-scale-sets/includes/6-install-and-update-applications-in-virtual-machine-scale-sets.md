When you deploy an application across a scale set, you need a mechanism that makes it possible to update your application consistently, across all instances in the scale set. You can achieve this task by using a custom script extension.

In the shipping company scenario, you need a quick way to roll out updates to the application while minimizing disruption to the end users. A custom script extension is the ideal mechanism to perform this operation.

In this unit, you'll learn:

- What an Azure custom script extension is.
- How to use an Azure custom script extension.
- How to update a running application on a scale set.

## Install an application using an Azure custom script extension

An Azure custom script extension enables you to download and run a script on Azure virtual machines. You might typically use a custom script extension for post-deployment configuration. You can also use a custom script extension for software installation, or any other scriptable configuration or management task.

You can store custom scripts in Azure Storage, or GitHub. You can also add a custom script to a virtual machine using the Azure portal.

You can combine a custom script extension with Azure Resource Manager (ARM) templates. This technique gives you a mechanism to run custom scripts as part of a templated deployment, used with the Azure CLI, PowerShell, Portal, or REST API. You can find more information about this approach at  [Custom Script Extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/custom-script-windows) and [Use the Azure Custom Script Extension Version 2 with Linux virtual machines](https://docs.microsoft.com/azure/virtual-machines/extensions/custom-script-linux).

To use a custom script extension with the Azure CLI, you create a configuration file that defines the files to obtain and the commands to run. This file is in JSON format.  The example below shows a custom script configuration that downloads an application from a repository in  GitHub and installs it on a host instance by running a script named *custom_application_v1.sh*: 

```json
# yourConfigV1.json 
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v1.sh"],
  "commandToExecute": "./custom_application_v1.sh"
}
```

To deploy this configuration on the scale set, you use a custom script extension. The code below shows how to create a custom script extension for a virtual machine scale set using the Azure CLI:

```powershell
az vmss extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group myResourceGroup \
  --vmss-name yourScaleSet \
  --settings @yourConfigV1.json
```

START HERE TOMORROW

## **Update an app deployment using custom script extension**

At some point, you will want to apply an updated version of your application that is running on a scale set. With a Custom Script Extension, it is possible to reference an updated deploy script and reapply the extension to part or all of your scale set.

When creating a scale set, you can define an upgrade policy. The three modes are:

- Automatic - the scale set makes no guarantees as to the order of the VMs being brought down. Potentially, all VMs could be brought down at the same time, causing a service outage.
- Rolling - the scale set rolls out the update in batches with an optional pause to minimize or eliminate service outage.
- Manual - when you update the scale set model,  no actions are taken on existing VMs.

You can define an upgrade policy mode when provisioning an azure virtual machine scale set. Below is an example in Azure CLI:  

```powershell
az vmss create \
  --resource-group yourResourceGroup \
  --name yourScaleSet \
  --image UbuntuLTS \
  --upgrade-policy-mode automatic \ 
  --admin-username azureuser \
  --generate-ssh-keys
```

 In order to update a VM scale set with a new updated version of your application, you can simply deploy the custom script configuration for the new version of the application.  Below shows an example of a configuration that fetches a new version of an application and installs it: 

````json
# yourConfigV2.json 
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v2.sh"],
  "commandToExecute": "./custom_application_v2.sh"
}
````

Now all you need to do is deploy an extension using the new configuration, as shown below using Azure CLI: 

```powershell
az vmss extension set \
    --publisher Microsoft.Azure.Extensions \
    --version 2.0 \
    --name CustomScript \
    --resource-group yourResourceGroup \
    --vmss-name yourScaleSet \
    --settings @yourConfigV2.json
```

You have now automatically updated all of the instances in the scale set with your new version of the application. 