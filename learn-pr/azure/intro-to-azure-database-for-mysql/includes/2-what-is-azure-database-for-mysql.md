To help you decide whether your organization can benefit from migrating to Azure Database for MySQL, let's start with a quick overview of DBaaS databases and suitable options for hosting MySQL on Azure and Azure Database for MySQL.

## What is DBaaS?

With a DBaaS, organizations can set up and access databases in the cloud without the need to manage virtual machines (VMs) and other underlying infrastructure. Azure Database for MySQL, a fully managed service, exemplifies this by enabling the development of database applications on a DBaaS platform, with all configuration and maintenance handled by Microsoft Azure.

> [!NOTE]
> DBaaS apps fall within the broader category of Platform as a Service (PaaS) offerings.

### What is MySQL?

MySQL is an open-source, robust database platform extensively used by both developers and enterprise-level organizations to host web applications and mission-critical systems. It is optimized for internet-scale OLTP workloads and is a key part of the LAMP (Linux, Apache, MySQL, PHP) stack, one of the most popular technology stacks for web development.

## How to choose a suitable hosting option

With Azure, your MySQL workloads can run in a hosted virtual machine infrastructure as a service (IaaS) or as a hosted platform as a service (PaaS), also referred to as a relational database as a service (DBaaS). The following represent the two hosting options covered by this module:

- **Azure Database for MySQL flexible server**: Azure Database for MySQL flexible server is a fully managed, relational DBaaS hosted on Azure and is based on the open-source MySQL Community Edition. It provides several availability, maintenance, security and performance capabilities, out-of-the-box, requiring almost no administration, but also allows for granular control and flexibility over database management functions and configuration settings.

> [!NOTE]
> Throughout this module, when you see "Azure Database for MySQL", we are referring to Azure Database for MySQL flexible server.

- **MySQL on Azure VMs**: For those requiring IaaS, this option offers flexibility in managing MySQL Server on Azure’s managed VMs, suitable for scenarios not covered by DBaaS benefits.

Let's examine these options more closely.

### Azure Database for MySQL flexible server deployment mode

Azure Database for MySQL is a fully managed, relational DBaaS platform hosted in Azure. The service provides:

- High availability and disaster recovery options, including zone-redundant configurations, cross-region replication, and Universal Geo Restore.
- Data protection with automatic and on-demand backups and the option for long-term retention (up to 10 years in preview).

   > [!NOTE]
   > Azure Database for MySQL uses automatic backups and point-in-time restoration for up to 35 days, which you can use independently or in addition to long-term retention.

- Automated maintenance, to ensure that the service is the most secure and up to date, of the following components:

  - Underlying hardware
  - OS
  - Database engine
  - Flexibility to select your scheduled maintenance window

- Predictable performance, with features like auto-scaling IOPS and Accelerated Logs, which help to match workload demands.
- Elastic scaling and optimized costs, with capabilities for starting/stopping the server and burstable compute tier.
- Enterprise-grade security and compliance features to help protect sensitive data at rest and while in transit.
- Advanced security features, including data encryption with Customer Managed Keys, private connectivity with Azure Private Link, and simplified threat protection using Microsoft Defender for Cloud.
- Monitoring and automation tools that streamline management of large-scale deployments.

These standard features require little administrative effort to implement and configure.

Azure Database for MySQL supports common tools like MySQL Workbench and integrates with Azure Data Studio through the [MySQL extension](https://learn.microsoft.com/azure-data-studio/extensions/mysql-extension), maintaining a familiar workflow for developers. It provides you the flexibility to develop applications using your favorite tools, languages, and frameworks, deploy faster by integrating with Azure services like App Services or AKS, and automate CI/CD tasks using GitHub or Azure DevOps.

Consider this deployment mode to support cloud-native apps and solutions that:

- Are designed to manage automated patching with sufficient flexibility and control of the maintenance schedule.

- Support high availability either:
  - Within a single availability zone
  - Across multiple availability zones

- Can benefit from cost-optimization controls through the ability to:
  - Start and stop your server.
  - Implement burstable compute.

   > [!TIP]
   > These flexible cost-optimization controls are useful for workloads that don't always need full computing capacity.

- Require the database to scale its compute and storage dynamically.

- Need out-of-the-box performance, along with the ability to control and customize MySQL configuration settings.

- Can benefit from a simplified development experience and tight interoperability with the Azure ecosystem.

#### MySQL on Azure VMs

This mode belongs to the industry category of IaaS rather than being a fully managed database service. It allows you to run MySQL Server inside a managed VM on the Azure cloud platform.

> [!TIP]
> You can install all recent versions and editions of MySQL in your hosted VM.

Consider this mode only when you need to trade the ease of use and other benefits included in a DBaaS platform for greater control provided by IaaS deployments.

## How are the hosting options different?

You can deploy MySQL on Azure in different ways. The following table identifies the key characteristics of each of these approaches.

| Hosting option            | Summary                                                                              |
| ------------------------- | ------------------------------------------------------------------------------------ |
| Azure Database for MySQL  | A fully managed DBaaS platform with extensive user configuration and control.        |
| MySQL on Azure VMs        | An IaaS-based option giving full control over the database implementation.           |

Here is a closer examination of the differences in features:

- **MySQL Version Support**:
  - Azure Database for MySQL supports MySQL versions 5.7 and 8.0, with automated major and minor version upgrades.
  - MySQL on Azure VMs allows any MySQL version installation, providing flexibility for legacy support.
- **Compute Scaling**:
  - Both options provide scalable resources to accommodate varying load demands.
- **Network connectivity**:
  - All options support:
    - Public endpoints with a server firewall.
    - Private access with Private Link support is available for MySQL on Azure VMs.
    - Private access with Virtual Network integration is available for Azure Database for MySQL.
- **SSL/TLS connectivity**:
  - Supported across all hosting methods to ensure secure data transmission.
- **Storage and IOPS**:
  - Azure Database for MySQL supports storage sizes between 5 gigabytes (GiBs) and 32 terabytes (YiBs). It also supports automated storage scaling and auto-scaling of IOPS.
  - MySQL on Azure VMs supports from 32 GiB to 32,767 GiB but doesn't support online storage or IOPS scaling.
- **Updating and patching**:
  - OS updates:
    - Automatic for Azure Database for MySQL.
    - Managed by end users for MySQL on Azure VMs.
  - MySQL patching:
    - Automatic for Azure Database for MySQL.
    - Managed by end users for MySQL on Azure VMs.
- **High availability**:
  - Azure Database for MySQL supports built-in high availability with multiple availability zones.
  - MySQL on Azure VMs requires that you custom-manage these settings.
- **Data encryption at rest**:
  - Azure Database for MySQL supports data encryption at rest with service-managed or customer-managed keys.
  - MySQL on Azure VMs doesn't support data encryption at rest.
- **Backup**:
  - Azure Database for MySQL provides automated backups with configurable retention up to 35 days and now supports long-term retention up to 10 years.
  - Backups on Azure VMs require manual management. Additionally, Azure Database for MySQL comes with other built-in features like monitoring and alerting, the ability to scale out up to 10 read replicas, Microsoft Entra ID authentication, and Microsoft Defender for Cloud support that are either not available or need manual management while running MySQL on Azure VMs.

In the next unit, you examine Azure Database for MySQL in more detail.
