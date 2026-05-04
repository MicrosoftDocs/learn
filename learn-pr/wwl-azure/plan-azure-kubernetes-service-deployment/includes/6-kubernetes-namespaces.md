Most workload resources, such as Pods, Deployments, and Services, are namespaced. Some resources, such as Nodes, PersistentVolumes, StorageClasses, and namespaces, are cluster-scoped. Use namespaces to logically divide an AKS cluster and create, view, or manage resources. For example, you can create namespaces to separate business groups. Kubernetes RBAC or other authorization mechanisms can be used to scope user access to namespaces; ClusterRoleBindings can grant cluster-wide or cross-namespace access.

:::image type="content" source="../media/namespaces-kubernetes-overview-5ff9e09d.png" alt-text="Diagram that shows Kubernetes namespaces to logically divide resources and applications.":::


When you create an AKS cluster, the following namespaces are available:<br>

| **Namespace**     | **Description**                                                                                                                                                                                                                                                        |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| *default*         | Used when no namespace is specified. The default namespace is suitable for simple or test scenarios, but production workloads should usually use dedicated namespaces.                                                                                                  |
| *kube-system*     | Where core system resources exist, such as CoreDNS, metrics-server, and other AKS components. kube-proxy exists depending on networking configuration; AKS clusters that use the Cilium data plane don't use kube-proxy. You typically don't deploy your own applications into this namespace. |
| *kube-public*     | Typically not used. Reserved for resources that need to be visible across the whole cluster and readable by any user.                                                                                                                                                  |
| *kube-node-lease* | Holds Lease objects associated with each node. The kubelet sends heartbeats to its Lease so the control plane can detect node failures quickly.                                                                                                                        |
