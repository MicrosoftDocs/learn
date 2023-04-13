There are two types of Azure virtual WANs:

- Basic – site-to-site VPN only.

- Standard – can include ExpressRoute, User VPN (P25), VPN (site-to-site), inter-hub and VNet to VNet transiting, Azure Firewall, and NVA in a virtual WAN.

> [!NOTE]
> You can upgrade from Basic to Standard, but not the other way around.

## Monitor virtual WANs

To view the status of a virtual WAN, use Azure Monitor Insights for Azure Virtual WAN. This displays the status of the components of your virtual WAN, including for each hub, VPN sites, firewalls, connections, and third-party NVAs. You can see the overall health of the virtual WAN, as well as navigating to specific resources.

Resource-level metrics are displayed in a virtual WAN metrics workbook. This displays metrics for different levels:

- Virtual WAN

- Hub

- Gateway

- Connection

To access Azure Monitor Insights for Azure Virtual WAN:

1. From the Azure portal, select **Virtual WAN**.

1. Under **Monitoring**, select **Insights (preview)**. The **Insights** view is displayed.

:::image type="content" source="../media/5-insights-view.png" alt-text="Screenshot of Insights view." lightbox="../media/5-insights-view.png":::

The Insights view displays the virtual WAN resources with color-coded symbols to indicate their status. When you select a resource, the Insights view is displayed.

:::image type="content" source="../media/5-virtual-network-resources.png" alt-text="Screenshot virtual WAN resources." lightbox="../media/5-virtual-network-resources.png":::

The Insights view is diagrammatic, with each resource state color-coded. Metrics are displayed in a mini workbook on the right.

The dependency map displays:

- Resources in a connected graph with colored status symbols.

- Indirectly connected virtual networks that are peered with virtual WAN spoke virtual networks.

You can:

- Hover over each resource to display configuration settings.

- Right-click to access the Azure portal page for that resource.

:::image type="content" source="../media/5-dependency-map.png" alt-text="Screenshot of dependency map." lightbox="../media/5-dependency-map.png" border="false" :::

Select **View detailed metrics** to display information about your virtual WAN resource capacity, performance, and utilization at the virtual WAN level, hub level, and for individual connections.

:::image type="content" source="../media/5-detailed-metrics.png" alt-text="Screenshot of detailed metrics." lightbox="../media/5-detailed-metrics.png":::

## Determine whether sites are configured correctly

Connectivity between VNets in a virtual WAN is managed with a virtual hub via a virtual network connection. Transit connectivity between the VNets in Standard Virtual WAN is enabled due to the presence of a router in every virtual hub. This router is instantiated when the virtual hub is first created.

Display the routing status by going to the **Virtual Hub** page in the Azure portal. The router can be in one of four states:

- **Provisioned** – indicates that the virtual hub has been successfully instantiated.

- **Provisioning** – indicates that the virtual hub is in the process of being provisioned.

- **None** – indicates that the virtual hub wasn't able to create the router. This can happen if the virtual WAN is of Basic type, or if the virtual hub was deployed before the service was made available.

- **Failed** – indicates failure during instantiation. To reset the router, go to the virtual hub **Overview** page locate and select the **Reset Router** option. Resetting is a way to bring failed resources such as route tables, the hub router, or the virtual hub resource back to the provisioning state. 

Each virtual hub router supports an aggregate throughput up to 50Gbps.

Connectivity between the virtual network connections assumes a maximum total of 2000 VM workload across all VNets connected to a single virtual hub. However, this limit can be increased at additional cost.

## Troubleshoot transit routing

Connectivity between VNets in a virtual WAN is through a virtual hub, which connects the virtual networks. In a Standard Virtual WAN, each virtual hub has a router that is instantiated when the virtual hub is created.

This router can be in one of four states:

- Provisioned.

- Provisioning.

- Failed – the router failed during instantiation. Use the Reset Router option on the virtual hub Overview page in the Azure portal.

- None – the router has not been provisioned, for example if the virtual WAN is of Basic type, or if the virtual hub was deployed before the service was available.

You can  view the Routing status, on the Virtual Hub page, in the Azure portal.

Every virtual hub router supports an aggregate throughput up to 50Gbps.

## Troubleshoot secured virtual hubs

A **secured virtual hub** is different from a virtual hub because it has security and routing policies configured by Azure Firewall Manager. Secured virtual hubs are used to create hub-and-spoke and transitive architectures with inbuilt security.

You use a secured virtual hub to provide automated routing to filter traffic between:

- Virtual networks (V2V).

- Virtual networks and branch offices (B2V).

- Traffic to the internet (B2I/V2I).

You don't need to configure user-defined routes (UDRs) to route traffic through your firewall.

Secured virtual hubs can either be created as secured virtual hubs or converted from an existing virtual hub.

When you troubleshoot issues with secured virtual hubs, be aware of the following limitations:

- A secured hub doesn't support branch-to-branch (B2B) filtering and filtering across multiple hubs. 

- You cannot configure more than one secured hub per Azure region.

- Local policies must be created in the same region as the base policy. However, a policy that was created in one region can be applied to a secured hub in another region.

- Communication filtering between secured virtual hubs isn't supported. However, hub-to-hub communication still works if private traffic filtering via Azure Firewall isn't enabled.

- Secured virtual hubs sharing the same virtual WAN must be in the same resource group.

- The secure hub firewall goes into a failed state if you add multiple public IP addresses.

- DDoS Protection isn't supported with secured virtual hubs.

- Activity logs are not fully supported.

