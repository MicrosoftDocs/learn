It's easy to add security rules to control inbound and outbound traffic in the Azure portal. You can configure your virtual network security group rule settings, and select from a large variety of communication services, including HTTPS, RDP, FTP, and DNS.

### Things to know about configuring security rules

Let's look at some of the properties you need to specify to create your security rules. As you review these settings, think about the traffic rules you need to create and what services can fulfill your network requirements.

:::image type="content" source="../media/add-network-security-rule-2f306d23.png" alt-text="Screenshot that shows how to configure source and destination settings to create a security rule in the Azure portal.":::

- **Source**: Identifies how the security rule controls **inbound** traffic. The value specifies a specific source IP address range that's allowed or denied. The source filter can be any resource, an IP address range, an application security group, or a default tag. 

- **Destination**: Identifies how the security rule controls **outbound** traffic. The value specifies a specific destination IP address range that's allowed or denied. The destination filter value is similar to the source filter. The value can be any resource, an IP address range, an application security group, or a default tag.

- **Service**: Specifies the destination protocol and port range for the security rule. You can choose a predefined service like RDP or SSH or provide a custom port range. There are a large number of services to select from. 

   :::image type="content" source="../media/security-services.png" alt-text="Screenshot that shows service rule options for a security rule in the Azure portal.":::

- **Priority**: Assigns the priority order value for the security rule. Rules are processed according to the priority order of all rules for a network security group, including a subnet and network interface. The lower the priority value, the higher priority for the rule.

   :::image type="content" source="../media/security-priority.png" alt-text="Screenshot that shows how to set the priority value for a security rule in the Azure portal.":::