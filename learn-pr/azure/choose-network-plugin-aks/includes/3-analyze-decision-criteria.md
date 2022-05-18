Choosing the best network plugin for your use case depends on a number of decision criteria. Each option has pros and cons, and tradeoffs should be considered when making a selection.

## High level decision criteria

### IPv4 exhaustion

Kubenet is designed with the conservation of IP address space in mind. Azure CNI provides pods with complete network connectivity, but requires more IP address space and planning. The address range may be too small to allow more nodes during a scale or upgrade operation or to support your expected application demands.

Kubenet lets the nodes receive defined IP addresses, without the need to reserve a large number of IP addresses up front for all of the potential pods that could run in the cluster. You can use a much smaller IP address range and still support large clusters and application demands.

The following basic calculations compare the difference in network models:

* kubenet - a simple /24 IP address range can support up to 251 nodes in the cluster (each Azure virtual network subnet reserves the first three IP addresses for management operations). This node count could support up to 27,610 pods (with a default maximum of 110 pods per node with kubenet).
* Azure CNI - that same basic /24 subnet range could only support a maximum of 8 nodes in the cluster. This node count could only support up to 240 pods (with a default maximum of 30 pods per node with Azure CNI).

### Cluster size

Kubenet has a hard maximum of 400 nodes per cluster. The limit of nodes per cluster when using Azure CNI is dependent on how the plugin is configured.

### Connectivity

In Kubenet, you must manually manage and maintain user-defined routes (UDRs). To reach pods from outside the cluster, a load balancer must be used. With Azure CNI, pods get full virtual network connectivity and can be directly reached via their private IP address from connected networks.

### Multi-cluster support

In kubenet, multiple clusters can't use the same node subnet. With Azure CNI, this configuration is possible.

### Latency

Compared to Azure CNI, Kubenet needs an extra hop, which can introduce some minor latency. Latency-sensitive workloads should be deployed on clusters using Azure CNI.

### Additional capabilities

Azure CNI supports complex network topologies such as subnet per node pool, dynamic allocation of IPs, and node vs pod subnet allocations. Many features also require Azure CNI networking, such as Virtual Nodes or Azure Network Policies.

## Behavioral differences between Kubenet and Azure CNI

In addition to high level criteria, there are many behavioral differences and discrepancies in feature support:

|Capability|Kubenet|Azure CNI|
|----------|-------|---------|
|Deploy cluster in existing or new virtual network|Supported - UDRs manually applied|Supported|
|Pod-pod connectivity|Supported|Supported|
|Pod-VM connectivity; VM in the same virtual network|Works when initiated by pod|Works both ways|
|Pod-VM connectivity; VM in peered virtual network|Works when initiated by pod|Works both ways|
|On-premises access using VPN or Express Route|Works when initiated by pod|Works both ways|
|Access to resources secured by service endpoints|Supported|Supported|
|Access to resources exposed by Private Endpoints|Supported|Supported|
|Expose Kubernetes services using a load balancer service, App Gateway, or ingress controller|Supported|Supported|
|Default Azure DNS and Private Zones|Supported|Supported|
|Support for Windows node pools|Not Supported|Supported|
|Virtual nodes|Not Supported|Supported|
|Multiple clusters sharing one subnet|Not supported|Supported|
|Network policies supported|Calico|Calico and Azure Network Policies|