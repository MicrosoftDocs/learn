There are three kinds of rules that you can configure in the Azure Firewall. Remember, by default, Azure Firewall blocks all traffic, unless you enable it.

:::image type="content" source="../media/firewall-rules-7485b43c.png" alt-text="Screenshot of the application rule collection.":::


## NAT rules

You can configure Azure Firewall Destination Network Address Translation (DNAT) to translate and filter inbound traffic to your subnets. Each rule in the NAT rule collection is used to translate your firewall public IP and port to a private IP and port. Scenarios where NAT rules might be helpful are publishing SSH, RDP, or non-HTTP/S applications to the Internet. A NAT rule that routes traffic must be accompanied by a matching network rule to allow the traffic. Configuration settings include:

 -  **Name**: A label for the rule.
 -  **Protocol**: TCP or UDP.
 -  **Source Address**: \* (Internet), a specific Internet address, or a CIDR block.
 -  **Destination Address**: The external address of the firewall that the rule will inspect.
 -  **Destination Ports**: The TCP or UDP ports that the rule will listen to on the external IP address of the firewall.
 -  **Translated Address**: The IP address of the service (virtual machine, internal load balancer, and so on) that privately hosts or presents the service.
 -  **Translated Port**: The port that the inbound traffic will be routed to by the Azure Firewall.

## Network rules

Any non-HTTP/S traffic that will be allowed to flow through the firewall must have a network rule. For example, if resources in one subnet must communicate with resources in another subnet, then you would configure a network rule from the source to the destination. Configuration settings include:

 -  **Name**: A friendly label for the rule.
 -  **Protocol**: TCP, UDP, ICMP (ping and traceroute) or Any.
 -  **Source Address**: The address or CIDR block of the source.
 -  **Destination Addresses**: The addresses or CIDR blocks of the destination(s).
 -  **Destination Ports**: The destination port of the traffic.

## Application rules

Application rules define fully qualified domain names (FQDNs) that can be accessed from a subnet. For example, specify the Windows Update network traffic through the firewall. Configuration settings include:

 -  **Name**: A friendly label for the rule.
 -  **Source Addresses**: The IP address of the source.
 -  **Protocol:Port**: HTTP/HTTPS and the port that the web server is listening on.
 -  **Target FQDNs**: The domain name of the service, such as www.contoso.com. Wildcards can be used. An FQDN tag represents a group of FQDNs associated with well known Microsoft services. Example FQDN tags include Windows Update, App Service Environment, and Azure Backup.

## Rule processing

When a packet is being inspected to determine if it is allowed or not, the rules are processed in this order:

1.  Network Rules
2.  Application Rules (network and application)

Once a rule is found that allows the traffic through, no more rules are checked.
