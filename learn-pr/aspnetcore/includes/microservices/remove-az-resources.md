## Remove Azure resources

> [!IMPORTANT]
> It's important that you de-provision the Azure resources used in this module to avoid accruing unwanted charges.

To de-provision all of the resources created in this module, run the following command:

```azurecli
az group delete --name eshop-learn-rg --yes
```

The preceding command deletes the resource group containing the AKS and ACR resources. Another resource group containing infrastructure resources, such as IP addresses, was previously created on behalf of the AKS resource. This group, and all resources contained within, is also deleted when the AKS resource is deleted.
