Application scalability is only one of the ideas that are possible within Kubernetes. The application scalability will scale out your application when there's need for more computing power or to distribute the load among more copies of the services.

However, cluster nodes don't have infinite resources, which means there are only so many pods you can spin up in a single node.

## Node starvation

A pod will require an amount of resources that is defined in the `spec.containers.resources` key in the pod's YAML file. Once you create a new pod within a node, Kubernetes automatically allocates that amount of resources to the pod so it can run with the requested amount of power it needs.

A single node is a single VM, which means it has a limited amount of resources like CPU and RAM available for pods, so you cannot spin up an infinite number of pods in it. When a node doesn't meet the needed requirements for the pod's resource, the pod remains on status **Pending**, and it's not scheduled to any nodes until there are enough resources available.

## Cluster scalability

To remedy that problem, the operator needs to scale out the cluster itself, adding more VMs to the NodePool. This can be done either via the Azure CLI with the `az aks scale` command or in the Azure portal inside the **Node Pools** menu item inside your AKS cluster object.

:::image type="content" source="../media/2-portal-scale.png" alt-text="Screen that shows the Azure portal scalability button on node pools menu.":::

This process can be a little overwhelming especially for a cluster with variable demand, when the number of pods fluctuates a lot, this would require the operator to constantly monitor for unscheduled pods to make tweaks in real time.

## Cluster autoscaler

The cluster autoscaler AKS module is a tool that automatizes the process of scaling the cluster manually. It is installed within your AKS cluster and watches for unscheduled pods with resource constraints, then it automatically increases the number of nodes in a cluster to meet these requirements.

:::image type="content" source="../media/2-cluster-autoscaler.png" alt-text="Diagram that shows how the cluster autoscaler works.":::

The cluster autoscaler can not only increase but decrease the number of nodes in a cluster if there's unused cluster capacity for some time. When this condition is met, the autoscaler cordons and drains the node so all the pods that are scheduled in that node are safely moved to other nodes and no other pods are scheduled during the process. Then it removes the node from the pool.

But there are some situations where the cluster autoscaler won't remove the node because some pods cannot be moved out of that node:

- When a pod is directly created (by the operator with a YAML file) and it's not bound to any controllers such as Deployments or ReplicaSets
- When the *Pod Disruption Budget* (PDB) is too restrictive and doesn't allow for the number of pods to fall below a certain threshold
- When the pod has a node selector for that particular node or a node affinity that would prevent it to go somewhere else.

> [!TIP]
> Take a look at the links in the summary section to learn more about the types of pods that can prevent the autoscaler to scale down.

It's important to notice that, when autoscaling is enabled, the manual cluster scalability is disabled.
