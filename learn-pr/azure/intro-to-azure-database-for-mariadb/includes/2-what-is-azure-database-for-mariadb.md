To help you evaluate whether using Azure Database for MariaDB can address your business requirements, let's start with a quick overview of MariaDB and Azure Database for MariaDB. 

MariaDB is a popular open-source database that independent software vendors and developers use to build web apps. Many large enterprise-level organizations also use it to host mission-critical applications. Azure Database for MariaDB is based on the MariaDB Community Edition. The older edition is available under the GNU General Public License, version 2 (GPLv2). It's a fully managed relational DBaaS platform.

> [!TIP]
> MariaDB also runs in a hosted virtual machine (VM) infrastructure as a service (IaaS) mode on Azure.

## Why use a DBaaS database?

Why use a DBaaS delivery platform for your relational database apps? It enables you to focus on quickly developing them instead of worrying about managing your VMs and their related infrastructure. You don't need to think about configuring and maintaining the platform. Azure manages it for you. If you use Azure Database for MariaDB, you're choosing to implement your database apps on a DBaaS basis.

> [!NOTE]
> DBaaS apps fall within the industry category of PaaS-hosted services.

## Azure Database for MariaDB definition

Azure Database for MariaDB is a fully managed, relational DBaaS platform hosted in Azure. It provides:

- Built-in high-availability at no extra cost.
- Data protection.

   > [!NOTE]
   > Azure Database for MariaDB uses automatic backups and point-in-time restorations. It'll store them for 35 days maximum.

- Automated maintenance of the following components to keep the service secure and up to date:

  - Underlying hardware
  - OS
  - Database engine

- Predictable performance.
- Rapid scaling.
- Optimized costing.
- Enterprise-level security and compliance features to help protect your sensitive data at rest and in motion.
- Monitoring and automation to help simplify management and monitoring of large-scale deployments.

> [!NOTE]
> Most of these features, included as standard options, require minimal administrative effort.

Azure Database for MariaDB supports common database tools, such as MySQL Workbench. When you implement Azure Database for MariaDB, you can continue working with familiar tools and platforms.

### Choose a suitable deployment option

Azure Database for MariaDB is available in the following deployment options:

- Azure Database for MariaDB.
- MariaDB on Azure VMs.

Let's examine these deployments more closely.

#### Azure Database for MariaDB

This option provides for a fully managed database service that requires minimal user configuration and control. This option:

- Has minimal requirements for database customizations.
- Is designed to handle most database-management functions, such as:

  - Patching
  - High availability
  - Backups
  - Security

- Is optimized to provide 99.99 percent availability.

Consider this deployment mode to support cloud native apps that:

- Are designed to manage automated patching.
- Don't require:
  - Granular control of the patching schedule.
  - Custom MariaDB configuration settings.

#### MariaDB on Azure VMs

This option isn't a fully managed database service. Rather, it's an IaaS. However, this option does enable you to run MariaDB Server, inside a managed VM on the Azure cloud platform.

> [!TIP]
> You can install all recent MariaDB versions and editions in your hosted VM.

Consider this option only when you don't want the benefits that a DBaaS platform offers. In the next unit, we examine Azure Database for MariaDB in more detail.
