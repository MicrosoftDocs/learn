You work for a growing video editing company that provides a cloud-based video rendering service.  Usage of its client application peaks at various times during a 24-hr period. Due to increasing and decreasing demand, the company needs to scale its application accordingly to provide a better experience to all customers. Since the application is event driven and receives a significant number of events at various times; CPU and Memory based metrics are not representative of pending work to scale properly.

You first deployed the application as a Deployment with a static replica count.  We discussed why this would be challenging for workloads that process events and have fluctuating resource needs.  After looking at the options for our scenario, using KEDA with a scaler for the Redis list would help us autoscale in an efficient and effective manner.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Open the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

2. Select **Resource groups** on the left.

3. Find the **rg-contoso-video** resource group, or the resource group name you used, and select it.

4. On the **Overview** tab of the resource group, select **Delete resource group**.

5. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

6. Finally, run the `kubectl config delete-context` command to remove the deleted clusters context. Here's an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

    ```bash
    kubectl config delete-context aks-contoso-video
    ```

    If successful, the command returns the following example output.

    ```output
    deleted context aks-contoso-video from /home/user/.kube/config
    ```

## Learn more

To learn more about Azure Kubernetes Service, see the following articles:

- [AKS documentation on Microsoft Docs](/azure/aks/)
- [Introduction to AKS](/learn/modules/intro-to-azure-kubernetes-service/)
- [Prepare an application for AKS](/azure/aks/tutorial-kubernetes-prepare-app)
- [Deploy an AKS cluster](/azure/aks/tutorial-kubernetes-deploy-cluster)
- [HTTP application routing](/azure/aks/http-application-routing)
- [AKS scaling options](/azure/aks/concepts-scale)
- [KEDA documentation](https://keda.sh)
- [AKS cluster autoscaling](/azure/aks/cluster-autoscaler)
- [Kubernetes horizontal pod scaling (HPA)](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale)
