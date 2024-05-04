To succeed in your migration, you need to know what resources to create on the cloud and how to configure them. Start by examining your existing infrastructure to determine how much CPU, storage capacity, and IO load your applications and databases use on-premises. From there, map out what you should create before migrating your applications and data.

In this section, you assess your on-premises environment. You map out how to configure your Oracle Database@Azure instance to support your databases and then determine the Azure resources you need to prepare to support your migrated applications.

## Understand your database requirements

Although Oracle Database@Azure manages the underlying Exadata infrastructure for your databases, you still need to assess database hardware requirements. This includes determining the number of virtual database and storage servers to create, including the total number of CPUs and amount of storage capacity needed.

Work with the Oracle sales team to analyze your existing database infrastructure, collecting data such as the CPU, memory, and IO performance of your Oracle databases. With this information, you can select the correct amount of compute and storage capacity for your workload when you provision your infrastructure.

Unlike with [traditional VM-based database server migrations](/azure/virtual-machines/workloads/oracle/oracle-migration), you don't need to be concerned with choosing the best type of storage to support your workload. To work with Oracle Database@Azure, you just need to know how much storage you want and how you want to organize it into storage servers.

## Assess your existing application hosting needs

You'll be migrating the application tier of your workload to Azure VMs. As with a more standard rehosting scenario, your first step is to pinpoint which application servers you need to move. This means identifying the on-premises servers running application code and then determining the compute, storage, IO, and networking requirements for the VMs you create on Azure.

The [Azure Migrate: Discovery and assessment tool](/azure/migrate/concepts-assessment-calculation) can help you analyze your existing on-premises VMs and physical servers. It helps you determine:

- How suitable your existing on-premises application servers are for migration to Azure.

- The size and number of VMs you need on Azure.

- The costs for running these VMs on Azure.

- Any additional cross-server dependencies and optimization strategies for moving interdependent servers to Azure.

For details on how best to set up and use assessment information, consult the [Azure Migrate "Best practices for creating assessments" documentation](/azure/migrate/best-practices-assessment).

## Additional considerations

Before finalizing your plan, consider the following additional factors:

- [Backup and disaster recovery.](/azure/virtual-machines/backup-recovery) Understand your backup requirements. How often do you need to back up data? How quickly can you recover from a backup, if necessary?

- [High availability.](https://azure.microsoft.com/explore/global-infrastructure/availability-zones/) What are your uptime requirements? Do you need to take those requirements into account when you plan your Azure deployment?

- [Access control.](/azure/security/fundamentals/identity-management-best-practices) Who in your organization needs to be able to access and manage your servers on Azure? How can you best secure and control access to these resources?

- [Networking.](/azure/virtual-network/network-overview) Does your workload have specific traffic management or security requirements? Is your virtual network properly configured to allow your Oracle Database@Azure infrastructure to communicate with your other Azure resources?

    - [Azure role-based access control (RBAC)](/azure/role-based-access-control/overview) helps you manage who has access to Azure resources, what they can do with those resources, and which areas they can access.

    - [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview) allows you to manage network traffic in much the same way you would when using an on-premises network. [Network virtual appliances](https://azure.microsoft.com/solutions/network-appliances) can offer firewall and gateway/router capabilities. Your virtual network can even be connected to your on-premises or other cloud networks, by using [Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) or [Azure ExpressRoute](https://azure.microsoft.com/products/expressroute).

## Finalize your plan

After performing these assessments, you should have all the information you need to plan your migration. These details enable you to map out your migration landing zone, including the access and networking architecture, in addition to any VM and storage resources you should create.
