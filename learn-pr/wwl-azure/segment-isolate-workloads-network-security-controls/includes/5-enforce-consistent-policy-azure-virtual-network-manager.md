Network security groups (NSGs) and application security groups work well within a single virtual network. However, they don't prevent application teams with Owner permissions from creating rules that violate organization-wide security policies. At Contoso, several teams created NSG rules allowing RDP from the internet—a configuration the security policy explicitly prohibits. Here, you learn how Azure Virtual Network Manager enforces security policies across subscriptions so no team can override critical security controls.

| Configuration step | Action |
|-------------------|--------|
| Define AVNM scope | Select management groups or subscriptions to govern |
| Create network group | Add VNets manually or using Azure Policy conditions |
| Build security admin rule | Define Allow, Always Allow, or Deny traffic rules |
| Deploy configuration | Push rules to network group regions |

## The multi-subscription enforcement gap

NSGs and application security groups operate within the boundaries of a single virtual network and subscription. When application teams have Owner-level permissions on their own subscriptions, they can create NSG rules that contradict your organization's security policy. Azure Policy can restrict NSG rule creation by denying rules that match certain patterns, but it operates on resource creation events, not on the effective network posture in real time.

**Azure Virtual Network Manager (AVNM)** addresses this gap directly. AVNM lets you define network policy at the organization or management group level and push it to virtual networks across subscriptions. Unlike NSGs, which any resource owner can modify, AVNM configurations require centralized administrative permissions and override local network rules.

This enforcement model solves a critical security engineering challenge: ensuring that baseline security controls remain in place even when distributed teams manage their own infrastructure.

## How Azure Virtual Network Manager works

Azure Virtual Network Manager introduces four foundational concepts that enable centralized network governance.

**AVNM scope** defines which management groups or subscriptions the AVNM instance manages. An AVNM instance deployed at the management group level can govern all child subscriptions, giving you organization-wide control without deploying separate instances per subscription.

**Network groups** are logical collections of virtual networks managed by AVNM. You add virtual networks (VNets) to a network group either manually or using Azure Policy conditional expressions. Think of network groups as application security groups for virtual networks—they let you target policies at sets of networks rather than configuring each virtual network individually.

**Configurations** define what you apply to a network group. AVNM supports two configuration types: connectivity configurations create hub-spoke or mesh topologies, while security admin configurations enforce traffic rules. For security engineering, security admin configurations are the critical tool.

**Security admin rules** are rules in a security admin configuration that apply before any NSG rules are evaluated. They can Allow, Always Allow, or Deny traffic, regardless of what NSG rules exist on the affected resources. This evaluation order is what gives AVNM its enforcement power.

## Security admin rules vs. NSG rules

Understanding the difference between security admin rules and NSG rules is essential for effective network security design.

| Property | NSG rule | Security admin rule |
|----------|----------|---------------------|
| Scope | Single NSG (subnet or NIC) | Network group (all VNets in scope) |
| Who can create | Resource Owner or Network Contributor | AVNM admin (centralized) |
| Can teams override it? | Yes—anyone with NSG write permissions | No—admin rules take precedence |
| Action types | Allow, Deny | Allow, Always Allow, Deny |
| Evaluated | After admin rules | Before NSG rules |

The security consequence of this design is powerful: a security admin rule with the **Deny** action on port 3389 from the Internet service tag blocks all inbound RDP from the internet on every virtual network in the network group, even if a team has an NSG Allow rule on port 3389. The admin rule wins.

With **Always Allow** rules, required management traffic always reaches its destination, preventing teams from accidentally blocking critical services with overly restrictive NSGs. This bidirectional control—enforcing both minimum and maximum security baselines—makes AVNM unique among Azure networking services.

The evaluation order matters in traffic flow decisions. Azure evaluates security admin rules first, then subnet NSGs, then NIC NSGs. If a security admin rule makes a definitive Allow or Deny decision, NSG rules are effectively bypassed for that traffic.

## Create a network group and security admin rule

Creating your first security admin rule involves six portal steps that build from scope definition to rule deployment.

1. **Create an AVNM instance**: In the Azure portal, search for "Network Manager" and select **Create**. Choose your scope (management group or subscription), provide a name like `avnm-contoso-security`, and select the **Security admin** feature under network manager features. Connectivity features are optional for security-focused deployments.

2. **Create a network group**: In your AVNM instance, navigate to **Network groups** and select **Create**. Name it `ng-production-vnets` and add VNets from the relevant subscriptions manually. For production deployments, configure Azure Policy-based dynamic membership to automatically include VNets tagged with `environment:production`.

3. **Create a security admin configuration**: Navigate to **Configurations** > **Security admin** and select **Create**. Name it `sec-config-baseline` to indicate this configuration contains your baseline security controls.

4. **Add a rule collection**: Within the security admin configuration, select **Add a rule collection**. Name it `rule-collection-block-management-ports`. Rule collections let you group related rules for easier management.

5. **Add a security admin rule**: In the rule collection, select **Add** and configure the rule:
   - **Name**: `deny-rdp-from-internet`
   - **Priority**: 100 (lower numbers are evaluated first)
   - **Protocol**: TCP
   - **Source**: Service tag `Internet`
   - **Source port**: Any (*)
   - **Destination**: Any
   - **Destination port**: 3389
   - **Action**: Deny

6. **Deploy the configuration**: After creating the rule, select **Deployments** in the AVNM instance. Select the security admin configuration and choose the regions where your network group has VNets. Confirm the deployment.

> [!IMPORTANT]
> Deploying a security admin rule is a network-wide change that takes effect immediately on all VNets in the network group. Test configurations in a nonproduction network group before deploying to production VNets. Changes to security admin configurations don't take effect until you explicitly deploy them.

The deployment process typically completes within a few minutes, but the timing depends on the number of VNets in your network group and their geographic distribution.

## When to use AVNM security admin rules

Security admin rules are most effective when you have organization-wide security requirements that must apply regardless of team-specific configurations.

**Block dangerous ports organization-wide**: Use **Deny** rules to block RDP from the internet (port 3389), SSH from the internet (port 22), and unencrypted management protocols. Setting these at the AVNM level ensures no team can accidentally or intentionally create exceptions that expose management interfaces to public networks.

**Always Allow for required management traffic**: If your organization uses Azure Bastion for management access, create an **Always Allow** rule for Bastion subnet traffic so teams can't accidentally block management connectivity with their own NSGs. This pattern also works for centralized monitoring agents, backup services, and other infrastructure services that must reach all workloads.

**Standard port enforcement**: If your organization has a policy that all internal services communicate on specific approved ports only, security admin rules enforce that requirement at the platform level. Teams can still create NSG rules for application-specific traffic, but the baseline port policy remains immutable.

Security admin rules and NSG rules are now in place across Contoso's environment. But how do you verify that the combined effect of admin rules, subnet NSGs, and NIC NSGs actually produces the security posture you intended? In the next unit, you use Azure Network Watcher to evaluate the effective security rules on your resources and confirm that segmentation controls are working as designed.
