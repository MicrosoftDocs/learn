Here, we'll discuss the working of Firewall Manager and the tasks that you can accomplish by using it. We'll also determine how firewall policy rules work. As described, the fundamental building block of Firewall Manager is the policy. You create policies and associate them with Azure Firewall instances in secured virtual hubs or hub virtual networks.

The following diagram displays a typical configuration. It includes a global administrator who is creating and associating policies at the top level. These policies are associated with both a secured virtual hub, and two hub virtual networks. A local admin is also able to configure and associate policies with one of the hub virtual networks.

:::image type="content" source="../media/policy-overview.png" alt-text="A representative Firewall Manager configuration, as described in the preceding text.":::

Azure Firewall policies consist of rules and settings that control traffic in the protected resources. In this unit, you'll learn about:

- Azure Firewall policies rules and threat intelligence settings.
- Rule processing.
- The tasks you can perform with Firewall Manager.

## What are Azure Firewall policy rules?

The following table describes the Azure Firewall policy rule collections and settings.

| Rule collection or setting   | Description    |
| ---------------------------- | ------------------------------------------------------------ |
| Threat Intelligence Settings | Implement threat intelligence-based filtering in an Azure Firewall policy to alert you about potentially malicious traffic. You can also deny traffic from and to known malicious IP addresses and domains. |
| NAT rule collection          | Enables you to configure Azure Firewall Destination Network Address Translation (DNAT) rules that translate and filter inbound internet traffic to your Azure subnets. |
| Network rule collection      | Manages non-HTTP/S traffic flowing through the firewall.     |
| Application rule collection  | Manages HTTP/S traffic flowing through the firewall.         |

After you've considered the rules you need to manage your traffic, you can use Firewall Manager to create and configure Azure Firewall policies containing these rules, as the following graphic depicts. 

:::image type="content" source="../media/threat-intelligence.png" alt-text="Screenshot of the Threat Intelligence blade in the Azure portal within a Firewall Policy called ContosoFirewallPolicy.":::

### How rules are processed

In reality, a NAT rule is a routing rule that directs traffic from public to private IP addresses in your Azure resources. When a firewall processes the defined rules in a policy, it's the network and application rules that determine whether the traffic is allowed or not . The following process describes how these rules are processed against traffic:

1. Threat intelligence rules are processed before NAT, network, or application rules. When you establish these rules, you an configure one of two behaviors:

   - Alert when rule is triggered (default mode)
   - Alert and deny when rule is triggered

2. Network rules are applied next. If a network rule matches the traffic, that rule is applied, and no further rules are checked.
3. If, however, no network rules match, if the traffic is HTTP/S, then application rules are applied.
4. If no application rule matches, then the traffic is compared with the infrastructure rule collection.
5. Finally, if there's still no match for the traffic, then the traffic is implicitly denied.

> [!NOTE]
> Infrastructure rule collections define FQDNs that are allowed by default. These FQDNs are specific to Azure.

## Use Firewall Manager

You can use Firewall Manager to complete the following tasks:

- Define rules for traffic filtering across multiple Azure Firewall instances in secured virtual hubs and hub virtual networks.
- Associate an Azure Firewall policy with new or existing virtual networks to enforce consistent firewall policies across multiple hub virtual networks.
- Associate an Azure Firewall policy or a Security Partner Provider with new or existing virtual hubs to enforce consistent security and routing policies across multiple hubs.

In the following graphic, an administrator is deploying a Firewall with a Firewall policy for an existing virtual network.

:::image type="content" source="../media/deploy-firewall.png" alt-text="Screenshot of the Virtual networks blade in Firewall Manager. The administrator has selected an existing virtual network.":::
