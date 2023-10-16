As the lead system engineer and Azure administrator who’s tasked with resolving current connectivity issues with Azure VMs, your first step is to understand the technological background and the capabilities of Azure NAT Gateway.

Azure NAT Gateway is a fully managed cloud service that runs in Azure. It’s highly resilient, scalable, and easy to configure. When you use Azure NAT Gateway with your existing virtual networks in Azure, individual VMs or other Azure resources can remain fully private, unless they host services that accept inbound connections from the internet. All outbound connectivity that’s initiated from your virtual network uses the NAT gateway's static public IP addresses.

## Overview of NAT

NAT isn’t a new technology. It’s been used for decades for mapping local IP addresses to public addresses. One of NAT’s main purposes is to save public IPv4 addresses, which is especially helpful for internet service providers (ISPs). These companies can use NAT to map a scope of many private IPv4 addresses to just one public IP address, or to a few public IP addresses.

NAT is also used in homes and local networks. If you have a home router that connects you to the internet, it likely has NAT implemented. So that all your devices are routed to the internet by using just one public IP address. NAT also hides your internal address space, so that all outbound traffic seems to be coming from a single public IP address. The IP address is assigned to a router or gateway device.

When using NAT, it’s important to understand Transmission Control Protocol (TCP) ports and their purpose. Port address translation enables each host in a private network to communicate on the internet by using a single public IP address, so that each communication path is established over a unique TCP port. The process is as follows:

1. A device on the private network establishes a connection to a resource on the internet. The NAT replaces the internal device IP address in the packet header with the external IP address of the NAT device.
1. Port address translation then assigns the connection a port number from a pool of available ports.
1. That port number is inserted in the source port field in the packet header, and the packet is then forwarded to the internet.
1. The NAT device then records an entry in a network translation table:

    - For each connection that’s established, this entry contains the internal IP address, original source port, and the translated source port.
    - Subsequent packets from the same internal source IP address and port number are always translated to the same external IP address and port number.

1. The computer receiving a packet that has undergone NAT then establishes a connection to the port and IP address specified in the altered packet, oblivious to the fact that the supplied address is being translated.

The following diagram depicts the NAT process.

:::image type="content" source="../media/2-network-address-translation.svg" alt-text="The process of network address translation between a host and server." border="false":::

> [!NOTE]
> NAT is mostly used for establishing outbound connections to the internet. However, it cannot directly manage inbound connections from the internet. You need to use different technologies for that purpose.

## NAT service in Azure

When you create a virtual network in Azure, you assign it a private address space, and then create one or more subnets to that network. When you create a VM in Azure and then put it in that virtual network, it gets its local IP address from that network. If you want to accept outbound internet connections on that VM, you can also assign a public IP address object to that VM.

> [!NOTE]
> Azure VMs that you don’t assign a public IP address to can still access the internet by using Azure network address translation or Port address translation. However, in such cases, you can’t control which public IP address will be used for outbound connections. You also can’t enable inbound connections or use Remote Desktop Protocol (RDP) to connect to these VMs from outside; instead, you need to use an Azure Bastion host.

To help ensure secure, controllable, and scalable outbound connectivity for Azure VMs and other resources, you can create an instance of the Azure NAT Gateway service. You then assign the instance to one or more subnets within the same virtual network in Azure.

The Azure NAT Gateway service then helps securely translate your private IP addresses into a public IP address as the following diagram depicts:

:::image type="content" source="../media/2-network-address-translation-private-public.svg" alt-text="Azure NAT Gateway is assigned to two subnets on a virtual network and translates private IP addresses to public IP." border="false":::
