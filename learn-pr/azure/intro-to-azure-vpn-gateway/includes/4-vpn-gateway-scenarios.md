Azure VPN gateways allow you to set up the following connections:

- Connect on-premises datacenters to Azure virtual networks through a site-to-site connection
- Connect individual devices to Azure virtual networks through a point-to-site connection
- Connect Azure virtual networks to other Azure virtual networks through a network-to-network connection

Azure VPN gateways are suitable for Adatum for the following reasons:

- It's necessary to provide remote workers with secure access to applications running on IaaS virtual machines that are hosted on Azure virtual networks. It can be accomplished by configuring point-to-site VPNs that connect to an Azure VPN gateway on the same virtual network that hosts the IaaS virtual machine workloads. It will allow secure access to the applications without exposing those applications directly to hosts on the internet.
- It's necessary to provide workers at Adatum's main office with access to the applications running on the IaaS virtual machines in Azure. In this case, a site-to-site VPN configured between the main office and the Azure VPN gateway on the IaaS workload virtual network will allow secure access without exposing the VM workloads directly to hosts on the internet.

Because Adatum is likely to deploy more subnets on its virtual networks and to also deploy more IaaS workloads on virtual networks around the world in the future, you should ensure that Adatum deploys a route-based VPN gateway rather than a policy-based VPN gateway. Route-based VPN gateways support adding subnets to existing virtual networks and VPN connections between Azure virtual networks.

## When not to use Azure VPN Gateway

Azure VPN Gateway is not always the best solution for connecting an on-premises environment to the cloud. Azure ExpressRoute is a dedicated, high-speed private connection between an on-premises network and Microsoft cloud services, including Microsoft Azure and Microsoft 365. Azure ExpressRoute is most suitable for organizations that need to quickly and reliably transfer large volumes of data between their on-premises workload and their cloud workload.

Adatum should choose Azure ExpressRoute over Azure VPN Gateway as a method of connecting your on-premises environment to Azure if the following factors are true:

- Workers at Adatum require low-latency connections to resources in Microsoft clouds.
- Workers at Adatum require a high-bandwidth connection to resources in Microsoft clouds.
- Compliance regulations require that all data transmitted between Adatum's on-premises location and Microsoft cloud not pass across a public network.
