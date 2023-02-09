Security rules in network security groups enable you to filter network traffic. You can define rules to control the traffic flow in and out of virtual network subnets and network interfaces.

### Things to know about security rules

Let's review the characteristics of security rules in network security groups.

- Azure creates several default security rules within each network security group, including inbound traffic and outbound traffic. Examples of default rules include `DenyAllInbound` traffic and `AllowInternetOutbound` traffic.

- Azure creates the default security rules in each network security group that you create.

- You can add more security rules to a network security group by specifying conditions for any of the following settings:
   - **Name**
   - **Priority**
   - **Port**
   - **Protocol** (Any, TCP, UDP)
   - **Source** (Any, IP addresses, Service tag)
   - **Destination** (Any, IP addresses, Virtual network)
   - **Action** (Allow or Deny)

- Each security rule is assigned a Priority value. All security rules for a network security group are processed in priority order. When a rule has a low Priority value, the rule has a higher priority or precedence in terms of order processing.

- You can't remove the default security rules.

- You can override a default security rule by creating another security rule that has a higher Priority setting for your network security group.

#### Inbound traffic rules

Azure defines three default inbound security rules for your network security group. These rules **deny all inbound traffic** except traffic from your virtual network and Azure load balancers. The following image shows the default inbound security rules for a network security group in the Azure portal.

:::image type="content" source="../media/inbound-rules-a554314b.png" alt-text="Screenshot that shows default inbound security rules for a network security group in the Azure portal.":::

#### Outbound traffic rules

Azure defines three default outbound security rules for your network security group. These rules **only allow outbound traffic** to the internet and your virtual network. The following image shows the default outbound security rules for a network security group in the Azure portal.

:::image type="content" source="../media/outbound-rules-ff90d802.png" alt-text="Screenshot that shows default outbound security rules for a network security group in the Azure portal.":::