SQL Server on Azure Virtual Machine allows you to run complete SQL Server editions without the burden of managing on-premises hardware. Azure offers a large gallery of virtual machine (VM) images allowing you to deploy a server quickly with the exact version, edition, and operating system you need. This Infrastructure as a Service (IaaS) approach has benefits, and considerations that you need to take into account when taking this migration path.

You may have specific requirements that are better suited for SQL Server on Azure Virtual Machines rather than Azure SQL Managed Instance in the following scenarios:

1. You need direct access to the operating system or file system, such as installing third-party or custom agents on the same virtual machine alongside SQL Server.
1. You heavily rely on features that aren't yet supported, such as FileStream/FileTable, PolyBase, and cross-instance transactions.
1. Your business requires staying at a particular version of SQL Server.
1. Your compute requirements are lower than what a managed instance offers, and database consolidation isn't an option.

### Use case scenario

Throughout this module, we're using an example scenario to explain key data migration concepts.

You've been hired as a senior database administrator at a global retail company and you're working with consultants and architects to initiate a data platform modernization project that meets the organization's technical and business requirements. 

The organization has a large number of different databases that underpin business-critical functions such as Customer Relationship Management (CRM), stock management, distribution, and human resources. The company runs many on-premises databases on different versions across multiple servers. 

Your main responsibility is to identify what is needed and ultimately migrate many databases running different versions of SQL Server.

In this module, you'll learn how to migrate SQL Server workloads to run on Azure Virtual Machine. You'll explore the various ways you can migrate your SQL Server workloads both offline and online. After you've migrated your workload, you'll complete some post migration tasks. These tasks will ensure that the migrated database performance hasn't been impacted.

By the end of this module, you'll be able to plan and execute a migration from on-premises SQL Server to Azure Virtual Machine.
