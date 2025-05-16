Suppose your organization has a significant investment in SQL Server infrastructure on-premises and in local data centers. In that case, it's crucial to be aware that using the cloud isn't an all-or-nothing proposition. There are ways to use existing on-premises infrastructure in a hybrid capacity with Azure to improve operational resiliency and reduce costs.

Adopting a hybrid infrastructure is an excellent initial step for organizations that rely on on-premises solutions and are cautious about transitioning to the cloud. Many modern organizations use a combination of physical and virtualized SQL Server deployments on-premises, which can be extended to the cloud as part of a hybrid solution. The hybrid SQL Server platform combines the advantages of both on-premises and cloud services, serving as a complementary middle ground. Typically, the cloud component uses IaaS services such as storage or SQL Server virtual machines.

:::image type="content" source="../media/module-22-plan-implement-final-10.png" alt-text="Diagram depicting on-premises infrastructure and cloud infrastructure bridged by a hybrid solution.":::

In addition to extending on-premises solutions, the same patterns apply to existing alternative cloud solutions, enabling cloud-to-cloud hybrid implementations. Let's review some of the most common hybrid scenarios for SQL Server.

## Hybrid scenarios for SQL Server

Let's review a few strategies for when deploying a hybrid solution for SQL Server.

### Disaster Recovery

Disaster Recovery is the most common scenario for a hybrid deployment of SQL Server. It ensures business continuity if catastrophic events occur. Organizations can distribute deployments across multiple data centers for failover in an on-premises approach. These data centers typically reside within the same geographic region as the organization, making them susceptible to significant regional disasters. Physical data centers are also costly to deploy, monitor, and maintain. Arguably, the cost of spinning up Azure virtual machines running SQL Server in various geographical regions is much less than establishing a new physical data center in another geography.

:::image type="content" source="../media/module-22-plan-implement-final-13.png" alt-text="Diagram depicting local failover from headquarters to physical data center and a hybrid failover to Azure from the on-premises network.":::

In this hybrid approach, Azure is used for [DR failover](/azure/azure-sql/virtual-machines/windows/business-continuity-high-availability-disaster-recovery-hadr-overview#hybrid-it-disaster-recovery-solutions) (to one or more regions) while the regular day-to-day processing continues to use on-premises servers for local high availability.

### SQL Server Backups

SQL Server Backups is another common hybrid scenario. Backups may be done directly into Azure Storage via URL or Azure file share (SMB). This scenario protects against data loss when on-site backup storage fails. In addition, these backups may also be restored to virtual machines in Azure and tested as part of Disaster Recovery procedures.

Another scenario uses Azure Storage to store on-premises **SQL Server data files for user databases**. These are user files and not system databases. If the local storage fails, the user files are safely stored in the cloud, preventing data loss. In addition, by using Azure storage, there are [built-in reliability guarantees](https://techcommunity.microsoft.com/t5/azure-storage-blog/understanding-azure-storage-redundancy-offerings/ba-p/1431700) so storing these files in the cloud is more resilient. For this hybrid scenario, it's essential to keep the network communication secure, evaluate the network latency of the solution, and ensure the storage account is locked down using ACLs and Microsoft Entra ID.

### Azure Arc-enabled SQL Servers

Having [**Azure Arc-enabled SQL Servers**](/sql/sql-server/azure-arc/overview) extends and centralizes Azure management services to SQL Server instances hosted on-premises, in your data centers, on the edge, and in multicloud environments. In this hybrid scenario, Azure Arc enables the inventory of all registered SQL Server deployments and assesses their configurations, usage patterns, and security to provide actions and recommendations based on best practices. By using [SQL Server enabled by Azure Arc](/sql/sql-server/azure-arc/overview), you gain the benefits of centralized server management. You also get real-time security alerts and vulnerability reporting on both on-premises SQL Servers and their host operating systems. 

:::image type="content" source="../media/module-22-plan-implement-final-14.png" alt-text="A diagram depicting a sample Azure Arc-enabled SQL Server architecture.":::

## Security considerations

When deploying a hybrid SQL solution, all core infrastructure, such as Active Directory and DNS, must exist on-premises and in Azure. In addition, secure two-way communication must exist between the on-premises network and Azure. This secured communication can take the form of a [site-to-site (S2S) VPN](/azure/vpn-gateway/tutorial-site-to-site-portal) or a dedicated [ExpressRoute](/azure/expressroute/expressroute-introduction) tunnel. When evaluating different connectivity methods, it's vital to determine the amount of latency acceptable for your organization. Regardless of the solution chosen, network security must also be at the forefront of the implementation.

:::image type="content" source="../media/module-22-plan-implement-final-12.png" alt-text="A connection diagram depicting an ExpressRoute connection to Azure.":::

The ExpressRoute connections tend to be more costly, but they provide the best security and lowest latency as all communication flows over a direct secured channel independent of the public internet. However, common drawbacks for this solution include overall cost and the inability to apply ExpressRoute between cloud providers in a multicloud solution.
