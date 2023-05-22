In this unit, you learn about enterprise design considerations and recommendations for network segmentation in Azure.

## Considerations

You should design based on zero trust and assumed breach. Systems should be able to communicate with each other only on the ports and protocols that the applications need. Here are a few key items to remember:

- Application security groups don't span virtual networks.
- Network security groups are stateful, but aren't firewalls. They're access-control lists.
- Azure Firewall is available from Microsoft. You can also find partner firewalls in Azure Marketplace.

## Recommendations

Delegate subnet creation to the owner of the landing zone. This configuration lets the owner define how to segment workloads across subnets. For example, a single large subnet or a multitier app.

The platform team can use Azure Policy to ensure that a network security group with specific rules is always associated with subnets that have deny-only policies. An example of a specific rule is denying inbound SSH or RDP from the internet, or allowing/blocking traffic across landing zones.

Use network security groups to restrict traffic between subnets and other east/west traffic, and use firewalls for north/south traffic. Be sure to enable flow logs for network security groups and feed them into Traffic Analytics in order to audit traffic or debug network flows. Use network security groups selectively for traffic between landing zones.