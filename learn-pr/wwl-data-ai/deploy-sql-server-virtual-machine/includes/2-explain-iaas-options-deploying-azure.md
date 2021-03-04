Many applications will require a VM running SQL Server. Some reasons for this option include:

- **Older versions of SQL Server**—If an application requires an older version of SQL Server for vendor support, running inside a VM is the best option for those applications, because it allows for the application to be supported by that vendor.

- **Use of other SQL Server services**—While Analysis Services and to an extent Integration Services (through the use of Azure Data Factory) are available as PaaS offerings, many users maximize their licensing by running SQL Server Analysis Services, Integration Services, or Reporting Services on the same machine as the database engine.

- **General application incompatibility**—This reason is a somewhat of a catch-all. For example, Azure SQL Database doesn't support cross-database querying, while managed instance does. Some applications may require additional services to be co-located with the database instance in a manner that isn't compatible with a PaaS offering.

Infrastructure as a Service (IaaS) allows the administrator to have more granular access over specific settings of the underlying infrastructure than the other Azure offerings. While the Azure platform manages the underlying server and network hardware, you still have access to the virtual storage, virtual networking configuration, and any additional software you might install within the virtual machine. This includes Microsoft SQL Server.

:::image type="content" source="../media/module-22-plan-implement-final-01.png" alt-text="Granularity of Control of SaaS, PaaS, and IaaS options":::

The image above illustrates the increased control you have using IaaS, compared to the other Azure SQL offerings. While the exact configuration options vary between service offerings, typically in SaaS offerings the administrator is responsible only for user security and possibly data management. When using PaaS services, the operating system (OS) and other software are managed by the cloud provider. A good example of this is the Azure Database platform where the operating system and RDBMS are installed and configured by Microsoft, allowing you to start building database applications quickly. IaaS solutions are the most open ended; you are responsible for OS patching, as well as optimal configuration of your network and storage options. With an IaaS deployment, you are also responsible for software configuration.

For IaaS solutions running in Azure, Microsoft will manage any resource below the operating system, including the physical servers, storage and physical networking. The database administrator is responsible for configuration of your SQL Server instances running on the operating system.

Some of your applications may not be suited for other Azure offerings, such as Azure SQL Database, because they require specific operating conditions. These conditions could include a specific combination of SQL Server and Windows versions for vendor support purposes, or additional software that needs to be installed alongside of SQL Server. SQL Server paired with the Azure IaaS platform provides the required control options for many organizations, whether it be specific feature like CLR or replication, or the use of Active Directory (as opposed to Azure Active Directory) authentication. Another requirement is that some applications install software alongside SQL Server, which requires direct access to the underlying operating system. Direct access to the OS isn't supported in a PaaS model. These organizations and their applications can obtain the advantages of moving to a cloud service without losing critical capabilities that their organization requires.

### SQL Server IaaS Agent Extension

When you deploy an SQL Server VM from the Azure Marketplace, part of the process installs the IaaS Agent Extension.

:::image type="content" source="../media/module-11-azure-dba-final-01.png" alt-text="SQL Server VM Creation from Azure Marketplace":::

Extensions are code that is executed on your VM post-deployment, typically to perform post deployment configurations. Some examples are installing anti-virus features, or installing a Windows feature. The SQL Server IaaS Agent Extension provides three key features that can reduce your administrative overhead.

- **SQL Server automated backup**
- **SQL Server automated patching**
- **Azure Key Vault integration**

In addition to these features, the extension allows you to view information about your SQL Server’s configuration and storage utilization.

:::image type="content" source="../media/module-11-azure-dba-final-02.png" alt-text="Image of SQL Virtual Machine Configuration in Azure portal":::

## SQL Server licensing models

There are several different options related to how SQL Server is licensed when using the Azure IaaS offering.

If you aren’t participating in the Microsoft Software Assurance (SA) program, you can deploy an image from the Azure Marketplace containing a preconfigured SQL Server, and pay-per-minute for the use of SQL Server. This option is referred to as the Pay as you Go model and the cost of the SQL Server license is included with the cost of the virtual machine.

If you are participating in the Microsoft Software Assurance (SA) program, you have more flexibility in how you license your SQL Server:

* You can use the previous method and pay-per-minute by deploying a virtual machine image containing a SQL Server from the Azure Marketplace

* You can Bring Your Own License (BYOL) when deploying the virtual machine that doesn’t contain a preconfigured SQL Server instance. This option is possible when you already have purchased a valid SQL Server license for your on-premises infrastructure. This license can be applied to the virtual machine to ensure that you're properly licensed. You must report the usage of licenses to Microsoft by using the License Mobility verification form within 10 days of implementing the virtual machine.

    When choosing this method, you can manually install SQL Server through media you have obtained, or you can choose to upload a virtual machine image to Azure.

In addition to flexible licensing options for SQL Server, there are also Windows Server licensing options that can be taken advantage of. These Windows Server options are known as the Azure Hybrid Use Benefit (AHUB). Similar to applying a SQL Server license you already have purchased, you're able to take advantage of Windows Server licenses you already own.

Reserving a virtual machine for one to three years provides another option for cost savings. This commitment doesn't require an upfront payment and can be billed monthly. Using the reservation option can be beneficial if you know the workloads are going to be persisted. The cost savings can be significant, especially for larger VMs.

## Virtual machine families

When deploying to an Azure virtual machine, there are several series, or “families”, of virtual machine sizes that can be selected. Each series is a combination of memory, CPU, and storage that meets certain requirements. For example, the series that are compute optimized have a higher CPU to memory ratio. Having multiple options allows you to select an appropriate hardware configuration for the expected workload. The following six series each have various sizes available, the details of which are fully described in the Azure portal when you choose the option to select your VM size.

[General purpose](https://docs.microsoft.com/azure/virtual-machines/sizes-general) - These VMs provide a balanced ration of CPU to memory. This VM class is ideal for testing and development, small to medium-sized database servers, and web servers with a low to medium amount of traffic.

[Compute optimized](https://docs.microsoft.com/azure/virtual-machines/sizes-compute) - Compute optimized VMs have a high CPU-to-memory ratio and are good for web servers with a medium amount of traffic, network appliances, batch processes, and application servers. These VMs can also support machine learning workloads that can't benefit from GPU-based VMs.

[Memory optimized](https://docs.microsoft.com/azure/virtual-machines/sizes-memory) - These VMs provide high memory-to-CPU ratio. These VMs cover a broad range of CPU and memory options (all the way up to 4 TB of RAM) and are well suited for most database workloads.

[Storage optimized](https://docs.microsoft.com/azure/virtual-machines/sizes-storage) - Storage optimized VMs provide fast, local, NVMe storage that is ephemeral. They are good candidates for scale-out data workloads such as Cassandra. It is possible to use them with SQL Server, however since the storage is ephemeral, you need to ensure you configure data protection using a feature like Always On Availability Groups or Log Shipping.

[GPU](https://docs.microsoft.com/azure/virtual-machines/sizes-gpu) - Azure VMs with GPUs are targeted at two main types of workloads—naturally graphics processing operations like video rendering and processing, but also massively parallel machine learning workloads that can take advantage of GPUs.

[High performance compute](https://docs.microsoft.com/azure/virtual-machines/sizes-hpc) - High Performance Compute workloads support applications that can scale horizontally to thousands of CPU cores. This support is provided by high-performance CPU and remote direct memory access (RDMA) networking that provides low latency communications between VMs.

The easiest way to see the sizing options within each series is through the Azure portal. From the blade for creating a VM, you can click the option to “Select Size” and see a list.

:::image type="content" source="../media/module-22-plan-implement-final-02.png" alt-text="A Partial list of the VM sizes available through the Azure portal":::

The image above shows just a small set of the series and size possibilities. For each option, you can see the number of Virtual CPUs, the amount of RAM, the number of Data disks, the Max IPS, the temporary storage provided and whether Premium storage is supported.

## High availability

One of the major benefits of cloud computing is that platform high availability is part of the architecture. Azure provides a high-level of built hardware, storage, and networking redundancy. High availability for a system is typically measured as a percentage of uptime per year. In the table below, you can see what those numbers translate into in terms of time.

| **Availability %**| **Downtime per Year** |
| - | - |
| **99% ("two nines")**| 3.65 days |
| **99.5% ("two and a half nines")**| 1.83 days |
| **99.9% ("three nines")**| 8.77 hours |
| **99.95% ("three and a half nines")**| 4.38 hours |
| **99.99% ("four nines")**| 52.60 minutes |
| **99.995% ("four and a half nines")**| 26.30 minutes |
| **99.999% ("five nines")**| 5.26 minutes |

A single Azure Virtual Machine provides three nines (99.9%) of high availability when used in conjunction with Azure managed storage. Three nines means that the service guarantees the availability of the virtual machine up to 99.9% of the time, which translates into a downtime of no more than 8.77 hours each year.

In addition to the default number of nines, there are additional features that you can include with your SQL Server in Azure virtual machine to ensure that you achieve the maximum amount of up time.
