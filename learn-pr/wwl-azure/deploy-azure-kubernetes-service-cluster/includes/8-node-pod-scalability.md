## Scale pods and nodes in Azure Kubernetes Service (AKS)

Azure Kubernetes Service (AKS) supports scaling at two levels: **pod-level scaling** changes the number of workload replicas, and **node-level scaling** changes the cluster infrastructure that runs those workloads. Choose scaling mechanisms that match the workload pattern, availability requirements, and budget. For example, a steady web API might use a fixed node pool with the Horizontal Pod Autoscaler (HPA), while a bursty queue processor might use Kubernetes Event-driven Autoscaling (KEDA) and node autoscaling.

Use pod-level mechanisms to scale applications first. Use node-level mechanisms when the cluster needs more or fewer nodes to host scheduled pods. For more information, see [Scaling options for applications in AKS](/azure/aks/concepts-scale).

## Manual scaling

Manual scaling is useful for testing, controlled operations, or workloads with predictable demand. For pods, set the deployment replica count. For infrastructure, set the node count on a node pool or on the cluster.

```bash
kubectl scale deployment <name> --replicas <n>
az aks nodepool scale --cluster-name <cluster> --resource-group <rg> --name <pool> --node-count <n>
az aks scale --resource-group <rg> --name <cluster> --nodepool-name <pool> --node-count <n>
```

Fixed node-count scaling with `az aks scale` or `az aks nodepool scale` is disabled on node pools where cluster autoscaler is enabled. To set a specific node count, disable cluster autoscaler on that node pool first. If you want autoscaler to keep managing the node pool, adjust its `--min-count` and `--max-count` values instead.

`User` node pools can scale to `0` nodes. To force a user node pool to `0` manually, disable the cluster autoscaler on the node pool first. Autoscaler-enabled user node pools can allow scale-to-zero by setting `--min-count 0`. `System` node pools can't scale to `0` because AKS needs system nodes to run critical cluster services.

> [!IMPORTANT]
> Don't remove AKS nodes by running `kubectl delete node`. Always use `az aks` commands to scale nodes so AKS keeps the Kubernetes node objects and the underlying virtual machine scale set in sync.

For more information, see [Manually scale the node count in an AKS cluster](/azure/aks/scale-cluster).

## Horizontal Pod Autoscaler

The HPA scales the number of pod replicas based on observed metrics. You define minimum and maximum replicas and the metric targets that indicate when the workload should scale out or scale in.

Out of the box, HPA supports **CPU and memory** resource metrics from the Kubernetes Metrics Server. Custom and external metrics require an adapter, such as Prometheus Adapter or KEDA, to expose those metrics through the Kubernetes metrics APIs.

The HPA controller sync period is `15` seconds by default. In AKS, Metrics Server scrapes the kubelet every `60` seconds, so although the controller loop runs every `15` seconds it acts on data that refreshes only every `60` seconds — meaning effective scaling decisions change at most once every `60` seconds. HPA makes replica decisions from the metrics it observes, and the Kubernetes scheduler places new pods on nodes with available capacity.

Use HPA for workloads that need more or fewer replicas as resource use changes. If no node has enough available resources for the new replicas, the pods remain pending until node capacity is available.

## Vertical Pod Autoscaler

The Vertical Pod Autoscaler (VPA) right-sizes pod CPU and memory **requests** based on observed usage. VPA is generally available on AKS and helps improve scheduling and cluster utilization by aligning requests with real workload behavior.

VPA supports these update modes:

- `Off`: VPA provides recommendations only and doesn't apply changes.
- `Initial`: VPA applies recommendations only when pods are created.
- `Recreate`: VPA assigns updated resource requests when pods are created and evicts existing pods when their current requests differ significantly from recommendations, so they're recreated with updated values.
- `InPlaceOrRecreate` (Requires AKS 1.34+.): VPA tries to apply supported request changes in place, and recreates pods when in-place updates aren't possible. Microsoft recommends `InPlaceOrRecreate` over `Recreate` when the workload tolerates it, because it takes advantage of restart-free updates whenever possible.
- `Auto` (deprecated): An alias for `Recreate` (deprecated as of VPA 1.4.0 / AKS 1.34+). Use `Recreate` for new manifests.

Don't combine VPA and HPA on the **same** CPU or memory metrics. HPA changes replica count based on those metrics, while VPA changes the requested resources that those same metrics compare against. This conflict can cause unstable scaling behavior. VPA doesn't support AKS Windows containers.

For more information, see [Vertical pod autoscaling in AKS](/azure/aks/vertical-pod-autoscaler).

## Kubernetes Event-driven Autoscaling

AKS provides a managed KEDA add-on for event-driven autoscaling. KEDA scales workloads based on event sources such as queue depth, message backlog, schedules, or external metrics. KEDA can also scale workloads to `0` replicas when no events need processing.

Use KEDA when application demand is driven by events rather than only CPU or memory usage. Examples include queue processors, stream consumers, scheduled jobs, and workloads that use external metrics.

Use Microsoft Entra Workload ID for KEDA scalers that need to authenticate to Azure resources. Workload ID is preferred over pod-managed identity for new deployments. Don't combine a KEDA `ScaledObject` with an HPA that targets the same workload because KEDA uses HPA behavior in the background and the two controllers compete. By default, the conflict failure mode is asymmetric: if an HPA already exists for the workload, creating a KEDA `ScaledObject` for it fails; if the `ScaledObject` is created first, a subsequently created HPA isn't blocked but still produces unstable scaling behavior. KEDA exposes advanced ownership-transfer annotations such as `scaledobject.keda.sh/transfer-hpa-ownership`, but these are not a substitute for running a single autoscaler per workload.

For more information, see [KEDA add-on for AKS](/azure/aks/keda-about).

## Cluster autoscaler

The [cluster autoscaler](/azure/aks/cluster-autoscaler) adjusts the number of nodes in autoscaler-enabled node pools. It watches for pods that can't be scheduled because of resource constraints and adds nodes when another node could run those pods. It also evaluates whether underutilized nodes can be removed safely.

You don't have to enable cluster autoscaler during cluster provisioning. You can enable it later on an existing cluster or node pool.

```bash
az aks update --resource-group <rg> --name <cluster> --enable-cluster-autoscaler --min-count <n> --max-count <m>
az aks nodepool update --resource-group <rg> --cluster-name <cluster> --name <pool> --enable-cluster-autoscaler --min-count <n> --max-count <m>
```

AKS uses one cluster-wide autoscaler profile. You can enable cluster autoscaler on multiple node pools, but per-node-pool configuration is limited to values such as `min-count` and `max-count`. Autoscaler profile settings, such as `scan-interval`, apply to all autoscaler-enabled node pools in the cluster.

### Scale-up behavior

The Kubernetes scheduler first tries to place a pod on existing nodes. If no node has enough resources or matching scheduling constraints, the pod is marked unschedulable. The cluster autoscaler watches for that condition and asks Azure to add capacity to a suitable node pool. After the new node is ready, the scheduler can place pending pods on it.

### Scale-down behavior

The cluster autoscaler removes a node only when the node has been underutilized for `scale-down-unneeded-time` and the pods on the node can be safely evicted and rescheduled elsewhere. The default `scale-down-unneeded-time` is `10` minutes.

Scale-down can be blocked by workload or scheduling constraints. Common blockers include restrictive PodDisruptionBudgets, pods that can't run on other nodes because of affinity or topology constraints, and the `cluster-autoscaler.kubernetes.io/safe-to-evict: false` annotation. The `skip-nodes-with-local-storage` autoscaler-profile setting (which AKS defaults to `false`) controls whether nodes that run pods with local storage are skipped. The `skip-nodes-with-system-pods` setting (which AKS defaults to `true`) prevents scale-down of nodes running `kube-system` pods, except for DaemonSet and mirror pods.

### Default autoscaler profile settings

| Setting | Default |
| --- | --- |
| `scan-interval` | 10 s |
| `scale-down-unneeded-time` | 10 min |
| `scale-down-utilization-threshold` | 0.5 |
| `max-graceful-termination-sec` | 600 |
| `max-node-provision-time` | 15 min |

For more information, including the full list of profile settings, see [Use the cluster autoscaler in AKS](/azure/aks/cluster-autoscaler#cluster-autoscaler-profile-settings). For an architectural overview, see [Cluster autoscaling in AKS overview](/azure/aks/cluster-autoscaler-overview).

## PodDisruptionBudgets

Configure PodDisruptionBudgets (PDBs) for production workloads to maintain availability during voluntary disruptions such as node drains, cluster upgrades, and cluster autoscaler scale-down. A PDB tells Kubernetes how many pods in a workload must remain available while voluntary disruption operations proceed.

> [!CAUTION]
> Overly restrictive PDBs can block cluster autoscaler scale-down and AKS cluster upgrades. Set PDBs to protect availability without preventing safe evictions.

## Virtual nodes

Virtual nodes let AKS schedule pods to Azure Container Instances without provisioning extra virtual machines. They're useful for burst workloads that need fast capacity while you avoid keeping extra nodes running during idle periods.

Virtual nodes have important constraints. They support Linux pods only and require Azure CNI in flat-networking mode with a delegated virtual-node subnet (Microsoft's documented examples use Azure CNI Node Subnet). Azure CNI Overlay isn't compatible because virtual-node pods need direct VNet routability to Azure Container Instances. Virtual nodes don't support DaemonSets, don't support init containers, and don't support managed identity on virtual nodes, IPv6, or persistent volumes.

For more information, see [Create and configure an AKS cluster to use virtual nodes](/azure/aks/virtual-nodes).

## Node auto-provisioning

Node auto-provisioning (NAP) is a newer Karpenter-based node provisioning mode for AKS. NAP watches pending pods and automatically selects optimal VM SKUs and node configurations to satisfy workload requirements.

NAP is preconfigured in AKS Automatic. You can enable it on Standard-tier clusters (non-Automatic) when the cluster meets the prerequisites and constraints. NAP can't coexist with cluster autoscaler on the same cluster. Other limitations include no Windows node pools, no IPv6 clusters, no service principals (managed identity is required), and no cluster stop/start once NAP is enabled. NAP is supported through stable AKS APIs and is preconfigured for AKS Automatic clusters; Microsoft's general AKS scaling concepts page may still describe it as preview, so confirm the current preview/GA status against the [Node auto-provisioning in AKS](/azure/aks/node-auto-provisioning) documentation before adopting it for production.

For more information, see [Node auto-provisioning in AKS](/azure/aks/node-auto-provisioning).

## Scale limits

Plan scaling with AKS limits, Azure subscription quotas, regional VM capacity, IP address capacity, and the AKS pricing tier. Current AKS scale limits include the following values.

| Resource | Limit |
| --- | --- |
| Nodes per cluster with Virtual Machine Scale Sets and Standard Load Balancer SKU | Up to 5,000 for Standard and Premium tier clusters, subject to AKS quotas, regional capacity, and subscription quota. Free tier supports up to 1,000 nodes and is recommended for clusters with fewer than 10 nodes. |
| Nodes per virtual machine scale set node pool | 1,000 |
| Node pools per cluster | 100 |
| Pods per node | 250 |
| Azure CNI Overlay pod CIDR allocation | One `/24` pod CIDR per node |

For AKS service limits, see [AKS quotas, virtual machine size restrictions, and region availability](/azure/aks/quotas-skus-regions). For Azure CNI Overlay pod CIDR planning, including the per-node `/24` allocation, see [Azure CNI Overlay IP address planning](/azure/aks/concepts-network-azure-cni-overlay#ip-address-planning).
