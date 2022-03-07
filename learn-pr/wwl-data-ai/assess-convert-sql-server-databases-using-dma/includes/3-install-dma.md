**Microsoft Data Migration Assistant (DMA)** allows companies to check the compatibility of their databases, before doing upgrades.

In your law firm, you need to upgrade databases in your main office location, and in regional offices. Because there are many diverse databases, and because you want to consider migrating to database solutions in Azure, you've decided to use DMA to investigate the compatibility issues. After installing the DMA on your local machine, you can connect to local SQL Servers, and the ones in each remote office and assess them for migration.

In this unit, you'll see how to install the DMA on your local machine.

## What must be installed?

The Data Migration Assistant can be downloaded and installed on the machine from which you currently administer your databases. The DMA is a standalone application that has no dependencies other than the credentials for the SQL Server instance you want to upgrade. The DMA runs in isolation from any other software, such as SQL Server Management Studio (SSMS). It's not best practice to install DMA directly on the SQL Server host machine.

## How to install the Microsoft Data Migration Assistant

Download the installation package, **DataMigrationAssistant.msi**, from the Microsoft website to your local machine. Supported client operating system versions include Windows 7, 8, 8.1, and 10. While DMA is also supported on Windows Server 2012 and 2016, it's best practice not to install the software on your production servers. The DMA requires the .NET Framework 4.7.2 64-bit, or above.

After installing DMA, you'll need credentials and network access to the SQL Server instances to which you wish to connect:

- When running a compatibility test, DMA requires credentials for the source server
- When doing an upgrade, DMA requires credentials for the source and target servers
- For database upgrades, the account for the source server must have the **CONTROL SERVER** permission, and the credentials for the target server must be a member of the **sysadmin** server role

The DMA should be installed on your client machine. You can then connect to your on-premises SQL Server instances and cloud-based Azure SQL Databases. In practice, you'll ideally run the DMA against the databases in your development or test environments, before upgrading your production databases. 
