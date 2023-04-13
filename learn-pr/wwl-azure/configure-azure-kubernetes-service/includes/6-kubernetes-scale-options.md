The process of scaling involves adjusting the compute resources allocated for your application instances to meet workload demands. When you run applications in an Azure Kubernetes Service cluster, you might need to apply scaling to increase or decrease your compute resources. If the number of your application instances changes, the number of underlying Kubernetes nodes might also need to change. You might also need to quickly provision a large number of extra application instances.

The following illustration shows a scaling implementation for Azure Kubernetes Service.

:::image type="content" source="../media/kubernetes-scale-a7fff281.png" alt-text="Diagram that shows a cluster autoscaler and horizontal pod autoscaler in Azure Kubernetes Service." border="false":::

### Things to know about scaling techniques

In an Azure Kubernetes Service cluster, you can manually scale pods or nodes, and automatically scale pods or clusters.

| Scaling technique | Description | Version requirements |
| --- | --- | --- |
| **Manually scale pods or nodes** | Manually scale your replicas (pods) and nodes to test how your application responds to changes in available resources and state. Manually scaling resources lets you define a specific number of resources to use to maintain a fixed cost, such as the number of nodes. To manually scale, you define the replica or node count, and the Kubernetes API schedules creating new pods or draining nodes. | All Kubernetes versions |
| **Automatically scale pods** | Use the horizontal pod autoscaler (HPA) to monitor resource demand and automatically scale the number of your replicas. By default, the HPA checks the Metrics API every 30 seconds for any required changes in your replica count. When changes are required, the number of replicas is increased or decreased accordingly. | AKS clusters that deploy the Metrics Server for Kubernetes 1.8 or later |
| **Automatically scale clusters** | Respond to changing pod demands with the cluster autoscaler, which adjusts the number of your nodes based on the requested compute resources in the node pool. By default, the cluster autoscaler checks the API server every 10 seconds for any required changes in the node count. If the cluster autoscale determines a change is required, the number of nodes in your AKS cluster is increased or decreased accordingly. | RBAC-enabled AKS clusters that run Kubernetes 1.10.x or later |

### Things to consider when using horizontal autoscaling

Let's review some details about working with the horizontal pod autoscaler.

- **Consider number of pods (replicas)**. When you configure the HPA for a given deployment, you define the minimum and maximum number of pods (replicas) that can run.

- **Consider scaling metrics**. To use the HPA, define the metric to monitor and to use as the basis for scaling decisions, such as CPU usage.

- **Consider cooldown for scaling events**. As the HPA checks the Metrics API every 30 seconds, previous scale events might not complete before subsequent checks occur. The HPA might change the number of replicas before the previous scale event receives the application workload and resource demands to adjust accordingly.
   
   To minimize race events, set cooldown or delay values to define how long the HPA must wait after a scale event before another scale event is triggered. This behavior allows the new replica count to take effect and the Metrics API to reflect the distributed workload. By default, the delay on scale up events is 3 minutes, and the delay on scale down events is 5 minutes.
   
- **Consider tuning cooldown values**. You might need to tune cooldown values. Default cooldown values might give the impression that the HPA isn't scaling the replica count quickly enough. To more quickly increase the number of replicas in use, reduce the `--horizontal-pod-autoscaler-upscale-delay` value when you create your HPA definitions by using the  Azure CLI `kubectl` tool.

### Things to consider when using cluster autoscaling

Now let's consider the details for working with the cluster autoscaler.

- **Consider combining with HPA**. Cluster autoscaler is typically used alongside the horizontal pod autoscaler. When the two scaling techniques are combined, the HPA increases or decreases the number of pods based on application demand. The cluster autoscaler adjusts the number of nodes as needed to run the extra pods accordingly.

- **Consider scale-out events**. If a node doesn't have sufficient compute resources to run a requested pod, that pod can't progress through the scheduling process. The pod can't start unless other compute resources are available within the node pool.
   
   When the cluster autoscaler notices pods that can't be scheduled due to node pool resource constraints, the number of nodes within the node pool is increased to provide the extra compute resources. When the extra nodes are successfully deployed and available for use within the node pool, the pods are then scheduled to run on them.

- **Consider burst scaling to Azure Container Instances**. If your application needs to scale rapidly, some pods might remain in a state waiting to be scheduled until the new nodes deployed by the cluster autoscaler can accept the scheduled pods. For applications that have high burst demands, you can scale with virtual nodes and Azure Container Instances. We take a closer look at rapid burst scaling in the next section.

- **Consider scale-in events**. The cluster autoscaler monitors the pod scheduling status for nodes that haven't recently received new scheduling requests. This scenario indicates that the node pool has more compute resources than required, so the number of nodes can be decreased.

   A node that passes a threshold for not being needed for 10 minutes is scheduled for deletion by default. When this situation occurs, pods are scheduled to run on other nodes within the node pool, and the cluster autoscaler decreases the number of nodes.

- **Consider avoiding single pods**. Your applications might experience some disruption as pods are scheduled on different nodes when the cluster autoscaler decreases the number of nodes. To minimize disruption, avoid applications that use a single pod instance.