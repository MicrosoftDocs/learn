

As an Azure network engineer supporting an ExpressRoute deployment, you have to diagnose and resolve any ExpressRoute connection issues that arise.

At the highest level, there are three main ExpressRoute routing domains. You should consider each area when trying to resolve an issue. 

- The Azure network (blue cloud)
- The Internet or WAN (green cloud)
- The Corporate Network (orange cloud)

:::image type="content" source="../media/network-components.png" alt-text="Diagram of the ExpressRoute routing domains.":::

## Troubleshooting

Given the number of network components, a step-by-step process is more effective than random testing. Ensure your expectations are reasonable. Start at the edge of the network. Create a diagram. Keep an open mind and verify all assumptions. For more suggestions, consult the [troubleshooting reference](/azure/expressroute/expressroute-troubleshooting-network-performance).

### Verify the circuit and provider status

For an ExpressRoute circuit to be operational, the Microsoft **Circuit status** must be **Enabled**. Also, the **Provider status** must be **Provisioned**. 

:::image type="content" source="../media/circuit-provider-status.png" alt-text="Screenshot of the circuit and provider status in the portal. ":::

### Verify the peering 

Each ExpressRoute circuit can have: an Azure private peering, an Azure public peering, and/or a Microsoft peering. For success, the peering status should be **provisioned**. 

:::image type="content" source="../media/peering-status.png" alt-text="Screenshot of the peering status. ":::

### Get support help 

The Azure portal has information on configuring and troubleshooting ExpressRoute connections. The support wizard can identify and provide troubleshooting steps. 

:::image type="content" source="../media/portal-connectivity-issues.png" alt-text="Screenshot of the Azure portal to diagnose and solve problems.":::

When you need assistance from Microsoft or from an ExpressRoute partner, you must provide the ExoressRoute Service Key. The Service Key uniquely identifies your circuit.

> [!TIP]
> Learn more about ExpressRoute troubleshooting in the [Troubleshoot virtual network connectivity in Microsoft Azure](/training/modules/cloud-hybrid-connectivity/) module.