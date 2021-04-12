Let's start with a quick overview of MariaDB and Azure Database for MariaDB. This should help you evaluate the suitability of Azure Database for MariaDB for your business requirements.

MariaDB is a popular open-source database that independent software vendors and developers use to build web apps. Many large enterprise-level organizations also use it to host mission-critical applications. Azure Database for MariaDB is based on the MariaDB Community Edition that is available under the GNU General Public License, version 2 (GPLv2). It is a fully managed relational DBaaS platform.

> [!TIP]
> You can also choose to run MariaDB in a hosted virtual machine (VM) infrastructure as a service (IaaS) mode on Azure.

## Why use a DBaaS database?

A DBaaS delivery platform for your relational database apps enables you to focus on quickly developing your database apps instead of worrying about managing your VMs and their related infrastructure. You don't need to think about configuring and maintaining the platform, because that's managed by Azure. By selecting Azure Database for MariaDB, you're choosing to implement your database apps on a DBaaS basis.

> [!NOTE]
> DBaaS apps fall within the industry category of PaaS-hosted services.

## Azure Database for MariaDB definition

Azure Database for MariaDB is a fully managed, relational DBaaS platform hosted in Azure. It provides:

- Built-in high-availability at no additional cost.
- Data protection.

   > [!NOTE]
   > Azure Database for MariaDB uses automatic backups and point-in-time restoration for up to 35 days.

- Automated maintenance of the following components to keep the service secure and up-to-date:

  - Underlying hardware
  - Operating system
  - Database engine

- Predictable performance.
- Rapid scaling.
- Optimized costing.
- Enterprise-level security and compliance features to help protect your sensitive data, both at rest and while in-motion.
- Monitoring and automation to help simplify management and monitoring of large-scale deployments.

> [!NOTE]
> Most of these features require little administrative effort and are included as standard options.

Azure Database for MariaDB supports common database tools, such as MySQL Workbench. This means that by implementing Azure Database for MariaDB, you can continue working with familiar tools and platforms.

### Choose a suitable deployment option

Azure Database for MariaDB is available in the following deployment options:

- Azure Database for MariaDB
- MariaDB on Azure VMs

Let's examine these more closely.

#### Azure Database for MariaDB

This deployment option provides for a fully-managed database service that requires minimal user configuration and control. This option:

- Has minimal requirements for customizations of the database
- Is designed to handle most of the database management functions, such as:

  - Patching
  - High availability
  - Backups
  - Security

- Optimized to provide 99.99 percent availability

Consider this deployment mode to support cloud native apps that:

- Are designed to handle automated patching.
- Do not need:
  - Granular control on the patching schedule.
  - Custom MariaDB configuration settings.

#### MariaDB on Azure VMs

This option isn't a fully-managed database service and instead belongs to the industry category of IaaS. However, with this option, you can still run MariaDB Server, but inside a managed VM on the Azure cloud platform.

> [!TIP]
> You can install all the recent versions and editions of MariaDB in your hosted VM.

Consider this option only when you don't want the benefits offered by a DBaaS platform. In the next unit, let's examine Azure Database for MariaDB in more detail.
