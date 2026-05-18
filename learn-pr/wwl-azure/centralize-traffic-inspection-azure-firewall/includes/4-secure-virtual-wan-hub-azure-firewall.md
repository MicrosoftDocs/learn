Contoso's three regional offices connect to Azure via Virtual WAN site-to-site virtual private network (VPN) connections. Branch virtual machines (VMs) can reach spoke virtual networks (VNets) directly through the Virtual WAN hub, but that traffic is uninspected. The Security Officer's mandate requires all branch-to-cloud and spoke-to-spoke traffic to be inspected by Azure Firewall. Here, you learn how to deploy a **Secured Virtual Hub** and configure routing intent to force all traffic through the firewall for centralized inspection.

| Deployment step | Action |
|-----------------|--------|
| 1. Select Virtual WAN hub | Open Firewall Manager and choose the hub to secure |
| 2. Deploy Azure Firewall | Add Azure Firewall to the hub and associate a Firewall Policy |
| 3. Enable routing intent | Configure private and internet traffic to route through the firewall |
| 4. Verify route propagation | Confirm Virtual WAN updated route tables in connected branches and spokes |

## The Virtual WAN security gap

Azure Virtual WAN provides managed hub connectivity for branches (site-to-site VPN), remote users (point-to-site VPN), and spoke VNets. By default, the Virtual WAN hub routes traffic directly between connected branches and spokes—no inspection in the middle.

A branch VM in Contoso's London office connecting to a spoke VM in the North Europe region transits through the hub router but isn't inspected by any firewall. Lack of inspection creates an unguarded side: lateral movement between branch and cloud workloads is uninspected. The same issue applies to spoke-to-spoke traffic and branch-to-branch traffic—all flows bypass security controls.

The security requirement is clear: all inter-spoke, branch-to-spoke, and internet-bound traffic must pass through an inspection point. Azure Firewall deployed into the Virtual WAN hub solves this problem.

## Secured Virtual Hub architecture and routing intent

A **Secured Virtual Hub** is a Virtual WAN hub with Azure Firewall deployed into it. Deploying Azure Firewall into a Virtual WAN hub converts it to a Secured Virtual Hub. The firewall integrates with Virtual WAN routing to become the next hop for all traffic types when routing intent is enabled.

**Azure Firewall Manager** is the management plane for Secured Virtual Hubs. It applies Firewall Policy to the hub-deployed firewall and configures routing intent. Unlike the hub-spoke virtual network pattern, you don't create an AzureFirewallSubnet manually—the platform manages the subnet automatically when you deploy Azure Firewall into the hub.

### How routing intent works

**Routing intent** is the Virtual WAN feature that specifies which traffic types should route through the Secured Virtual Hub's firewall. You can route two traffic types through the firewall:

- **Private traffic**: branch-to-spoke, spoke-to-spoke, and branch-to-branch traffic
- **Internet traffic**: all internet-bound traffic from branches and spokes

When routing intent is enabled for private traffic, Virtual WAN automatically programs the route tables in all connected branches and spoke VNets to route via the hub firewall. You don't create or update user-defined routes (UDRs) manually—the platform handles route propagation for you.

When routing intent is enabled for internet traffic, all internet-bound flows route through the firewall before egress. You can enable routing intent for one or both traffic types, depending on your security requirements.

## Deploy a Secured Virtual Hub

You deploy a Secured Virtual Hub using Azure Firewall Manager. The process integrates firewall deployment and routing configuration in one workflow.

Routing intent can be configured through either **Azure Firewall Manager** or the **Virtual WAN portal**. Both portals control the same underlying configuration; changes in one are automatically reflected in the other.

Follow these steps to secure a Virtual WAN hub:

1. Open **Azure Firewall Manager** in the portal and select **Virtual hubs**.
2. Select the hub you want to secure (for example, `vwan-hub-northeurope`).
3. Select **Security configuration** and choose **Azure Firewall** as the security provider.
4. Create or select a Firewall Policy to associate with the hub firewall. Reuse the `policy-contoso-security` policy from Unit 3, or create a hub-specific child policy if you need different rules for branch traffic.
5. Select **Review + create** and deploy. Azure deploys Azure Firewall into the hub.
6. After deployment completes, configure routing intent using one of these two portal paths:
   - **Azure Firewall Manager**: return to the hub's **Security configuration** page and set **Private Traffic** and **Internet Traffic** dropdowns to **Azure Firewall**.
   - **Virtual WAN portal**: navigate to the hub, select **Routing** > **Routing Policies**, and set the **Private Traffic** and **Internet Traffic** next hop resources to **Azure Firewall**.
7. Set **Private traffic** to **Azure Firewall** - this routes all branch-to-spoke, spoke-to-spoke, and branch-to-branch traffic through the hub firewall.
8. Set **Internet traffic** to **Azure Firewall** - routes all internet-bound traffic through the hub firewall.
9. Set **Inter-hub** to **Enabled** - ensures routing intent applies across all hubs in multi-hub Virtual WAN deployments, not just the local hub.
10. Select **Save**. Virtual WAN updates route tables in all connected VNets and branches automatically.

> [!IMPORTANT]
> Enabling routing intent on a production hub reroutes all traffic through the firewall immediately. Test with a nonproduction hub first and verify all required traffic is permitted in the Firewall Policy before enabling routing intent in production environments.

After you enable routing intent, all traffic between Contoso's branches and spokes flows through the firewall. The firewall applies the rules in the associated Firewall Policy, including threat intelligence filtering, FQDN allow/deny rules, and network rules. Traffic that matches a deny rule is dropped, and the firewall logs the denied connection attempt for security investigation.

## Hub-spoke virtual network vs. Secured Virtual Hub

As a security engineer, you choose between two Azure Firewall deployment patterns: hub-spoke virtual network with Azure Firewall in a dedicated subnet, or Secured Virtual Hub in a Virtual WAN environment. The decision depends on your connectivity requirements and management preferences.

| Consideration | Hub-spoke virtual network with Azure Firewall | Secured Virtual Hub (Virtual WAN) |
|---------------|-------------------------------------|-----------------------------------|
| Branch (VPN or ExpressRoute) connectivity | Managed separately in VPN Gateway or ExpressRoute Gateway | Native—built into Virtual WAN |
| UDR management | Manual—update spoke UDRs when firewall IP changes | Automatic—routing intent manages route tables |
| Multiple regions | Manual peering and routing | Managed by Virtual WAN |
| Best for | Single-region, VNet-only environments | Multi-region or branch-connected environments |

The security implication: if Contoso has branch offices connecting via VPN or ExpressRoute, Secured Virtual Hub is the better long-term architecture. Virtual WAN handles branch connectivity natively and automates route propagation across all connected resources. If the environment is entirely VNet-to-VNet with no branches, hub-spoke with Azure Firewall in a dedicated subnet is simpler and requires less infrastructure.

Contoso's Virtual WAN traffic, including branch-to-cloud and spoke-to-spoke flows, now routes through Azure Firewall for inspection. The combination of Firewall Policy applied to the Secured Virtual Hub gives Contoso a single place to manage threat intelligence, FQDN filtering, and AI agent egress controls across all their regions and branch offices.
