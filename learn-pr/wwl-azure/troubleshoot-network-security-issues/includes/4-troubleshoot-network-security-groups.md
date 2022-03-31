## Demonstrate an understanding of network security group (NSG) configuration data including ports, service tags, and priority numbers

### Network security groups

An Azure network security group filters network traffic to and from resources in an Azure virtual network. A network security group comprises of security rules that allow or deny inbound and outbound network traffic, to and from, several types of Azure resource. For each rule, you can specify source and destination, port, and protocol.

In this unit, you will learn about:

- Properties of a network security group rule, and the default security rules that are applied.

- The rule properties that you can modify to create an augmented security rule.

### Security rules

A network security group can contain rules from zero, or as many as required, within Azure subscription limits. Each rule specifies the following properties:

| Property| Explanation|
| :--- | :--- |
| Name| A unique name within the network security group.|
| Priority| Rules with lower numbers are processed before higher numbers because lower numbers have higher priority. A number can be between 100 and 4096.|
| Source or destination| If you specify an address for an Azure resource, you must specify the private IP address, a range, a service tag, or application security group assigned to the resource.|
| Protocol| TCP, UDP, ICMP, ESP, AH, or Any.|
| Direction| Whether the rule applies to inbound, or outbound traffic.|
| Port range| Specifying ranges enables you to create fewer security rules. You can specify an individual or range of ports. For example, 80 or 10000-10005.|
| Action| Allow or deny.|

There are limits to the number of security rules you can create in a network security group. For details, see [Azure limits](/azure/azure-resource-manager/management/azure-subscription-service-limits?toc=/azure/virtual-network/toc.json).

### Default security rules

Azure creates the following default rules in each of your network security groups:

**Inbound**

AllowVNetInBound

| Priority| Source| Source ports| Destination| Destination ports| Protocol| Access|
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 65000| VirtualNetwork| 0-65535| VirtualNetwork| 0-65535| Any| Allow|
||||||||

AllowAzureLoadBalancerInBound

| Priority| Source| Source ports| Destination| Destination ports| Protocol| Access|
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 65001| AzureLoadBalancer| 0-65535| 0.0.0.0/0| 0-65535| Any| Allow|
||||||||

DenyAllInbound

| Priority| Source| Source ports| Destination| Destination ports| Protocol| Access|
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 65500| 0.0.0.0/0| 0-65535| 0.0.0.0/0| 0-65535| Any| Allow|
||||||||

**Outbound**

AllowVnetOutBound

| Priority| Source| Source ports| Destination| Destination ports| Protocol| Access|
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 65000| VirtualNetwork| 0-65535| VirtualNetwork| 0-65535| Any| Allow|
||||||||

AllowInternetOutBound

| Priority| Source| Source ports| Destination| Destination ports| Protocol| Access|
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 65001| 0.0.0.0/0| 0-65535| Internet| 0-65535| Any| Allow|
||||||||

DenyAllOutBound

| Priority| Source| Source ports| Destination| Destination ports| Protocol| Access|
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 65001| 0.0.0.0/0| 0-65535| 0.0.0.0/0| 0-65535| Any| Allow|
||||||||

In the **Source** and **Destination** columns, *VirtualNetwork*, *AzureLoadBalancer*, and *Internet* are service tags, rather than IP addresses. In the protocol column, **Any** encompasses TCP, UDP, and ICMP. When creating a rule, you can specify TCP, UDP, ICMP or Any. 0.0.0.0/0 in the **Source** and **Destination** columns represents all addresses. Clients like Azure portal, Azure CLI, or PowerShell can use ***** or Any for this expression.

You cannot remove the default rules, but you can override them by creating rules with higher priorities.

### Augmented security rules

With augmented security rules, you can combine multiple ports and multiple explicit IP addresses and ranges into a single security rule. In other words, augmented security rules simplify security definition for virtual networks. This allows you to break larger and complex network security policies into fewer, and simpler rules. Augmented rules are generally used in the source, destination, and port fields of a rule.

Combining augmented security rules with service tags or application security groups, helps streamline your security rule definition. However, there are limits to the number of addresses, ranges, and ports that you can specify in a rule.

- **Service tags**: A service tag represents a group of IP address prefixes from a given Azure service. It helps to minimize the complexity of frequent updates on network security rules. Refer to [Azure service tags](/azure/virtual-network/service-tags-overview).

- For an example of how to use the Storage service tag to restrict network access, go to [Restrict network access to PaaS resources with virtual network service endpoints using the Azure portal](/azure/virtual-network/tutorial-restrict-network-access-to-resources).

- **[Application security groups](/azure/virtual-network/application-security-groups)**: Application security groups enable you to configure network security as a natural extension of an application's structure. This allows you to group virtual machines and define network security policies based on those groups. You can reuse your security policy at scale without manual maintenance of explicit IP addresses. To learn more, see Application security groups.

## Troubleshoot NSG configuration issues

Network security groups (NSGs) enable you to control the inbound and outbound flow of traffic of a virtual machine (VM). You can associate an NSG to a subnet in an Azure virtual network, a network interface connected to a VM, or both. Any security rules applied to a network interface are a combination of rules present in the NSG associated to a network interface, and the subnet the network it is in. You can examine the conflict between rules in different NSGs that are applied on your VM's network interfaces.

The following articles help gain understanding of:

- [Virtual network overview](/azure/virtual-network/virtual-networks-overview)

- [Network interface](/azure/virtual-network/virtual-network-network-interface)

- [Network security groups overview](/azure/virtual-network/network-security-groups-overview)

In this unit, you’ll learn how to diagnose a network traffic filter problem by viewing the NSG security rules that are effective for a VM.

### Diagnose using Azure portal

**Scenario**

When you try to connect to a VM over port 80 from the internet, the connection fails. To understand why this happens, you can examine the effective security rules for a network interface using the Azure portal, PowerShell, or the Azure CLI.

If you don’t have an existing VM to view the effective security rules, you need to first deploy a Linux or Windows VM to complete the task.

In the following task, the examples are for a VM named **myVM** with a network interface named **myVMVMNic**. The VM and network interface are in a resource group named **myResourceGroup** and are in the East US region. To diagnose the problem, Change the values in the steps, as appropriate, for the VM.

1. Log into the Azure portal.

1. At the top of the Azure portal, enter the name of the VM in the search box. When the name of the VM appears in the search results, select it.

1. Under **SETTINGS**, select **Networking**.

 
   The rules you see listed in the following picture are for a network interface named **myVMVMNic**. There are **INBOUND PORT RULES** for the network interface from two different network security groups:

    - **mySubnetNSG**: Associated to the subnet that the network interface is in.

    - **myVMNSG**: Associated to the network interface in the VM named **myVMVMNic**.

   As you can see in the previous image, the rule named **DenyAllInBound** is preventing inbound communication from the internet to the VM over port 80. The rule lists 0.0.0.0/0 for SOURCE, which includes the internet. No other rule with a higher priority (lower number) allows port 80 inbound. To allow port 80 inbound to the VM from the internet, see [Resolve a problem](/azure/virtual-network/diagnose-network-traffic-filter-problem).

   Under **OUTBOUND PORT RULES**, at the bottom, there are outbound port rules for the network interface. **VirtualNetwork** and **AzureLoadBalancer** are service tags. Service tags represent a group of IP address prefixes to help minimize complexity for security rule creation.

1. Ensure that the VM is in the running state, and then select **Effective security rules**, as shown  in the following image:

 
   You can see that there are different tabs for the NSG associated to the network interface and the subnet. The rules listed are the same as in step 3<!--CE: Please check - which one is Step 3?--> although, as shown in the picture, only the first 50 rules are displayed. To download a .csv file that contains all the rules, select **Download**.

   To see which prefixes each service tag represents, select a rule, such as **AllowAzureLoadBalancerInbound**. The picture below shows the prefixes for the **AzureLoadBalancer** service tag:

   :::image type="content" source="../media/3-azure-load-balancer.png" alt-text="Screenshot showing prefixes for the AzureLoadBalancer service tag.":::

1. The VM in this example has two network interfaces, **myVMVMNic** and **myVMVMNic2** attached to it. The effective security rules can be different for each network interface. Select **myVMVMNic2** to view the rules for this network interface.

The **myVMVMNic2** network interface does not have a network security group associated to it, as the **myVMVMNic** network interface does. Each network interface and subnet can have zero, or one, NSG associated to it. The NSG associated to each network interface or subnet can be the same, or different. You can associate the same NSG to as many network interfaces and subnets as you choose.

> [!NOTE]
> Though effective security rules were viewed through the VM, you can also look at them through an individual:
> - Network interface: Learn how to [view a network interface](/azure/virtual-network/virtual-network-network-interface).
> - NSG: Learn how to [view an NSG](/azure/virtual-network/manage-network-security-group).

To run the commands using PowerShell, refer to [Diagnose using PowerShell](/azure/virtual-network/diagnose-network-traffic-filter-problem).

To run the commands using Azure CLI, refer to [Diagnose using Azure CLI](/azure/virtual-network/diagnose-network-traffic-filter-problem).

To troubleshoot connectivity problems:

- To allow inbound traffic from the internet, add security rules with a higher priority than default rules.

- To troubleshoot any issues related to virtual network peering, you can view the prefixes in the ExpandedAddressPrefix list.

- Ensure that there is an NSG associated with the VM's network interface and/or subnet. Also, check that the VM is in the running state.

- If the VM has a public IP address, it is recommended to apply an NSG to the <!--CE: Please check - I think there's a word missing here.-->subnet the network interface.

### Additional diagnosis

- Use the [IP flow verify](/azure/network-watcher/diagnose-vm-network-traffic-filtering-problem) capability of Azure Network Watcher to determine if traffic is allowed to or from a VM.

- If there are no security rules causing a VM's network connectivity to fail, the problem may be due to:

  - Firewall software running within the VM's operating system.

  - Routes configured for virtual appliances or on-premises traffic—refer to [forced-tunneling](/azure/vpn-gateway/vpn-gateway-forced-tunneling-rm?toc=/azure/virtual-network/toc.json). Also, to learn how to diagnose route problems that may impede the flow of traffic out of the VM, see [Diagnose a virtual machine network traffic routing problem](/azure/virtual-network/diagnose-network-routing-problem).

## Review and interpret NSG flow logs

### Introduction

The NSG flow logs feature in Azure Network Watcher allows you to log information about IP traffic flowing through an NSG. The flow data is sent to Azure Storage accounts and from there you can export it to any visualization tool, SIEM, or IDS.


## Why use flow logs?

Flow logs are crucial when it comes to managing and monitoring all the network activity in your cloud environment. You can use it for optimizing network flows, monitoring data, verifying compliance, detecting intrusions and more.

Some common use cases are:

**Network monitoring**:

- Identify unknown or undesired traffic.

- Monitor traffic levels and bandwidth consumption.

- Filter flow logs by IP and port to understand application behavior.

- Export flow logs to the analytics and visualization tools you choose, to set up monitoring dashboards.

**Usage monitoring and optimization**:

- Identify top talkers in your network.

- Combine with GeoIP data to identify cross-region traffic.

- Understand traffic growth for capacity forecasting.

- Use data to remove overtly restrictive traffic rules.

**Compliance**:

- Use flow data to verify network isolation and compliance with enterprise access rules.

**Network forensics and security analysis**:

- Analyze network flows from compromised IPs and network interfaces.

- Export flow logs to any SIEM or IDS tool of your choice.

## How logging works

- Flow logs operate at Layer 4 (transport layer). It records all IP flows going in and out of an NSG.

- Logs are collected at one-minute intervals through the Azure platform without affecting customer resources, or network performance.

- Logs are written in the JSON format. It shows outbound and inbound flows on a per NSG rule basis.

- Each log record contains the network interface (NIC). The flow applies to five-tuple information, the traffic decision and (version 2 only) throughput information. Refer to [Log format](/azure/network-watcher/network-watcher-nsg-flow-logging-overview).

- Flow logs delete the logs up to a year after creation.

To enable the flow logs, refer to [Enabling NSG Flow Logs](/azure/network-watcher/network-watcher-nsg-flow-logging-overview).

### IP flow verify

IP flow verify confirms if a packet is allowed or denied to or from a virtual machine. You can use IP flow verify to diagnose connectivity issues from or to the internet and from or to the on-premises environment. It provides the information regarding direction, protocol, local IP, remote IP, local port, and remote port. If a security group denies the packet, the name of the rule used is returned.

IP flow verify considers the rules for all NSGs applied to the network interface, such as a subnet or virtual machine NIC. It then verifies the traffic flow based on the configured settings to or from that network interface.

IP flow verify validates if a rule in an NSG is blocking ingress or egress traffic to or from a virtual machine. It also evaluates the Azure Virtual Network Manager rules and NSG rules.

:::image type="content" source="../media/3-ip-flow-verify.png" alt-text="Screenshot displaying IP flow verify window.":::

To learn more about troubleshooting NSG flow logs, see [Troubleshooting common issues](/azure/network-watcher/network-watcher-nsg-flow-logging-overview).

## Determine whether a VM or group of VMs is associated with an application security group (ASG)

Application security groups allow you to group virtual machines located in Azure virtual network, and define network security policies based on those groups. This helps in reducing the maintenance effort of explicit IP addresses. Consider the following picture for a better understanding of ASGs:

:::image type="content" source="../media/3-application-security-groups.png" alt-text="Diagram demonstration Application security groups.":::

In the previous picture, NIC1 and NIC2 are members of the AsgWeb ASG. NIC3 is a member of the AsgLogic ASG, and NIC4 a member of the AsgDb ASG. In this example, each network interface is a member of only one network security group. However, a network interface can be a member of multiple ASGs, up to the Azure limits.

None of the network interfaces have an associated network security group. NSG1 is associated to both subnets and contains the following rules:

### Allow-HTTP-Inbound-Internet

This rule is needed to allow traffic from the internet to the web servers. Because inbound traffic from the internet is denied by the DenyAllInbound default security rule, no additional rule is needed for the AsgLogic or AsgDb application security groups.

| Priority| Source| Source ports| Destination| Destination ports| Protocol| Access|
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 100| Internet| *| AsgWeb| 80| TCP| Allow|
||||||||

### Deny-Database-All

Because the **AllowVNetInBound** default security rule allows all communication between resources in the same virtual network, this rule is needed to deny traffic from all resources.

| Priority| Source| Source ports| Destination| Destination ports| Protocol| Access|
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 120| *| *| AsgWeb| 1433| Any| Deny|
||||||||

### Allow-Database-BusinessLogic

This rule allows traffic from the AsgLogic ASG to the AsgDb ASG. The priority for this rule is higher than that for the Deny-Database-All rule. As a result, this rule is processed before the Deny-Database-All rule, so traffic from the AsgLogic application security group is allowed, whereas all other traffic is blocked.

| Priority| Source| Source ports| Destination| Destination ports| Protocol| Access|
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 110| AsgLogic| *| AsgDb| 1433| TCP| Deny|
||||||||

The rules that specify an ASG as the source or destination are only applied to the network interfaces that are members of the ASG. If the network interface is not a member of an ASG, the rule is not applied to the network interface, even though the network security group is associated to the subnet.

Application security groups have the following constraints:

- There are several limits related to ASGs. One of these is the number of ASGs you can have in a subscription.

- You cannot add network interfaces from different virtual networks to the same ASG. For example, if the first network interface assigned to an ASG named AsgWeb is in the virtual network named VNet1, then all subsequent network interfaces assigned to ASGWeb must exist in VNet1.

- All network interfaces for both the source and destination ASGs need to exist in the same virtual network. For example, if AsgLogic contained network interfaces from VNet1, and AsgDb contained network interfaces from VNet2, you could not assign AsgLogic as the source and AsgDb as the destination in a rule.

