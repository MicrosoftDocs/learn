Knowing the number of pods and nodes is essential before we can assess how many IP addresses we need. So now that we know the number of pods and nodes, let's look at sizing the network.

## Sizing the virtual network subnet

We now know that we want a maximum of seven virtual machines for our Kubernetes cluster nodes. When you upgrade an Azure Kubernetes Service cluster, an extra node gets added to the cluster temporarily. So, we need to add that to our total and make our network size calculations based on eight virtual machines.

**Maximum 7 virtual machines, plus 1 additional virtual machine for upgrades = 8 node IP addresses**

By default, an Azure Kubernetes Service cluster using the Azure CNI network plug-in is configured to allow a maximum of 30 pods per node. This value is configurable to any value between 10 and 250 pods. The network sizing calculations must allow for that maximum number of pods to be deployed.

**8 virtual machines x 30 pods per node maximum = 240 pod IP addresses**

> [!NOTE]
> Today, the Azure CNI pre-allocates IP addresses for pods. So, if the default value of 30 pods per node is used, then 30 IP addresses will be pre-allocated in the subnet for each node. A new version of Azure CNI is currently in preview which will support dynamic IP address allocation.

We're going to need 8 IP addresses for nodes and 240 IP addresses for pods. Simple addition gives us a requirement of 248 IP addresses.
> [!TIP]
> If you plan to use an internal Azure Load Balancer with your cluster, this will also require an IP address. It's a common practice to use a dedicated subnet for load balancers, but if you plan to use the same subnet as your nodes, then you'll need to account for that.

In this design, we've decided to stay with the default node pool configuration. The default uses a single System Mode node pool that runs everything. If we want to ensure that we isolate system components from applications, then we need at least two node pools. We should adjust our IP address range calculations to include that.

So, you can now approach the team responsible for network allocation in your organization and request a subnet supporting 248 IP addresses. When you create a subnet in an Azure Virtual Network, five IP addresses are reserved for system use. A /24 address range would have 251 usable IP addresses, which would make it a good fit for our cluster.

## Selecting a Kubernetes service address range

With the node and pod subnet selected, there's only one more address range to select, and that's the address range used by Kubernetes Services. As described previously, services provide a static virtual IP address that allows traffic to be routed to your pods. This address range is only ever used for routing traffic inside your cluster. It's never used or exposed outside of the cluster, so you need to select a private network address range that's not in use elsewhere in Azure or your on-premises networks.

> [!TIP]
> Because the Kubernetes service address range is never used outside of the cluster, it's possible to re-use this address range across multiple clusters.

The rules for selecting a service address range are straightforward:

- It must not be within the IP address range of the virtual network used for your cluster.
- It must not be within the IP address range of any other virtual networks that are peered to the cluster network.
- It must not overlap with any IP address range you use in on-premises networks.
- It must not be in the IP address ranges 169.254.0.0/16, 172.30.0.0/16, 172.31.0.0/16, or 192.0.2.0/24.

You don't normally need many IP addresses for services within a cluster. Typically, you have one service in front of a group of pods that run multiple replicas of an application. In our case, we have eight different services that form our application, so we only need eight service IP addresses.

Other services running in your cluster, such as an Ingress Controller or a Service Mesh might consume more service IP addresses. It's best to factor in some room for other services you could be using now or in the future.

The service address range is only ever used within the cluster. It's safe and generally a good idea to use a fairly generous address range. A /24 address range provides plenty of space for the cluster to work with.

## Selecting a DNS service IP address

Kubernetes uses a built-in DNS service to provide service discovery features within the cluster. The DNS service needs an IP address that should be within the Kubernetes Service address range described previously. The only other rule is that you can't use the first IP address from the Kubernetes Service address range. But any other value is acceptable.

The virtual network subnet size has been determined. A Kubernetes service address range has been defined. A DNS service IP address has been selected. We now have all the information we need to deploy our cluster.