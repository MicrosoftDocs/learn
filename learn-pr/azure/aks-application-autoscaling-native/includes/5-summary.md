Your company is experiencing increased demand for its video rendering service due to recent international expansion. You were tasked with finding ways to scale the product to provide a better experience for all customers. You wanted to understand how to use native Kubernetes scaling to do it without too many changes in your infrastructure. You discovered that by using the Kubernetes HorizontalPodAutoscaler resource, you can automatically scale up and down your deployment. You found that you can scale your service transparently while effectively serving your customers.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).
2. Select **Resource groups** > **myResourceGroup** > **Delete resource group**.
3. Enter the name of the resource group to confirm and select **Delete**.
4. Navigate to the cluster resource group, **MC_myResourceGroup_myAKSCluster_eastus**.
5. Select **Delete resource group**.
6. Enter the name of the resource group to confirm and select **Delete**.
7. Finally, run the `kubectl config delete-context` command to remove the context of your deleted cluster.

    ```bash
    kubectl config delete-context myAKSCluster
    ```

    Your output should look similar to the following example output:

    ```output
    deleted context learn-aks-scalability from /home/user/.kube/config
    ```

## Learn more

Learn more about scalability in AKS and Kubernetes:

- [Scalability concepts](/azure/aks/concepts-scale)
- [HPA official docs](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)