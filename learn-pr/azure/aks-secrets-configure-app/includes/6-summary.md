You were able to understand and better secure the managed application state by using secrets to keep the connection string safe and still deploy your application without any problems. Now your cluster has a better handling of application sensitive values and configurations using ConfigMaps to inject this configuration without needing to reboot the application.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

[!INCLUDE [azure-optional-exercise-subscription-cleanup](../../../includes/azure-optional-exercise-subscription-cleanup.md)]

1. Open the Azure portal:

   > [!div class="nextstepaction"]
   > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Resource groups** from the Azure portal menu.

1. Find the resource group **rg-ship-manager**, or the resource group name that you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources that you created in this module.

1. Repeat the preceding steps for the resource group named **MC_rg-ship-manager_ship-manager-cluster_eastus** to delete all created resources.

1. Run the `kubectl config delete-context` command to remove the deleted cluster's context. Here's an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

   ```bash
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
