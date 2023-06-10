To help you decide whether your organization can benefit from migrating to Azure Database for MySQL, let's start with a quick overview of DBaaS databases and Azure Database for MySQL. 

## What is DBaaS?

*DBaaS* is a service that organizations can use to access databases in the cloud. A DBaaS delivery platform allows you to focus on developing your database apps instead of managing your virtual machines (VMs) and their related infrastructure. You can use Azure Database for MySQL to implement your database apps on a DBaaS basis. You don't need to worry about configuring and maintaining the platform because Microsoft Azure manages that.

> [!NOTE]
> DBaaS apps fall within the industry category of PaaS-hosted services.

### What is MySQL?

MySQL is one of the most popular open-source databases. Independent software vendors and developers use it to build web apps. Many enterprise-level organizations also use MySQL to host mission-critical applications.

Azure Database for MySQL is based on the MySQL Community Edition available under the GPLv2 license. It's also a fully managed relational DBaaS platform.

> [!TIP]
> On Azure, you can also run MySQL in a hosted VM infrastructure as a service (IaaS) mode.

## Azure Database for MySQL definition

*Azure Database for MySQL* is a fully managed, relational DBaaS platform hosted in Azure. It provides:

- High availability
- Greater data protection

   > [!NOTE]
   > Azure Database for MySQL uses automatic backups and point-in-time restoration for up to 35 days.

- Automated maintenance of the following components to keep the service more secure and up-to-date:

  - Underlying hardware
  - OS
  - Database engine

- Predictable performance
- Elastic scaling
- Optimized costing
- Robust security and compliance features to help protect sensitive data, both at rest and while in transit
- Monitoring and automation to help simplify management and monitoring of large-scale deployments

These features require little administrative effort and are all considered standard options.

Azure Database for MySQL supports common tools such as MySQL Workbench and others. You can continue working with familiar tools and platforms by implementing Azure Database for MySQL.

Azure Database for MySQL also supports the MySQL extension in Azure Data Studio.

## How to choose a suitable hosting option

Azure Database for MySQL is available in two hosting options:

- Azure Database for MySQL - Flexible Server
- MySQL on Azure VMs

Let's examine these options more closely.

### Azure Database for MySQL in Flexible Server mode

This mode provides for a fully managed database service and more user configuration and control when needed. This mode has the following characteristics:

- Minimal requirements for customizations of the database
- Designed to provide most of the database management functions, such as:
  - Patching
  - High availability
  - Backups
  - Security
- Optimized to provide 99.99% availability on a single availability zone

Consider this deployment mode to support cloud-native apps that:

- Are designed to manage automated patching.
- Don't need:
  - Granular control on the patching schedule.
  - Custom MySQL configuration settings.

- It enables you to opt for high availability either:
  - Within a single availability zone
  - Across multiple availability zones

- It provides cost-optimization controls with the ability to:
  - Start and stop your server.
  - Implement burstable SKU.

   > [!TIP]
   > This is useful for workloads that don't always need full computing capacity.

Consider this deployment mode when you require:

- Custom control and customizations of MySQL engine.
- Zone-redundant high availability.
- Managed maintenance windows.

#### MySQL on Azure VMs

This mode isn't a fully managed database service; instead, it belongs to the industry category of IaaS. With this option, you can still run MySQL Server, but it runs inside a managed VM on the Azure cloud platform.

> [!TIP]
> You can install all recent versions and editions of MySQL in your hosted VM.

Consider this mode only when you don't want the benefits included in a DBaaS platform.

In the next unit, let's examine Azure Database for MySQL in more detail.