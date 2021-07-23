## Remove Azure resources

> [!IMPORTANT]
> It's important that you deprovision the Azure resources that you used in this module to avoid accruing unwanted charges.

To deprovision all of the resources created in this module, run the following command:

```azurecli
az group delete --name eshop-learn-rg --yes
```

The preceding command deletes the resource group that contains the AKS and Azure Container Registry resources. Another resource group that contains infrastructure resources, such as IP addresses, was previously created on behalf of the AKS resource. This group, along with all resources that it contains, is also deleted when the AKS resource is deleted.
