In our example scenario, you needed to support an operating platform by managing the application state while using Kubernetes on Azure Kubernetes Service (AKS).

By creating a new instance of Azure Cosmos DB, you delegated the management of the database to Azure. The application can grow across many regions in the world without any added complexity. Now, your cluster has a better handling of application states. Your cluster is also scalable to the point where you can handle multiple users without needing to configure the database.

## Clean up resources

[!INCLUDE [azure-subscription-cleanup](../../../includes/azure-subscription-cleanup.md)]

1. Navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).
2. Select **Resource groups** > **rg-ship-manager**.
3. On the **Overview** tab of the resource group, select **Delete resource group**.
4. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources that you created in this module.
5. Repeat the preceding steps for the resource group named **MC_rg-ship-manager_ship-manager-cluster_eastus** to delete all created resources.
6. Remove the deleted cluster's context using the `kubectl config delete-context` command. Remember to replace the name of the cluster with your cluster's name.

    ```azurecli-interactive
    kubectl config delete-context ship-manager-cluster
    ```

    If the command is successful, it returns the following example output:

    ```output
    deleted context ship-manager-cluster from /home/user/.kube/config
    ```

## Learn more

To learn more about Azure Kubernetes Service, see the following articles:

- [Introduction to AKS](/training/modules/intro-to-azure-kubernetes-service/)
- [AKS documentation](/azure/aks/)
- [AKS production baseline](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks)
- [Deploy an AKS cluster](/azure/aks/tutorial-kubernetes-deploy-cluster)
- [Storage concepts with AKS](/azure/aks/concepts-storage)
