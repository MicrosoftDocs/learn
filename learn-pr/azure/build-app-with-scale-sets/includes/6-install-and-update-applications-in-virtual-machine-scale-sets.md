You need to configure your virtual machines when they start in the scale set and periodically will need to update the application running on your virtual machine. By the end of this unit, you'll understand:

- What is Azure Custom Script Extension. 
- How to use Azure Custom Script Extension. 
- How to update a running application on a scale set.



## **Install an application using Azure custom script extension**

Custom Script Extension allows you to download and execute scripts on Azure VMs. Typically this is used for post-deployment configuration, software installation, or any other configuration/management task. 

Custom scripts can be hosted on Azure Storage (for example, Blob), GitHub or added to a VM through the Azure portal at extension runtime.

Custom Script Extension can be integrated with Azure Resource Manager (ARM) templates, used with the Azure CLI, PowerShell, Portal, or REST API.  More information can be found [here](https://docs.microsoft.com/azure/virtual-machines/linux/extensions-customscript). 

To use the Custom Script Extension with the Azure CLI, you create a JSON file that defines what files to obtain and commands to execute.  Below is an example of a custom script configuration that downloads an application and installs it on a host instance: 

```json
# yourConfigV1.json 
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v1.sh"],
  "commandToExecute": "./custom_application_v1.sh"
}
```

Now, you need to deploy this configuration on the scale set using Custom Script Extension. Below is an example of how to do this in Azure CLI: 

```powershell
az vmss extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group myResourceGroup \
  --vmss-name yourScaleSet \
  --settings @yourConfigV1.json
```



You have used a Custom Script Extension to install an application on your scale set. 



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