
Azure Firewall is a managed, cloud-based network security service that provides threat protection for your cloud workloads and resources running in Azure. 

You can deploy Azure Firewall on any virtual network but the best approach is to use it on a centralized virtual network. All your other virtual and on-premises networks will then route through it. The advantage of this model is the ability to centrally exert control of network traffic for all your VNets across different subscriptions.

:::image type="content" source="../media/2-azure-firewall.png" alt-text="Diagram showing how Azure Firewall is running on a centralized virtual network can protect both cloud-based VNets and your on-premises network.":::

With Azure Firewall, you can scale up the usage to accommodate changing network traffic flows, so you don't need to budget for peak traffic. Network traffic is subjected to the configured firewall rules when you route it to the firewall as the subnet default gateway.

### Key features of Azure Firewall

Azure Firewall is offered in three SKUs: Standard, Premium, and Basic.  The list that follows provides a list of some of the key features that are included across all Azure Firewall SKUs.

- **Built-in high availability and availability zones**: High availability is built in so there's nothing to configure. Also, Azure Firewall can be configured to span multiple availability zones for increased availability.
- **Network and application level filtering**: Use IP address, port, and protocol to support fully qualified domain name filtering for outbound HTTP(s) traffic and network filtering controls.
- **Outbound SNAT and inbound DNAT to communicate with internet resources**: Translate the private IP address of network resources to an Azure public IP address (source network address translation or SNAT) to identify and allow traffic originating from the virtual network to internet destinations. Similarly, inbound internet traffic to the firewall public IP address is translated (Destination Network Address Translation or DNAT) and filtered to the private IP addresses of resources on the virtual network.
- **Multiple public IP addresses**: These addresses can be associated with Azure Firewall.
- **Threat intelligence**: Threat intelligence-based filtering can be enabled for your firewall to alert and deny traffic from/to known malicious IP addresses and domains.
- **Integration with Azure Monitor**: Integrated with Azure Monitor to enable collecting, analyzing, and acting on telemetry from Azure Firewall logs.

Detailed information of the features included for each of the available SKUs (standard, premium, and basic) is provided in the Learn more section in the summary and resources unit.
