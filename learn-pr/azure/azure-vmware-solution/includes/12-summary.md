Contoso needed a way to secure outbound internet connectivity from its Azure VMware Solution private cloud. Contoso also wanted to continue using their favourite NVA in Azure.

Azure VMware Solution addressed both these requirements. The process involves generating and injecting a default route (0.0.0.0/0) from the NVA. Azure Route Server can be used to learn the default route from a custom or 3rd party NVAs using BGP. Azure Route Server then propagates the default route to Azure VMware Solution private cloud. Azure Firewall is used to control and inspect outbound internet traffic from Azure VMware Solution private cloud.

Contoso was delighted with the simplicity and elegance of this solution. They felt confident to meet strict audit requirements from healthcare industry regulators.

Using Azure VMware Solution provided all the flexibility Contoso needed. It included continued use of standard practices with NVAs. Contoso also took advantage of Azure native services such as Azure Route Server and Azure Firewall. Integration between Azure VMware Solution, NVA, Azure Route Server and Azure Firewall was seamless and easy to implement.

## References

- [Azure Landing Zone Architecture](/azure/cloud-adoption-framework/scenarios/azure-vmware/enterprise-scale-landing-zone#architecture)
- [Azure Landing Zone connectivity subscription](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions)
- [Border Gateway Protocol](https://en.wikipedia.org/wiki/Border_Gateway_Protocol)
- [FRRouting](https://frrouting.org/)
