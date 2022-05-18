Let's start with a quick overview of DBaaS databases and Azure Database for MySQL. This will help you decide whether your organization can benefit from migrating to Azure Database for MySQL.

## What is DBaaS?

*DBaaS* is a service that organizations can use to access databases in the cloud. Using a DBaaS delivery platform allows you to focus on developing your database apps instead of managing your virtual machines (VMs) and their related infrastructure. You can use Azure Database for MySQL to implement your database apps on a DBaaS basis. You don't need to worry about configuring and maintaining the platform, because that's managed by Microsoft Azure.

> [!NOTE]
> DBaaS apps fall within the industry category of PaaS-hosted services.

### What is MySQL?

MySQL is one of the most popular open-source databases. It's used by independent software vendors and developers to build web apps. Many enterprise-level organizations also use MySQL to host mission-critical applications.

Azure Database for MySQL is based on the MySQL Community Edition available under the GPLv2 license. It's also a fully managed relational DBaaS platform.

> [!TIP]
> You can also choose to run MySQL in a hosted VM infrastructure as a service (IaaS) mode on Azure.

## Azure Database for MySQL definition

*Azure Database for MySQL* is a fully managed, relational DBaaS platform hosted in Azure. It provides:

- High availability
- Greater data protection

   > [!NOTE]
   > Azure Database for MySQL uses automatic backups and point-in-time-restoration for up to 35 days.

- Automated maintenance of the following components to keep the service more secure and up-to-date:

  - Underlying hardware
  - OS
  - Database engine

- Predictable performance
- Elastic scaling
- Optimized costing
- Robust security and compliance features to help protect sensitive data, both at rest and while in transit
- Monitoring and automation to help simplify management and monitoring of large-scale deployments

Most of these features require little administrative effort and are all included as standard options.

Azure Database for MySQL supports common database tools, such as MySQL Workbench and others. By implementing Azure Database for MySQL, you can continue working with familiar tools and platforms.

## How to choose a suitable hosting option

Azure Database for MySQL is available in two hosting options:

- Azure Database for MySQL, for which there are two deployment modes:
  - Single Server
  - Flexible Server
- MySQL on Azure VMs

Let's examine these options more closely.

### Azure Database for MySQL in Single Server mode

This mode provides for a fully managed database service and requires minimal user configuration and control. This mode has the following characteristics:

- Minimal requirements for customizations of the database
- Designed to provide most of the database management functions, such as:

  - Patching
  - High availability
  - Backups
  - Security
- Optimized to provide 99.99% availability on single availability zone

Consider this deployment mode to support cloud native apps that:

- Are designed to manage automated patching.
- Don't need:
  - Granular control on the patching schedule.
  - Custom MySQL configuration settings.

### Azure Database for MySQL in Flexible Server mode

This mode also provides for a fully managed database service, but provides for more user configuration and control, when needed. This mode has the following characteristics:

- It enables you to opt for high availability either:

  - Within a single availability zone
  - Across multiple availability zones
- It provides better cost-optimization controls with the ability to:

  - Start and stop your server.
  - Implement burstable SKU.

   > [!TIP]
   > This is useful for workloads that don't always need full compute capacity.

Consider this deployment mode when you require:

- Custom control and customizations of MySQL engine.
- Zone-redundant high availability.
- Managed maintenance windows.

#### MySQL on Azure VMs

This mode isn't a fully managed database service; instead, it belongs to the industry category of IaaS. With this option you can still run MySQL Server, but it runs inside a managed VM on the Azure cloud platform.

> [!TIP]
> You can install all recent versions and editions of MySQL in your hosted VM.

Consider this mode only when you don't want the benefits included in a DBaaS platform.

In the next unit, let's examine Azure Database for MySQL in more detail. 
