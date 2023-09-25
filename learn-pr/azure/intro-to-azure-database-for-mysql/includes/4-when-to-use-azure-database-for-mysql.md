In this unit, we discuss how to determine if Azure Database for MySQL is a suitable solution for your internal developers. They don't want to focus on VM characteristics and capabilities or database versioning, configuration, and security settings. Instead, they want to get on with app development and deployment. Azure Database for MySQL Flexible Server, which is a fully managed PaaS solution, addresses these needs.

With MySQL for Azure VMs, an IaaS solution, developers must maintain the VM, its OS, and the MySQL database engine instance. However, if you want a specific version of MySQL that Azure Database doesn't support for MySQL Flexible Server, then MySQL for Azure VMs works for you.

Let's evaluate these solutions in detail against the following criteria:

- Administrative effort
- Cost
- High-availability options

Before using Azure Database for MySQL, consider whether MySQL for Azure VMs can help you meet your needs. Remember that this option is an IaaS solution. You need to maintain the VM, its OS, and the MySQL database engine instance. However, if you want a specific version of MySQL that Flexible Server doesn't support, then MySQL for Azure VMs works. In most circumstances, consider one of the deployment options for Azure Database for MySQL.

## Decision criteria

To determine whether to use MySQL for Azure VMs or Azure Database for MySQL, use the criteria described in the following table.

| Criteria              | Analysis |
| --------------------- | -------- |
| Administrative effort | Azure Database for MySQL is a fully managed service and requires only minimal, optional administrative effort. MySQL for Azure VMs requires you to manage the entire infrastructure and requires considerable effort. |
| Cost | Azure Database for MySQL is currently available as a service in several tiers with different prices for resources. You can choose the most appropriate tier and SKU. MySQL - Flexible Server offers a free trial with an Azure free account. |
| High-availability options | Azure Database for MySQL automatically provides high-availability options. |

## Apply the criteria

For many organizations, the decision to move their MySQL database is about addressing the criteria we discussed. As a reminder, with IaaS, Microsoft:

- Administers the underlying infrastructure.
- Provides automated patching for underlying hardware and OS.

With PaaS, Microsoft:

- Administers the underlying infrastructure.
- Provides automated patching for underlying hardware, OS, and database engine.
- Manages high availability of the database.
- Automatically performs backups and replicates all data to provide disaster recovery.
- Encrypts the data at rest and in motion by default.
- Monitors your server and provides query performance insights and recommendations features.

### Analyze administrative effort

The following table describes administrative considerations for each hosting model.

| Hosting model                   | Administrative effort                                        |
| ------------------------ | ------------------------------------------------------------ |
| MySQL on Azure VMs | You have complete control over the OS, the MySQL server instance, and its configuration. You decide when to update or upgrade the OS and database engine and which patches to apply. You also decide if and when to install other software (such as an antivirus app). You can control the size of the VM, the number of disks, and their storage configurations. Some automated features are provided to simplify patching, backup, and high availability. In summary, although you have complete control, a significant amount of administrative effort is involved. |
| Azure Database for MySQL | You can continue administering your database, but you no longer have to manage the hardware, the OS, or the database engine. You can still choose to administer some items. Such as, databases, sign-in options, index tuning, query tuning, auditing, and security. In summary, there's considerably less administrative effort involved. |

### Analyze cost

With MySQL on Azure VMs, you pay for the provisioned VM, storage costs associated with the data, backup, data monitoring, and log storage. You also pay for the specific MySQL license type used.

With Azure Database for MySQL, you start by selecting the tier and SKU that's most relevant to your needs. In addition, all resources are charged hourly at a fixed rate, and you're charged for outgoing internet traffic at regular data transfer rates. Administrative costs are reduced because Microsoft manages the service for you.

Flexible Server also allows you to stop and start the server to minimize costs.

### Analyze high availability

If high availability is critical to your app, then keep in mind that to enable high availability with MySQL for Azure VMs, you're wholly responsible for configuring the required Azure components. This configuration involves extra administrative effort and cost. With Azure Database for MySQL, high availability is automatically available.

## Summary

Choose MySQL on Azure VMs when you:

- Want to avoid the time and expense of acquiring new on-premises hardware.
- Require granular control and customization of the MySQL engine that the Azure Database doesn't support for MySQL service.

Choose Azure Database for MySQL over an IaaS solution when you:

- Require online storage scaling.
- Don't want to worry about managing the underlying OS and MySQL engine.
- Require data encryption at rest for your databases.
- Want automated backup and recovery options.

Azure Database for MySQL Flexible Server also provides you with the following capabilities:

- Better control and customization over app development.
- Zone-redundant high availability.
- Managed maintenance windows.
- Read replica support (Up to 10 replicas).
