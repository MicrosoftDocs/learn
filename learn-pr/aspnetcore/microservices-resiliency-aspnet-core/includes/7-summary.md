In this module, you:

- Created an AKS cluster with an initial e-commerce application.
- Reviewed some key resiliency concepts.
- Implemented a resilience feature in your application code using Polly.
- Created an ACR instance to publish and deploy an updated microservice to AKS.
- Implemented a resiliency system in your cluster using Linkerd.

## Clean up Azure resources

> [!IMPORTANT]
> It's very important you deallocate the Azure resources used in this module so that you don't get billed or spend your free account with unwanted charges.

You have to:

### 1. - De-provision all the resources created in this module

Use the following command:

```azurecli
az group delete --name eshop-learn-rg --yes
```

### 2. - De-provision the storage account used by the Cloud Shell

If you let the Cloud Shell create the storage using the default options, you should have a resource group named `cloud-shell-storage-{region}`. To delete the storage account, you can delete the resource group from the Azure portal. You can't delete the storage account from the Azure CLI.
