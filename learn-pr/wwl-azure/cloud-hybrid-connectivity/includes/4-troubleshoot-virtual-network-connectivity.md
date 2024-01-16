## Determine whether traffic is allowed between peers

Peering lets you connect two or more virtual networks in Azure. The traffic between the virtual networks is routed through Microsoft's backbone infrastructure, not through a gateway or over the public internet. There are two types of peering in Azure:

- **Virtual network peering** – connecting virtual networks within the same Azure region.

- **Global virtual network peering** – connecting virtual networks in different Azure regions.

Global virtual network peering has the following constraints:

- Resources in one virtual network can't communicate with the front-end IP address of a Basic Internal Load Balancer (ILB) in a globally peered virtual network.

- Some services that use a Basic load balancer don't work over global virtual network peering. 

- You can't peer across clouds. 

- The virtual networks you peer must have non-overlapping IP address spaces.

- When two virtual networks are peered, you can't add or delete address ranges from a virtual network's address space. To add or remove address ranges, delete the peering, add or remove the address ranges, then recreate the peering.

- You can't peer two virtual networks created through the classic deployment model.

- Azure inbuilt name resolution won't resolve names in peered virtual networks. To resolve names in other virtual networks, you must use Azure private zones, or a custom DNS Server.

- A virtual network can be peered to another virtual network, and also be connected to it, with an Azure virtual network gateway. When virtual networks are connected through both peering and a gateway, traffic between the virtual networks flows through the peering configuration, rather than the gateway.

- Point-to-site VPN clients must be downloaded again after virtual network peering has been successfully configured, to ensure the new routes are downloaded to the client.

To troubleshoot connectivity between peers, do the following:

1. Check the status of the peering connection:

   - **Initiated** indicates that you do not have a bidirectional link. For example, to peer VNetA to VNetB, two links must be created, one from VNetA to VNetB and another from VNetB to VNetA. Creating both links will change the state to **Connected**.

   - **Disconnected** indicates that one of the links was deleted. To re-establish a peering connection, you will need to delete and recreate both links.

1. Check that two VNets do not have matching or overlapping address ranges. 

## Troubleshoot VPN gateway transit issues

[Gateway transit](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/virtual-network/virtual-network-peering-overview.md) is a peering property that allows a virtual network to use the VPN gateway in the peered virtual network for VNet-to-VNet connectivity. In the following diagram, you can see how gateway transit works with virtual network peering:

:::image type="content" source="../media/4-gateway-transit.png" alt-text="Diagram of gateway transit with virtual network peering." border="false":::

The following constraints apply when virtual networks are globally peered:

- Resources in one virtual network can't communicate with the front-end IP address of a Basic ILB in a globally peered virtual network.

- Some services that use a Basic load balancer don't work over global virtual network peering. For further details, see [What are the constraints related to Global VNet Peering and Load Balancers?](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/virtual-network/virtual-networks-faq.md)

To troubleshoot VPN gateway transit issues, try the following:

- If the spoke virtual network already has a VPN gateway, the **Use remote gateway** option isn't supported on the spoke virtual network due to a peering limitation.

- For a hub-spoke network connectivity issue between spoke virtual networks in the same region, the hub network must include an NVA. Configure UDRs in spokes that have an NVA set as the next hop and enable **Allow forwarded traffic** in the hub virtual network.

## Troubleshoot transitivity between peers

Transitive peering is when you:

- Peer VNetA to VNetB.

- Peer VNetB to VNetC.

- By default, VNetA is not peered with VNetC.

To achieve peering between VNetA and VNetC, you must peer them together. Alternatively, use a hub-and-spoke configuration and go through an NVA in the hub.

:::image type="content" source="../media/4-virtual-network-peering.png" alt-text="Screenshot showing all v nets peered to each other.":::

## Troubleshoot hub-and-spoke VNet configurations

With a hub-and-spoke configuration, the hub virtual network acts as a central point of connectivity to many spoke virtual networks. The hub can also be used as the connectivity point to your on-premises networks. The spoke virtual networks peer with the hub and can be used to isolate workloads.

:::image type="content" source="../media/4-hub-spoke.png" alt-text="Screenshot showing Hub-and-spoke configuration." lightbox="../media/4-hub-spoke.png":::

Here's how to troubleshoot connectivity between a hub-spoke virtual network and an on-premises resource.

If your network uses a third-party NVA, check for the following:

- Software updates.

- Service Account setup and functionality.

- User-defined routes (UDRs) on virtual network subnets that direct traffic to NVA.

- UDRs on virtual network subnets that direct traffic from NVA.

- Routing tables and rules within the NVA (for example, from NIC1 to NIC2).

- Tracing on NVA NICs to verify receiving and sending network traffic.

- When using a Standard SKU and Public IPs, there must be an NSG created and an explicit rule to allow the traffic to be routed to the NVA.

- The minimum configuration for NVAs on Azure.

If your network uses a VPN gateway, check for the following:

- The gateway must be in the virtual network in the Resource Manager model.

If your network does not use a third-party NVA or VPN gateway, does the hub virtual network and the spoke virtual network have a VPN gateway? If the spoke virtual network already has a VPN gateway, the **Use remote gateway** option isn't supported on the spoke virtual network. This is because of a virtual network peering limitation.

For site-to-site or Azure ExpressRoute connections, check the following causes of connectivity issues to the remote virtual network from on-premises:

- If the virtual network has a gateway, verify that the **Allow forwarded traffic** check box is selected.

- If the virtual network doesn't have a gateway, verify that the **Use remote gateway** check box is selected.

- Ask your network administrator to check your on-premises devices to verify that they all have the remote virtual network address space added.

For point-to-site connections:

- On the virtual network that has a gateway, verify that the **Allow forwarded traffic** check box is selected.

- On the virtual network that doesn't have a gateway, verify that the **Use remote gateway** check box is selected.

- Download and reinstall the point-to-site client package. Virtual network routes that are newly peered don't automatically add routes to point-to-site clients.

### Troubleshoot global peering connectivity

To troubleshoot a connectivity issue between peered virtual networks:

1. Sign in to the Azure portal with an account that has the necessary roles and permissions.

1. Select the virtual network, select **Peering**, and then select the **Status** field.

1. If the status is **Disconnected**, delete the peering from both virtual networks, and then recreate them.

1. If the status is **Connected**, check the network traffic flows.

  Use [Connection Troubleshoot](/azure/network-watcher/network-watcher-connectivity-overview) and [IP flow verify](/azure/network-watcher/network-watcher-ip-flow-verify-overview) from the source VM to the destination VM to determine whether there is an NSG or UDR that is causing interference in traffic flows.

If you're using a firewall or NVA:

  1. Document the UDR parameters so that you can restore them after this step is complete.

  1. Remove the UDR from the source VM subnet or NIC that points to the NVA as the next hop. Verify connectivity from the source VM directly to the destination that is bypassing the NVA.

  1. Take a network trace:
    - Start a network trace on the destination VM. For Windows, you can use **Netsh**. For Linux, use **TCPDump**.
    - Run **TcpPing** or **PsPing** from the source to the destination IP. This is an example of a **TcpPing** command: 

```console
tcping64.exe -t <destination VM address> 3389
```
After the **TcpPing** is complete, stop the network trace on the destination. If packets arrive from the source, there is no networking issue. Examine both the VM firewall and the application listening on that port to locate the configuration issue.

 > [!NOTE]
 > You can't connect to the following resource types over global virtual network peering (virtual networks in different regions):

- VMs behind Basic ILB SKU

- Redis cache (uses Basic ILB SKU)

- Application gateway (uses Basic ILB SKU)

- Scale sets (uses Basic ILB SKU)

- Service Fabric clusters (uses Basic ILB SKU)

- SQL Server Always On (uses Basic ILB SKU)

- App Service Environment (uses Basic ILB SKU)

- API Management (uses Basic ILB SKU)

- Microsoft Entra Domain Services (uses Basic ILB SKU)

For more information, see the [requirements and constraints](/azure/virtual-network/virtual-network-peering-overview) of global peering.

## Troubleshoot VNet to VNet connections

Do the following:

- Check that the gateways are configured using Dynamic routing and not Static routing. Static routing is not supported.

- Check the number of VPN connections. For basic and standard dynamic routing gateways, the maximum number of VPN connections and VNets to which a particular VNet can connect to is currently 10. It is 30 for high performance gateways.

- Check the address prefixes on both VNets to ensure there is no overlapping of address spaces between the two VNets.

## Troubleshoot service chaining

Service chaining is the ability to send traffic from one virtual network to an NVA in a peered network via user-defined routes. In peered virtual networks, you configure user-defined routes that point to virtual machines as the next hop IP address. You will need to set up a route table and associate it to a subnet. For step-by-step instructions for routing network traffic, see [Tutorial: Route network traffic with a route table using the Azure portal](/azure/virtual-network/tutorial-create-route-table-portal).

Using PowerShell, you can test the routing of network traffic using tracert:

```powershell
tracert myvmprivate

```

This will display the tracing route, and you'll see if the traffic is taking the route you anticipated. Tracert has a response similar to:

```bash
Tracing route to myvmprivate.q04q2hv50taerlrtdyjz5nza1f.bx.internal.cloudapp.net [10.0.1.4] over a maximum of 30 hops:

1     1 ms     *        2 ms  myvmnva.internal.cloudapp.net [10.0.2.4]

2     2 ms     1 ms     1 ms  myvmprivate.internal.cloudapp.net [10.0.1.4]

Trace complete.

```
