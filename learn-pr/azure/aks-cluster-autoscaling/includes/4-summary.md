Your company is experiencing increased demand for its video rendering service because of its international expansion. They have already found a way to scale the application, but the cluster was not keeping up with the demand. You want to understand how to use the cluster autoscaler to do it without too many changes in your infrastructure.

By using AKS cluster autoscaler feature, you can automatically scale up and down your nodes so the node can keep up with the application scalability and all the users of the website are served well and it's all done transparently.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Open the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Resource groups** on the left.

1. Find the **learn-aks-cluster-scalability** resource group, or the resource group name you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

1. Also, delete the **MC_learn-aks-cluster-scalability_learn-aks-cluster-scalability_eastus** resource group to remove all AKS-related resources.

1. Finally, run the `kubectl config delete-context` command to remove the deleted clusters context. Here's an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

    ```bash
    kubectl config delete-context learn-aks-cluster-scalability
    ```

    If successful, the command returns the following example output.

    ```output
    deleted context learn-aks-cluster-scalability from /home/user/.kube/config
    ```

## Learn more

- [Scalability concepts](/azure/aks/concepts-scale)
- [Other types of pods that prevent scaling down](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-types-of-pods-can-prevent-ca-from-removing-a-node)