Let's start with a quick overview of DBaaS databases and Azure Database for MySQL. This should help you decide whether your organization can benefit from migrating to Azure Database for MySQL.

## What is DBaaS?

DBaaS is a service that organizations can use to access databases on the cloud. A DBaaS delivery platform for your relational database apps enables you to focus on quickly developing your database apps instead of worrying about managing your VMs and their related infrastructure. You can use Azure Database for MySQL to implement your database apps on a DBaaS basis. You don't need to think about configuring and maintaining the platform, because that's managed by Azure.

> [!NOTE]
> DBaaS apps fall within the industry category of PaaS hosted services.

### What is MySQL?

MySQL is one of the most popular open source databases. It's used by independent software vendors and developers to build web apps. It's also used by many large enterprise-level organizations to host mission critical applications.

Azure Database for MySQL is based on the MySQL Community Edition available under the GPLv2 license and is a fully managed relational database as a service platform.

> [!TIP]
> You can also choose to run MySQL in a hosted VM infrastructure as a service (IaaS) mode on Azure.

## Azure Database for MySQL definition

Azure Database for MySQL is a fully managed, relational DBaaS platform hosted in Azure. It provides:

- High availability
- Data protection

   > [!NOTE]
   > Azure Database for MySQL uses automatic backups and point-in-time-restoration for up to 35 days.

- Automated maintenance of the following components to keep the service secure and up-to-date:

  - Underlying hardware
  - Operating system
  - Database engine

- Predictable performance
- Elastic scaling
- Optimized costing
- Robust security and compliance features to help protect your sensitive data, both at rest and while in transit
- Monitoring and automation to help simplify management and monitoring of large-scale deployments

Most of these features require little administrative effort, and are all included as standard.

Azure Database for MySQL supports common database tools, such as MySQL Workbench and others. By implementing Azure Database for MySQL, you can continue working with familiar tools and platforms.

## How to choose a suitable deployment option

Azure Database for MySQL is available in a number of deployment modes, depending on your needs. These are:

- Azure Database for MySQL, for which there are two options:
  - Single Server
  - Flexible Server
- MySQL on Azure VMs

Let's examine these more closely.

> [!IMPORTANT]
> At the time of writing (March 2021), Flexible Server is in preview.

### Azure Database for MySQL in Single Server mode

This mode provides for a fully-managed database service and requires minimal user configuration and control. This mode has the following characteristics:

- Minimal requirements for customizations of the database
- Designed to provide most of the database management functions, such as:

  - Patching
  - High availability
  - Backups
  - Security
- Optimized to provide 99.99% availability on single availability zone

Consider this deployment mode to support cloud native apps that:

- Are designed to handle automated patching.
- Do not need:
  - Granular control on the patching schedule.
  - Custom MySQL configuration settings.

### Azure Database for MySQL in Flexible Server mode

This mode also provides for a fully-managed database service, but provides for more user configuration and control, when needed. This mode has the following characteristics:

- It enables you to opt for high availability within either:

  - A single availability zone
  - Across multiple availability zones
- It provides better cost-optimization controls with the ability to:

  - Start and stop your server 
  - Implement Burstable SKU

   > [!TIP]
   > This is useful for workloads that don't always need full compute capacity.

Consider this deployment mode when you require:

- Custom control and customizations of MySQL engine
- Zone redundant high availability
- Managed maintenance windows

#### MySQL on Azure VMs

This mode isn't a fully-managed database service. Instead, it belongs to the industry category of IaaS. However, with this option, you can still run MySQL Server, but inside a managed VM on the Azure cloud platform.

> [!TIP]
> You can install all recent versions and editions of MySQL in your hosted VM.

Consider this mode only when you don't want the benefits offered by a DBaaS platform.

In the next unit, let's examine Azure Database for MySQL in more detail.
