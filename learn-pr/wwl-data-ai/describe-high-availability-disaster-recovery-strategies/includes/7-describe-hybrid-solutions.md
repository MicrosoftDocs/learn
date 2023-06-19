You should now understand recovery time objectives (RTOs) and recovery point objectives (RPOs) as well as the different features both in SQL Server as well as Azure to increase availability, you can put all of that together and design a solution to meet your high availability and disaster recovery (HADR) requirements.

While an architecture can be deployed in one or more Azure regions, many organizations will need or want to have solutions that span both on premises and Azure, or possibly Azure to another public cloud. This type of architecture is known as a hybrid solution.

PaaS solutions by nature aren't designed to allow traditional hybrid solutions. HADR is provided by the Azure infrastructure. There are some exceptions. For example, SQL Server’s transactional replication feature can be configured from a publisher located on premises (or another cloud) to an Azure SQL Managed Instance subscriber, but not the other way.

Hybrid solutions are therefore IaaS-based since they rely on traditional infrastructure. Hybrid solutions are useful. Not only can they be used to help migrate to Azure, but the most common usage of a hybrid architecture is to create a robust disaster recovery solution for an on premises system. For example, a secondary replica for an AG can be added in Azure. That means any associated infrastructure must exist, such as AD DS and DNS.

Arguably the most important consideration for a hybrid HADR solution that extends to Azure is networking. Not having the right bandwidth could mean missing your RTO and RPO. Azure has a fast networking option called ExpressRoute. If ExpressRoute isn't something your company can or will implement, configure a secure site-to-site VPN so that the Azure VMs will act as an extension of your on premises infrastructure. Exposing IaaS VMs directly to the public internet is discouraged.

Although not traditionally thought of as hybrid, Azure can also be used as the destination for a database backup and as cold, archival storage for backups.
