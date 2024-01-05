Your company is experiencing increased demand for its video rendering service because of its international expansion. You're looking for ways to scale the product to provide a better experience for all customers. You wanted to understand how to use native Kubernetes scaling to do it without too many changes in your infrastructure.

You discovered that by using the Kubernetes HorizontalPodAutoscaler resource, you can automatically scale up and down your deployment. You found that you can scale your service transparently while still serving all of your website users well.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Open the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Resource groups** on the left-hand.

1. Find the **learn-aks-scalability** resource group, or the resource group name you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

1. Also, delete the **MC_learn-aks-scalability_learn-aks-scalability_eastus** resource group to remove all AKS-related resources.

1. Finally, run the `kubectl config delete-context` command to remove the deleted clusters context. Here's an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

    ```bash
    kubectl config delete-context learn-aks-scalability
    ```

    If successful, the command returns the following example output.

    ```output
    deleted context learn-aks-scalability from /home/user/.kube/config
    ```

## Learn more

- [Scalability concepts](/azure/aks/concepts-scale)
- [HPA official docs](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)