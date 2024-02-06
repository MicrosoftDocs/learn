By using secrets to keep the connection string safe, you're able to better understand and secure the managed application state, and still deploy your application without any problems. Now, your cluster is better able to handle sensitive values and configurations using ConfigMaps to inject configurations without the need to reboot your application.

## Clean up resources

In this module, you created resources using your Azure subscription. The following steps show you how to clean up those resources so you won't incur Azure charges after you're done with the module.

[!INCLUDE [azure-optional-exercise-subscription-cleanup](../../../includes/azure-optional-exercise-subscription-cleanup.md)]

1. Navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).
2. Select **Resource groups** > **rg-ship-manager**.
3. Select **Delete resource group** and enter the name of the resource group to confirm.
4. Select **Delete** > **Delete**.
5. Repeat the preceding steps for the resource group named **MC_rg-ship-manager_ship-manager-cluster_eastus** to delete all created resources.
6. Remove the delete cluster's context using the `kubectl config delete-context`.

   ```azurecli-interactive
   kubectl config delete-context ship-manager
   ```

   If the command is successful, it returns the following example output:

   ```output
   deleted context ship-manager from /home/user/.kube/config
   ```

## Learn more

To learn more about Azure Kubernetes Service, see the following articles:

- [Introduction to AKS](/training/modules/intro-to-azure-kubernetes-service/)
- [AKS documentation](/azure/aks/)
- [AKS production baseline](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks)
- [Deploy an AKS cluster](/azure/aks/tutorial-kubernetes-deploy-cluster)
