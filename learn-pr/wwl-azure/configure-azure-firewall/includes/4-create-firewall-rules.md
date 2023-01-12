By default, Azure Firewall denies all traffic through your virtual network. The purpose of the default behavior is to provide the highest level of protection against malicious or unknown access. To allow traffic for a particular resource or service, you need to define rules to control the specific traffic.

There are three kinds of rules you can configure for Azure Firewall: NAT, network, and application. The rules are defined in the Azure portal.

#### How rules are processed by Azure Firewall

When a packet arrives on a designated port in your network, the packet is inspected to determine if it's allowed. Azure Firewall processes the packet by evaluating it against your rules in the following order:

1. Network rules
1. Application rules (for the network and applications)

If a rule is found that allows the packet through, no remaining network or application rules are checked against the packet.

After a packet is allowed, Azure Firewall checks for NAT rules that define how to route the allowed traffic.

Suppose you define five network rules and five application rules. A packet arrives on port 80 and inspection begins. Azure Firewall progresses through your rule sets. After the five network rules are processed, Azure Firewall continues to deny the packet. After three application rules are processed, Azure Firewall discovers a rule to allow the packet. Azure Firewall then checks the NAT rules for information about how to route the traffic. The packet data is routed into and through your network according to the rule definitions. Azure Firewall doesn't process the remaining two application rules for the packet because the packet is already allowed.

### Things to know about NAT rules

You can configure NAT or Azure Firewall destination network address translation (DNAT) rules to translate and filter inbound traffic to your subnets. Each rule in your NAT rule collection is used to translate your firewall public IP and port to a private IP and port. A NAT rule that routes traffic must be accompanied by a matching network rule to allow the traffic.

Scenarios where NAT rules can be helpful are publishing SSH, RDP, or non-HTTP/S applications to the internet. 

The configuration settings for a NAT rule include:

- **Name**: Provide a label for the rule.
- **Protocol**: Choose the TCP or UDP protocol.
- **Source Address**: Identify the address as \* (internet), a specific internet address, or a classless inter-domain routing (CIDR) block.
- **Destination Address**: Specify the external address of the firewall for the rule to inspect.
- **Destination Ports**: Provide the TCP or UDP ports that the rule listens to on the external IP address of the firewall.
- **Translated Address**: Specify the IP address of the service (virtual machine, internal load balancer, and so on) that privately hosts or presents the service.
- **Translated Port**: Identify the port that the inbound traffic is routed to by Azure Firewall.

### Things to know about Network rules

Any non-HTTP/S traffic that's allowed to flow through your firewall must have a network rule. Consider a scenario where resources in one subnet must communicate with resources in another subnet. In this case, you can configure a network rule from the source to the destination. 

A network rule has the following configuration settings:

- **Name**: Provide a friendly label for the rule.
- **Protocol**: Choose the protocol for the rule, including TCP, UDP, ICMP (ping and traceroute), or Any.
- **Source Address**: Identify the address or CIDR block of the source.
- **Destination Addresses**: Specify the addresses or CIDR blocks of the destination(s).
- **Destination Ports**: Provide the destination port of the traffic.

### Things to know about Application rules

Application rules define fully qualified domain names (FQDNs) that can be accessed from a subnet. An example is when you need to allow Windows Update network traffic through the firewall.

Here are the configuration settings for an application rule:

- **Name**: Provide a friendly label for the rule.
- **Source Addresses**: Identify the IP address of the source.
- **Protocol:Port**: Specify `HTTP` or `HTTPS` and the port that the web server is listening on.
- **Target FQDNs**: Provide the domain name of the service, such as `www.contoso.com`. Wildcards (\*) can be used. An FQDN tag represents a group of FQDNs associated with well known Microsoft services. Example FQDN tags include `Windows Update`, `App Service Environment`, and `Azure Backup`.