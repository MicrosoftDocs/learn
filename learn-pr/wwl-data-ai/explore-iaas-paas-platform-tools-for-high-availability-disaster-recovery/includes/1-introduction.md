If you are using IaaS for deploying your database solution, there are considerations for properly deploying HADR.

Suppose you want to use an Availability Group(AG). How is deploying a Windows Server Failover Cluster (WSFC) different? Are there any specific considerations for AGs that differ from an on-premises solution?

Implementing a PaaS-based high availability and disaster recovery (HADR) solution for PaaS solutions is different than IaaS. For IaaS, the configuration is done at the Azure level. For PaaS, the solutions that allow your applications and data to be highly available and meet your RTOs and RPOs are configured within the database or database server.

By the end of this module, you will understand what is needed to be able to deploy IaaS database platform solutions in Azure.

## Learning objectives

In this module, you will understand:

- What to consider when deploying a WSFC in Azure
- What to consider when deploying an AG in Azure
- How to enable AGs
- Temporal Tables
- Active-geo replication
- Autofailover groups
