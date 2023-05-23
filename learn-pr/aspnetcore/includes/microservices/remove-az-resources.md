## Remove Azure resources

> [!IMPORTANT]
> It's important to deprovision the Azure resources you used in this module to avoid accruing unwanted charges.

To remove all the resources created in this module, run the following command:

```azurecli
az group delete --name eshop-learn-rg --yes
```

The preceding command deletes the resource group that contains the AKS and Container Registry resources. Another resource group that contains infrastructure resources, such as IP addresses, was created on behalf of the AKS resource. This group, along with all resources that it contains, is also deleted when you delete the AKS resource.
