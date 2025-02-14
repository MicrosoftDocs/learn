Many applications will require a VM running SQL Server. Some reasons for this option include:

- **Older versions of SQL Server**—If an application requires an older version of SQL Server for vendor support, running inside a VM is the best option for those applications, because it allows for the application to be supported by that vendor.

- **Use of other SQL Server services**—While Analysis Services and to an extent Integration Services (through the use of Azure Data Factory) are available as PaaS offerings, many users maximize their licensing by running SQL Server Analysis Services, Integration Services, or Reporting Services on the same machine as the database engine.

- **General application incompatibility**—This reason is a somewhat of a catch-all. For example, Azure SQL Database doesn't support cross-database querying, while managed instance does. Some applications may require additional services to be co-located with the database instance in a manner that isn't compatible with a PaaS offering.

Infrastructure as a Service (IaaS) allows the administrator to have more granular access over specific settings of the underlying infrastructure than the other Azure offerings. While the Azure platform manages the underlying server and network hardware, you still have access to the virtual storage, virtual networking configuration, and any additional software you might install within the virtual machine. This includes Microsoft SQL Server.

:::image type="content" source="../media/module-22-plan-implement-final-01.png" alt-text="Granularity of Control of SaaS, PaaS, and IaaS options":::

The image above illustrates the increased control you have using IaaS, compared to the other Azure SQL offerings. While the exact configuration options vary between service offerings, typically in SaaS offerings the administrator is responsible only for user security and possibly data management. When using PaaS services, the operating system (OS) and other software are managed by the cloud provider. A good example of this is the Azure Database platform where the operating system and RDBMS are installed and configured by Microsoft, allowing you to start building database applications quickly. IaaS solutions are the most open ended; you are responsible for OS patching, as well as optimal configuration of your network and storage options. With an IaaS deployment, you are also responsible for software configuration.

For IaaS solutions running in Azure, Microsoft will manage any resource below the operating system, including the physical servers, storage and physical networking. The database administrator is responsible for configuration of your SQL Server instances running on the operating system.

Some of your applications may not be suited for other Azure offerings, such as Azure SQL Database, because they require specific operating conditions. These conditions could include a specific combination of SQL Server and Windows versions for vendor support purposes, or additional software that needs to be installed alongside of SQL Server. SQL Server paired with the Azure IaaS platform provides the required control options for many organizations, whether it be specific feature like CLR or replication, or the use of Active Directory (as opposed to Microsoft Entra ID) authentication. Another requirement is that some applications install software alongside SQL Server, which requires direct access to the underlying operating system. Direct access to the OS isn't supported in a PaaS model. These organizations and their applications can obtain the advantages of moving to a cloud service without losing critical capabilities that their organization requires.

### SQL Server IaaS Agent Extension

When you deploy an SQL Server VM from the Azure Marketplace, part of the process installs the IaaS Agent Extension.

:::image type="content" source="../media/module-11-azure-dba-final-01.png" alt-text="SQL Server VM Creation from Azure Marketplace":::

Extensions are code that is executed on your VM post-deployment, typically to perform post deployment configurations. Some examples are installing anti-virus features, or installing a Windows feature. The SQL Server IaaS Agent Extension provides the following main features that can reduce your administrative overhead.

- **Automated backup**
- **Automated patching**
- **Azure Key Vault integration**
- **Defender for Cloud portal integration**
- **View Disk utilization in the portal**
- **Flexible licensing**
- **Flexible version or edition**
- **SQL best practices assessment**

In addition to these features, the extension allows you to view information about your SQL Server’s configuration and storage utilization.

:::image type="content" source="../media/module-11-azure-dba-final-02.png" alt-text="Image of SQL Virtual Machine Configuration in Azure portal":::

## SQL Server licensing models

There are several different options related to how SQL Server is licensed when using the Azure IaaS offering.

If you aren’t participating in the Microsoft Software Assurance (SA) program, you can deploy an image from the Azure Marketplace containing a pre-configured SQL Server, and pay-per-minute for the use of SQL Server. This option is referred to as the Pay as you Go model and the cost of the SQL Server license is included with the cost of the virtual machine.

If you are participating in the Microsoft Software Assurance (SA) program, you have more flexibility in how you license your SQL Server:

* You can use the previous method and pay-per-minute by deploying a virtual machine image containing a SQL Server from the Azure Marketplace

* You can Bring Your Own License (BYOL) when deploying the virtual machine that doesn’t contain a pre-configured SQL Server instance. This option is possible when you already have purchased a valid SQL Server license for your on-premises infrastructure. This license can be applied to the virtual machine to ensure that you're properly licensed. You must report the usage of licenses to Microsoft by using the License Mobility verification form within 10 days of implementing the virtual machine.

When choosing this method, you can manually install SQL Server through media you have obtained, or you can choose to upload a virtual machine image to Azure.

In addition to flexible licensing options for SQL Server, there are also Windows Server licensing options that can be taken advantage of. These Windows Server options are known as the Azure Hybrid Benefit (AHB). Similar to applying a SQL Server license you already have purchased, you're able to take advantage of Windows Server licenses you already own.

Reserving a virtual machine for one to three years provides another option for cost savings. This commitment doesn't require an upfront payment and can be billed monthly. Using the reservation option can be beneficial if you know the workloads are going to be persisted. The cost savings can be significant, especially for larger VMs.

## Virtual machine families

When deploying to an Azure virtual machine, there are several series, or “families”, of virtual machine sizes that can be selected. Each series is a combination of memory, CPU, and storage that meets certain requirements. For example, the series that are compute optimized have a higher CPU to memory ratio. Having multiple options allows you to select an appropriate hardware configuration for the expected workload. The following six series each have various sizes available, the details of which are fully described in the Azure portal when you choose the option to select your VM size.

[General purpose](/azure/virtual-machines/sizes-general) - These VMs provide a balanced ratio of CPU to memory. This VM class is ideal for testing and development, small to medium-sized database servers, and web servers with a low to medium amount of traffic.

[Compute optimized](/azure/virtual-machines/sizes-compute) - Compute optimized VMs have a high CPU-to-memory ratio and are good for web servers with a medium amount of traffic, network appliances, batch processes, and application servers. These VMs can also support machine learning workloads that can't benefit from GPU-based VMs.

[Memory optimized](/azure/virtual-machines/sizes-memory) - These VMs provide high memory-to-CPU ratio. These VMs cover a broad range of CPU and memory options (all the way up to 4 TB of RAM) and are well suited for most database workloads.

[Storage optimized](/azure/virtual-machines/sizes-storage) - Storage optimized VMs provide fast, local, NVMe storage that is ephemeral. They are good candidates for scale-out data workloads such as Cassandra. It is possible to use them with SQL Server, however since the storage is ephemeral, you need to ensure you configure data protection using a feature like Always On Availability Groups or Log Shipping.

[GPU](/azure/virtual-machines/sizes-gpu) - Azure VMs with GPUs are targeted at two main types of workloads—naturally graphics processing operations like video rendering and processing, but also massively parallel machine learning workloads that can take advantage of GPUs.

[High performance compute](/azure/virtual-machines/sizes-hpc) - High Performance Compute workloads support applications that can scale horizontally to thousands of CPU cores. This support is provided by high-performance CPU and remote direct memory access (RDMA) networking that provides low latency communications between VMs.

The easiest way to see the sizing options within each series is through the Azure portal. From the blade for creating a VM, you can click the option to “Select Size” and see a list.

:::image type="content" source="../media/module-22-plan-implement-final-02.png" alt-text="A Partial list of the VM sizes available through the Azure portal":::

The image above shows just a small set of the series and size possibilities. For each option, you can see the number of Virtual CPUs, the amount of RAM, the number of Data disks, the Max IOPS, the temporary storage provided and whether Premium storage is supported.

For more information about VM size best practices, see [Best practices for SQL Server on Azure VMs](/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-checklist).

## Azure Marketplace

The Azure Marketplace is essentially a centralized location that provides the ability to create Azure resources based on a pre-designed template. For example, you can quickly create a SQL Server 2019 instance on Windows Server 2019 with a couple of clicks of the mouse along with some basic information, such as the virtual machine name as well as some SQL Server configuration information. Once provided, Azure Resource Manager will initiate the creation of the virtual machine and within minutes it will be up and running.

The blade for SQL Server 2019 on Windows Server 2019 in the Azure Marketplace is shown below. This blade gives you the option of pre-set configurations that support OLTP or Data Warehouse workloads and allow you to specify storage, patching, and backup options.

:::image type="content" source="../media/module-22-plan-implement-final-06.png" alt-text="Azure portal SQL Server VM Creation":::

The disadvantage of using the portal to create Azure resources is that it is not an easily repeatable process. However, it is easy to get started with the portal, where you can quickly get up and running resources.

## SQL Server configuration

When provisioning SQL Server to an Azure virtual machine, you can also configure specific SQL Server settings such as, Security and Networking, SQL Authentication preferences, SQL instance settings, and a few other options. These options are located on the **SQL Server settings** tab, as shown in the image below.

:::image type="content" source="../media/dp-3300-module-11-lab-51.png" alt-text="SQL Server settings tab when creating a SQL Server virtual machine":::

For more information about the SQL Server settings available when creating a virtual machine, see [Provision SQL Server on Azure VM (Azure portal)](/azure/azure-sql/virtual-machines/windows/create-sql-vm-portal).
