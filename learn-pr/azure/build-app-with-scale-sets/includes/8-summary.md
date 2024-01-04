In this module, you got to know the features of Virtual Machine Scale Sets. You learned how to manually scale a scale set. You also learned how to configure a scale set to autoscale based on a schedule or on performance metrics. You then learned how to use a custom extension script to deploy and update an application across the virtual machines in a scale set.

In the example scenario, you applied your knowledge to the shipping company's system. You deployed the website by using a scale set, and you configured the scale set to scale out and back in as the CPU usage across the virtual machines changed. You also rolled out a new version of the web application across the scale set while allowing the virtual machines to continue running. These actions allow users to access the system and maintain a good response time, even when the application is being updated.

## Clean up

In Cloud Shell, run the following command to delete the resource group. This action also removes the scale set.

```azurecli
az group delete --name myResourceGroup --yes
```

## Learn more

- [Overview of autoscale with Azure Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-autoscale-overview)
- [Deploy your application on Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-deploy-app)
- [Work with large Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups)
- [Use the custom script extension for Windows](/azure/virtual-machines/extensions/custom-script-windows)
- [Use the Azure custom script extension version 2 with Linux VMs](/azure/virtual-machines/extensions/custom-script-linux)
- [Use the application health extension with Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-health-extension)
