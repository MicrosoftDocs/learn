Making adjustments to server configuration is commonly performed with equipment in your on-premises environment. In this sense, you can consider Azure VMs to be an extension of that environment. You can alter configuration, manage networks, open or block traffic, and more through the Azure portal, the Azure CLI, or Azure PowerShell tools.

We've got our server running, and Apache is installed and serving up pages. Our security team mandates that we lock down all our servers, and we've not done anything to this VM yet. We didn't do anything, and it let Apache listen on port 80. Let's explore the Azure network configuration to see how to use the built-in security support to harden our server.

## Opening ports in Azure VMs

By default, new VMs are locked down. 

Apps can make outgoing requests, but the only inbound traffic allowed is from the virtual network (e.g., other resources on the same local network) and from Azure Load Balancer (probe checks).

There are two steps to adjusting the configuration to support different protocols on the network. When you create a new VM, you have an opportunity to open a few common ports (RDP, HTTP, HTTPS, and SSH). However, if you require other changes to the firewall, you will need to adjust them manually.

The process for this involves two steps:

1. Create a network security group.
2. Create an inbound rule allowing traffic on the ports you need.

### What is a network security group?

Virtual networks (VNets) are the foundation of the Azure networking model and provide isolation and protection. Network security groups (NSGs) are the primary tool you use to enforce and control network traffic rules at the networking level. NSGs are an optional security layer that provides a software firewall by filtering inbound and outbound traffic on the VNet. 

Security groups can be associated to a network interface (for per host rules), a subnet in the virtual network (to apply to multiple resources), or both levels. 

#### Security group rules

NGSs use _rules_ to allow or deny traffic moving through the network. Each rule identifies the source and destination address (or range), protocol, port (or range), direction (inbound or outbound), a numeric priority, and whether to allow or deny the traffic that matches the rule.

![An illustration showing the architecture of network security groups in two different subnets. In one subnet, there are two virtual machines, each with their own network interface rules.  The subnet itself has a set of rules that applies to both the virtual machines. ](../media/7-nsg-rules.png)

Each security group has a set of default security rules to apply the default network rules described above. These default rules cannot be modified but _can_ be overridden.

#### How Azure uses network rules

For inbound traffic, Azure processes the security group associated to the subnet and then the security group applied to the network interface. Outbound traffic is handled in the opposite order (the network interface first, followed by the subnet).

> [!WARNING]  
> Keep in mind that security groups are optional at both levels. If no security group is applied, then **all traffic is allowed** by Azure. If the VM has a public IP, this could be a serious risk, particularly if the OS doesn't provide a built-in firewall.

The rules are evaluated in _priority order_, starting with the **lowest priority** rule. Deny rules always **stop** the evaluation. For example, if a network interface rule blocks an outbound request, any rules applied to the subnet will not be checked. For traffic to be allowed through the security group, it must pass through _all_ applied groups.

The last rule is always a **Deny All** rule. This is a default rule added to every security group for both inbound and outbound traffic with a priority of 65500. That means to have traffic pass through the security group, _you must have an allow rule_, or the final default rule will block it.

> [!NOTE]  
> SMTP (port 25) is a special case. Depending on your subscription level and when your account was created, outbound SMTP traffic may be blocked. You can request to remove this restriction with business justification.

Since we didn't create a security group for this VM, let's do that and apply it.

## Creating network security groups

Security groups are managed resources like most everything in Azure; you can create them in the Azure portal or through command-line scripting tools. The challenge is in defining the rules. Let's look at defining a new rule to allow HTTP access and block everything else.