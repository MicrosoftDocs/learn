In this module, you explored some of the cost optimization strategies to optimize Azure Kubernetes Service (AKS) compute costs. You were evaluating strategies to manage the deployment of many workloads needed to match customer demands cost-effectively. You also want to introduce business policies that govern how your development teams create and use AKS compute resources.

By configuring multiple node pools on your AKS cluster, you can identify specific node pools to run specific workloads. You saw how to configure these node pools and manually scale the node count to zero in scenarios where you have control over usage intervals.

Next, you configured a spot node pool to access unused Azure compute capacity at a discount or predefined price and schedule workloads to run on nodes in the node pool. Here you configured the cluster autoscaler to scale the number of nodes up or down based on computing resource requirements. This configuration allows you to handle increased customer demands without creating many nodes that aren't used.

Finally, you enabled and configured the Azure Policy Add-on for AKS to manage resource quotas to govern the deployment of AKS compute resources. You enabled the built-in *Ensure CPU and memory resource limits* policy to configure parameters to deny workloads that exceed predefined CPU and memory resource limits.

Azure Kubernetes Service (AKS) makes it simple to deploy a managed Kubernetes cluster in Azure and the optimization of computing costs when running many workloads.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Open the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Resource groups** on the left.

1. Find the **aks-costsaving-grp** resource group, or the resource group name you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

1. Finally, run the `kubectl config delete-context` command to remove the deleted clusters context. Here is an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

    ```bash
    kubectl config delete-context akscostsaving-2398
    ```

    If successful, the command returns the following example output.

    ```output
    deleted context akscostsaving-2398 from /home/user/.kube/config
    ```

## Learn more

We've covered a number of concepts in this module. Visit the articles and sites below to learn more about each of the concepts.

- [Create and manage multiple node pools for a cluster in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/use-multiple-node-pools)

- [Add a spot node pool to an Azure Kubernetes Service (AKS) cluster](https://docs.microsoft.com/azure/aks/spot-node-pool)

- [Automatically scale a cluster to meet application demands on Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/cluster-autoscaler)

- [Understand Azure Policy for Kubernetes clusters](https://docs.microsoft.com/azure/governance/policy/concepts/policy-for-kubernetes)

- [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)

- [Best practices for advanced scheduler features in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/operator-best-practices-advanced-scheduler)