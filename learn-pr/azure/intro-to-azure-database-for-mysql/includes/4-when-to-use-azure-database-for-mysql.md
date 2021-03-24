Intro and state problem to be solved xxx





COPIED:





## Business motivations for choosing PaaS or IaaS

There are several factors that can influence your decision to choose PaaS or IaaS to host your MySQL databases.

### Cost

Cost reduction is often the primary consideration that determines the best solution for hosting your databases. This is true whether you're a startup with little cash or a team in an established company that operates under tight budget constraints. This section describes billing and licensing basics in Azure as they apply to Azure Database for MySQL and MySQL on Azure VMs.

#### Billing

Azure Database for MySQL is currently available as a service in several tiers with different prices for resources. All resources are billed hourly at a fixed rate. For the latest information on the currently supported service tiers, compute sizes, and storage amounts, see [pricing page](https://azure.microsoft.com/pricing/details/mysql/). You can dynamically adjust service tiers and compute sizes to match your application's varied throughput needs. You're billed for outgoing Internet traffic at regular [data transfer rates](https://azure.microsoft.com/pricing/details/data-transfers/).

With Azure Database for MySQL, Microsoft automatically configures, patches, and upgrades the database software. These automated actions reduce your administration costs. Also, Azure Database for MySQL has [automated backups](https://docs.microsoft.com/en-us/azure/mysql/concepts-backup) capabilities. These capabilities help you achieve significant cost savings, especially when you have a large number of databases. In contrast, with MySQL on Azure VMs you can choose and run any MySQL version. No matter what MySQL version you use, you pay for the provisioned VM, storage cost associated with the data, backup, monitoring data and log storage and the costs for the specific MySQL license type used (if any).

Azure Database for MySQL provides built-in high availability for any kind of node-level interruption while still maintaining the 99.99% SLA guarantee for the service. However, for database high availability within VMs, you use the high availability options like [MySQL replication](https://dev.mysql.com/doc/refman/8.0/en/replication.html) that are available on a MySQL database. Using a supported high availability option doesn't provide an additional SLA. But it does let you achieve greater than 99.99% database availability at additional cost and administrative overhead.

For more information on pricing, see the following articles:

- [Azure Database for MySQL pricing](https://azure.microsoft.com/pricing/details/mysql/)
- [Virtual machine pricing](https://azure.microsoft.com/pricing/details/virtual-machines/)
- [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/)

### Administration

For many businesses, the decision to transition to a cloud service is as much about offloading complexity of administration as it is about cost.

With IaaS, Microsoft:

- Administers the underlying infrastructure.
- Provides automated patching for underlying hardware and OS.

With PaaS, Microsoft:

- Administers the underlying infrastructure.
- Provides automated patching for underlying hardware, OS, and database engine.
- Manages high availability of the database.
- Automatically performs backups and replicates all data to provide disaster recovery.
- Encrypts the data at rest and in motion by default.
- Monitors your server and provides features for query performance insights and performance recommendations

The following list describes administrative considerations for each option:

- With Azure Database for MySQL, you can continue to administer your database. But you no longer need to manage the database engine, the operating system, or the hardware. Examples of items you can continue to administer include:

  - Databases
  - Sign-in
  - Index tuning
  - Query tuning
  - Auditing
  - Security

  Additionally, configuring high availability to another data center requires minimal to no configuration or administration.

- With MySQL on Azure VMs, you have full control over the operating system and the MySQL server instance configuration. With a VM, you decide when to update or upgrade the operating system and database software and what patches to apply. You also decide when to install any additional software such as an antivirus application. Some automated features are provided to greatly simplify patching, backup, and high availability. You can control the size of the VM, the number of disks, and their storage configurations. For more information, see [Virtual machine and cloud service sizes for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes).

### Time to move to Azure

- Azure Database for MySQL is the right solution for cloud-designed applications when developer productivity and fast time to market for new solutions are critical. With programmatic functionality that is like DBA, the service is suitable for cloud architects and developers because it lowers the need for managing the underlying operating system and database.
- When you want to avoid the time and expense of acquiring new on-premises hardware, MySQL on Azure VMs is the right solution for applications that require a granular control and customization of MySQL engine not supported by the service or requiring access of the underlying OS. This solution is also suitable for migrating existing on-premises applications and databases to Azure intact, for cases where Azure Database for MySQL is a poor fit.

Because there's no need to change the presentation, application, and data layers, you save time and budget on rearchitecting your existing solution. Instead, you can focus on migrating all your solutions to Azure and addressing some performance optimizations that the Azure platform might require.



//COPIED





## Decision criteria



xxx



## Apply the criteria

xxx

Consider using <product> when:

- xxx