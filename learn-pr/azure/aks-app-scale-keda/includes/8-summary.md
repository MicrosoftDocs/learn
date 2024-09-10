In this module, you deployed an application as a Deployment with a static replica count. We discussed why this situation might be challenging for workloads that process events and have fluctuating resource needs. After looking at the options for your scenario, you determined that using KEDA with a scaler for the Redis list would help autoscale in an efficient and effective manner.

## Delete Azure resources

When you're done with the resources you created in this module, delete them to avoid incurring charges.

1. Navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).
1 Select **Resource groups** and select the resource group you created for this module.
1. Under **Overview**, select **Delete resource group**.
1. Enter the resource group name to confirm and select **Delete** to delete all of the resources you created in this module.
1. Select **Delete** again to confirm deletion.
1. Remove the cluster's context using the `kubectl config delete-context` command. Make sure you replace the name of the cluster with your cluster's name.

    ```azurecli-interactive
    kubectl config delete-context CLUSTER_NAME
    ```

    Your output should look similar to the following example output:

    ```output
    deleted context aks-contoso-video from /home/user/.kube/config
    ```

## Learn more

To learn more about AKS, see the following articles:

- [AKS documentation](/azure/aks/)
- [Introduction to AKS](/training/modules/intro-to-azure-kubernetes-service/)
- [Prepare an application for AKS](/azure/aks/tutorial-kubernetes-prepare-app)
- [Deploy an AKS cluster](/azure/aks/tutorial-kubernetes-deploy-cluster)
- [HTTP application routing](/azure/aks/http-application-routing)
- [AKS scaling options](/azure/aks/concepts-scale)
- [KEDA documentation](https://keda.sh)
- [AKS cluster autoscaling](/azure/aks/cluster-autoscaler)
- [Kubernetes horizontal pod scaling (HPA)](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale)
