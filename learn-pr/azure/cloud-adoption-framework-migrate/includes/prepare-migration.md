## Prepare your landing zone for migration

Before you plan individual workload migrations, you must ready your organization and cloud resources to support the migration. 

Regardless of which Azure landing zone reference implementation you used, you must perform some tasks to prepare your landing zone for a successful migration project.

Establish hybrid connectivity

During an Azure landing zone deployment, you can deploy a Connectivity subscription with a hub virtual network and network gateways, such as Azure VPN gateways, Azure ExpressRoute gateways, or both. After your Azure landing zone deployment, you must still configure hybrid connectivity from these gateways to connect to your existing datacenter appliances or your ExpressRoute circuit.

Prepare identity

During your Azure landing zone deployment, you should deploy a supporting architecture for your identity platform. And you must deploy the identity resources after the Azure landing zone deployment.

Extend Active Directory domain controllers

you need to deploy domain controllers to Azure inside the identity network area that you deployed. 

Enable hybrid DNS

To resolve Domain Name System (DNS) requests for namespaces that are a part of existing environments and ensure that resources in the existing environment can resolve resources in Azure, you need to configure DNS services to support common flows. You can use Azure landing zones to deploy many of the resources you need.

Custom DNS resolution

If you use Active Directory for your DNS resolver or if you deploy a non-Microsoft solution, you must deploy VMs. You can use these VMs as your DNS servers if you deploy your domain controllers to your Identity subscription and network spoke. Otherwise, you must deploy and configure the VMs to house these services.

After you deploy the VMs, you must integrate them into your existing DNS platform so they can perform lookups against your existing namespaces. For Active Directory DNS servers, this integration is automatic. If your design uses private DNS zones or if you use private endpoints to perform modernization efforts, you must plan accordingly.

Azure Firewall DNS proxy

You can configure Azure Firewall as a DNS proxy to receive traffic and forward it to an Azure resolver or your DNS servers. Use this configuration to perform lookups from on-premises to Azure. You can also configure the DNS servers for your Azure virtual networks to the custom servers that you use.

Configure the hub firewall

An Azure firewall blocks traffic until you add explicit allow rules. You should apply standard rules to all enabled workloads and also apply individual rules and rule collections based on workload needs. 

Routing

Azure provides routing between resources:

- In the same virtual network.
- In peered virtual networks.
- And a virtual network gateway, either in its own virtual network or in a peered virtual network that's configured to use the gateway.

You don't need any extra configuration for the preceding routing. Or you can use [another routing scenario](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) that needs extra configuration. 

Configure inter-spoke routing so that traffic to any unknown location goes to the firewall, which inspects the traffic and applies your firewall rules.

Enable subscription vending to automate and accelerate the process of creating new subscriptions.

When you deploy your landing zone, you also set policies to enable Defender for Cloud for your Azure subscriptions. Defender for Cloud provides security posture recommendations in its secure score, which evaluates deployed resources against the Microsoft security baseline.

## Prepare tools and backlog

## Align roles and responsibilities