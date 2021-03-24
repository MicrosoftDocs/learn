MySQL is one of the most popular open source databases. It's used by independent software vendors and developers to build web apps. It's also used by many large enterprise-level organizations to host critical applications. Azure Database for MySQL is based on the MySQL Community Edition available under the GPLv2 license and is a fully managed relational database as a service platform.


> [!NOTE]
> You can also choose to run Azure Database for MySQL in a hosted virtual machine (VM) infrastructure as a service (IaaS) mode.

## Why use a DBaaS database?

By selecting Azure Database for MySQL, you're choosing to implement your database apps on DBaaS basis. By using a DBaaS delivery platform for your relational database apps, you can focus on quickly developing your database apps instead of worrying about managing your VMs and related infrastructure.  


> [!NOTE]
> DBaaS apps fall within the industry category of PaaS hosted services.

## Azure Database for MySQL definition

Azure Database for MySQL is a fully managed, relational DBaaS platform hosted in Azure. It provides:

- High availability
- Data protection 

   > [!NOTE]
   > Azure Database for MySQL uses automatic backups and point-in-time-restoration for up to 35 days

- Automated maintenance of the following components to keep the service secure and up to date:

   - Underlying hardware
   - Operating system
   - Database engine 

- Predictable performance
- Elastic scaling
- Optimized costing
- Robust security and compliance features to help protect your sensitive, both at rest and while in-motion
- Monitoring and automation to help simplify management and monitoring of large-scale deployments

Most of these features require little administrative effort, and are all included as standard. Azure Database for MySQL supports common database tools, such as MySQL Workbench and others. This means that by implementing Azure Database for MySQL, you can continue working with familiar tools and platforms. 

### Choose a suitable deployment option

Azure Database for MySQL is available in a number of deployment modes, depending on your needs. These are:

- Azure Database for MySQL, for which there are two options:
   - Single Server
   - Flexible Server
- MySQL on Azure VMs

Let's examine these more closely.

> [!IMPORTANT]
> At the time of writing, March 2021, Flexible Server is in Preview.

#### Azure Database for MySQL in Single Server mode

This mode provides for a fully managed database service, and requires minimal user configuration and control. This mode has the following characteristics:

- Minimal requirements for customizations of the database
- Designed to handle most of the database management functions, such as:

   - Patching
   - High-availability
   - Backups
   - Security
- Optimized to provide 99.99% availability on single availability zone 

Consider this deployment mode to support cloud native apps that:

- Are designed to handle automated patching 
- Do not need: 
   - Granular control on the patching schedule 
   - Custom MySQL configuration settings

#### Azure Database for MySQL in Flexible Server mode

This mode also provides for a fully managed database service, but provides for more user configuration and control, when needed. This mode has the following characteristics:

- Enables you to opt for high-availability within either: 

   - A single availability zone 
   - Across multiple availability zones
- Provides better cost optimization controls with the ability to:

   - Start/stop your server 
   - Burstable SKUs 

   > [!TIP]
   > This is useful for workloads that don't always need full compute capacity.

Consider this deployment mode when you require:

- Custom control and customizations of MySQL engine
- Zone redundant high-availability
- Managed maintenance windows

#### MySQL on Azure VMs

This mode isn't a fully managed database service and, instead, falls into the industry category of IaaS. However, with this option, you can still run MySQL Server, but inside a managed VM on the Azure cloud platform. 

> [!TIP]
> You can install all recent versions and editions of MySQL in your hosted VM.

Consider this mode only when you don't want the benefits offered by a DBaaS platform.

## How to choose the appropriate deployment option


To further help you determine which deployment option best suits your needs, refer to the following table. 

| Attribute                      | Azure Database for MySQL Single Server                       | Azure Database for MySQL Flexible Server                     | MySQL on Azure VMs                                           |
| :----------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| MySQL Version Support          | 5.6, 5.7 and 8.0                                               | 5.7 and 8.0                                                    | Any version                                                  |
| Compute scaling                | Supported                                                    | Supported                                                    | Supported                                                    |
| Storage size                   | 5 GiB to 16 TiB                                              | 5 GiB to 16 TiB                                              | 32 GiB to 32,767 GiB                                         |
| Online Storage scaling         | Supported                                                    | Supported                                                    | Not supported                                                |
| Auto storage scaling           | Supported                                                    | *Not supported in preview*                                   | Not supported                                                |
| Additional IOPs scaling        | Not Supported                                                | Supported                                                    | Not supported                                                |
| Network Connectivity           | - Public endpoints with server firewall. - Private access with Private Link support. | - Public endpoints with server firewall. - Private access with Virtual Network integration. | - Public endpoints with server firewall. - Private access with Private Link support. |
| Service-level agreement (SLA)  | 99.99% availability SLA                                      | *No SLA in preview*                                          | 99.99% using Availability Zones                              |
| Operating system patching      | Automatic                                                    | Automatic with custom maintenance window control             | Managed by end users                                         |
| MySQL patching                 | Automatic                                                    | Automatic with custom maintenance window control             | Managed by end users                                         |
| High availability              | Built-in HA within single availability zone                  | Built-in HA within and across availability zones             | Custom managed using clustering, replication, etc.           |
| Zone redundancy                | Not supported                                                | Supported                                                    | Supported                                                    |
| Zone placement                 | Not supported                                                | Supported                                                    | Supported                                                    |
| Hybrid scenarios               | Supported with Data-in Replication                           | *Not available in preview*                                   | Managed by end users                                         |
| Read replicas                  | Supported (up to 5 replicas)                                 | Supported (up to 10 replicas)                                | Managed by end users                                         |
| Backup                         | Automated with 7-35 days retention                           | Automated with 1-35 days retention                           | Managed by end users                                         |
| Monitoring database operations | Supported                                                    | Supported                                                    | Managed by end users                                         |
| Disaster recovery              | Supported with geo-redundant backup storage and cross region read replicas | *Not supported in preview*                                   | Custom Managed with replication technologies                 |
| Query Performance Insights     | Supported                                                    | *Not available in preview*                                   | Managed by end users                                         |
| Reserved Instance Pricing      | Supported                                                    | *Not available in preview*                                   | Supported                                                    |
| Azure AD Authentication        | Supported                                                    | *Not available in preview*                                   | Not Supported                                                |
| Data Encryption at rest        | Supported with customer managed keys                         | Supported with service managed keys                          | Not Supported                                                |
| SSL/TLS                        | Enabled by default with support for TLS v1.2, 1.1 and 1.0    | Enforced with TLS v1.2                                       | Supported with TLS v1.2, 1.1 and 1.0                         |
| Fleet Management               | Supported with Azure CLI, PowerShell, REST, and Azure Resource Manager | Supported with Azure CLI, PowerShell, REST, and Azure Resource Manager | Supported for VMs with Azure CLI, PowerShell, REST, and Azure Resource Manager |

