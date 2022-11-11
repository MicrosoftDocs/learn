It's easy to add inbound and outbound rules. You can select from a large variety of services. These services include HTTPS, RDP, FTP, and DNS.

:::image type="content" source="../media/add-network-security-rule-2f306d23.png" alt-text="Screenshot of the Add inbound security rule page in the Azure portal.":::

**Source.** The source filter can be Any, an IP address range, an Application security group, or a default tag. It specifies the incoming traffic from a specific source IP address range that will be allowed or denied by this rule.

**Destination.** The destination filter can be Any, an IP address range, an application security group, or a default tag. It specifies the outgoing traffic for a specific destination IP address range that will be allowed or denied by this rule.

**Service.** The service specifies the destination protocol and port range for this rule. You can choose a predefined service, like RDP or SSH, or provide a custom port range. There are a large number of services to select from. 

:::image type="content" source="../media/security-services.png" alt-text="Screenshot of the service rule selections.":::

**Priority.** Rules are processed in priority order; the lower the number, the higher the priority. We recommend leaving gaps between rules - 100, 200, 300, etc. - so that it's easier to add new rules without having to edit existing rules.

> [!NOTE]
> Will you need to create rules? Which services will you need to control the network traffic?
