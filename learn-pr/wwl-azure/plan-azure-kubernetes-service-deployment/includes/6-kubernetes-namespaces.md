Kubernetes resources, such as pods and deployments, are logically grouped into a *namespace* to divide an AKS cluster and create, view, or manage access to resources. For example, you can create namespaces to separate business groups. Users can only interact with resources within their assigned namespaces.

:::image type="content" source="../media/namespaces-kubernetes-overview-5ff9e09d.png" alt-text="Diagram that shows Kubernetes namespaces to logically divide resources and applications.":::


When you create an AKS cluster, the following namespaces are available:<br>

| **Namespace** | **Description**                                                                                                                                                                                                                                                                                                                               |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| *default*     | Where pods and deployments are created by default when none is provided. In smaller environments, you can deploy applications directly into the default namespace without creating other logical separations. When you interact with the Kubernetes API, such as with kubectl get pods, the default namespace is used when none is specified. |
| *kube-system* | Where core resources exist, such as network features like DNS and proxy, or the Kubernetes dashboard. You typically don't deploy your own applications into this namespace.                                                                                                                                                                   |
| *kube-public* | Typically not used, but can be used for resources to be visible across the whole cluster, and viewed by any user.                                                                                                                                                                                                                             |
