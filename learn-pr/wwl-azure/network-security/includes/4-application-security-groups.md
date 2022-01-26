In this topic we look at Application Security Groups (ASGs), which are built on network security groups. A quick review of Security groups reminds us that you can filter network traffic to and from Azure resources in an Azure virtual network with a network security group. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources.

For each rule, you can specify source and destination, port, and protocol. You can enable network security group flow logs to analyze network traffic to and from resources that have an associated network security group.

## Application security groups

ASGs enable you to configure network security as a natural extension of an application's structure. You then can group VMs and define network security policies based on those groups.

You also can reuse your security policy at scale without manual maintenance of explicit IP addresses. The platform manages the complexity of explicit IP addresses and multiple rule sets, allowing you to focus on your business logic. Consider the following illustration.

:::image type="content" source="../media/az500-application-security-group-d47a5711.png" alt-text="ASGs and NSGs combine to protect applications.":::


In the illustration, NIC1 and NIC2 are members of the AsgWeb ASG. NIC3 is a member of the AsgLogic ASG. NIC4 is a member of the AsgDb ASG. Though each network interface in this example is a member of only one ASG, a network interface can be a member of multiple ASGs, up to the Azure limits. None of the network interfaces have an associated network security group. NSG1 is associated to both subnets and contains the following rules:

 -  **Allow-HTTP-Inbound-Internet**
 -  **Deny-Database-All**
 -  **Allow-Database-BusinessLogic**

The rules that specify an ASG as the source or destination are only applied to the network interfaces that are members of the ASG. If the network interface is not a member of an ASG, the rule is not applied to the network interface even though the network security group is associated to the subnet.

## Application security groups have the following constraints

 -  There are limits to the number of ASGs you can have in a subscription, in addition to other limits related to ASGs.
 -  You can specify one ASG as the source and destination in a security rule. You cannot specify multiple ASGs in the source or destination.
 -  All network interfaces assigned to an ASG must exist in the same virtual network that the first network interface assigned to the ASG is in. For example, if the first network interface assigned to an ASG named AsgWeb is in the virtual network named VNet1, then all subsequent network interfaces assigned to ASGWeb must exist in VNet1. You cannot add network interfaces from different virtual networks to the same ASG.
 -  If you specify an ASG as the source and destination in a security rule, the network interfaces in both ASGs must exist in the same virtual network. For example, if AsgLogic contained network interfaces from VNet1, and AsgDb contained network interfaces from VNet2, you could not assign AsgLogic as the source and AsgDb as the destination in a rule. All network interfaces for both the source and destination ASGs need to exist in the same virtual network.

## Summary

Application Security Groups along with NSGs, have brought multiple benefits on the network security area:

 -  **A single management experience**
 -  **Increased limits on multiple dimensions**
 -  **A great level of simplification**
 -  **A seamless integration with your architecture**
