Knowing the number of pods and nodes is essential before you can determine how many IP addresses you need. Now that you know the number of pods and nodes needed, let's look at sizing the network.

## Sizing the virtual network subnet

You want a maximum of seven VMs for the Kubernetes cluster nodes. Remember that an extra node is temporarily added to Azure Kubernetes Service (AKS) clusters during the upgrade process. So, you need to make network size calculations based on eight virtual machines (VM)s.

`Maximum 7 VMs + 1 VM for upgrades = 8 node IP addresses`

By default, AKS clusters using the Azure Container Networking Interface (CNI) plugin are configured to allow a maximum of 30 pods per node. This value is configurable to any value between 10 and 250 pods. The network sizing calculations must allow for that maximum number of pods to be deployed.

`8 VMs x 30 pods per node maximum = 240 pod IP addresses`

You need 8 IP addresses for nodes and 240 IP addresses for pods.

`8 node IP addresses + 240 pod IP addresses = 248 IP addresses`

> [!TIP]
> If you plan to use an internal Azure Load Balancer with your cluster, it also requires an IP address. It's a common practice to use a dedicated subnet for load balancers, but if you plan to use the same subnet as your nodes, then you need to account for it.

In this design, you decided to keep the default node pool configuration. The default configuration uses a single System Mode node pool that runs everything. If you want to ensure that system components are isolated from applications, you need at least two node pools. You should adjust the IP address range calculations to account for it.

You can now approach the team responsible for network allocation in your organization and request a subnet supporting 248 IP addresses. When you create a subnet in an Azure Virtual Network, five IP addresses are reserved for system use. A /24 address range would have 251 usable IP addresses, which would make it a good fit for the cluster.

## Selecting a Kubernetes service address range

With the node and pod subnet selected, there's only one more address range to select: the address range for the Kubernetes Service. Kubernetes Service provides a static virtual IP address that allows traffic to be routed to your pods. This address range is only ever used for routing traffic inside your cluster. The address range is never used or exposed outside of the cluster. So, you need to select a private network address range that isn't used somewhere else in Azure or your on-premises networks.

> [!TIP]
> Because the Kubernetes service address range is never used outside of the cluster, it's possible to reuse this address range across multiple clusters.

The rules for selecting a service address range include:

- The range can't be within the IP address range of the virtual network used for your cluster.
- The range can't be within the IP address range of any other virtual networks that are peered to the cluster network.
- The range can't overlap with any IP address range you use in on-premises networks.
- The range can't be in the IP address ranges 169.254.0.0/16, 172.30.0.0/16, 172.31.0.0/16, or 192.0.2.0/24.

You usually don't need many IP addresses for services within a cluster. Typically, you have one service in front of a group of pods that run multiple replicas of an application. In this case, you have eight different services forming the application, so you only need eight service IP addresses.

Other services running in the cluster, such as Ingress Controllers or Service Meshes, might consume more service IP addresses. It's best to factor in extra room for other services you might use in the future. It's generally a good idea to use a generous address range. A /24 address range provides plenty of space for the cluster to work with.

## Selecting a DNS service IP address

Kubernetes uses a built-in Domain Name System (DNS) service to provide service discovery features within the cluster. The DNS service needs an IP address within the Kubernetes Service address range. You can't use the first IP address from the Kubernetes Service address range, but any other value is acceptable.

You now have all the information you need to deploy the cluster.
