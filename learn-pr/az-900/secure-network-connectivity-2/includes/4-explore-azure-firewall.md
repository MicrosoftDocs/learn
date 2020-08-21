A **Firewall** is a service that grants access based on the originating IP address of each request. You can create firewall rules that specify ranges of IP addresses. Only clients granted IP addresses from within those ranges will be allowed to access the destination server. Firewall rules can also include specific network protocol and port information.

![Azure Firewall icon.](../media/icon-firewall.png)

[Azure Firewall](https://azure.microsoft.com/services/azure-firewall?azure-portal=true) is a managed, cloud-based, network security service that protects resources in your Azure Virtual Networks. It is a *fully stateful* firewall (meaning it analyzes the complete context of a network connection, not just an individual packet of network traffic) provided by Microsoft as a service with built-in high availability and unrestricted cloud scalability.

You can centrally create, enforce, and log, application and network connectivity policies across subscriptions, and virtual networks. Azure Firewall uses a static (unchanging) public IP address for your virtual network resources, which allows outside firewalls to identify traffic coming from your virtual network. The service is fully integrated with Azure Monitor for logging and analytics.

Azure Firewall provides many features, including:

- Built-in high availability.
- Unrestricted cloud scalability.
- Inbound and outbound filtering rules.
- Azure Monitor logging.


### Common usage scenarios
<div style="background:yellow;">
TODO: Add TWT scenario.
</div>

You typically deploy Azure Firewall on a central virtual network to control general network access. With Azure Firewall you can configure:

- Application rules that define fully qualified domain names (FQDNs) that can be accessed from a subnet.
- Network rules that define source address, protocol, destination port, and destination address.

[Azure Application Gateway](https://azure.microsoft.com/services/application-gateway?azure-portal=true) also provides a firewall, called the **Web Application Firewall** (WAF). WAF provides centralized, inbound protection for your web applications against common exploits and vulnerabilities. 