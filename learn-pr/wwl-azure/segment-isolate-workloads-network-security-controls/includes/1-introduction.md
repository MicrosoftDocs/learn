Contoso, a financial services organization, recently migrated its line-of-business applications to Azure. A post-migration security assessment revealed a critical vulnerability: a compromised web-tier VM could connect directly to SQL Server database instances on port 1433 with no network controls blocking the path. Investigation uncovered the root causes: inconsistent network security group (NSG) rules across subscriptions, workloads sharing subnets with unrelated systems, and no deliberate segmentation strategy to contain lateral movement between tiers.

In financial services environments, a single compromised virtual machine with direct database access becomes a data exfiltration path. Network segmentation limits the blast radius by controlling east-west traffic between workload tiers. Many organizations assume Azure virtual networks provide isolation by default. They don't. Effective segmentation requires deliberate, consistent, and verifiable network security controls enforced at scale.

Here, you learn to assess segmentation gaps in virtual network (virtual network) topologies, configure NSG rules to enforce least-privilege access between workloads. The configuration simplifies rule management using application security groups, apply organization-wide enforcement with security admin rules, and verify effective security rules using network diagnostics. Start by understanding how attackers move through unsegmented networks.

## Learning objectives

After completing this module, you'll be able to:

- Assess a virtual network topology to identify lateral movement risk and network segmentation gaps
- Configure NSG rules to enforce least-privilege access between Azure workloads
- Use ASGs to simplify and maintain NSG rule sets for grouped workloads
- Configure Azure Virtual Network Manager security admin rules to enforce organization-wide network policies
- Verify effective network security rules using Network Watcher diagnostics
