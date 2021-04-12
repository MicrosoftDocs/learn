The developers in your organization don't want to worry about VM characteristics and capabilities, database versioning, configuration, or security settings. Here, you'll evaluate whether Azure Database for MariaDB can address your needs and help your developers get on with app development and deployment. You'll evaluate Azure Database for MariaDB against the following criteria:

- Administrative effort
- Cost
- High-availability options

Before you select a version of Azure Database for MariaDB, you should consider whether MariaDB for Azure VMs can meet your needs. Keep in mind that this is an IaaS solution, and will require you to maintain the VM, its operating system, and the instance of the MariaDB database engine. However, if you want a specific version of MariaDB that isn't supported by Azure Database for MariaDB, then choose MariaDB for Azure VMs. In most other circumstances, consider Azure Database for MariaDB.

## Decision criteria

To determine whether to use MariaDB for Azure VMs or Azure Database for MariaDB, use the criteria described in the following table.

| Criteria              | Analysis |
| --------------------- | -------- |
| Administrative effort | Azure Database for MariaDB is a fully-managed service and requires only minimal, optional administrative effort. MariaDB for Azure VMs requires you to manage the entire infrastructure and involves considerably more effort. |
| Cost      | Azure Database for MariaDB is currently available as a service in several tiers with different prices for resources. You can choose the most appropriate tier. |
| High-availability options      | Azure Database for MariaDB automatically provides high-availability options. |

## Apply the criteria

For many organizations, the decision to move their MariaDB database is about addressing the criteria you just reviewed. As a reminder, with IaaS, Microsoft:

- Administers the underlying infrastructure.
- Provides automated patching for underlying hardware and OS.

With PaaS, Microsoft:

- Administers the underlying infrastructure.
- Provides automated patching for underlying hardware, OS, and database engine.
- Manages high availability of the database.
- Automatically performs backups and replicates all data to provide disaster recovery.
- Encrypts the data at rest and in motion, by default.
- Monitors your server and provides features for query performance insights and performance recommendations.

### Analyze administrative effort

The following table describes administrative considerations for each option.

| Option                   | Administrative effort                                        |
| ------------------------ | ------------------------------------------------------------ |
| MariaDB on Azure VMs       | You have complete control over the OS and the MariaDB server instance and its configuration. You decide when to update or upgrade the OS and database engine and which patches to apply. You also decide if and when to install any additional software, such as an antivirus app. You can control the size of the VM, the number of disks, and their storage configurations. Some of the automated features greatly simplify patching, backup, and high availability. In summary, although you have complete control, there is a significant amount of administrative effort involved. |
| Azure Database for MariaDB | You can continue to administer your database without having to manage the hardware, the OS, or the database engine. You can still choose to administer some items, such as databases, sign-in options, index tuning, query tuning, auditing, and security. In summary, there's considerably less administrative effort involved. |

### Analyze cost

With MariaDB on Azure VMs, you pay for:

- The provisioned VM.
- The storage cost associated with the data, backup, monitoring data, and log storage.
- The costs for the specific MariaDB license type used.

With Azure Database for MariaDB, you start by selecting the tier that's most relevant to your needs. In addition, all resources are charged hourly at a fixed rate, and you're charged for outgoing internet traffic at regular data-transfer rates. Administrative costs are reduced, because Microsoft manages the service for you.

> [!TIP]
> You can also stop Azure Database for MariaDB when it's not being used. This allows you to help minimize costs.

### Analyze high availability

If high availability is critical to your app, then you should carefully consider the difference between MariaDB for Azure VMs and Azure Database for MariaDB. To enable high availability with MariaDB for Azure VMs, you are wholly responsible for configuring the required Azure components. This involves additional administrative effort and cost. With Azure Database for MariaDB, high availability is automatically available.

## Summary

In summary, you should choose MariaDB on Azure VMs when you want:

- To avoid the time and expense of acquiring new on-premises hardware.
- Granular control and customization of the MariaDB engine that's not supported by the Azure Database for MariaDB service.

Choose Azure Database for MariaDB over an IaaS solution when:

- You require online storage scaling.
- You don't want to worry about managing the underlying operating system and MariaDB engine.
- You require data encryption at rest for your databases.
- You want automated backup and recovery options.
