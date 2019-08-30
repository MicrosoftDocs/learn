In this module, you looked at the features of virtual machine scale sets. You saw how to manually scale a scale set, and configure a scale set to autoscale – based on a schedule – or by using performance metrics. You also learned how to use a custom extension script to deploy and update an application across the virtual machines in a scale set.

You applied your knowledge to the shipping company's system. You deployed their web site using a scale set, and you configured the scale set to scale out and back in as the CPU utilization across the virtual machines increased and decreased. You also rolled out a new version of the web application across the scale set while allowing the virtual machines to continue running. These features will enable users to access the system while maintaining a good response time, even when the application is being updated.

## Clean up

- In the Cloud Shell, run the following command to delete the **scalesetrg** resource group. This action also removes the scale set.

    ```bash
        az group delete \
          --name scalesetrg \
          --yes
    ```

## Learn more

- [Overview of autoscale with Azure virtual machine scale sets](https://docs.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-autoscale-overview)
- [Deploy your application on virtual machine scale sets](https://docs.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-deploy-app)
- [Using Application Health extension with virtual machine scale sets](https://docs.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-health-extension)
- [Working with large virtual machine scale sets](https://docs.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups)
- [Custom Script Extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/custom-script-windows)
- [Use the Azure Custom Script Extension Version 2 with Linux virtual machines](https://docs.microsoft.com/azure/virtual-machines/extensions/custom-script-linux)
- [Use the Application Health extension with virtual machine scale sets](https://docs.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-health-extension)