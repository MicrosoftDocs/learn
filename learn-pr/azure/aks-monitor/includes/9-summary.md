You needed to ensure that your applications on your AKS cluster were always available to customers and performing well. You also needed to ensure that your support staff were immediately alerted to any problems with the cluster or application.

By enabling container insights for your AKS cluster, you were able to monitor your cluster and send alerts when problem arose.

In this module, you enabled Container insights on your AKS cluster. You then inspected different features of Container insights to view the different components of their cluster and their operation and performance. Finally, you created an alert rule and action group to send you a text message when an error is detected.  

## Clean up resources

In this module, you might have created an Azure Kubernetes Service cluster. If you want to remove the service so that there's no continued charge against your account, follow the steps below to clean up the resources.

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Kubernetes Services**.

1. Select your service, for this module, *aks-contoso-video*.

1. Right-click the cluster's resource group and select **Open in a new tab**.

1. On Kubernetes service page for the cluster you want to delete, select **Delete**, then select **Delete** again, then select **Delete** one more time to confirm. It takes a few minutes to delete the cluster.

1. Switch to the tab that you opened for the cluster's resource group. If you created a resource group for this module *and* there are no other resources in the group that you want to keep, delete the resource group.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources that you created for this module. Select **Delete** to confirm the deletion.

1. From a cloud sell, run the `kubectl config delete-context` command to remove the deleted cluster's context. Here's an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

    ```bash
    kubectl config delete-context aks-contoso-video
    ```

    If the command is successful, it returns output like the following example:

    ```output
    deleted context aks-contoso-video from /home/user/.kube/config
    ```

