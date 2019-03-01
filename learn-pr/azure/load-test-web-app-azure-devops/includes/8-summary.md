In this module, you learned how to use the Azure portal to build and run a performance test for your web apps. You examined the results and used this information to help you configure and customize tests in Azure DevOps. 

Identifying potential performance issues through a combination of the Azure portal for initial tests, and the Azure DevOps Portal for more detailed and configurable testing, will help you create high performing Web apps with better user experiences.

## Cleanup

Run the following command to remove the resource group, app service, storage account, and all related resources.

```azurecli
az group delete --resource-group ContosoRentalsRG
```