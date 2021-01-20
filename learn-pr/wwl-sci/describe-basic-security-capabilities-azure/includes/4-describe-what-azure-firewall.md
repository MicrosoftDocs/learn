Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network (VNet) resources from attackers. You can deploy Azure Firewall on any virtual network; however, the best approach is to deploy the firewall on a centralized virtual network. Then have all your other virtual, and on-premises networks route through it. The advantage of this model is the ability to centrally exert control of network traffic across all your VNets across different subscriptions. 

:::image type="content" source="../media/2-azure-firewall.png" alt-text="Diagram showing how Azure Firewall is running on a centralized VNet can protect both cloud-based VNets and your on-premises network.":::

With Azure Firewall, you can scale up the usage to accommodate changing network traffic flows, so you don't need to budget for your peak traffic. Network traffic is subjected to the configured firewall rules when you route your network traffic to the firewall as the subnet default gateway.

## Key features of Azure Firewall

Azure firewall comes with many features, including but not limited to:

- **Built-in high availability and Availability zones:** high availability is built in so there is nothing to configure. Also Azure firewall can be configured to span multiple availability zones for increate availability.
- **Network and application level filtering**: support fully qualified domain name filtering for outbound HTTP(s) traffic and network filtering controls, using IP address, port, and protocol.
- **Outbound SNAT and Inbound DNAT to communicate with internet resources**: translates the private IP address of network resources to an Azure public IP address (source network address translation) to identify and allow traffic originating from the virtual network to internet destinations. Similarly, Inbound Internet traffic to the firewall public IP address is translated (Destination Network Address Translation) and filtered to the private IP addresses of resources on the virtual network.
- **Multiple public IP addresses** can be associated with Azure firewall
- **Threat intelligence:** Threat intelligence-based filtering can be enabled for your firewall to alert and deny traffic from/to known malicious IP addresses and domains.
- **Integration with Azure Monitor:** integrated with Azure Monitor to enable collecting, analyzing, and acting on telemetry from Azure firewall logs.

Use Azure Firewall to help you protect your Azure resources connected to Azure Virtual Networks.
