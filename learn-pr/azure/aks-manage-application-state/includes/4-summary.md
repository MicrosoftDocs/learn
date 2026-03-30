In our example scenario, you needed to support an operating platform by managing the application state while using Kubernetes on Azure Kubernetes Service (AKS).

By creating a new instance of Azure Cosmos DB, you delegated the database management to Azure. The application can grow across many regions in the world without any added complexity. Now, your cluster has a better handling of application states. Your cluster is also scalable to the point where you can handle multiple users without needing to configure the database.

## Clean up resources

[!INCLUDE [azure-subscription-cleanup](../../../includes/azure-subscription-cleanup.md)]

1. Delete the _rg-ship-manager_ resource group that you created for this module. This action deletes all of the resources that you created in this module, including the AKS cluster and Azure Cosmos DB account.

    ```azurecli-interactive
    az group delete --name rg-ship-manager --yes --no-wait
    ```

   When the resource group is deleted, the **MC_rg-ship-manager_ship-manager-cluster_eastus** that contains the cluster's resources is also deleted.

1. Remove the deleted cluster's context using the `kubectl config delete-context <clusterName>` command.

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
