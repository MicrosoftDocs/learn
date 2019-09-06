Application Security Groups along with the latest improvements in NSGs, have brought multiple benefits on the network security area, such as a single management experience, increased limits on multiple dimensions, a great level of simplification, and a natural integration with your architecture, begin today and experience these capabilities on your virtual networks.

For more details see the [NSG overview article](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview#application-security-groupshttps://docs.microsoft.com/azure/virtual-network/security-overview), which also explains ASGs. Learn how to implement NSGs and ASGs on the [following tutorial](https://docs.microsoft.com/en-us/azure/virtual-network/create-network-security-group-preview).

As always, your feedback helps us improve and keep moving in the right direction. We would like to hear your suggestions and feedback for ASGs, as well as future scenarios through our user voice channel. Stay tuned for more interesting updates in the network security space from Azure!


## Configure Azure Application Security Groups

In this lesson we look at Application Security Groups (ASGs), which are built on network security groups. A quick review of Security groups reminds us that you can filter network traffic to and from Azure resources in an Azure virtual network with a network security group. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources.

For each rule, you can specify source and destination, port, and protocol. You can enable network security group flow logs to analyze network traffic to and from resources that have an associated network security group.

* To learn about which Azure resources can be deployed into a virtual network and have network security groups associated to them, see [Virtual network integration for Azure services.](https://docs.microsoft.com/azure/virtual-network/virtual-network-for-azure-services)

* If you've never created a network security group, to get experience creating one you can complete a quick tutorial here: [Tutorial: Filter network traffic with a network security group using the Azure Portal](https://docs.microsoft.com/azure/virtual-network/tutorial-filter-network-traffic). 

* If you're familiar with network security groups and need to manage them, see [Create, change, or delete a network security group](https://docs.microsoft.com/en-us/azure/virtual-network/manage-network-security-group).

* If you're having communication problems and need to troubleshoot network security groups, see [Diagnose a virtual machine network traffic filter problem](https://docs.microsoft.com/en-us/azure/virtual-network/diagnose-network-traffic-filter-problem).

* You can read more about enabling network security group flow logs to analyze network traffic to and from resources that have an associated network security group at:

    - [Tutorial: Log network traffic to and from a virtual machine using the Azure portal](https://docs.microsoft.com/azure/network-watcher/network-watcher-nsg-flow-logging-portal?toc=%2fazure%2fvirtual-network%2ftoc.json)

    - [Traffic Analytics](https://docs.microsoft.com/azure/network-watcher/traffic-analytics?toc=%2fazure%2fvirtual-network%2ftoc.json)

### ASGs

ASGs enable you to configure network security as a natural extension of an application's structure. You then can group VMs and define network security policies based on those groups.

You also can reuse your security policy at scale without manual maintenance of explicit IP addresses. The platform manages the complexity of explicit IP addresses and multiple rule sets, allowing you to focus on your business logic. Consider the following illustration.

![A diagram of Application security groups (ASGs) is defined in the following paragraph.](../media/M4-application-security-groups1.png)

In the illustration, NIC1 and NIC2 are members of the AsgWeb ASG. NIC3 is a member of the AsgLogic ASG. NIC4 is a member of the AsgDb ASG. Though each network interface in this example is a member of only one ASG, a network interface can be a member of multiple ASGs, up to the Azure limits. None of the network interfaces have an associated network security group. NSG1 is associated to both subnets and contains the following rules:

* [Allow-HTTP-Inbound-Internet](https://docs.microsoft.com/azure/virtual-network/security-overview)

* [Deny-Database-All](https://docs.microsoft.com/azure/virtual-network/security-overview)

* [Allow-Database-BusinessLogic](https://docs.microsoft.com/azure/virtual-network/security-overview)

The rules that specify an ASG as the source or destination are only applied to the network interfaces that are members of the ASG. If the network interface is not a member of an ASG, the rule is not applied to the network interface even though the network security group is associated to the subnet.

### ASGs have the following constraints

* There are limits to the number of ASGs you can have in a subscription, in addition to other limits related to ASGs.

* You can specify one ASG as the source and destination in a security rule. You cannot specify multiple ASGs in the source or destination.

* All network interfaces assigned to an ASG have to exist in the same virtual network that the first network interface assigned to the ASG is in. For example, if the first network interface assigned to an ASG named AsgWeb is in the virtual network named VNet1, then all subsequent network interfaces assigned to ASGWeb must exist in VNet1. You cannot add network interfaces from different virtual networks to the same ASG.

* If you specify an ASG as the source and destination in a security rule, the network interfaces in both ASGs must exist in the same virtual network. For example, if AsgLogic contained network interfaces from VNet1, and AsgDb contained network interfaces from VNet2, you could not assign AsgLogic as the source and AsgDb as the destination in a rule. All network interfaces for both the source and destination ASGs need to exist in the same virtual network.
