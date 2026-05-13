In this module, you learned how to segment Azure workloads and control lateral movement using a layered network security approach. You started by assessing the risk of flat network topologies, where unrestricted communication between resources creates opportunities for attackers to move laterally. You then applied Network Security Group (NSG) rules with a default-deny stance to enforce least-privilege access between tiers. Next you used application security groups to simplify rule management as workloads scale. Then, you deployed Azure Virtual Network Manager security admin rules to push consistent policy across all subscriptions. Finally, you verified your security posture using Network Watcher's effective security rules and IP flow verify tools.

For Contoso, the transformation was clear: a previously flat subnet with inconsistent NSG rules across 12 subscriptions now has database tiers isolated with deny-all-except-app-tier NSGs, ASG-based rules that scale automatically, an AVNM security admin rule blocking RDP from the internet across all subscriptions, and a verified security posture confirmed by Network Watcher. The web-tier VM that previously had unchecked access to SQL Server on port 1433 is now properly restricted.

These controls segment your workloads at the network layer, but they don't inspect traffic content or protect against volumetric attacks. In the next module, you learn how to centralize traffic inspection and apply deep packet inspection using Azure Firewall.

> [!NOTE]
> While NSGs and ASGs control lateral movement within your network, Azure DDoS Protection provides defense against volumetric attacks from the internet. Consider enabling DDoS Protection to complement your network segmentation strategy.

## Learn more

- [Network security groups overview](/azure/virtual-network/network-security-groups-overview)
- [Application security groups](/azure/virtual-network/application-security-groups)
- [Azure Virtual Network Manager overview](/azure/virtual-network-manager/overview)
- [Security admin rules in Azure Virtual Network Manager](/azure/virtual-network-manager/concept-security-admins)
- [Effective security rules in Network Watcher](/azure/network-watcher/effective-security-rules-overview)
- [Azure DDoS Protection overview](/azure/ddos-protection/ddos-protection-overview)
