Here, we'll explore how Azure Database for MySQL works. If you're using MySQL, and are considering using Azure to host your MySQL apps, you must choose between hosting in one of the following ways:

- PaaS, by using one of the two Azure Database for MySQL deployment options
- IaaS, by using MySQL on Azure VMs

In addition, if you choose to use Azure Database for MySQL, you'll also have to select one of the following two options:

- Single Server
- Flexible Server

In this unit, you'll learn more about the differences between these options and the functions and features they provide, together with their specific requirements.

## How are the hosting options different?

There are three possible hosting options. The following table identifies the key characteristics of each of these options.

| Option                                           | Summary                                                      |
| ------------------------------------------------ | ------------------------------------------------------------ |
| Azure Database for MySQL in Single Server mode   | Fully managed DBaaS requiring minimal user configuration or control. |
| Azure Database for MySQL in Flexible Server mode | Fully managed DBaaS, but providing more user configuration and control, if required. |
| MySQL on Azure VMs                               | A database implementation that uses IaaS. The database is managed by you.                   |

Let's examine more closely the differences in the features:

- Version of MySQL:

  - All options support versions 5.7 and 8.0.
  - Flexible Server also supports 5.6.
  - MySQL on Azure VMs supports any version you want to install.
- Compute scaling. All options are able to scale, as required, to accommodate changes in load.
- Network connectivity:
  - All support public endpoints with server firewall.
  - Private access with Private Link support is available for Single Server and MySQL on Azure VMs.
  - Private access with Virtual Network integration is available for Flexible Server.
- SSL/TLS connectivity is supported on all platforms.
- Storage:
  - Both Azure Database for MySQL options support storage sizes between 5 gibibytes (GiBs) to 16 tebibytes (TiBs). Both also support online storage scaling, although currently, only Single Server supports auto storage scaling.
  - MySQL on Azure VMs supports the range 32 GiB to 32,767 GiB. However, it doesn't support online storage scaling.

- Updating and patching:
  - Operating system updates:
    - Automatic for Azure Database for MySQL options, although administrators have more control with Flexible Server.
    - Managed by end users for MySQL on Azure VMs.

  - MySQL patching:
    - Automatic for Azure Database for MySQL options, although administrators have more control with Flexible Server.
    - Managed by end users for MySQL on Azure VMs.

- High availability:
  - Single Server supports built-in high availability within a single availability zone
  - Flexible Server supports built-in high availability with multiple availability zones
  - MySQL on Azure VMs requires that you custom-manage these settings
- Data encryption at rest:
  - Single Server supports it with customer-managed keys
  - Flexible Server supports it with service-managed keys
  - Unsupported on MySQL on Azure VMs
- Backup:
  - Automated on Single Server  with retention between 7 and 35 days
  - Automated on Flexible Server with retention between 1 and 35 days
  - Manually managed on MySQL on Azure VMs

> [!IMPORTANT]
> Azure Database for MySQL Flexible Server is in Preview. Consequently, not all planned features are currently available.

## Azure Database for MySQL architecture

Let's examine the architecture of Azure Database for MySQL. We'll focus on the Flexible Server option. In the diagram, an instance of Azure Database for MySQL is deployed. It's configured with Azure Premium Storage for data and logs. MySQL also has access to locally redundant storage for backup.

The instance of MySQL is hosted in Availability Zone 1, but other availability zones are available and can be used by Flexible Server. Connected to the instance of MySQL are various client apps.

:::image type="content" source="../media/flexible-server.png" alt-text="The detailed architecture of Azure Database for MySQL Flexible Server in a typical organization.":::

### How high availability works

In the case of Flexible Server, within the single availability zone, the following steps occur after a hosting server failure:

1. Azure provisions a new VM.
2. Azure maps the storage and data files to the new VM.
3. Azure brings the MySQL database engine online.
4. Client apps reconnect to the new instance of MySQL.

> [!NOTE]
> If you have provisioned high availability across zones, the hot standby server is maintained in another availability zone in the same Azure region.

Things are slightly different with Single Server:

1. Azure provisions a new compute container.
2. Azure maps the data files to the new container.
3. Azure brings the database engine online.
4. A gateway service redirects clients to the new instance.

### How backups work

The process is the same for Single Server and Flexible Server options. The Azure Database for MySQL service automatically creates backups and stores them in locally redundant storage. You're then able to use the backups to restore your server to any point in time within the retention period (35 days).

### How scaling works

Scaling works in broadly the same way for both Single Server and Flexible Server. However, the way it works is controlled by the specific SKU you select. Both options are available in 3 SKUs. For Single Server, these SKUs are:

- Basic. Best suited for low-cost development and low concurrency workloads.
- General Purpose.  Better suited for production workloads requiring high concurrency, scale, and predictable performance.
- Memory Optimized. Better suited for production workloads requiring high concurrency, scale, and predictable performance.

For Flexible Server, the SKUs are:

- Burstable. Best suited for low-cost development and low concurrency workloads that don't need full compute capacity continuously.
- General Purpose. Better suited for production workloads requiring high concurrency, scale, and predictable performance.
- Memory Optimized. Better suited for production workloads requiring high concurrency, scale, and predictable performance.

Depending on the SKU, you can configure the desired settings, and then adjust the scale settings as required to meet your application needs.

Next, let's consider whether Azure Database for MySQL is suitable for  your organization, its apps, and its database workloads.
