To see your scale set in action, get the public IP address of your load balancer with [az network public-ip show](/cli/azure/network/public-ip#show). The following example gets the IP address for *myScaleSetLBPublicIP* created as part of the scale set:

```azurecli
az network public-ip show \
  --resource-group myResourceGroup \
  --name myScaleSetLBPublicIP \
  --query [ipAddress] \
  --output tsv
```

Type the public IP address into your web browser. The default NGINX web page is displayed, as shown in the following example:

![Default NGINX page running from Packer VM image](media/deploy-custom-vmss-app/default-nginx-website.png)

Leave the web browser open. In the next module, you deploy a basic web app from GitHub to the VM instances in your scale set.