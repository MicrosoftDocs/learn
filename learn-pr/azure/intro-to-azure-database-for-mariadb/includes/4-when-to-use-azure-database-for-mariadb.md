The developers in your organization don't want to worry about VM characteristics and capabilities, database versioning, configuration, or security settings. Here, you evaluate whether Azure Database for MariaDB can address your needs and help your developers focus their energy on app development and deployment. Let's assess Azure Database for MariaDB against the following criteria:

- Administrative effort
- Cost
- High-availability options

Before you implement an Azure Database for MariaDB version, you should consider whether it meets your needs. Remember that it's an IaaS solution. It requires that you maintain the VM, its OS, and the MariaDB database engine instance. However, if you want a specific MariaDB version that Azure Database for MariaDB doesn't support, you should choose MariaDB for Azure VMs. In most other circumstances, Azure Database for MariaDB should meet your needs.

## Decision criteria

The following table describes the criteria you can use to decide whether to use MariaDB for Azure VMs or Azure Database for MariaDB.

| Criteria              | Analysis |
| --------------------- | -------- |
| Administrative effort | Azure Database for MariaDB is a fully managed service and requires only minimal, optional administrative effort. MariaDB for Azure VMs requires you to manage the entire infrastructure and involves considerably more effort. |
| Cost      | Azure Database for MariaDB is currently available as a service in several tiers. There are different prices for resources. You can choose the most appropriate tier. |
| High-availability options      | Azure Database for MariaDB automatically provides high-availability options. |

## Apply the criteria

For many organizations, the decision to move their MariaDB database is about addressing this criteria. As you consider the criteria, remember that with IaaS, Microsoft:

- Administers the underlying infrastructure.
- Provides automated patching for your underlying hardware and OS.

With PaaS, Microsoft:

- Administers the underlying infrastructure.
- Provides automated patching for your underlying hardware, OS, and database engine.
- Manages high availability of the database.
- Automatically performs backups. It also replicates all data to provide disaster recovery.
- Encrypts data at rest and in motion, by default.
- Monitors your server and provides features for query-performance insights and performance recommendations.

### Analyze administrative effort

The following table describes administrative considerations for each option.

| Option                   | Administrative effort                                        |
| ------------------------ | ------------------------------------------------------------ |
| MariaDB on Azure VMs       | You have complete control over the OS and the MariaDB server instance and its configuration. You decide when to update or upgrade the OS and database engine, and which patches to apply. You also decide when to install any other software, such as an antivirus app. You can control VM size, the number of disks, and their storage configurations. Some of the automated features greatly simplify patching, backups, and high availability. In summary, although you have complete control, there's a significant amount of administrative effort involved. |
| Azure Database for MariaDB | You can continue to administer your database without having to manage the hardware, the OS, or the database engine. You can choose to administer some items, such as databases, sign-in options, index tuning, query tuning, auditing, and security. However, there's considerably less administrative effort involved. |

### Analyze cost

With MariaDB on Azure VMs, you pay for:

- The provisioned VM.
- The storage costs associated with data, backup, monitoring data, and log storage.
- The costs for the specific MariaDB license type you use.

With Azure Database for MariaDB, you select the tier that you want. From there, all resources are charged hourly at a fixed rate. You're also charged for outgoing internet traffic at regular data-transfer rates. Microsoft manages the services, which reduces your administrative costs.

> [!TIP]
> To help minimize your costs, you can stop Azure Database for MariaDB when you're not using it.

### Analyze high availability

If high availability is critical to your app, you should carefully consider the difference between MariaDB for Azure VMs and Azure Database for MariaDB. To enable high availability with MariaDB for Azure VMs, you're wholly responsible for configuring the required Azure components. This configuration involves more administrative effort and cost. With Azure Database for MariaDB, high availability is automatically available.

## Summary

In summary, you should choose MariaDB on Azure VMs when you want:

- To avoid the time and expense of acquiring new on-premises hardware.
- Granular control and customization of a MariaDB engine that the Azure Database for MariaDB service doesn't support.

Choose Azure Database for MariaDB rather than an IaaS solution when:

- You require online storage scaling.
- You don't want to manage the underlying OS and MariaDB engine.
- You require data encryption, at rest, for your databases.
- You want automated backup and recovery options.
