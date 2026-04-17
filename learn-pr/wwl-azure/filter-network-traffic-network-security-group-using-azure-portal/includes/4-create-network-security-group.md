An Azure network security group filters network traffic between Azure resources in an Azure virtual network. Network security groups contain security rules that allow or deny inbound and outbound network traffic based on **source**, **destination**, **port**, and **protocol**.

## Security rules

A network security group can contain multiple security rules, within Azure subscription limits. Each rule specifies the following properties:

:::image type="content" source="../media/azure-network-security-group-rules-e86bda4a.png" alt-text="Illustration of a table showing network security rule properties and explanations.":::

Security rules are evaluated and applied based on the **five-tuple** information: **source**, **source port**, **destination**, **destination port**, and **protocol**. You can't create two security rules with the same priority and direction.

### Stateful connection tracking

Network Security Groups (NSGs) are stateful. A flow record is created for existing connections, and communication is allowed or denied based on the connection state. This means:

- If you allow outbound traffic on port 80, you don't need an inbound rule for return traffic
- If you allow inbound traffic on a port, you don't need an outbound rule for response traffic

### Rule change behavior

When you modify NSG rules, the changes only affect new connections. Existing connections continue using the rules that were in place when the connection was established and can't be interrupted when you remove a security rule.

### Default security rules

Every NSG includes default rules that can't be deleted but can be overridden with higher-priority custom rules:

**Inbound default rules:**
- **AllowVNetInBound** (Priority 65000): Allows all traffic from resources within the same virtual network
- **AllowAzureLoadBalancerInBound** (Priority 65001): Allows traffic from Azure Load Balancer
- **DenyAllInBound** (Priority 65500): Denies all other inbound traffic

**Outbound default rules:**
- **AllowVNetOutBound** (Priority 65000): Allows all traffic to resources within the same virtual network
- **AllowInternetOutBound** (Priority 65001): Allows all outbound traffic to the internet
- **DenyAllOutBound** (Priority 65500): Denies all other outbound traffic

## How network security groups filter network traffic

You can associate zero or one network security group to each virtual network subnet and network interface. The same NSG can be associated with multiple subnets and network interfaces, enabling consistent security policies across resources.

The diagram illustrates how NSGs might be deployed to **allow network traffic to and from the internet over TCP port 80**:

:::image type="content" source="../media/network-security-group-interaction-6fb53fae.png" alt-text="Diagram showing an example of how network security groups might be deployed to allow network traffic to and from the internet over TCP port 80.":::


> [!NOTE]
> Reference the image, along with the following text, to understand how Azure processes inbound and outbound rules for network security groups:

## Inbound traffic

For inbound traffic, Azure processes the rules in a network security group associated to a subnet first, if there's one, and then the rules in a network security group associated to the network interface, if there's one. This process includes intra-subnet traffic as well.

 -  **VM1**: NSG1 (subnet level) processes rules first. Unless a rule allows port 80 inbound, the DenyAllInBound default rule denies traffic. If NSG1 allows the traffic, NSG2 (NIC level) then processes it. Both NSG1 and NSG2 must allow port 80 for the traffic to reach VM1.
 -  **VM2**: NSG1 processes all traffic since VM2 has no NIC-level NSG. Traffic allowed or denied by NSG1 applies to VM2.
 -  **VM3**: No subnet-level NSG exists for Subnet 2, so traffic enters the subnet. NSG2 (NIC level) then processes the traffic.
 -  **VM4**: All traffic is allowed because no NSG is associated with Subnet 3 or VM4's network interface.

## Outbound traffic

For outbound traffic, Azure processes the rules in a network security group associated to a network interface first, if there's one, and then the rules in a network security group associated to the subnet, if there's one. This process includes intra-subnet traffic as well.

 -  **VM1**: NSG2 (NIC level) processes rules first. The AllowInternetOutBound default rule allows traffic unless you create a deny rule. If NSG2 denies port 80, NSG1 never evaluates the traffic.
 -  **VM2**: Traffic flows from the NIC to the subnet since VM2 has no NIC-level NSG. NSG1 (subnet level) processes the traffic.
 -  **VM3**: If NSG2 denies port 80, traffic is blocked. Otherwise, the AllowInternetOutBound default rule allows the traffic.
 -  **VM4**: All outbound traffic is allowed because no NSG is associated with Subnet 3 or VM4's network interface.

## Intra-Subnet traffic

Security rules in an NSG associated with a subnet can affect connectivity between VMs within that subnet. By default, the AllowVNetInBound rule allows VMs in the same subnet to communicate. If you add a deny rule for all traffic, VMs in the same subnet can't able to communicate with each other.

## Troubleshooting and monitoring

Azure provides tools to help you understand and troubleshoot NSG behavior:

- **Effective security rules**: View the aggregate rules applied to a network interface, showing both subnet level and NIC level NSG rules
- **IP flow verify**: Use Azure Network Watcher to test whether traffic is allowed or denied and identify which security rule is responsible
- **NSG flow logs**: Enable logging to capture information about traffic flowing through NSGs for security analysis and monitoring

> [!NOTE]
> Network security groups are associated to subnets or to virtual machines and cloud services deployed in the classic deployment model. NSGs are aligned with subnets or network interfaces in the Resource Manager deployment model.

> [!TIP]
> Unless you have a specific reason to, we recommend that you associate a network security group to a subnet, or a network interface, but not both. Since rules in a network security group associated to a subnet can conflict with rules in a network security group associated to a network interface, you can have unexpected communication problems that require troubleshooting.
