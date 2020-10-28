

When planning to deploy AD domain controllers in Azure, there are some important things for Contoso IT staff to consider: networking, AD DS sites, and trust relationships.

## Deployment considerations

- Network recommendations. Configure the VM network interface (NIC) for each AD DS server with a static, private IP address for full DNS support. You must also configure the Active Directory subnet network security group (NSG) rules to permit incoming traffic from on-premises and outgoing traffic to on-premises.

> [!TIP]
> Because of security concerns, you should NOT configure the VM NIC for any domain controller with a public IP address.

- Inter-site connectivity. A key design element is inter-site connectivity between your on-premises environment and Azure. To ensure that Azure-hosted VMs can communicate with internal domain controllers, you must set up a VNet with site-to-site connectivity back to your on-premises network, or you must use ExpressRoute. Cross-premises connectivity requires a VPN server that supports incoming connections from Azure, a static public IP address on your internet connection, and a dynamic gateway for the VNet to establish connectivity with the on-premises infrastructure.
- Active Directory sites. You must configure sites in AD DS so that you can control replication traffic between the on-premises and Azure-based domain controllers. Knowledge Consistency Checker (KCC) controls the replication process, with intra-site replication relying on a bidirectional ring topology that assumes connections with high bandwidth and that are permanently available. Replication traffic is not scheduled, and updates are optimized for speed. By contrast, inter-site replication uses a least-cost spanning tree topology with a default three-hour interval that can be restricted to certain times of the day or week.
- Trust relationship. A trust relationship is required in the scenario where your on-premises AD domain is contained within a different AD forest from your AD domain in Azure. To enable authentication of on-premises users in Azure, the domain in Azure must trust the logon domain in the on-premises forest. Similarly, if Azure provides a logon domain for external users, it might be necessary for the on-premises forest to trust the cloud domain. You can establish trusts at the forest level by creating forest trusts, or at the domain level by creating external trusts. A forest-level trust creates a transitive trust relationship between all the domains in the two forests. Conversely, an external domain level trust only creates a non-transitive trust relationship between two specified domains. Trusts can be unidirectional (*one-way*) or bidirectional (*two-way*):
  - A one-way trust enables users in one domain or forest (known as the *incoming domain or forest*) to access the resources in another forest (known as the *outgoing domain or forest*).
  - A two-way trust enables users in either domain or forest to access resources in the other.

> [!NOTE]
> You should only create external domain-level trusts between domains in different forests.

The following table summarizes trust configurations for some simple scenarios.

|Scenario|On-premises trust|Azure trust|
|------------------------------------------------------------|------------------------------|------------------------------|
|On-premises users require access to resources in Azure, but not vice versa|One-way, incoming|One-way, outgoing|
|Users in Azure require access to resources located on-premises, but not vice versa|One-way, outgoing|One-way, incoming|
|Users in Azure and on-premises both require access to resources in Azure and on-premises|Two-way, incoming and outgoing|Two-way, incoming and outgoing|

- Read-only domain controllers (RODCs). This arrangement reduces the amount of egress traffic and the resulting Azure service charges. RODCs do not work in situations where a service or application needs write access to AD DS.
- Flexible single master operations (FSMO) roles and global catalog placement. Regardless of your domain topology, you should configure all of your Azure-based domain controllers as global catalog servers. This arrangement prevents global catalog lookups and evaluations of universal group memberships from having to traverse from Azure to the on-premises global catalog, thus incurring egress network traffic charges. If Azure domain controllers are in a separate forest, its operation masters need to be hosted in Azure. If your Azure domain controllers are in a separate domain, you will need to configure the domains primary domain emulator master, relative ID master, and infrastructure master on those VMs in Azure.

> [!TIP]
> You might consider designating one or more servers in each domain as standby operations masters in case connectivity to a server acting as a FSMO role fails.

- Availability. You should provision at least two AD domain controllers for each domain. This enables automatic replication between servers. You should also consider creating an availability set for the AD domain controller VMs and configure at least two servers for each availability set.

> [!NOTE]
> Because requests to AD domain controllers are distributed across all domain controllers within a domain, you don't need to configure a load balancer to direct traffic to controllers within the domain.

- Back up and restore. Use the same procedure as for an on-premises domain controller to back up the system state on a domain controller. You should avoid copying, or *cloning*, the virtual hard drive as this could introduce an update sequence number rollback effect. This might also prevent the database from starting as the AD DS database file on the virtual hard drive might not be in a consistent state when it's copied.

- Management. You should not shut down an AD domain controller VM using the Azure portal. Instead, you should shut down and restart from the guest (OS). Shutting down the AD domain controller through the Azure portal causes the Azure VM to be deallocated, which resets both the Active Directory repository's VM-GenerationID and invocationID. This discards the AD DS relative identifier (RID) pool and marks the **sysvol** folder as nonauthoritative. It might also require reconfiguration of the domain controller.

- Monitoring. Monitor the resources of the domain controller VMs and the AD DS services, and create a plan to quickly correct any problems. For example, you can use Azure Monitor to analyze the performance of your infrastructure, which enables you to monitor and diagnose networking issues without signing in to your VMs. You can use Application Insights to provide metrics and logs to verify the state of your infrastructure.

The requirements for creating a domain controller on an Azure VM as a replica domain controller or in a new forest are similar. Both scenarios require a storage account for creating the OS and data disk for the VM, and as a best practice you should configure the domain controller with static IP addresses. However, in the first scenario, you must configure a VNet for cross-premises connectivity by using site-to-site VPN or ExpressRoute.
