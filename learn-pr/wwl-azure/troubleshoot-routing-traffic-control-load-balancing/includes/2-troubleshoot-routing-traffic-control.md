Routing errors can occur anywhere along the virtual network and the setting to control inbound and outbound traffic will cause problems with traffic control. This unit will examine the different tools available to troubleshoot typical problems.

## Troubleshoot user-defined routing issues

A user-defined route overrides Azure's default routing and is used to route traffic through a network virtual appliance (NVA). The main advantage is to help with routing and firewall optimization.

The key steps to set up a user-defined route are:

1. Create an NVA that routes traffic.

1. Create a route table and a route.

1. Associate the route table to a subnet.

1. Deploy virtual machines into different subnets.

1. Route traffic from one subnet to another via the NVA.

The main problems that occur when setting up a user-defined route are:

- Have you set up three subnets for the public, private and the perimeter network demilitarized zone (DMZ)? The DMZ subnet gives an added layer of protection to a local area network (LAN).

- Have you set up the subnets with unique non-overlapping address ranges?

- Do you have a non-overlapping address space for the Bastion subnet address space?

- Have you connected the route table to the public subnet?

- Have you added the DMZ subnet name as the subnet in Settings, in the NVA?

   :::image type="content" source="../media/3-propagate-gateway-routes.png" alt-text="Screenshot of Propagate gateway routes dialog box.":::

- The route table overrides any default routing in the network. Have you allowed the gateway route to propagate?

- Have you assigned the correct subnet ranges to the route?

- The address prefix is the private subnet address range.

- The next hop address is the DMZ subnet address range.

- Have you added the route table to the public virtual network?

- Have you enabled the IP forwarding on the NVA?

## Review route tables

To route traffic between Azure, on-premises, and internet resources, a route table is created for each subnet within the Azure virtual network. It automatically creates system default routes to the route table.

Important points to note:

- You cannot create or remove system routes, only override them with custom user-defined routes.

- Each subnet must be associated with a route table. You can assign a user-defined route table, or the system will allocate a default table.

:::image type="content" source="../media/3-route-table.png" alt-text="Screenshot showing a typical route table.":::

A typical route table holds an address prefix and the next hop type.

## Determine whether subnets are associated with route tables

When you deploy a virtual machine, several default routes are automatically created, or you can associate your own route table.

To diagnose any connection problems, you can use:

- The Azure portal

- PowerShell

- Azure CLI

### Azure portal

Log in to the Azure portal then search for and select the virtual machine you want to check:

1. Select **Settings** > **Networking** and select the **network interface resource**.

1. Select **Effective Routes** and the route table will be displayed.

### Diagnose routes using PowerShell

```azurepowershell
Get-AzEffectiveRouteTable `

  -NetworkInterfaceName myVMNic1 `

  -ResourceGroupName myResourceGroup `

  | Format-Table

```

### Diagnose routes using Azure CLI

```azurecli
az network nic show-effective-route-table \

  --name myVMNic1 \

  --resource-group myResourceGroup

```

## Resolving routing problems

To resolve a route problem, try the following actions:

- Add a custom route to override a default route and test.

- Delete an existing custom route and set up a new custom route.

- Check that any custom routes in the route table are associated with the correct subnet.

- Use VPN diagnostics to check that any gateways or NVAs are operable.

- Use the next hop feature in Azure Network Watcher.

:::image type="content" source="../media/3-next-hop.png" alt-text="Screenshot of the next hop option.":::

## Troubleshoot asymmetric routing

Asymmetric routing is when a packet takes one path to the destination and follows another path when it returns to the source. This often happens when multiple circuits are used to improve network uptime and the router finds the best path. If your system is not set up correctly, packets can be dropped.

Solutions to prevent packet loss can be found through routing and by using source network address translation (SNAT).

### Routing

Check the following:

- Are your public IP addresses advertised to the correct wide area network (WAN) links?

- If you want to use the internet for authentication traffic, don't advertise your Active Directory Federation Services (AD FS) public IP address over ExpressRoute.

### Source-based NAT

:::image type="content" source="../media/3-source-based-network-address-translation.png" alt-text="Diagram of a network with SNAT incorporated.":::

If you experience dropped packets, SNAT can help to direct them via the same route. In the above example, instead of using ExpressRoute to advertise the public IP address of an on-premises Simple Mail Transfer Protocol (SMTP) server, you could choose to use the internet path. The process will work effectively if:

- The request from Microsoft travels the internet route.

- You use SNAT for the incoming IP address.

- Return traffic goes to the edge firewall which you use for NAT—this will then direct the return traffic via the internet path rather than ExpressRoute.

## Tracking asymmetric routing

Use Tracert to check the path your traffic is traveling along.

- Open the command prompt and type pathping. The full path is shown below:

  ```console
  pathping [/n] [/h <maximumhops>] [/g <hostlist>] [/p <Period>] [/q <numqueries> [/w <timeout>] [/i <IPaddress>] [/4 <IPv4>] [/6 <IPv6>][<targetname>]

  ```

## Troubleshoot forced tunneling issues

Forced tunneling lets you direct all internet-bound traffic back to your on-premises location via a site-to-site VPN tunnel for inspection and auditing.

:::image type="content" source="../media/3-forced-tunnelling.png" alt-text="Diagram of a network with forced tunneling.":::

Check the following points to resolve routing problems:

- If you cannot connect to the internet, check that the routing you have configured for the device routes traffic to a public or private IP address for the virtual machine.

- If users with virtual machines cannot activate Windows, it is because the activation request is coming from your on-premises network. Ensure the activation request comes from an Azure public IP address.

## Troubleshoot Border Gateway Protocol (BGP) issues

Within the Azure portal, you can view metrics for learned routes, BGP peers and advertised routes then download the data via csv for further analysis.

Follow the steps below to access the BGP metrics within Azure:

1. Open the gateway.

1. Navigate to BGP peers.

  :::image type="content" source="../media/3-border-gateway-protocol-peers.png" alt-text="Screenshot of the BGP peers screen.":::

## Troubleshoot multi-VNet configuration

Read through the list to troubleshoot configuration problems:

- If the peering status shows as Connected, use the Connection Troubleshooter and IP Flow in Azure to verify from the source VM to the destination VM, to see if a network security group (NSG) or user-defined route is the issue. You can then run a network trace from the source to the destination IP.

   ```console
   tcping64.exe -t <destination VM address> 3389

   ```

- If the peering status is Disconnected, delete the peering from both networks and recreate it.

- If you are using a third-party NVA, contact the vendor to double check the setting.

- Have you used a remote gateway on a spoke network? This is not supported.

- Have you set Allow forwarded traffic or Use remote gateway, depending on your setup?

- If you transit over a global virtual network peering, check you have a [supported resource](/troubleshoot/azure/virtual-machines/custom-routes-enable-kms-activation).

## Troubleshoot service chaining

Service chaining helps to automate traffic flow between services in a virtual network because the best routing path should be selected. However, if you are experiencing slow internet connections, it could be due to the additional hops that chaining has added to the process.

Points to remember:

- Have you configured the user-defined route as the next hop IP address?

- User-defined routes can point to virtual network gateways.

- Consider building a hub and spoke network topology so the hub virtual network hosts the infrastructure. The spoke networks then peer with the hub, with traffic flowing through the network virtual applicant or VPN gateway on the hub.

:::image type="content" source="../media/3-service-chaining.png" alt-text="Screenshot of spoke and hub network." lightbox="../media/3-service-chaining.png":::

### Troubleshoot routing configuration of Azure VMs that function as routers

You need to contact the vendor of the network virtual appliance if you have any connectivity or routing problems when you connect to Azure.

When you set up a virtual appliance that will function as a router there are two main areas to investigate:

- Ensure you have the correct up-to-date information from the vendor.

- Troubleshoot the in-house elements.

### Network Virtual Appliance vendors

Check the following with the NVA vendor:

- Is the software up-to-date?

- Is the service account with the vendor set up correctly and fully functional?

- Check all user-defined routes.

- Are the routing tables set up correctly?

- Run tracing on the NVA network interfaces to check you can receive and send traffic.

### Other troubleshooting steps

It is also important to check your in-house setup:

- Do you meet the minimum configuration requirements?

- If you experience packet loss:

- Check CPU usage for capacity and spikes.

- Use network traces to check packet traffic.

- Check firewalls.

- Are NSGs or UDRs interfering with the trace?

- Is the routing table incorrect?
