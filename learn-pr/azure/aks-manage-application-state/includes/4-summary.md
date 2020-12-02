You needed to support a whole operating platform by managing the application state while using Kubernetes on Azure Kubernetes Service (AKS).

By creating a new instance of Azure Cosmos DB, you delegated the management of the database to Azure. This way, you don't need to worry about availability, because Azure Cosmos DB better supports multiple-region and multiple-master deployments. The application can grow across many regions in the world without any added complexity.

Along with that, you were able to understand the managed application state by using connection strings as environment variables and deploy your application without any problems. Now your cluster has a better handling of application states. Your cluster is also scalable to the point where you can handle multiple users without needing to configure the database.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Open the Azure portal:

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Resource groups** on the left.

1. Find the **rg-ship-manager** resource group, or the resource group name that you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources that you created in this module.

1. Repeat the preceding steps for the resource group named **MC_rg-ship-manager_ship-manager-cluster_eastus** to delete all created resources.

1. Run the `kubectl config delete-context` command to remove the deleted cluster's context. Here's an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

    ```bash
    kubectl config delete-context ship-manager-cluster
    ```

    If the command is successful, it returns the following example output:

    ```output
    deleted context ship-manager-cluster from /home/user/.kube/config
    ```

## Learn more

To learn more about Azure Kubernetes Service, see the following articles:

- [Introduction to AKS](https://docs.microsoft.com/learn/modules/intro-to-azure-kubernetes-service/)
- [AKS documentation on Microsoft Docs](https://docs.microsoft.com/azure/aks/)
- [AKS production baseline](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks)
- [Deploy an AKS cluster](https://docs.microsoft.com/azure/aks/tutorial-kubernetes-deploy-cluster)
- [Storage concepts with AKS](https://docs.microsoft.com/azure/aks/concepts-storage)
