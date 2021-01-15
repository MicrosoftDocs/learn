If you have a functional on-premises database, why should you consider moving it into a cloud service, such as Azure? Similarly, why consider implementing a new database system in Azure? Many organizations perform this migration because it's easy and relatively cheap to create a highly available and scalable service in the cloud, compared to using an on-premises datacenter.

For your start-up company, databases that currently run on MySQL and PostgreSQL on-premises are mission-critical but limited by your data center's size and the size of your administration team. You want to investigate whether you can address these limitations by using Azure services and, if so, which services are best suited to your needs.

Here, you'll learn about Azure Database for MySQL, Azure Database for MariaDB, and Azure Database for PostgreSQL and the deployment options you can use with them. You'll also learn about the advantages of running open-source databases on virtual machines or containers in Azure and the Infrastructure-as-a-Service (IaaS) approach.

### Availability

The availability guaranteed by Azure service-level agreements (SLAs) depends on the precise details of your implementation—but they're always high. For example, for Azure Database for PostgreSQL, Microsoft guarantee 99.99% availability with no additional cost. For even higher availability, you can use Flexible Server.

If you wanted to achieve this availability in an on-premises network, you would have to architect a system that's resilient to hardware failures. You would need:

- Multiple physical servers.
- A load balancer that could reroute queries if there's a server failure.
- A storage area network that shares data between servers or a way to replicate data between servers.
- Resilient network hardware.
- An environmentally controlled datacenter.
- Uninterruptible power supplies and backup generators.

All these components are expensive and require skill to implement and run. They would also consume significant administrative resources. With Azure, these requirements are already solved; you just create the database, and high availability is built-in.

### Scalability

If your user base grows, system demand grows with it. Every on-premises system has a maximum capacity—if you approach that limit, you must increase it by adding more hardware. You can't add capacity instantaneously. Instead, you must purchase the hardware, install the necessary operating system and software, apply updates, and then add the data to the new database instance. All these things take time.

Also remember that high demand is often temporary. For example, if you run a successful marketing campaign, you might see a peak in traffic, followed by a return to lower demand. In an on-premises set-up, you have to design the system for these peaks. This means that the system is under-utilized most of the time but still runs up bills and requires maintenance.

These challenges are much easier to overcome in the cloud. If your system reaches its capacity, you can respond very quickly—for example, by moving to a larger tier or adding virtual machines. If demand drops, you'll quickly save money by removing capacity. In Azure, you only pay for the capacity you use.

### IaaS and PaaS

You can choose from at least two approaches when you implement a database on Azure, depending on the level of control you need:

- **Infrastructure as a service (IaaS).** If you choose the IaaS approach, Azure runs the physical infrastructure for you. You create virtual machines and virtual networks to connect them, and then install the necessary software and data. Running a virtual machine is like running a physical server. You maintain the operating system and software but you don't have to worry about the datacenter, environmental control, or connections to the internet.
- **Platform as a service (PaaS).** If you choose the PaaS approach, Azure runs the physical infrastructure, the necessary virtual servers, and the database software. You don't have to perform configuration or maintenance tasks on these components. For example, Azure applies services packs automatically. You can concentrate on database administration. PaaS offerings for running open source databases on Azure include **Azure Database for MySQL**, **Azure Database for MariaDB**, and **Azure Database for PostgreSQL**.

## What are the Azure Database services for MySQL, MariaDB, and PostgreSQL?

If you have an on-premises database system built on MySQL, MariaDB, or PostgreSQL, and you want to move your database into the cloud, consider using **Azure Database for MySQL**, **Azure Database for MariaDB**, or **Azure Database for PostgreSQL**. You might also want to use these services to implement new databases. For example, if your developers and database administrators have experience with those database servers, and you don't want them to spend time learning a new system, then using **Azure Database for MySQL**, **Azure Database for MariaDB**, or **Azure Database for PostgreSQL** enables staff to use their existing knowledge. **Azure Database for MySQL**, **Azure Database for MariaDB**, and **Azure Database for PostgreSQL** are PaaS systems, so you don't have to concern yourself with architecting or implementing virtual servers or networks.

### What is Azure Database for MySQL?

Azure Database for MySQL is a PaaS implementation of MySQL in the Azure cloud, based on the MySQL Community Edition. You can currently select from support for MySQL versions 5.6, 5.7, and 8.0, depending on your needs. Support for additional versions will be provided as MySQL evolves.

You get the following features with Azure Database for MySQL:

- High availability features built-in.
- Predictable performance.
- Easy scaling that responds quickly to demand.
- Secure data, both at rest and in motion.
- Automatic backups and point-in-time restore for the last 35 days.
- Enterprise-level security and compliance with legislation.

The system uses pay-as-you-go pricing so you only pay for what you use.

You can choose from two deployment options:

#### Azure Database for MySQL - Single Server

Azure Database for MySQL Single Server provides a database system that scales up to large databases without the need to manage hardware, network components, virtual servers, software patches, and other underlying components.

#### Azure Database for MySQL - Flexible Server

Azure Database for MySQL - Flexible Server provides greater availability by replicating your databases to multiple availability zones. It also enables you to start and stop your database service quickly to optimize costs.

Azure Database for MySQL provides a global database system that scales up to large databases without the need to manage hardware, network components, virtual servers, software patches, and other underlying components.

### What is Azure Database for MariaDB?

MariaDB is a fork of MySQL that was created by the community in response to the acquisition of MySQL by Oracle. Azure Database for MariaDB is the PaaS implementation of MariaDB in the Azure cloud.

MariaDB is designed to be a drop-in replacement for MySQL, so that you can replace a MySQL database with a MariaDB database without extensive recoding of client apps or changes in the database schema. Many features of MariaDB are the same as in MySQL, for example:

- Database structures and indexes
- Data definition commands
- Client protocols, structures, and APIs
- The `mysqldump` and `mysqladmin` programs

This similarity between MySQL and MariaDB means that migration tasks for MySQL to Azure Database for MySQL are very similar for MariaDB to Azure Database for MariaDB. There are some differences between the systems. For example, MariaDB supports ColumnStore and Redis Cache, both of which can be used to optimize performance.

> [!NOTE]
> Because the migration of databases from MySQL and MariaDB into Azure is so similar, they will be covered together in this course.

> [!Important]
> At the time of writing, there is no Flexible Server deployment option for Azure Database for MariaDB.

### What is Azure Database for PostgreSQL?

If you prefer PostgreSQL, you can choose Azure Database for PostgreSQL to get a PaaS implementation of that database server in the Azure Cloud. This provides the same availability, performance, scaling, security, and administrative benefits as the MySQL service.

You can choose from three deployment options:

#### Azure Database for PostgreSQL Single Server

The Single Server deployment option for PostgreSQL provides similar benefits as Azure Database for MySQL. You choose from three pricing tiers: Basic, General Purpose, and Memory Optimized. Each tier supports different numbers of CPUs, memory, and storage sizes—you select one based on the load you expect to support.

#### Azure Database for PostgreSQL - Flexible Server

Azure Database for PostgreSQL - Flexible Server provides similar benefits as MySQL Flexible Server. You can use it to provide the greatest levels of availability and convenient restarts.

> [!NOTE]
> At the time of writing, the Azure Database for PostgreSQL Flexible Server deployment option is in public preview. It's a fully functional service, but doesn't yet offer a service-level agreement (SLA).

#### Azure Database for PostgreSQL Hyperscale (Citus)

Hyperscale (Citus) is a deployment option that scales queries across multiple server nodes to support large database loads. Your database is split across nodes. Different data is split into chunks based on the value of a partition key or sharding key. Consider using this deployment option for the largest database PostgreSQL deployments in the Azure Cloud.

## IaaS options for running MySQL, MariaDB, and PostgreSQL in Azure

Use the IaaS approach to replicate a physical architecture in the cloud. You might choose IaaS if you want to retain more control of the operating systems and software that underlies your system.

However, there are several approaches you might adopt to implement the IaaS approach, depending on your requirements, and the complexity of your existing systems.

### Lift-and-shift

One approach is to mirror your on-premises architecture in the cloud by creating a virtual network infrastructure that matches that of your datacenter—you create a virtual machine for each server in your on-premises system. You install and configure your database management system software (MySQL, MariaDB, or PostgreSQL) on the virtual machines. You then *lift-and-shift* the system into the cloud with little alteration to client code or configuration.

With this strategy, you follow a step-by-step process for migration. You move parts of your system incrementally to the cloud, while retaining other elements on-premises, using Azure network gateway. Use this hybrid approach to stabilize the system at each step, and roll back if necessary.

### Use prebuilt virtual machines

The marketplace includes virtual machines preconfigured for MySQL, MariaDB, and PostgreSQL servers. These images save time because you don't need to install the database server software yourself. When you're setting up database virtual machines, check if there's an image in the Marketplace with the right version of the database software, and consider using it.

You could also upload a custom virtual machine image to Azure and use it to create virtual machines. This image could include the database software of your choice and even the database itself. For more information, see [Tutorial: Create a custom image of an Azure VM with Azure PowerShell](https://docs.microsoft.com/azure/virtual-machines/windows/tutorial-custom-images).

### Use MySQL, MariaDB, or PostgreSQL containers

Another virtualization technology you might consider is containerization. A container is like a virtual machine, but shares the operating system with the host computer. Containers are smaller than virtual machines, so you can run more of them on a host computer, and start new ones more quickly. However, you can't run a Linux container on a Windows machine, for example, because the operating system is shared. To run containers on a physical server, you need container host software, such as Docker. Containers are deployed from images and, like virtual machines, those images can include database software such as MySQL, MariaDB, and PostgreSQL.

If you want to run small numbers of containers in Azure, install Docker on a virtual machine. Alternatively, if you use the Container Instances service, you could run containers on Azure without setting up your own virtual machines. If you want to easily manage large numbers of containers that need to communicate with each other, use the Azure Kubernetes Service.
