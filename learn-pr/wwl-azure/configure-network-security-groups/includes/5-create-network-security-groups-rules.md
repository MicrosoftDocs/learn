It is easy to add inbound and outbound rules. You can select from a large variety of services. These services include HTTPS, RDP, FTP, and DNS.

:::image type="content" source="../media/add-network-security-rule-2f306d23.png" alt-text="Screenshot of the Add inbound security rule page in the Azure portal. The Advanced configuration link is highlighted. Custom services are shown such as HTTP, HTTPS, and SSH.":::


**Service.** Service specifies the destination protocol and port range for this rule. You can choose a predefined service, like HTTPS and SSH. When you select a service, the Port range is automatically completed. Choose custom to provide your own port range.

**Port ranges.** Port ranges can include a single port, a port range, or a comma-separated list of ports. The ports designate the traffic will be allowed or denied by this rule. Provide an asterisk (\*) to allow traffic on any port.

**Priority.** Rules are processed in priority order. The lower the number, the higher the priority. We recommend leaving gaps between rules to make it easier to add new rules. The value is between 100-4096 and unique for all security rules within the network security group.

> [!NOTE]
> Will you need to create rules? Which services will you need to control the network traffic?
