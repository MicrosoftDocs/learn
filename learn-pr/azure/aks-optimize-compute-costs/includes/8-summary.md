In this module, you explored some strategies to optimize Azure Kubernetes Service (AKS) compute costs. You were looking for ways to manage the cost-effective deployment of many workloads to meet customer demands. You also wanted to introduce business policies that govern how your development teams create and use AKS compute resources.

By configuring multiple node pools on your AKS cluster, you can identify specific user node pools to run specific workloads. You saw how to configure these node pools and manually scale the node count to zero in scenarios where you have control over usage intervals.

Next, you configured a spot user node pool to access unused Azure compute capacity at a discount or predefined price. You also scheduled workloads to run on nodes in the node pool. You configured the cluster autoscaler to scale the number of nodes up or down based on computing resource requirements. This configuration handles increased customer demands without creating many nodes that aren't used.

Finally, you enabled and configured the Azure Policy Add-on for AKS. The add-on manages resource quotas to govern the deployment of AKS compute resources. You enabled the built-in **Ensure CPU and memory resource limits** policy. This policy configures parameters to deny workloads that exceed predefined resource limits for CPU and memory.

AKS makes it simple to deploy a managed Kubernetes cluster in Azure and to optimize computing costs when many workloads are running.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Open the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Resource groups** on the left.

1. Find the **rg-akscostsaving** resource group, or the resource group name you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

1. Finally, run the `kubectl config delete-context` command to remove the deleted cluster's context. Here's an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

    ```bash
    kubectl config delete-context akscostsaving-17835
    ```

    If the command succeeds, it returns output like this:

    ```output
    deleted context akscostsaving-17835 from /home/user/.kube/config
    ```

## Learn more

To learn more about each of the concepts covered in this module, visit these articles and sites:

- [Create and manage multiple node pools for a cluster in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/use-multiple-node-pools)

- [Add a spot node pool to an Azure Kubernetes Service (AKS) cluster](https://docs.microsoft.com/azure/aks/spot-node-pool)

- [Automatically scale a cluster to meet application demands on Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/cluster-autoscaler)

- [Understand Azure Policy for Kubernetes clusters](https://docs.microsoft.com/azure/governance/policy/concepts/policy-for-kubernetes)

- [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)

- [Best practices for advanced scheduler features in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/operator-best-practices-advanced-scheduler)

- [Azure Kubernetes Service (AKS) Production Baseline, Cost Optimization](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks#cost-optimization)