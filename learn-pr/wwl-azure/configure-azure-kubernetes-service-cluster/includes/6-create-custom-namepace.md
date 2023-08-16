Kubernetes resources, such as pods and deployments, are logically grouped into a namespace to divide an AKS cluster and create, view, or manage access to resources. For example, you can create namespaces to separate business groups. Users can only interact with resources within their assigned namespaces.

Namespaces are intended for environments with multiple users spanning multiple teams or organizations. Namespaces are suited medium, large, and enterprise organizations that have hundreds or thousands of users to manage.

Namespaces provide a scope for names. Names of resources should be unique within a namespace, but not across namespaces. Namespaces can't be nested inside one another and each Kubernetes resource can only be in one namespace.

When you create an AKS cluster, the following namespaces are available:<br>

| **Namespace** | **Description**                                                                                                                                                                                                                                                                                                                              |
| ------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| default       | Where pods and deployments are created by default when none is provided. In smaller environments, you can deploy applications directly into the default namespace without creating more logical separations. When you interact with the Kubernetes API, such as with kubectl get pods, the default namespace is used when none is specified. |
| kube-system   | Where core resources exist, such as network features like DNS and proxy, or the Kubernetes dashboard. You typically don't deploy your own applications into this namespace.                                                                                                                                                                  |
| kube-public   | Typically not used, but can be used for resources to be visible across the whole cluster, and viewed by any user.                                                                                                                                                                                                                            |

### Logically isolated clusters using namespaces

With logical isolation, you can use a single AKS cluster for multiple workloads, teams, or environments. Kubernetes Namespaces form the logical isolation boundary for workloads and resources.

:::image type="content" source="../media/logical-isolation-namespaces-clusters-adc77058.png" alt-text="Diagram showing how logical isolation of a Kubernetes cluster can be done using namespaces.":::


Logical separation of clusters usually provides a higher pod density than physically isolated clusters, with less excess compute capacity sitting idle in the cluster. When combined with the Kubernetes cluster autoscaler, you can scale the number of nodes up or down to meet demands. This best practice approach minimizes costs by running only the required number of nodes.

### Create a custom namespace

1.  Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com/).
2.  On the Azure portal menu or from the **Home** page, select the Azure Kubernetes cluster used in previous exercises**.**
3.  Select **Namespaces.** :::image type="content" source="../media/azure-kubernetes-namespace-configuration-8f5962e2.png" alt-text="Displays a screenshot of how to navigate to existing cluster.":::
    
4.  Select **Create**, and then select **Namespace**. :::image type="content" source="../media/select-namespace-custom-2c0f8985.png" alt-text="Displays a screenshot of the new namespace creation process.":::
    
5.  In **Create a namespace**, enter a name for the namespace, and select **Create**.
6.  Select the new namespace. :::image type="content" source="../media/select-new-namespace-f060aee3.png" alt-text="Displays a screenshot of the newly created namespace.":::
    
7.  To edit the namespace, select **YAML**. :::image type="content" source="../media/edit-namespace-yaml-1220bb0c.png" alt-text="Displays a screenshot of the YAML for the namespace.":::
    
8.  Select **Review + save** to save YAML updates to the namespace.
