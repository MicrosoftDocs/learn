In this module, you worked for a growing video editing company that provides a cloud-based video rendering service. The service was experiencing increased demand from recent international expansion. The application leveraged the Horizontal Pod Autoscaler (HPA) for scaling purposes, but the cluster couldn't keep up. Your manager tasked you with finding a solution to scale the cluster automatically.

You looked into the AKS cluster autoscaler feature to see if it would be the right fit. With this feature, you were able to automatically scale up and down the number of nodes in your cluster. You configured the cluster autoscaler to watch for unscheduled pods with resource constraints, and it automatically increased and decreased the number of nodes to meet those requirements. You saw how the feature could allow your company to keep up with application scalability and decided to propose the solution to your manager.

## Clean up resources

In this module, you created resources by using your Azure subscription. To avoid incurring charges, delete the resources you created using the following steps:

1. In the Cloud shell, remove the resource group you created in this module using the `az group delete` command.

    ```azurecli-interactive
    az group delete --resource-group myResourceGroup
    ```

2. When you create a cluster in AKS, a second resource group is automatically created to store the AKS resources. This resource group uses the following naming format: **MC_resource-group-name_cluster-name_location**. Remove this resource group using the `az group delete` command.

    ```azurecli-interactive
    az group delete --resource-group MC_myResourceGroup_myAKSCluster_eastus
    ```

3. Remove the deleted cluster's context using the `kubectl config delete-context` command.

    ```azurecli-interactive
    kubectl config delete-context myAKSCluster
    ```

## Learn more

For more information on the topics covered in this module, see the following resources:

- [Scalability concepts in AKS](/azure/aks/concepts-scale)
- [Types of pods that prevent scale downs](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-types-of-pods-can-prevent-ca-from-removing-a-node)
