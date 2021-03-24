To integrate your on-premises environment with Azure, you need the ability to create an encrypted connection. You can connect over the Internet or over a dedicated link. Here, we'll look at Azure VPN Gateway, which provides an endpoint for incoming connections from on-premises environments.

You have set up an Azure virtual network and need to ensure that any data transfers from Azure to your site and between Azure virtual networks are encrypted. You also need to know how to connect virtual networks between regions and subscriptions.

## What is a VPN gateway?

An Azure virtual network gateway provides an endpoint for incoming connections from on-premises locations to Azure over the Internet. A VPN gateway is a specific type of virtual network gateway that can be an endpoint for encrypted connections. It can also send encrypted traffic between Azure virtual networks over Microsoft's dedicated network that links Azure datacenters in different regions. This configuration allows you to link virtual machines and services in different regions securely.

Each virtual network can have only one VPN gateway. All connections to that VPN gateway share the available network bandwidth.

Within each virtual network gateway there are two or more virtual machines (VMs). These VMs have been deployed to a special subnet that you specify, called the _gateway subnet_. They contain routing tables for connections to other networks, along with specific gateway services. These VMs and the gateway subnet are similar to a hardened network device. You don't need to configure these VMs directly and should not deploy any additional resources into the gateway subnet.

Creating a virtual network gateway can take some time to complete, so it's vital that you plan appropriately. When you create a virtual network gateway, the provisioning process generates the gateway VMs and deploys them to the gateway subnet. These VMs will have the settings that you configure on the gateway.

A key setting is the **_gateway type_**. The gateway type determines the way the gateway functions. For a VPN gateway, the gateway type is "vpn". Options for VPN gateways include:

- Network-to-network connections over IPsec/IKE VPN tunneling, linking VPN gateways to other VPN gateways.

- Cross-premises IPsec/IKE VPN tunneling, for connecting on-premises networks to Azure through dedicated VPN devices to create site-to-site connections.

- Point-to-site connections over IKEv2 or SSTP, to link client computers to resources in Azure.

Now, let's look at the factors you need to consider for planning your VPN gateway.

## Plan a VPN gateway

When you're planning a VPN gateway, there are three architectures to consider:

- Point to site over the Internet
- Site to site over the Internet
- Site to site over a dedicated network, such as Azure ExpressRoute

### Planning factors

Factors that you need to cover during your planning process include:

- Throughput - Mbps or Gbps
- Backbone - Internet or private?
- Availability of a public (static) IP address
- VPN device compatibility
- Multiple client connections or a site-to-site link?
- VPN gateway type
- Azure VPN Gateway SKU

The following table summarizes some of these planning issues. The remainder are discussed later.

|                           |  Point to site            | Site to site                          |  ExpressRoute                 |
| -------------             | -------------             | -------------                         | ---------                     |
| Azure supported services  | Cloud services and VMs    | Cloud services and VMs                | All supported services        |
| Typical bandwidth         | Depends on [VPN Gateway SKU](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways#gwsku)    | Depends on [VPN Gateway SKU](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways#gwsku)       | See [ExpressRoute bandwidth options](https://docs.microsoft.com/azure/expressroute/expressroute-introduction#bandwidth-options)       |
| Protocols supported       | SSTP and IPsec            | IPsec                                 | Direct connection, VLANs      |
| Routing                   | RouteBased (dynamic)      | PolicyBased (static) and RouteBased   | BGP                           |
| Connection resiliency     | Active-passive            | Active-passive or active-active       | Active-active                 |
| Use case                  | Testing and prototyping   | Dev, test and small-scale production  | Enterprise/mission critical   |

### Gateway SKUs

It's important that you choose the right SKU. If you have set up your VPN gateway with the wrong one, you'll have to take it down and rebuild the gateway, which can be time consuming. For the latest information about gateway SKUs, including throughput, see [What is VPN Gateway? - Gateway SKUs](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways#gwsku).

## Workflow

When designing a cloud connectivity strategy using virtual private networking on Azure, you should apply the following workflow:

1. Design your connectivity topology, listing the address spaces for all connecting networks.

1. Create an Azure virtual network.

1. Create a VPN gateway for the virtual network.

1. Create and configure connections to on-premises networks or other virtual networks, as required.

1. If required, create and configure a point-to-site connection for your Azure VPN gateway.

### Design considerations

When you design your VPN gateways to connect virtual networks, you must consider the following factors:

- Subnets cannot overlap

    It is vital that a subnet in one location does not contain the same address space as in another location.

- IP addresses must be unique

    You cannot have two hosts with the same IP address in different locations, as it will be impossible to route traffic between those two hosts and the network-to-network connection will fail.

- VPN gateways need a gateway subnet called **GatewaySubnet**

    It must have this name for the gateway to work, and it should not contain any other resources.

### Create an Azure virtual network

Before you create a VPN gateway, you need to create the Azure virtual network.

### Create a VPN gateway

The type of VPN gateway you create will depend on your architecture. Options are:

- RouteBased

    Route-based VPN devices use any-to-any (wildcard) traffic selectors, and let routing/forwarding tables direct traffic to different IPsec tunnels. Route-based connections are typically built on router platforms where each IPsec tunnel is modeled as a network interface or VTI (virtual tunnel interface).

- PolicyBased

    Policy-based VPN devices use the combinations of prefixes from both networks to define how traffic is encrypted/decrypted through IPsec tunnels. A policy-based connection is typically built on firewall devices that perform packet filtering. IPsec tunnel encryption and decryption are added to the packet filtering and processing engine.

## Set up a VPN gateway

The steps you need to take will depend on the type of VPN gateway that you are installing. For example, to create a point-to-site VPN gateway by using the Azure portal, you would perform the following steps:

1. Create a virtual network.

2. Add a gateway subnet.

3. Specify a DNS server (optional).

4. Create a virtual network gateway.

5. Generate certificates.

6. Add the client address pool.

7. Configure the tunnel type.

8. Configure the authentication type.

9. Upload the root certificate public certificate data.

10. Install an exported client certificate.

11. Generate and install the VPN client configuration package.

12. Connect to Azure.

As there are several configuration paths with Azure VPN gateways, each with multiple options, it is not possible to cover every setup in this course. For more information, see the Additional Resources section.

## Configure the gateway

After your gateway is created, you'll need to configure it. There are several configuration settings you'll need to provide, such as the name, location, DNS server, and so on. We'll explore these in more detail in the exercise.

Azure VPN gateways are a component in Azure virtual networks that enable point-to-site, site-to-site, or network-to-network connections. Azure VPN gateways enable individual client computers to connect to resources in Azure, extend on-premises networks into Azure, or facilitate connections between virtual networks in different regions and subscriptions.
