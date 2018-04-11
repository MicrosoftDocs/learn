Create a scale set with [az vmss create](/cli/az/vmss#az_vmss_create). Instead of a platform image, such as *UbuntuLTS* or *CentOS*, specify the name of your custom VM image. The following example creates a scale set named *myScaleSet* that uses the custom image named *myImage* from the previous step:

```azurecli
az vmss create \
  --resource-group myResourceGroup \
  --name myScaleSet \
  --admin-username azureuser \
  --generate-ssh-keys \
  --upgrade-policy-mode automatic \
  --image myPackerImage
```

It takes a few minutes to create and configure all the scale set resources and VMs.
