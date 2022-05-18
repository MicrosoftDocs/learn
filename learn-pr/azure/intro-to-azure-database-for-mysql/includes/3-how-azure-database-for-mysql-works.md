In this unit, you'll explore how Azure Database for MySQL works. If you're using MySQL and are considering using Azure to host your MySQL apps, you must choose between one of the following hosting methods:

- PaaS, by using one of the two Azure Database for MySQL deployment options
- IaaS, by using MySQL on Azure VMs

If you choose to use Azure Database for MySQL, you'll also have to choose between the Single Server and Flexible Server deployment modes.

In this unit, you'll learn more about the differences between these hosting options and deployment modes. You'll also learn about the functions and features they provide, along with their specific requirements.

## How are the hosting options and deployment modes different?

You can deploy MySQL on Azure in three ways. The following table identifies the key characteristics of each of these approaches.

| Hosting option / deployment mode                                          | Summary                                                      |
| ------------------------------------------------ | ------------------------------------------------------------ |
| Azure Database for MySQL in Single Server mode   | Fully managed DBaaS requiring minimal user configuration or control. |
| Azure Database for MySQL in Flexible Server mode | Fully managed DBaaS, but providing more user configuration and control, if required. |
| MySQL on Azure VMs                               | A database implementation that uses IaaS and is managed by you.                   |

Let's examine more closely the differences in features:

- MySQL version:

  - All deployment options support versions 5.7 and 8.0.
  - Flexible Server deployment also supports version 5.6.
  - MySQL on Azure VMs supports any MySQL version you want to install.
- Compute scaling. All options can scale as necessary to accommodate load changes.
- Network connectivity:
  - All options support public endpoints with a server firewall.
  - Private access with Private Link support is available for Single Server and MySQL on Azure VMs.
  - Private access with Virtual Network integration is available for Flexible Server.
- SSL/TLS connectivity is supported on all platforms.
- Storage:
  - Both Azure Database for MySQL deployment modes support storage sizes between 5 gibibytes (GiBs) to 16 tebibytes (TiBs). Both also support online storage scaling.
  - Currently only Single Server supports automatic storage scaling.
  - MySQL on Azure VMs supports from 32 GiB to 32,767 GiB but doesn't support online storage scaling.

- Updating and patching:
  - OS updates:
    - Automatic for both Azure Database for MySQL deployment modes, although administrators have more control with Flexible Server.
    - Managed by end users for MySQL on Azure VMs.

  - MySQL patching:
    - Automatic for both Azure Database for MySQL deployment modes, although administrators have more control with Flexible Server.
    - Managed by end users for MySQL on Azure VMs.

- High availability:
  - Single Server supports built-in high availability within a single availability zone.
  - Flexible Server supports built-in high availability with multiple availability zones.
  - MySQL on Azure VMs requires that you custom-manage these settings.
- Data encryption at rest:
  - Single Server supports this with customer-managed keys.
  - Flexible Server supports this with service-managed keys.
  - MySQL on Azure VMs doesn't support this.
- Backup:
  - On Single Server, backups are automated with retention between 7 and 35 days.
  - On Flexible Server, backups are automated with retention between 1 and 35 days.
  - On MySQL on Azure VMs, backups are managed manually.

## Azure Database for MySQL architecture

Let's examine the Azure Database for MySQL architecture. We'll focus on the Flexible Server deployment mode. In the following diagram, an instance of Azure Database for MySQL is deployed. It's configured with Azure Premium Storage for data and logs. MySQL also has access to locally redundant storage for backup.

The MySQL instance is hosted in Availability zone 1. Other availability zones are present, and Flexible Server could use those as well. Various client apps are connected to the MySQL instance.

:::image type="content" source="../media/flexible-server.png" alt-text="This is a detailed architecture of Azure Database for MySQL Flexible Server in a typical organization as previously described.":::

### How high availability works

For Flexible Server, within the single availability zone, the following steps occur after a hosting server failure:

1. Azure provisions a new VM.
2. Azure maps the storage and data files to the new VM.
3. Azure brings the MySQL database engine online.
4. Client apps reconnect to the new MySQL instance.

> [!NOTE]
> If you have provisioned high availability across zones, the hot standby server is maintained in another availability zone in the same Azure region.

Things are slightly different with Single Server after a hosting server failure:

1. Azure provisions a new compute container.
2. Azure maps the data files to the new container.
3. Azure brings the database engine online.
4. A gateway service redirects clients to the new instance.

### How backups work

The backup process is the same for Single Server and Flexible Server deployment modes. The Azure Database for MySQL service automatically creates backups and stores them in locally redundant storage. You're then able to use the backups to restore your server to any point in time within the retention period (35 days).

### How scaling works

Scaling works in broadly the same way for both Single Server and Flexible Server deployment modes. However, how it works is determined by the specific SKU you select. Both deployment modes are available in three SKUs.

For Single Server, these SKUs are:

- Basic. Best suited for low-cost development and low-concurrency workloads.
- General Purpose. Better suited for production workloads requiring high concurrency, scale, and predictable performance.
- Memory Optimized. Better suited for production workloads requiring high concurrency, scale, and predictable performance.

For Flexible Server, the SKUs are:

- Burstable. Best suited for low-cost development and low concurrency workloads that don't need full compute capacity continuously.
- General Purpose. Better suited for production workloads requiring high concurrency, scale, and predictable performance.
- Memory Optimized. Better suited for production workloads requiring high concurrency, scale, and predictable performance.

Depending on the SKU, you can configure the desired settings, and then adjust the scale settings as required to meet your application needs.

Next, let's consider whether Azure Database for MySQL is suitable for your organization, its apps, and its database workloads.
