Kubernetes resources reside in a *namespace* to divide an AKS cluster and create, view, or manage access to resources. For example, you can create namespaces to separate business groups. Users can only interact with resources within their assigned namespaces.

:::image type="content" source="../media/namespaces-kubernetes-overview-5ff9e09d.png" alt-text="Diagram that shows Kubernetes namespaces to logically divide resources and applications.":::


When you create an AKS cluster, the following namespaces are available:<br>

| **Namespace** | **Description**                                                                                                                                                                                                                                                        |
| ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| *default*     | Where pods and deployments reside. In smaller environments, you can deploy applications directly into the default namespace without creating other logical separations. The default namespace when interacting with the Kubernetes API, such as with kubectl get pods. |
| *kube-system* | Where core resources exist, such as network features like DNS and proxy, or the Kubernetes dashboard. You typically don't deploy your own applications into this namespace.                                                                                            |
| *kube-public* | Typically not used. Used for resources to be visible across the whole cluster, and viewed by any user.                                                                                                                                                                 |
