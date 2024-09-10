Choosing the best network plugin for your use case depends on your criteria. Each option has its own pros, cons, and tradeoffs to be considered when making a selection.

## High level decision criteria

### IPv4 exhaustion

Kubenet is designed with the conservation of IP address space in mind. Azure CNI provides pods with complete network connectivity, but requires more IP address space and planning. IPv4 exhaustion is when the number of addresses reach the limit and stop nodes from a scale or upgrade operation. During exhaustion, your application demands too many resources and falters to keep up.

Kubenet lets the nodes receive defined IP addresses, without the need to reserve a large number of IP addresses up front for all of the potential pods that could run in the cluster. With kubenet, you worry less about IPv4 exhaustion and handle a small IP address range for large cluster support and application demands.

The following basic calculations compare address space in the network models:

* kubenet: a simple /24 IP address range can support up to 251 nodes in the cluster (each Azure virtual network subnet reserves the first three IP addresses for management operations). This node count could support up to 27,610 pods (with a default maximum of 110 pods per node with kubenet).
* Azure CNI: that same basic /24 subnet range could only support a maximum of 8 nodes in the cluster. This node count could only support up to 240 pods (with a default maximum of 30 pods per node with Azure CNI).

### Cluster size

Kubenet has a hard maximum of 400 nodes per cluster, while Azure CNI is dependent on how the plugin is configured.

### Connectivity

In Kubenet, you must manually manage and maintain user-defined routes (UDRs). To reach pods from outside the cluster, a load balancer must be used. With Azure CNI, pods get full virtual network connectivity and can be directly reached via their private IP address from connected networks.

### Multi-cluster support

In kubenet, multiple clusters can't use the same node subnet. With Azure CNI, this configuration is possible.

### Latency

Compared to Azure CNI, Kubenet needs an extra hop, which can introduce some minor latency. Latency-sensitive workloads should be deployed on clusters using Azure CNI.

### Extra capabilities

Azure CNI supports complex network topologies with Azure CNI networking, such as Virtual Nodes or Azure Network Policies.

These extra capabilities are:

* Subnet per node pool
* Dynamic allocation of IPs
* Node vs pod subnet allocations

## Behavioral differences between Kubenet and Azure CNI

In addition to high level criteria, there are many behavioral differences and discrepancies in feature support:

|Capability|Kubenet|Azure CNI|Azure CNI Overlay|Azure CNI Powered by Cilium|
|----------|-------|---------|-----------------|---------------------------|
|Deploy cluster in existing or new virtual network|Supported - UDRs manually applied|Supported|Supported|Supported|
|Pod-pod connectivity|Supported|Supported|Supported|Supported|
|Pod-VM connectivity; VM in the same virtual network|Works when initiated by pod|Works both ways|Works when initiated by pod|Works when initiated by pod|
|Pod-VM connectivity; VM in peered virtual network|Works when initiated by pod|Works both ways|Works when initiated by pod|Works when initiated by pod|
|On-premises access using VPN or Express Route|Works when initiated by pod|Works both ways|Works when initiated by pod|Works when initiated by pod|
|Access to resources secured by service endpoints|Supported|Supported|Supported| |
|Access to resources exposed by Private Endpoints|Supported|Supported| | |
|Expose Kubernetes services using a load balancer service, App Gateway, or ingress controller|Supported|Supported|Supported|Same limitations when using Overlay mode|
|Default Azure DNS and Private Zones|Supported|Supported|Supported| |
|Support for Windows node pools|Not supported|Supported|Supported|Available only for Linux|
|Virtual nodes|Not Supported|Supported|Not supported| |
|Multiple clusters sharing one subnet|Not supported|Supported|Supported| |
|Network policies supported|Calico|Calico and Azure Network Policies|Calico, Azure Network Policies, Cilium|Ciliuim|