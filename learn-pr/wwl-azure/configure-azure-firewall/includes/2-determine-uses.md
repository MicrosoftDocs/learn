Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability. You can centrally create, enforce, and log application and network connectivity policies across subscriptions and virtual networks.

Azure Firewall uses a static public IP address for your virtual network resources allowing outside firewalls to identify traffic originating from your virtual network. The service is fully integrated with Azure Monitor for logging and analytics.

:::image type="content" source="../media/firewall-threat-8a2c65f9.png" alt-text="Two spoke vnets are shown using the Firewall to control network traffic.":::


## Azure Firewall features

 -  **Built-in high availability**. High availability is built in, so additional load balancers aren't required. There's nothing you need to configure.
 -  **Availability Zones**. Azure Firewall can be configured during deployment to span multiple Availability Zones for increased availability.
 -  **Unrestricted cloud scalability**. Azure Firewall can scale up as much as you need to accommodate changing network traffic flows, so you don't need to budget for your peak traffic.
 -  **Application FQDN filtering rules**. You can limit outbound HTTP/S traffic or Azure SQL traffic to a specified list of fully qualified domain names (FQDN) including wild cards.
 -  **Network traffic filtering rules**. You can centrally create allow or deny network filtering rules by source and destination IP address, port, and protocol. Azure Firewall is fully stateful, so it can distinguish legitimate packets for different types of connections. Rules are enforced and logged across multiple subscriptions and virtual networks.
 -  **Threat intelligence**. Threat intelligence-based filtering can be enabled for your firewall to alert and deny traffic from/to known malicious IP addresses and domains. The IP addresses and domains are sourced from the Microsoft Threat Intelligence feed.
 -  **Multiple public IP addresses**. You can associate multiple public IP addresses with your firewall.
