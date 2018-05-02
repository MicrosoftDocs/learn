The Azure CLI 2.0 creates the supporting resources for a virtual machine scale set, such as an Azure virtual network and Azure load balancer. When you create a scale set, you specify an image to be used for the VM instances. Instead of an Azure marketplace image, such as *UbuntuLTS* or *CentOS*, you can specify the name of a custom image. In this tutorial, we'll use the Packer image created in the preceding unit. 

Create a scale set in the Azure Cloud Shell with [az vmss create](/cli/azure/vmss#az_vmss_create). The following example creates a scale set named *myScaleSet* that uses the custom image named *myPackerImage* from the previous module:

```azurecli
az vmss create \
  --resource-group myResourceGroup \
  --name myScaleSet \
  --admin-username azureuser \
  --generate-ssh-keys \
  --upgrade-policy-mode automatic \
  --image myPackerImage
```

It takes a few minutes to create and configure all the scale set resources and VMs from the Packer image.
