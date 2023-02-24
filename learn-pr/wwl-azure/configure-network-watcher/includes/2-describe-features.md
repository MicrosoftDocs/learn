Azure Network Watcher provides tools to monitor, diagnose, view metrics, and enable or disable logs for resources in an Azure virtual network. Network Watcher is a regional service that enables you to monitor and diagnose conditions at a network scenario level.

:::image type="content" source="../media/network-watcher-861659e0.png" alt-text="Screenshot of the Network Watcher Get Started page in the Azure portal." border="false":::

### Things to know about Network Watcher

Let's review some of the prominent features of Network Watcher.

| Feature | Description | Scenarios |
| --- | --- | --- |
| **IP flow verify** | Quickly diagnose connectivity issues from or to the internet, and from or to your on-premises environment. | _Identify if a security rule blocks ingress or egress traffic to or from a virtual machine_ <br><br> _Troubleshoot issues to determine if other exploration is required_ |
| **Next hop** | View the next connection point (or _next hop_) in your network route, and analyze your network routing configuration. | _Determine if there's a next hop, and view the next hop target, type, and route table_ <br><br> _Confirm traffic reaches an intended target destination_ |
| **VPN troubleshoot** | Diagnose and troubleshoot the health of your virtual network gateway or connection with gathered data. View connection statistics, CPU and memory information, IKE security errors, packet drops, and buffers and events. | _View summary diagnostics in the Azure portal_ <br><br> _Review detailed diagnostics in generated log files stored in your Azure storage account_ <br><br> _Simultaneously troubleshoot multiple gateways or connections_ |
| **NSG diagnostics** | Use flow logs to map IP traffic through a network security group (NSG) and gather diagnostic data. A common implementation for NSG flow logs is to meet security compliance regulations and auditing requirements. | _Define prescriptive NSG rules for your organization, and conduct periodic compliance audits_ <br><br> _Compare your prescriptive NSG rules against the effective rules for each virtual machine in your network_ |
| **Connection troubleshoot** | Azure Network Watcher Connection Troubleshoot is a more recent addition to the Network Watcher suite of networking tools and capabilities. Check a direct TCP or ICMP connection from a virtual machine, application gateway, or Azure Bastion host to a virtual machine, fully qualified domain name (FQDN), URI, or IPv4 address.| _Troubleshoot your network performance and connectivity issues in Azure_ <br><br> _Troubleshoot connection issues for a virtual machine, application gateway, or Azure Bastion host_ |

> [!NOTE]
> To use Network Watcher, you must be an Owner, Contributor, or Network Contributor. If you create a custom role, the role must be able to read, write, and delete the Network Watcher service.

### Things to consider when using Network Watcher

Azure Network Watcher supports many Azure monitoring tasks and scenarios. As you review these features, think about how Network Watcher can support your Azure monitoring requirements.

- **Consider remote monitoring**. Automate remote network monitoring with packet capture. You can monitor and diagnose networking issues without logging in to your virtual machines.

- **Consider alert notifications**. Set alerts to trigger packet capture, and access real-time performance information at the packet level. When you observe an issue, you can investigate in detail for better diagnoses.

- **Consider NSG flow log diagnosis**. Use NSG flow logs to gain insight into your network traffic. Build a deeper understanding of your network traffic pattern by using NSG flow logs. Information provided by flow logs helps you gather data for compliance, auditing, and monitoring your network security profile.

- **Consider log analysis**. Diagnose your most common Azure VPN Gateway and connections issues. You can identify issues and use the generated detailed logs to assist your analysis.