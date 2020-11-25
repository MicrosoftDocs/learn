You needed to support a whole operating platform by managing the application state while using Kubernetes on AKS.

By creating a new instance of CosmosDB you managed to delegate the management of the database to Azure, this way you don't need to worry about availability since CosmosDB better supports multi-region and multi-master deployments and the application would be able to grow across many regions in the world without any added complexity.

Along with that, you were able to understand and better secure the managed application state using secrets to keep the connection string safe and still be able to deploy your application without any problems. Now your cluster has a better handling of application states and is also scalable to the point where you can handle multiple users without needing to configure the database.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Open the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Resource groups** on the left.

1. Find the **rg-ship-manager** resource group, or the resource group name you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

1. Repeat the steps above for the resource group named **MC_rg-ship-manager_ship-manager-cluster_eastus** to delete all created resources.

1. Finally, run the `kubectl config delete-context` command to remove the deleted clusters context. Here's an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

    ```bash
    kubectl config delete-context ship-manager-cluster
    ```

    If successful, the command returns the following example output.

    ```output
    deleted context ship-manager-clsuter from /home/user/.kube/config
    ```

## Learn more

To learn more about Azure Kubernetes Service, see the following articles:

- [Introduction to AKS](https://docs.microsoft.com/learn/modules/intro-to-azure-kubernetes-service/)
- [AKS documentation on Microsoft Docs](https://docs.microsoft.com/azure/aks/)
- [Azure Kubernetes Service (AKS) Production Baseline](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks)
- [Deploy an AKS cluster](https://docs.microsoft.com/azure/aks/tutorial-kubernetes-deploy-cluster)
- [Storage concepts with AKS](https://docs.microsoft.com/azure/aks/concepts-storage)
