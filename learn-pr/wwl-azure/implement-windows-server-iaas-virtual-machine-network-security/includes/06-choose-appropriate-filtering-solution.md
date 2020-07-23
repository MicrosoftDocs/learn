

A number of traffic filtering solutions are available to help Contoso to manage their network traffic. It's important that IT staff understand which to use, and when. 

## Available filtering options

You can use the following filtering options:

- NAT rules
- Network rules
- Applications rules

> [!NOTE] 
> Microsoft Azure Firewall processes rule collections according to the rule type in priority order, lower numbers to higher numbers from 100 to 65,000. If you enable threat intelligence-based filtering, those rules are highest priority and are always processed first.

The following table describes how Azure Firewall manages the various configured rules to filter inbound and outbound traffic.

|Direction|Rule types| Description|
|----|----|----|
|Outbound connectivity|Network rules and applications rules|If you configure both network rules and application rules, network rules are applied in priority order before application rules. The rules are terminating; If a match is found in a network rule, no other rules are processed. If there is no network rule match, and if the protocol is HTTP, HTTPS, or MSSQL, then the packet is evaluated by the application rules in priority order. If still no match is found, then the packet is evaluated against the infrastructure rule collection. If there is still no match, then the packet is denied by default.|
|Inbound connectivity|Network address translation (NAT) rules|You can enable inbound internet connectivity by configuring Destination Network Address Translation (DNAT). NAT rules are applied in priority before the network rules. If a match is found, an implicit corresponding network rule that allows the translated traffic is added. You can override this behavior by explicitly adding a network rule collection with deny rules that match the translated traffic.|

> [!TIP] 
> Application rules aren't applied for inbound connections. So, if you want to filter inbound HTTP or HTTPS traffic, you should use Web Application Firewall.

## Examples

Consider the following examples.

### Example 1

Contoso's IT department wants to enable access to `Microsoft.com` from users' web browsers. You configure the necessary filtering using network rules and application rules.

#### Create a network rule 


You create a network rule with the properties in the following table.

|Name|Protocol|Source type|Source|Destination type|Destination address|Destination ports|Action|
|----|----|----|----|----|----|----|----|
|Allow-web|Transmission Control Protocol (TCP)|IP address| * |IP address| * |80, 443|Allow|

The connection to `Microsoft.com` is permitted because there is a matching network rule.

#### Address conflicting application rules 


However, you also discover the presence of an existing application rule that denies access to `Microsoft.com`, as indicated in the following table.

|Name|Source type|Source|Protocol:port|Target FQDNs|Action|
|----|----|----|----|----|----|
|Deny-Microsoft|IP address| * |http:80,https:443|`Microsoft.com`|Deny|

#### Result

Despite the existence of the application rule that denies access, the connection to `Microsoft.com` is allowed because the packet matches the Allow-web network rule. Rule processing stops at this point.

### Example 2

Contoso IT's security team is worried about enabling Secure Shell (SSH) traffic to and from VMs. You investigate, and discover two rules. The first allows SSH traffic, the second denies that traffic.

#### Network rule collection 1

- Name: **Allow-collection**
- Priority: **200**
- Action: **Allow**

|Name|Protocol|Source type|Source|Destination type|Destination address|Destination ports|Action|
|----|----|----|----|----|----|----|----|
|Allow-SSH|TCP|IP address| * | IP address | * |22|Allow|

#### Network rule collection 2

- Name: **Deny-collection**
- Priority: **100**
- Action: **Deny**

|Name|Protocol|Source type|Source|Destination type|Destination address|Destination ports|Action|
|----|----|----|----|----|----|----|----|
|Deny-SSH|TCP|IP address| * | IP address | * |22|Deny|

#### Result

The end result is that SSH traffic is denied because a higher priority Deny network rule collection blocks it.
