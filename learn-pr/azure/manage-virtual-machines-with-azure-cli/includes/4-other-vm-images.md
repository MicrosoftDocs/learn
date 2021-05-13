We used UbuntuLTS for the image to create the virtual machine. Azure has several standard VM images you can use to create a virtual machine. 

## Listing images

You can get a list of the available VM images using the following command. 

```azurecli
az vm image list --output table
```
> [!NOTE] 
  >  If you get an error az: command not found.  Type exit into the shell and try again. 


This will output the most popular images that are part of an offline list built into the Azure CLI. However, there are _hundreds_ of image options available in the Azure Marketplace. 

## Getting all images

You can get a full list by adding the `--all` flag to the command. Since the list of images in the Marketplace is very large, it is helpful to filter the list with the `--publisher`, `--sku` or `–-offer` options.

For example, try the following command to see _all_ Wordpress images available:

```azurecli
az vm image list --sku Wordpress --output table --all
```

Or this command to see all images provided by Microsoft:

```azurecli
az vm image list --publisher Microsoft --output table --all
```

## Location-specific images

Some images are only available in certain locations. Try adding the `--location [location]` flag to the command to scope the results to ones available in the region where you want to create the virtual machine. For example, type the following into Azure Cloud Shell to get a list of images available in the `eastus` region.

```azurecli
az vm image list --location eastus --output table
```

Try checking some of the images in the other Azure sandbox available locations:

[!include[](../../../includes/azure-sandbox-regions-note.md)]

> [!TIP]
> These are the standard images that are provided by Azure. Keep in mind that you can also [create and upload your own custom images](https://docs.microsoft.com/azure/virtual-machines/linux/tutorial-custom-images) to create VMs based on unique configurations or less common versions or distributions of an operating system.

Your command window is probably full now, you can type `clear` to clear the screen if you like.
