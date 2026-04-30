When running applications in Azure Kubernetes Service (AKS), you might need to increase or decrease compute resources. Most AKS scaling decisions act at one of two layers: workload replicas or node pool capacity. Scaling replicas changes how many pods run for an application. Scaling nodes changes the compute capacity available for Kubernetes to schedule those pods. For sudden or short-lived demand, you can also use Azure Container Instances (ACI) through virtual nodes.

This module summarizes the core AKS application scaling concepts, including:

- Manual scaling of workload replicas and AKS node pools
- Horizontal pod autoscaler (HPA)
- Cluster autoscaler
- Virtual nodes and Azure Container Instances (ACI)

### Manually scale pods or nodes

You can manually scale a workload's replica count or an AKS node pool to test how your application responds to more or less capacity. Manual scaling sets a fixed target, such as a specific replica count or node count, instead of reacting automatically to load. When you scale replicas, Kubernetes reconciles the desired replica count by creating or terminating pods. When you scale AKS nodes, use AKS scaling operations: for a single-node-pool cluster you can use `az aks scale`, and for a specific node pool or multi-node-pool cluster use `az aks nodepool scale` (or `az aks scale --nodepool-name`). Removing AKS nodes directly with `kubectl` isn't supported.

During node scale-in, AKS cordons and drains nodes to minimize disruption before reducing the underlying compute capacity. For node pools backed by Virtual Machine Scale Sets, Azure determines which VM instances to remove during scale-in. To learn more about how nodes are selected for removal, see the [Virtual Machine Scale Sets FAQ](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-faq#if-i-reduce-my-scale-set-capacity-from-20-to-15--which-vms-are-removed-). To learn how to manually scale AKS nodes, see [Manually scale the node count in an AKS cluster](/azure/aks/scale-cluster).

### Horizontal pod autoscaler

Kubernetes uses the horizontal pod autoscaler (HPA) to monitor demand and automatically scale the number of workload replicas. HPA can use resource metrics, such as CPU or memory, and it can use custom or external metrics when the required metric adapters are configured. For resource utilization targets, containers in the targeted workload must define requests for the resource being measured, such as CPU requests for CPU-based scaling, so HPA can calculate utilization correctly.

By default, HPA evaluates each scaling target every 15 seconds, controlled by the kube-controller-manager `--horizontal-pod-autoscaler-sync-period` setting. Each evaluation uses the latest sample from the Metrics API. The current upstream Metrics Server reference manifests collect resource metrics from each Kubelet every 15 seconds (`--metric-resolution=15s`); the actual cadence depends on the deployed Metrics Server configuration in your cluster. HPA requires Metrics Server for resource metrics such as CPU and memory. To learn how to configure HPA in AKS, see [Autoscale pods in AKS](/azure/aks/tutorial-kubernetes-scale#autoscale-pods).

:::image type="content" source="../media/horizontal-pod-autoscaling-introduction-8ff0e018.png" alt-text="Diagram showing HPA reading workload metrics, increasing the Deployment replica count, and Kubernetes scheduling additional pods.":::


When you configure HPA for a workload such as a Deployment, you define the minimum and maximum number of replicas that can run. You also define the metric to monitor and base scaling decisions on, such as CPU usage.

Horizontal scaling is a reaction to an increased load that results in deploying more pods. Horizontal scaling differs from vertical scaling, where more resources are assigned to the pods that are already running a workload.

If the load decreases, and the number of pods is above the minimum, horizontal scaling adjusts the workload to scale back down.

### Cooldown of scaling events

Because metric samples are refreshed over time and new pods need time to start receiving traffic, a previous scaling event might not be reflected before another HPA evaluation occurs. This behavior could cause HPA to change the number of replicas before the application workload and resource demands adjust to the previous change.

To minimize rapid oscillation, Kubernetes applies stabilization behavior to scaling decisions. By default, scale-up uses a stabilization window of 0 seconds (subject to the default scale-up rate policies), while scale-down decisions are stabilized for *5 minutes* (`behavior.scaleDown.stabilizationWindowSeconds: 300`, also exposed by the kube-controller-manager `--horizontal-pod-autoscaler-downscale-stabilization` flag). For more information, see the Kubernetes documentation for [Horizontal Pod Autoscaler algorithm details](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#algorithm-details).

### Cluster autoscaler

The cluster autoscaler adjusts the number of nodes in AKS node pools. It doesn't scale nodes directly from CPU or memory usage. Instead, it reacts when pods can't be scheduled because their resource requests don't fit on available nodes, and it removes nodes that have been underutilized long enough to be unnecessary. By default, the cluster autoscaler reevaluates the cluster every 10 seconds and considers nodes for scale-in after they're unneeded for 10 minutes. Scale-in requires pods on candidate nodes to be evictable and schedulable elsewhere, so design workloads with realistic resource requests, appropriate replica counts, and disruption budgets.

The cluster autoscaler is often used with HPA. HPA increases or decreases the number of pod replicas based on application demand, and the cluster autoscaler adds nodes when newly created pods are pending because the node pool lacks capacity. Configure minimum and maximum node counts on each autoscaled node pool, and let the cluster autoscaler manage the underlying scale settings. Don't configure separate Virtual Machine Scale Sets autoscale rules for AKS node pools that use the cluster autoscaler. For implementation details, see [Use the cluster autoscaler in AKS](/azure/aks/cluster-autoscaler).

### Burst to Azure Container Instances

For sudden or short-lived capacity needs, virtual nodes can let AKS schedule pods to run as ACI container groups. ACI-backed pods can start without waiting for the cluster autoscaler to provision more VM-backed nodes, and you pay per second for the container instances while they run. Virtual nodes are best for workloads that fit ACI's supported feature set; they aren't a replacement for every workload that runs on VM-backed node pools. The AKS virtual nodes add-on supports Linux pods and nodes only and requires Azure CNI advanced (VNet) networking. Clusters that use kubenet aren't supported, and not every Azure CNI mode is supported (for example, Azure CNI Overlay isn't recommended where features such as virtual nodes are required). Verify support for the specific Azure CNI mode in current documentation before adopting virtual nodes. Review current regional availability, networking requirements, quotas, and limitations before relying on virtual nodes. For more information, see [Virtual nodes on Azure Container Instances](/azure/container-instances/container-instances-virtual-nodes) and [Create and configure an AKS cluster to use virtual nodes](/azure/aks/virtual-nodes).

### Other scaling options

AKS also supports additional scaling mechanisms that build on the concepts in this module:

- [Kubernetes Event-driven Autoscaling (KEDA)](/azure/aks/keda-about) scales workloads in response to event sources such as queue length or external service metrics, instead of relying only on in-cluster CPU or memory resource metrics. KEDA can scale supported workloads to zero. For `ScaledObject`-based autoscaling, KEDA uses HPA in the background, so avoid configuring a KEDA `ScaledObject` and a separate HPA for the same workload unless the design explicitly accounts for that interaction.
- [Node auto-provisioning (NAP)](/azure/aks/node-auto-provisioning), which uses the open-source Karpenter project, dynamically provisions nodes of an appropriate VM SKU based on pending pod requirements. NAP is different from the cluster autoscaler because it can select suitable node configurations instead of only changing the count of an existing node pool. Check the current prerequisites and limitations before using NAP; for example, NAP can't be enabled on clusters that use the cluster autoscaler.

The remaining units focus on the cluster autoscaler and on bursting to Azure Container Instances with virtual nodes.
