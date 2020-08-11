A **Firewall** is a service that grants server access based on the originating IP address of each request. You create firewall rules that specify ranges of IP addresses. Only clients from these granted IP addresses will be allowed to access the server. Firewall rules also include specific network protocol and port information.

![Azure Firewall icon.](../media/icon-firewall.png)

[Azure Firewall](https://azure.microsoft.com/services/azure-firewall?azure-portal=true) is a managed, cloud-based, network security service that protects your Azure Virtual Network resources. It is a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability.

You can create, enforce, and log, application and network connectivity policies across subscriptions, and virtual networks, centrally. Azure Firewall uses a static public IP address for your virtual network resources, which allows outside firewalls to identify traffic originating from your virtual network. The service is fully integrated with Azure Monitor for logging and analytics.

Azure Firewall provides many features, including:

- Built-in high availability.
- Unrestricted cloud scalability.
- Inbound and outbound filtering rules.
- Azure Monitor logging.


### Common usage scenarios

You typically deploy Azure Firewall on a central virtual network to control general network access. With Azure Firewall you can configure:

- Application rules that define fully qualified domain names (FQDNs) that can be accessed from a subnet.
- Network rules that define source address, protocol, destination port, and destination address.

> [!div class="checklist"]
> - [Azure Application Gateway](https://azure.microsoft.com/services/application-gateway?azure-portal=true) also provides a firewall, called the [**Web Application Firewall** (WAF)](https://azure.microsoft.com/services/web-application-firewall/). WAF provides centralized, inbound protection for your web applications against common exploits and vulnerabilities. 
