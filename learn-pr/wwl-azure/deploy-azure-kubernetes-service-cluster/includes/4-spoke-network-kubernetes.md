The address space of the spoke virtual network should be large enough to hold all subnets and the IP allocations those subnets support. Plan the address space around the Azure Container Networking Interface (CNI) mode that you choose for the Azure Kubernetes Service (AKS) cluster.

## Choose a network model

AKS supports several network plugins and data plane options. Choose the model before you size the spoke virtual network because the choice determines whether pod IP addresses come from virtual network subnets or from a separate overlay address space. For more information, see [Network concepts for applications in AKS](/azure/aks/concepts-network-cni-overview) and [Azure CNI Overlay networking in AKS](/azure/aks/concepts-network-azure-cni-overlay).

- **Azure CNI Overlay** is the recommended baseline for most AKS clusters. Pods receive IP addresses from a separate private pod CIDR; AKS uses `10.244.0.0/16` by default if you don't specify `--pod-cidr`, but you can choose any private RFC 1918 or RFC 6598 range that doesn't overlap your spoke virtual network, peered virtual networks, on-premises networks, or the Kubernetes service CIDR. This overlay address space doesn't consume IP addresses from the spoke virtual network subnets, so pod scale doesn't drive subnet sizing.
- **Azure CNI Pod Subnet** is appropriate when pods must be directly routable from the virtual network (for example, when services outside the cluster need direct pod connectivity). Pod Subnet supports two allocation modes: [Dynamic IP Allocation](/azure/aks/configure-azure-cni-dynamic-ip-allocation) for efficient per-pod IP use, and [Static Block Allocation](/azure/aks/configure-azure-cni-static-block-allocation) for large-scale clusters that need predictable per-node CIDR blocks.
- **Azure CNI Node Subnet** is the legacy flat Azure CNI model. In general, use it only if you need AKS to manage the virtual network for your cluster.
- **Kubenet** is a legacy plugin that [retires on March 31, 2028](https://azure.microsoft.com/updates?id=485172). Don't use kubenet for new clusters.
- **Azure CNI Powered by Cilium** is the preferred data plane and network policy option where it's supported. Cilium is currently supported on Linux node pools only. For Windows node pools, use Calico for network policy. Azure Network Policy Manager (NPM) is a legacy option: NPM support ends on Windows nodes on September 30, 2026, and on Linux nodes on September 30, 2028. Until Linux NPM retires, scaling beyond 250 nodes and 20,000 pods isn't supported and can result in out-of-memory errors. Don't use NPM for new clusters on either OS.

## Node subnet sizing for Azure CNI Overlay

With Azure CNI Overlay, plan the node subnets for node IP addresses, not pod IP addresses. Each node in a system or user node pool consumes an IP address from its node subnet. When you size the subnets, account for:

- The current node count for each node pool.
- Anticipated scale-out for system and user node pools.
- Upgrade headroom. AKS adds temporary surge nodes during upgrades. The default `maxSurge` value is 1 (one extra node). For production node pools, 33% is recommended. With Azure CNI Overlay, each surge node consumes one extra **node-subnet** IP address per node pool during an upgrade (pod IPs come from the overlay CIDR). With Azure CNI Node Subnet (flat networking), each surge node also consumes `maxPods` extra subnet IP addresses for its pods, which is why the flat-networking sizing formula later in this unit multiplies `(nodes + maxSurge)` by `maxPods`.
- Internal load balancers, Application Gateway instances, and API Server VNet Integration (which projects API server pods and an internal load balancer into the delegated `snet-apiserver` subnet) that consume IP addresses from their respective subnets.

## Pod CIDR sizing for Azure CNI Overlay

With Azure CNI Overlay, pods get IP addresses from a private overlay pod CIDR. This CIDR must not overlap the spoke virtual network, peered virtual networks, on-premises networks (including ExpressRoute and VPN ranges), or the Kubernetes service CIDR.

By default, the overlay assigns a `/24` pod block to each node. Size the overlay pod CIDR by the maximum simultaneous number of nodes in the cluster, including surge nodes during upgrades, not by the maximum number of pods. A `/16` pod CIDR contains 256 `/24` blocks, so it supports up to 256 simultaneously running nodes; for example, 255 steady-state nodes with `maxSurge=1` fits in a `/16`, but 256 steady-state nodes with `maxSurge=1` requires a larger pod CIDR. Use a larger pod CIDR for high-scale clusters.

## Legacy flat Azure CNI sizing formula

If you use a directly routable Azure CNI mode instead of Azure CNI Overlay, include pod IP addresses in the virtual network address plan because each pod consumes a virtual network IP address. For Azure CNI Node Subnet, size the node subnet with this formula:

`(nodes + maxSurge) + ((nodes + maxSurge) * maxPods)`

For Azure CNI Pod Subnet, sizing depends on the allocation mode. With **Dynamic IP Allocation**, IP addresses are allocated to nodes in batches of 16, with another batch requested when fewer than 8 IPs remain unallocated on a node. As a starting baseline, size the pod subnet using `(maxNodes + maxSurge) × 16`, plus headroom for system pods, and size up further if you anticipate sustained high pod density — see [Configure Azure CNI networking with Dynamic IP Allocation](/azure/aks/configure-azure-cni-dynamic-ip-allocation). With **Static Block Allocation**, each node is assigned one or more `/28` blocks (16 IPs each); one IP per node is reserved for internal use, so the documented optimal `maxPods` setting is `maxPods = (16 × N) − 1` (for example, 31 for `N=2`, 47 for `N=3`), where `N` is the number of `/28` blocks per node. From the published examples, `N` is effectively `⌈(maxPods + 1) / 16⌉` and the pod subnet must hold `(maxNodes + maxSurge) × N × 16` addresses; treat these as derived guidance and confirm your sizing against the official examples in [Configure Azure CNI networking with Static Block Allocation](/azure/aks/configure-azure-cni-static-block-allocation) (max pod subnet size is `/12`). In both modes, still reserve node-subnet IP addresses for `(nodes + maxSurge)`.

## Scalability

AKS supports up to 5,000 nodes per cluster (with VMSS-backed node pools and the Standard SKU Load Balancer), 1,000 nodes per virtual machine scale set node pool, and 100 node pools per cluster. For current limits, see [AKS quotas, virtual machine size restrictions, and region availability](/azure/aks/quotas-skus-regions).

For Azure CNI Overlay, the practical scale limit for pod addressing is the overlay pod CIDR size. Each node consumes one `/24` pod block by default, so make sure the pod CIDR has enough `/24` blocks for the maximum simultaneous node count, including upgrade surge headroom, that you plan to support.

## Upgrade

AKS surges new nodes during cluster and node-pool upgrades. The number of surge nodes is controlled by `--max-surge`. The default `maxSurge` value is 1 (one extra node). For production node pools, 33% is recommended.

For Azure CNI Overlay, surge nodes consume IP addresses from the node subnet. They don't consume pod-subnet IP addresses because Overlay doesn't use a pod subnet for pods.

For pods, you might need extra addresses depending on your workload's deployment strategy:

- Rolling updates use temporary pods while the workload is updated.
- Recreate strategy removes the old pods before new pods are created, so the new pods can reuse released addresses.

## Network policy

For network policy, prefer Cilium when you use Azure CNI Powered by Cilium. For Windows node pools, use Calico. Azure Network Policy Manager (NPM) support ends on Windows nodes on September 30, 2026, and on Linux nodes on September 30, 2028. Until Linux NPM retires, it has scale limitations beyond 250 nodes and 20,000 pods. Don't use NPM for new clusters on either OS. For more information, see [Network policies in AKS](/azure/aks/use-network-policies).

## Azure Private Link addresses

Factor in the addresses that are required for communication with other Azure services over Private Link. In this architecture, budget at least three Private Link IP addresses: two for the initial Azure Container Registry private endpoint (one for the registry endpoint and one for the home-region regional data endpoint) and one for Azure Key Vault. Add more if you enable Azure Container Registry geo-replication or additional regional endpoints.

:::image type="content" source="../media/hub-spoke-network-address.svg" alt-text="Diagram that shows a hub-spoke network topology with hub and spoke VNet address ranges and AKS cluster subnets.":::


This architecture is designed for a single workload. For multiple workloads, you might want to isolate the user node pools from each other and from the system node pool. That choice results in more subnets that are smaller in size. Also, the ingress resource might be more complex, and as a result you might need multiple ingress controllers that require extra IP addresses.
