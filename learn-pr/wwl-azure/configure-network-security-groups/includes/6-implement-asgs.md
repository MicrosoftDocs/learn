ASGs enable you to configure network security as a natural extension of an application's structure. You then can group VMs and define network security policies based on those groups.

You also can reuse your security policy at scale without manual maintenance of explicit IP addresses. The platform manages the complexity of explicit IP addresses and multiple rule sets, allowing you to focus on your business logic. Consider the following illustration.

:::image type="content" source="../media/asgs.png" alt-text="ASGs and NSGs combine to protect applications.":::

In the illustration, ASGs protect the Web Servers and Application Servers. Each ASG can have different access rules. An NSG wraps both ASGs to provide an additional level of security. 

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