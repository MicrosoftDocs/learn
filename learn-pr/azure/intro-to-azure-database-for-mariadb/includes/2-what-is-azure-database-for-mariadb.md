MariaDB is a very popular open source database. It's used by independent software vendors and developers to build web apps. It's also used by many large enterprise-level organizations to host mission critical applications. 

Azure Database for MariaDB is based on the MariaDB Community Edition available under the GPLv2 license and is a fully managed relational database as a service platform.


> [!TIP]
> You can also choose to run MariaDB in a hosted virtual machine (VM) infrastructure as a service (IaaS) mode on Azure.

## Why use a DBaaS database?

By selecting Azure Database for MariaDB, you're choosing to implement your database apps on a DBaaS basis. By using a DBaaS delivery platform for your relational database apps, you can focus on quickly developing your database apps instead of worrying about managing your VMs and their related infrastructure. You don't need to think about configuring and maintaining the platform because that's managed by Azure. 


> [!NOTE]
> DBaaS apps fall within the industry category of PaaS hosted services.

## Azure Database for MariaDB definition

Azure Database for MariaDB is a fully managed, relational DBaaS platform hosted in Azure. It provides:

- Built-in high-availability at no additional cost
- Data protection 

   > [!NOTE]
   > Azure Database for MariaDB uses automatic backups and point-in-time restoration for up to 35 days

- Automated maintenance of the following components to keep the service secure and up to date:

   - Underlying hardware
   - Operating system
   - Database engine 

- Predictable performance
- Rapid scaling
- Optimized costing
- Enterprise-level security and compliance features to help protect your sensitive, both at rest and while in-motion
- Monitoring and automation to help simplify management and monitoring of large-scale deployments

Most of these features require little administrative effort, and are all included as standard. 

Azure Database for MariaDB supports common database tools, such as MySQL Workbench and others. This means that by implementing Azure Database for MariaDB, you can continue working with familiar tools and platforms. 

### Choose a suitable deployment option

Azure Database for MariaDB is available in a number of deployment options, depending on your needs. These are:

- Azure Database for MariaDB
- MariaDB on Azure VMs

Let's examine these more closely.

> [!IMPORTANT]
> At the time of writing, March 2021, Flexible Server is in Preview.

#### Azure Database for MariaDB

This mode provides for a fully managed database service, and requires minimal user configuration and control. This mode has the following characteristics:

- Minimal requirements for customizations of the database
- Designed to handle most of the database management functions, such as:

   - Patching
   - High-availability
   - Backups
   - Security
- Optimized to provide 99.99% availability

Consider this deployment mode to support cloud native apps that:

- Are designed to handle automated patching 
- Do not need: 
   - Granular control on the patching schedule 
   - Custom MariaDB configuration settings


#### MariaDB on Azure VMs

This option isn't a fully managed database service and, instead, falls into the industry category of IaaS. However, with this option, you can still run MariaDB Server, but inside a managed VM on the Azure cloud platform. 

> [!TIP]
> You can install all recent versions and editions of MariaDB in your hosted VM.

Consider this option only when you don't want the benefits offered by a DBaaS platform. 

Let's examine Azure Database for MariaDB in more detail.

