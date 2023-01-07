Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability. You can centrally create, enforce, and log application and network connectivity policies across subscriptions and virtual networks.

:::image type="content" source="../media/firewall-threat-8a2c65f9.png" alt-text="Diagram that shows two spoke virtual networks using Azure Firewall to control network traffic." border="false":::

### Things to know about Azure Firewall

Let's examine the prominent features and benefits of Azure Firewall. As you review these items, start to think about how Azure Firewall can support your virtual network configuration.

| Feature | Description |
| --- | --- |
| **Public IP address** | Azure Firewall uses a static public IP address for your virtual network resources. External firewalls identify traffic originating from your virtual network by the IP address. <br><br> **Note**: You can associate multiple public IP addresses with your firewall. |
| **Built-in high availability** | With Azure Firewall, you gain built-in high availability without any extra configuration requirements. You don't need to implement other load balancers. |
| **Availability zones** | Configure Azure Firewall during deployment to span multiple availability zones for increased availability. |
| **Unrestricted cloud scalability** | Azure Firewall offers unrestricted cloud scalability to scale as needed to accommodate changing network traffic flows. You don't need to budget for your peak traffic. |
| **Application FQDN filtering rules** | Azure Firewall lets you limit outbound HTTP/S traffic or Azure SQL traffic to a specified list of fully qualified domain names (FQDN) including wild cards. |
| **Network traffic filtering rules** | Create network filtering rules in Azure Firewall to allow or deny traffic by source and destination IP address, port, and protocol. <br> Azure Firewall is fully stateful. The service can distinguish legitimate packets for different types of connections. Rules are enforced and logged across multiple subscriptions and virtual networks. |
| **Threat intelligence** | Azure Firewall supports threat intelligence-based filtering. Configure your firewall to alert and deny traffic from/to known malicious IP addresses and domains. The IP addresses and domains are sourced from the Microsoft Threat Intelligence feed. |
| **Azure Monitor integration** | Azure Firewall is fully integrated with Azure Monitor for logging and analytics. |