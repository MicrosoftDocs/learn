To allow access to your applications or between application components, Kubernetes provides an abstraction layer to virtual networking. Kubernetes nodes connect to a virtual network, providing inbound and outbound connectivity for pods. The *kube-proxy* component commonly provides Service networking in many configurations, but AKS clusters with Azure CNI powered by Cilium don't use kube-proxy.

In Kubernetes:

 -  *Services* typically group pods using label selectors and provide a stable IP address or DNS name to reach them. The ExternalName service type is an exception—it maps a service name to an external DNS hostname.
 -  *ServiceTypes* allow you to specify what kind of Service you want.
 -  You can distribute traffic using a *load balancer*.
 -  More complex routing of application traffic can also be achieved with *ingress controllers*.

The Azure platform also simplifies virtual networking for AKS clusters. When you create a Kubernetes LoadBalancer service, AKS provisions a Standard SKU Azure Load Balancer (the Basic SKU was retired on September 30, 2025). As you open network ports to pods, the corresponding Azure network security group rules are configured. The Application Routing add-on is a Microsoft-managed NGINX ingress option supported through November 2026; AKS is moving toward Gateway API as the long-term direction.

## Services

To simplify the network configuration for application workloads, Kubernetes uses *Services* to logically group a set of pods together and provide network connectivity. You can specify a Kubernetes *ServiceType* to specify what kind of Service you want.

The following ServiceTypes are available:

 -  **ClusterIP**
    
    ClusterIP creates an internal IP address for use within the AKS cluster. This Service is good for *internal-only applications* that support other workloads within the cluster.
    
    :::image type="content" source="../media/internal-address-cluster-3bcced45.png" alt-text="Diagram showing ClusterIP traffic flow in an AKS cluster.":::
    
 -  **NodePort**
    
    NodePort creates a port mapping on the underlying node that allows the application to be accessed directly with the node IP address and port. NodePort allocates a port from the cluster's configured node-port range (default 30000–32767) on every node.
    
    :::image type="content" source="../media/kubernetes-nodeport-cluster-f3af76e3.png" alt-text="Diagram showing NodePort traffic flow in an AKS cluster.":::
    
 -  **LoadBalancer**
    
    LoadBalancer creates a Standard SKU Azure load balancer resource. In AKS, the Azure Load Balancer backend pool contains cluster nodes, node IPs, or node pool instances, not pods. By default, AKS provisions a public Standard Load Balancer frontend IP; using the internal load balancer annotation provisions a private IP instead. Load balancing rules are created on the desired ports so the load balancer distributes traffic to cluster nodes, and Kubernetes Service networking forwards it to the selected pod endpoints.
    
    :::image type="content" source="../media/kubernetes-load-balancer-cluster-1ba6c92c.png" alt-text="Diagram showing Load Balancer traffic flow in an AKS cluster.":::
    
    
    For extra control and routing of the inbound traffic, you may instead use an [Ingress controller](/azure/aks/concepts-network-ingress#ingress-controllers).
 -  **ExternalName**
    
    Maps the service to an external DNS hostname by configuring the cluster DNS to return a CNAME record. No traffic proxying is performed; pods resolve the in-cluster service name and DNS redirects them to the external endpoint.

Either the load balancers and services IP address can be dynamically assigned, or you can specify an existing static IP address. You can assign both internal and external static IP addresses. Existing static IP addresses are often tied to a DNS entry.

You can create both *internal* and *external* load balancers. Internal load balancers are only assigned a private IP address, so they can't be accessed from the Internet.

## Azure virtual networks

AKS supports several network plug-ins (Container Network Interface, or CNI), grouped into two networking models:

 -  **Overlay model** — Pods receive IP addresses from a private CIDR that is logically separate from the virtual network subnet that hosts the nodes. This model conserves virtual network IP space and scales to large clusters.
 -  **Flat (VNet-integrated) model** — Pods receive IP addresses from the same virtual network as the nodes, so pods are directly addressable from other resources in the virtual network.

### Recommended plug-ins

 -  **Azure CNI Overlay** — The default plug-in for new AKS clusters. Pod IPs come from a private overlay CIDR, and traffic leaving the cluster is source NATed (SNATed) to the node IP. Recommended for most scenarios.
 -  **Azure CNI Pod Subnet** — Pods receive IPs from a separate, dedicated subnet in the virtual network and are directly addressable from other VNet resources without NAT. Recommended when pods need direct VNet IP connectivity.
 -  **Azure CNI Powered by Cilium** — Combines supported Azure CNI IPAM modes, including overlay, virtual-network pod subnet with dynamic pod IP allocation, and node subnet mode where supported, with the Cilium eBPF data plane for advanced network policy and observability.

### Legacy plug-ins

 -  **Azure CNI Node Subnet** — The original Azure CNI mode. Every pod receives an IP address from the node's virtual network subnet, and the maximum number of pod IPs per node is reserved up front. This approach can lead to IP exhaustion in large or growing clusters, so plan IP space carefully.
 -  **Kubenet** — A legacy overlay plug-in. Pods receive IPs from a logically separate address space and use network address translation (NAT) to reach resources on the virtual network; the source IP is translated to the node's primary IP. Kubenet is scheduled to be **retired on March 31, 2028** and isn't recommended for new clusters. Migrate to Azure CNI Overlay before that date.

### Advanced options

 -  **Bring your own (BYO) CNI** — Use `--network-plugin none` to install and manage your own CNI plug-in. Microsoft support can't assist with CNI-related issues in BYO CNI clusters; use AKS-supported CNI plug-ins when Microsoft CNI support is required.

:::image type="content" source="../media/advanced-networking-diagram-kubernetes-f78266ae.png" alt-text="Diagram showing two nodes with bridges connecting each to a single Azure virtual network.":::


## Ingress controllers

When you create a LoadBalancer-type Service, you also create an underlying Azure load balancer resource. The load balancer is configured to distribute traffic on the Service port to cluster nodes. Kubernetes Service routing then forwards that traffic to matching pod endpoints for the Service.

The *LoadBalancer* only works at layer 4. At layer 4, the Service is unaware of the actual applications, and can't make any more routing considerations.

*Ingress controllers* work at layer 7 and can use more intelligent rules to distribute application traffic. Ingress controllers typically route HTTP traffic to different applications based on the inbound URL.

:::image type="content" source="../media/kubernetes-ingress-cluster-c49f648e.png" alt-text="Diagram showing Ingress traffic flow in an AKS cluster.":::
