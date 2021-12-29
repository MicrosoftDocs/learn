For hybrid cloud scenarios, you'll need to plan how you want to connect Azure Stack Hub to Azure. There are two supported methods to connect virtual networks in Azure Stack Hub to virtual networks in Azure:

 -  **Site-to-site**: A virtual private network (VPN) connection over IPsec (IKE v1 and IKE v2). This type of connection requires a VPN device or Routing and Remote Access Service (RRAS). The communication over this tunnel is encrypted and secure. However, bandwidth is limited by the maximum throughput of the tunnel (100-200 Mbps).
 -  **Outbound Network Address Translation (NAT)**: By default, all virtual machines in Azure Stack Hub will have connectivity to external networks via outbound NAT. Each virtual network that's created in Azure Stack Hub gets a public IP address assigned to it. Whether the virtual machine is directly assigned a public IP address or is behind a load balancer with a public IP address, it will have outbound access via outbound NAT using the VIP of the virtual network. This method only works for communication that's initiated by the virtual machine and destined for external networks (either internet or intranet). It can't be used to communicate with the virtual machine from outside.

Hybrid cloud applications are a single system that has components running in both Azure and Azure Stack Hub. This solution blueprint is relevant to establishing connectivity for any application that involves communications between the Azure public cloud and on-premises Azure Stack Hub components. Hybrid connectivity is a foundational blueprint that will be applicable to most Azure Stack Hub solutions.

> [!NOTE]
> Not applicable Azure Stack Hub deployments that are disconnected from the public internet.

:::image type="content" source="../media/hybrid-connectivity-azure-stack-hub-41102cd2.png" alt-text="Image of virtual public network tunnel.":::


The flow of data is begins with the virtual network and end with a virtual private network.

1.  Deploy a virtual network in Azure and Azure Stack Hub.
2.  Deploy a virtual network gateway in Azure and Azure Stack Hub.
3.  Deploy virtual machines in each virtual network.
4.  Establish a VPN connection over the public internet between the network gateways.
