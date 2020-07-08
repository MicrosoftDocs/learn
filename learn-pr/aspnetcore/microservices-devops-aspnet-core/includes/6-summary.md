In this module you:

- Created an AKS cluster with an initial e-commerce application.
- Reviewed some key DevOps concepts.
- Implemented a small UI change.
- Implemented a simple CI/CD pipeline using GitHub Actions to deploy the change to AKS.
- Rolled back the deployment to the previous version.

## Clean up Azure resources

> **IMPORTANT**
>
> It's very important you deallocate the Azure resources used in this module so that you don't get billed or spend your free account with unwanted charges.

You have to:

### 1. - De-provision all the resources created in this module

Use the following command:

```bash
az group delete --name eshop-learn-rg --yes
```

### 2. - De-provision the storage account used by the Cloud Shell

If you let the Cloud Shell create the storage using the default options, you should have a resource group named `cloud-shell-storage-{region}`. To delete the storage account you can delete the resource group from the Azure portal. You won't be able to delete the storage account from **az cli**.
