Here, we'll discuss how you can decide if Azure Database for MySQL is a suitable solution for your internal developers. They don't want to worry about VM characteristics and capabilities or database versioning, configuration, and security settings. Instead, they want to get on with app development and deployment. In this unit, we'll evaluate which of the following solutions best addresses these needs: 

- Azure Database for MySQL Single Server
- Azure Database for MySQL Flexible Server

We'll  evaluate these solutions against the following criteria:

- Administrative effort
- Cost
- High-availability options

Before you select a version of Azure Database for MySQL, you should consider whether MySQL for Azure VMs can help you meet your needs. Keep in mind that this is an IaaS solution, and will require you to maintain the VM, its operating system, and the instance of the MySQL database engine. However, if you want a specific version of MySQL that isn't supported by Single Server or Flexible Server, then you can choose MySQL for Azure VMs. In most other circumstances, consider one of the Azure Database for MySQL options.

## Decision criteria

To determine whether to use MySQL for Azure VMs, or Azure Database for MySQL Single Server or Azure Database for MySQL Flexible Server, use the criteria described in the following table. 

| Criteria              | Analysis |
| --------------------- | -------- |
| Administrative effort | Azure Database for MySQL is a fully-managed service and requires only minimal, optional administrative effort. MySQL for Azure VMs requires that you manage the entire infrastructure and involves considerably more effort. |
| Cost      | Azure Database for MySQL is currently available as a service in several tiers with different prices for resources. You can choose the most appropriate tier and SKU. |
| High-availability options      | Azure Database for MySQL automatically provides high-availability options. |

## Apply the criteria

For many organizations, the decision to move their MySQL database is about addressing the criteria we just discussed. As a reminder, with IaaS, Microsoft:

- Administers the underlying infrastructure.
- Provides automated patching for underlying hardware and OS.

With PaaS, Microsoft:

- Administers the underlying infrastructure.
- Provides automated patching for underlying hardware, OS, and database engine.
- Manages high availability of the database.
- Automatically performs backups and replicates all data to provide disaster recovery.
- Encrypts the data at rest and in motion by default.
- Monitors your server and provides features for query performance insights and performance recommendations.

### Analyze administrative effort

The following table describes administrative considerations for each option.

| Option                   | Administrative effort                                        |
| ------------------------ | ------------------------------------------------------------ |
| MySQL on Azure VMs       | You have complete control over the OS and the MySQL server instance and its configuration. You decide when to update or upgrade the OS and database engine and which patches to apply. You also decide if and when to install any additional software (such as an antivirus app). You can control the size of the VM, the number of disks, and their storage configurations. Some automated features are provided to greatly simplify patching, backup, and high availability. In summary, although you have complete control, there is a significant amount of administrative effort involved. |
| Azure Database for MySQL | You can continue to administer your database, but you no longer have to manage the hardware, the OS, or the database engine. You can still choose to administer some items, such as databases, sign-in options, index tuning, query tuning, auditing, and security. In summary, there's considerably less administrative effort involved. |

### Analyze cost

With MySQL on Azure VMs, you pay for the provisioned VM, storage cost associated with the data, backup, monitoring data and log storage, and the costs for the specific MySQL license type used.

With Azure Database for MySQL, you start by selecting the tier and SKU that's most relevant to your needs. In addition, all resources are charged hourly at a fixed rate, and you're charged for outgoing internet traffic at regular data transfer rates. Administrative costs are reduced because Microsoft manages the service for you. 

> [!TIP]
> Flexible Server also allows you to stop and start the server to minimize costs.

### Analyze high availability

If high availability is critical to your app, then keep in mind that to enable high availability with MySQL for Azure VMs, you are wholly responsible for configuring the required Azure components. This involves additional administrative effort and cost. With Azure Database for MySQL, high availability is automatically available.

## Summary

Choose MySQL on Azure VMs when you want:

- To avoid the time and expense of acquiring new on-premises hardware.
- Granular control and customization of the MySQL engine that's not supported by the Azure Database for MySQL service.

Choose Azure Database for MySQL over an IaaS solution when:

- Online Storage scaling is required.
- You don't want to worry about managing the underlying operating system and MySQL engine.
- You require data encryption at rest for your databases.
- You want automated backup and recovery options.

When considering which Azure Database for MySQL tier to select, choose Flexible Server when you require:

- Better control and customizations over app development.
- Zone redundant high availability.
- Managed maintenance windows.
- Better read replica support (10 replicas versus 5).




