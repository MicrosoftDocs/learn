In this module, you explored how Azure Firewall provides centralized network security that goes beyond what network security groups can offer. You determined when Azure Firewall is necessary—when you need FQDN filtering, threat intelligence, Transport Layer Security (TLS) inspection, IDPS, or URL filtering. These capabilities protect against five threat classes that Network Security Groups (NSGs) can't address.

You configured Azure Firewall using Firewall Policy, defining DNAT rules to publish internal services, network rule collections for IP-based filtering, and application rule collections with FQDN filtering. You enabled threat intelligence in Alert and deny mode to block traffic to and from known malicious IP addresses and domains. You also configured DNS proxy, which allows Azure Firewall to resolve FQDNs in application rules.

For Contoso, this architecture fulfills the CISO's mandate. All internet-bound traffic from Azure AI agents now passes through Azure Firewall, which enforces application rules limiting access to approved Azure OpenAI endpoints. East-west traffic between spokes routes through the firewall in the hub. Branch offices in each region connect through Secured Virtual Hubs with integrated Azure Firewall, ensuring consistent inspection policies across the global network.

> [!NOTE]
> Azure Firewall controls outbound and east-west traffic. For protecting inbound HTTP/S web application traffic from OWASP threats, use Azure Web Application Firewall on Application Gateway or Azure Front Door.

Now that network traffic is segmented and centrally inspected, the next module addresses remote and hybrid connectivity—hardening VPN gateways and replacing broad VPN access with Microsoft Entra Private Access.

## Learn more

- [Azure Firewall overview](/azure/firewall/overview)
- [Azure Firewall rule processing](/azure/firewall/rule-processing)
- [Azure Firewall Policy overview](/azure/firewall-manager/policy-overview)
- [Secured Virtual Hub](/azure/firewall-manager/secured-virtual-hub)
- [Routing intent configuration](/azure/firewall-manager/how-to-configure-routing-intent-portal)
