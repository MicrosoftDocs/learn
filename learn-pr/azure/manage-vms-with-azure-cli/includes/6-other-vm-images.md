We used `Debian` for the image to create the virtual machine. Azure has several standard VM images you can use to create a virtual machine. You can get a list of the available images using the `az vm image list --output table` command. This will output the most popular images that are part of an offline list. However, there are _hundreds_ of image options available in the Azure Marketplace. You can get a full list by adding the `--all` flag to the command - this will will list every image available. Since this tends to be very large, it is helpful to filter the list with the `--publisher` or `–-offer` options.

Some images are only available in certain locations. You can add the `--location [location]` flag to the command to scope the results to ones available in the region you want to create the virtual machine in. For example, type the following into the Cloud Shell to get a list of images available in the `eastus` region.

```azurecli
az vm image list --location eastus --output table
```

These are the standard images that are provided by Azure. Keep in mind that you can also [create and upload your own custom images](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-custom-images) to create VMs based on unique configurations or less common versions or distributions of an operating system.