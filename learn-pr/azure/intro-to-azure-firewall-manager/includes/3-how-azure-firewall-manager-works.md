In this unit, we discuss how Firewall Manager works and what tasks you can accomplish by using it. We also examine how firewall policy rules work. As previously described, a policy is the fundamental building block of Firewall Manager. You create policies and associate them with Azure Firewall instances in secured virtual hubs or hub virtual networks.

The following diagram shows a typical configuration. It includes an enterprise administrator who's creating and associating policies at the top level. These policies are associated with both a secured virtual hub and two hub virtual networks. A local admin can also configure and associate policies with one of the hub virtual networks.

:::image type="content" source="../media/policy-overview.png" alt-text="Diagram that shows enterprise and local administrators managing policies for a secured virtual hub and two hub virtual networks.":::


Azure Firewall policies consist of rules and settings that control traffic in protected resources. In this unit, you learn about:

- Azure Firewall policies, rules, and threat intelligence settings.
- Rule processing.
- Tasks you can perform with Firewall Manager.

## What are Azure Firewall policy rules?

The following table describes the Azure Firewall policy rule collections and settings.

| Rule collection or setting   | Description    |
| ---------------------------- | ------------------------------------------------------------ |
| Threat Intelligence Settings | Alerts on traffic to or from known malicious IP addresses and domains. Azure Firewall Basic supports alert-only threat intelligence; Standard and Premium also support alert-and-deny. |
| NAT rule collection | Configures destination network address translation (DNAT). A matching DNAT rule translates the destination address and port and implicitly allows the translated traffic. |
| Network rule collection | Filters traffic by source and destination IP address, port, and protocol. Network rules can match HTTP/S connections as well as other traffic. |
| Application rule collection | Filters supported outbound and east-west HTTP, HTTPS, and MSSQL traffic using application-level criteria such as fully qualified domain names (FQDNs). SQL FQDN filtering requires proxy-mode connectivity. |

First you must decide which rules you need to manage your traffic. Then you use Firewall Manager to create and configure Azure Firewall policies containing these rules, as the following graphic depicts.

:::image type="content" source="../media/threat-intelligence.png" alt-text="Screenshot of Azure Firewall Policy threat intelligence settings in the Azure portal, with Alert Only selected." lightbox="../media/threat-intelligence.png":::

### How rules are processed

Azure Firewall evaluates configured rule types in this order: DNAT, network, and application rules. DNAT performs destination address and port translation and implicitly allows matching translated traffic; it isn't simply a routing rule. The following steps describe the full evaluation sequence:

1. If threat intelligence-based filtering is enabled, Azure Firewall evaluates it before DNAT, network, and application rules. Alert-only mode records an alert without blocking the connection through threat intelligence. Alert-and-deny can block matching traffic before configured rules are evaluated.

   Alert-only is the default threat-intelligence mode. Azure Firewall Basic supports alert-only threat intelligence; alert-and-deny requires Standard or Premium. This restriction doesn't prevent Basic from denying traffic through ordinary network rules.

1. Azure Firewall evaluates DNAT rules. A match translates the destination address and port and implicitly allows the translated traffic. That traffic isn't evaluated against subsequent network rules. Azure Firewall application rules don't filter inbound connections.

   > [!IMPORTANT]
   > Restrict DNAT source addresses to the clients that require access. Don't rely on a later network or application rule to narrow a DNAT allow. Use a Web Application Firewall when you require application-layer protection for inbound HTTP/S traffic.

1. If no DNAT rule matches, Azure Firewall evaluates network rules. These rules can match HTTP/S connections as well as other traffic. A network-rule match applies its allow or deny action and ends further network/application-rule evaluation.
1. If no network rule matches, Azure Firewall evaluates application rules for supported HTTP, HTTPS, and MSSQL traffic. SQL FQDN filtering requires proxy-mode connectivity. For configuration details, see **More info** in the summary unit.
1. If no application rule matches, Azure Firewall evaluates applicable traffic against its built-in infrastructure rule collection.
1. Traffic that hasn't been allowed is denied by default.

> [!NOTE]
> The built-in infrastructure rule collection permits specific Azure platform FQDNs. It's evaluated after application rules and before the final deny-all rule.

Within each rule-type evaluation, inherited parent-policy rule collection groups take precedence over child-policy groups. Rule collection groups and their rule collections are processed from lower numerical priority values to higher values. Priorities and inheritance don't change the DNAT-before-network-before-application order.

A terminating rule match doesn't disable other configured protection. For example, Azure Firewall Premium IDPS in alert-and-deny mode can block a connection that a network or application rule allowed.

For more information, see the rule-processing reference in the summary unit's **More info** section.

## Use Firewall Manager

Firewall Manager enables you to:

- Define rules for traffic filtering across multiple Azure Firewall instances in secured virtual hubs and hub virtual networks.
- Associate an Azure Firewall policy with new or existing virtual networks. This association enforces consistent firewall policies across multiple hub virtual networks.
- Associate an Azure Firewall policy or a Security Partner Provider with new or existing virtual hubs. This association enforces consistent security and routing policies across multiple hubs.
- Associate a Web Application Firewall policy to an application delivery platform (Azure Front Door or Azure Application Gateway).
- Associate your virtual networks with a DDoS protection plan.

The following screenshot shows the firewall and DDoS protection status of existing virtual networks in Firewall Manager.

:::image type="content" source="../media/deploy-firewall.png" alt-text="Screenshot of the Firewall Manager Virtual Networks page, showing firewall and DDoS protection status for two virtual networks." lightbox="../media/deploy-firewall.png":::
