We've installed our custom software, set up an FTP server, and configured the VM to receive our video files. However, if we try to connect to our public IP address with FTP, we'll find that it's blocked. 

Making adjustments to server configuration is commonly performed with equipment in your on-premises environment. In this sense, you can consider Azure VMs to be an extension of that environment. You can make configuration changes, manage networks, open or block traffic, and more through the Azure portal, Azure CLI, or Azure PowerShell tools.

You've already seen some of the basic information and management options in the **Overview** panel for the virtual machine. Let's explore network configuration a bit more.

## Open ports in Azure VMs

By default, new VMs are locked down.

Apps can make outgoing requests, but the only inbound traffic allowed is from the virtual network (for example, other resources on the same local network), and from Azure's Load Balancer (probe checks).

There are two steps to adjusting the configuration to support FTP. When you create a new VM, you have an opportunity to open a few common ports (RDP, HTTP, HTTPS, and SSH). However, if you require other changes to the firewall, you will need to make them yourself.

The process for this involves two steps:

1. Create a Network Security Group.
2. Create an inbound rule allowing traffic on port 20 and 21 for active FTP support.

### What is a Network Security Group?

Virtual networks (VNets) are the foundation of the Azure networking model, and provide isolation and protection. Network Security Groups (NSGs) are the main tool you use to enforce and control network traffic rules at the networking level. NSGs are an optional security layer that provides a software firewall by filtering inbound and outbound traffic on the VNet.

Security groups can be associated to a network interface (for per-host rules), a subnet in the virtual network (to apply to multiple resources), or both levels.

#### Security group rules

NSGs use *rules* to allow or deny traffic moving through the network. Each rule identifies the source and destination address (or range), protocol, port (or range), direction (inbound or outbound), a numeric priority, and whether to allow or deny the traffic that matches the rule. The following illustration shows NSG rules applied at the subnet and network-interface levels.

![Illustration showing the architecture of network security groups in two different subnets. In one subnet, there are two virtual machines, each with their own network interface rules. The subnet itself has a set of rules that applies to both the virtual machines.](../media/7-nsg-rules.png)

Each security group has a set of default security rules to apply the default network rules described in the preceding passage. You can't modify these default rules, but you *can* override them.

#### How Azure uses network rules

For inbound traffic, Azure processes the security group associated to the subnet, then the security group applied to the network interface. Outbound traffic is processed in the opposite order (the network interface first, followed by the subnet).

> [!WARNING]
> Keep in mind that security groups are optional at both levels. If no security group is applied, then **all traffic is allowed** by Azure. If the VM has a public IP, this could be a serious risk, particularly if the OS doesn't provide some sort of firewall.

The rules are evaluated in *priority order*, starting with the **lowest priority** rule. Deny rules always **stop** the evaluation. For example, if an outbound request is blocked by a network interface rule, any rules applied to the subnet will not be checked. In order for traffic to be allowed through the security group, it must pass through *all* applied groups.

The last rule is always a **Deny All** rule. This is a default rule added to every security group for both inbound and outbound traffic with a priority of 65500. That means to have traffic pass through the security group, *you must have an allow rule* or the default final rule will block it. [Learn more about security rules](/azure/virtual-network/network-security-groups-overview#security-rules).

> [!NOTE]
> SMTP (port 25) is a special case. Depending on your subscription level and when your account was created, outbound SMTP traffic might be blocked. You can make a request to remove this restriction with business justification.
