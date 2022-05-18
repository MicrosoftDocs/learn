A network plugin is required by an AKS cluster in order to facilitate pod-pod communication, pod-node communication, and in some cases, node-pod communication. Here you'll learn about the different plugin options available on AKS:

## Kubenet

By default, AKS clusters use kubenet. With kubenet, an Azure Virtual Network, subnet, and route table are created automatically when the cluster is deployed, but existing network resources can be provided. With kubenet:

* Nodes receive an IP address from the Azure Virtual Network subnet.
* Pods receive an IP address from a logically different address space than the node pool's subnet.
* Network address translation (NAT) is then configured so that the pods can reach resources on the Azure Virtual Network.
* The source IP address of the traffic is translated to the node's primary IP address.

Pods can't communicate directly with each other across nodes. Instead, User Defined Routing (UDR) and IP forwarding is used for connectivity between pods across nodes. By default, UDRs and IP forwarding configuration is created and maintained by the AKS service, but you have to the option to bring your own route table for custom route management.

If your custom subnet doesn't contain a route table, AKS creates one for you and adds rules to it throughout the cluster lifecycle. If your custom subnet contains a route table when you create your cluster, AKS acknowledges the existing route table during cluster operations and adds/updates rules accordingly for cloud provider operations.

:::image source="../media/kubenet-overview.png" alt-text="Diagram of the kubenet network model with an AKS cluster. Two nodes are shown using kubenet to route/NAT traffic over the virtual network's node subnet.":::

## Azure CNI

The Azure CNI plugin is a more complex networking option with higher configurability and more supported features. With Azure CNI, a pre-existing subnet and a virtual network are required in order to utilize the Clusters using with Azure CNI networking require extra planning. The size of your virtual network and its subnet must accommodate the number of pods you plan to run and the number of nodes for the cluster. With Azure CNI:

* Nodes receive an IP address space from the Azure Virtual Network subnet.
* Each pod receives an IP address in the node pool's subnet, and can directly communicate with other pods and services.
* Your clusters can be as large as the IP address range you specify. However, the IP address range must be planned in advance, and all of the IP addresses are consumed by the AKS nodes based on the maximum number of pods that they can support. 

With Azure CNI, a pre-existing subnet and a virtual network are required in order to utilize the Azure CNI network plugin. This subnet and virtual network can be created during the creation time of the AKS cluster.

:::image source="../media/advanced-networking-diagram.png" alt-text="Diagram of the Azure CNI network model. Pods are shown communicating through a bridge. Each pod has a unique IP assigned from the virtual network's node subnet.":::

## Bring your own

For customers who plan to use a completely custom network configuration and want existing AKS networking out of the way, it's possible to create clusters with no networking plugin. This is required when planning on using a CNI provider like Cilium or Flannel. Addressing this option isn't in scope for this module.
