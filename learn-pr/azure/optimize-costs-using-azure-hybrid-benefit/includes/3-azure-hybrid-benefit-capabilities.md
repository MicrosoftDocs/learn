### Azure Hybrid Benefit for Windows Server

Azure Hybrid Benefit for Windows Server allows you to use Windows VMs on Azure at a reduced cost. You can use Azure Hybrid Benefit for Windows Server to deploy new VMs with Windows operating systems.

To qualify for Azure Hybrid Benefit for Windows Server, you need on-premises core licenses for Windows Server from an applicable program with active Software Assurance or qualifying subscription licenses. Software Assurance and qualifying subscription licenses are only available as part of certain commercial licensing agreements.

The following Windows Server licenses with an active subscription or Software Assurance are eligible for the Microsoft Azure Hybrid Benefit:

- Windows Server Standard/Datacenter core licenses
- Windows Server Standard/Datacenter processor licenses

To use Azure Hybrid Benefit, you need a minimum of eight core licenses (Datacenter or Standard edition) per VM. For example, eight core licenses are still required if you run a 4-core instance. You could also run instances larger than eight cores by allocating licenses equal to the core size of the instance. For example, 12 core licenses are required for a 12-core instance. For customers with processor licenses, each processor license is equivalent to 16 core licenses.

| License with Software Assurance/subscription      | VMs and cores granted            | How they can be used                  |
| ------------------------------------------------- | -------------------------------- | ------------------------------------- |
| Windows Server Datacenter (8 cores or a 2-proc L) | Up to two VMs and up to 16 cores | Run VMs both on-premises and in Azure |
| Windows Server Standard (8 cores or a 2-proc L)   | Up to two VMs and up to 16 cores | Run VMs both on-premises and in Azure |

Azure Hybrid Benefit includes the following cost savings:

- **Windows Server VMs on Azure**. Azure Hybrid Benefit covers the license for Windows Server, so you only need to pay for the base compute rate of the VM. The base compute rate is equal to the Linux rate for VMs.
- **Azure Local**. The Azure Local host fee and Windows Server subscription fee are waived with Azure Hybrid Benefit. That is, unlimited virtualization rights are provided at no extra cost. You still pay other costs associated with Azure Local such as customer-managed hardware, Azure services, and workloads. Available for Windows Server Datacenter Edition.
- **AKS**. You can run AKS on Windows Server and Azure Local at no extra cost. You still pay for the underlying host infrastructure and any licenses for Windows containers unless you're also eligible for Azure Hybrid Benefit for Azure Local. With Azure Hybrid Benefit for Azure Local, you can waive fees for the Azure Local host and Windows Server subscription.

:::image type="content" source="../media/azure-hybrid-benefit-savings-inline.png" alt-text="Screenshot of illustration depicting Azure Hybrid Benefit savings for Windows Server VMs on Azure, AHB for Azure Stack HCI, AHB for AKS on Azure Stack HCI or Windows Server. The last column depicts how combining savings options can help increase the maximum eligibility." lightbox="../media/azure-hybrid-benefit-savings-expanded.png" border="false":::

The following diagram compares the cost benefits of using AKS on HCI or Windows Server against using AKS without Azure Hybrid Benefit.

:::image type="content" source="../media/aks-on-hcl-with-ahb.png" alt-text="Screenshot of illustration depicting comparison of costs for using AKS, AKS on HCI without AHB and AKS on HCI or Windows Server with AHB against the Azure Hybrid." border="false":::

#### Migration allowance rights for Windows Server

Azure Hybrid Benefit provides the following migration allowance rights for Windows Server:

- **Windows Server Standard edition**. You must use licenses either on-premises or in Azure, but not at the same time. You can apply for a one-time exception for up to 180 days to allow you to migrate the same workloads to Azure.
- **Windows Server Datacenter edition**. For VM Licensing, licenses allow simultaneous usage on-premises and in Azure indefinitely.
- **Dedicated Host Licensing**. Licenses allow simultaneous on-premises and Azure usage for a period of 180 days from when the licenses are allocated to Azure.

#### Unlimited virtualization rights

*Unlimited virtualization rights* refers to the right to use any number of Windows Server VMs on a host. Azure Hybrid Benefit provides the following Unlimited Virtualization Rights for Windows Server:

- **Windows Server Datacenter edition**. You can use any number of Windows Server VMs on an Azure dedicated host if you allocate Windows Server Datacenter licenses with active Software Assurance or subscription for all the available physical cores on that Azure server.
- **Windows Server Standard edition**. Unlimited virtualization rights aren't available.

#### License allocation for dedicated host licensing (Datacenter only) and azure local

You must allocate enough Windows Server Datacenter core licenses for all physical cores available to the customer on a Dedicated Host or an Azure Local Cluster. Azure Hybrid Benefit for Azure Local is available for Enterprise Agreement (EA) or cloud solution provider (CSP) customers only. You could run unlimited VMs on that host/cluster. When migrating workloads to Azure, the customer could also continue to use its licensed software on devices for a period of 180 days from when the licenses are allocated to Azure.

If you have Windows Server Datacenter licenses with active Software Assurance, you’re eligible to activate Azure Hybrid Benefit for your Azure Local cluster. To activate this benefit, you'll need to exchange your 1-core license of Software Assurance–enabled Windows Server Datacenter for a 1-physical core of Azure Local.

> [!NOTE]
> Aside from the migration allowances described in the following sections, after the licenses are allocated to Azure, the customer might not use them elsewhere. When at least 90 days have passed, the customer might elect to stop using them for Azure Hybrid Benefit.*

### Azure Hybrid Benefit for SQL Server

Azure Hybrid Benefit allows you to use SQL Server licenses with Software Assurance ("Qualified License") on Azure VMs. With Azure Hybrid Benefit, you aren't charged for the use of a SQL Server license on a VM; instead, you’re charged only for the cost of the underlying cloud computing resources (that is, the *base rate*), storage, and backups. You also pay for I/O associated with usage of the services, as applicable. To estimate your cost savings in SQL Server with the Azure Hybrid benefit, use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/).

:::image type="content" source="../media/sql-example.png" alt-text="Screenshot of illustration depicting an example of SQL Server Enterprise Edition savings achieved by using Azure Hybrid Benefit." border="false":::

It’s important to note that according to Microsoft Product Terms, you must indicate that you’re using Azure SQL Database (SQL Managed Instance, Elastic Pool, and Single Database), Azure Data Factory, SQL Server Integration Services, or SQL Server VMs under Azure Hybrid Benefit for SQL Server when configuring workloads on Azure.

To indicate the use of Azure Hybrid Benefit for SQL Server on Azure VM (and to comply with the product terms), you can choose from three options:

- Provision a VM by using a bring-your-own-license (BYOL) SQL Server image from Azure Marketplace.

- Provision a VM by using a pay-as-you-go SQL Server image from Azure Marketplace, and then activate the Azure Hybrid Benefit.

- Self-install SQL Server on an Azure VM, manually register with the SQL Infrastructure-as-a-service (IaaS) Agent extension, and then activate Azure Hybrid Benefit.

You can configure the SQL Server license type when you provision the VM, or anytime afterward. Switching between license models incurs no downtime, doesn't restart the VM or the SQL Server service, doesn't add any additional costs, and is effective immediately. In fact, activating Azure Hybrid Benefit reduces your cost.

Customers can use Azure Hybrid Benefit with their own Azure account. The following table lists the Qualified Licenses that can be used for the Azure Data Service and the specified ratios.

| **Qualified license**                                    | **Microsoft Azure data services**                         | **Ratio of qualified licenses to Azure vCores** |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------- |
| SQL Server Enterprise (Core)                                | SQL Managed Instance enabled by Azure Arc – General Purpose | 1 core license:4 vCores                           |
| SQL Managed Instance enabled by Azure Arc – Business Critical | 1 core license:1 vCore                                       |                                                   |
| Azure SQL Database (Elastic Pool and Single Database)/Azure SQL Managed Instance – General Purpose | 1 core license:4 vCores                                     |                                                   |
| Azure SQL Database (Elastic Pool and Single Database)/Azure SQL Managed Instance – Business Critical | 1 core license:1 vCore                                       |                                                   |
| Azure Data Factory SQL Server Integration Services (Enterprise) | 1 core license:1 vCore                                       |                                                   |
| Azure Data Factory SQL Server Integration Services (Standard) | 1 Core License:4 vCores                                      |                                                   |
| SQL Server Enterprise VMs                                    | 1 core license:1 vCPU *(Subject to a minimum of four Core Licenses per VM.)* |                                                   |
| SQL Server Standard VMs                                      | 1 core license:4 vCPUs                                       |                                                   |
| SQL Server Standard (Core)                                   | Azure Arc SQL Managed Instance– General Purpose              | 1 core license:1 vCore                            |
| Azure Arc SQL Managed Instance – Business Critical           | 4 core licenses:1 vCore                                      |                                                   |
| Azure SQL Database (Elastic Pool and Single Database)/Azure SQL Managed Instance – General Purpose | 1 core license:1 vCore                                       |                                                   |
| Azure SQL Database (Elastic Pool and Single Database)/Azure SQL Managed Instance – Business Critical | 4 core licenses:1 vCore                                      |                                                   |
| Azure Data Factory SQL Server Integration Services (Standard) | 1 core license: 1 vCore                                      |                                                   |
| Azure Data Factory SQL Server Integration Services (Enterprise) | 4 core licenses:1 vCore                                      |                                                   |
| SQL Server Standard VMs                                      | 1 core license:1 vCPU *(Subject to a minimum of four Core Licenses per VM.)* |                                                   |
| SQL Server Enterprise VMs                                    | 4 core licenses:1 vCPU *(Subject to a minimum of four Core Licenses per VM.)* |                                                   |

> [!NOTE]
> Azure Hybrid Benefit is not available in the serverless compute tier of Azure SQL Database.

#### Azure migration allowance

Aside from the migration allowance described in subsequent sections, after you allocate licenses to Azure, you can’t use them anywhere else. However, after at least 90 days have passed, you might elect to stop using them for Azure Hybrid Benefit. When migrating workloads to Azure, you can also continue to use your licensed software on devices for a period of 180 days from when the licenses are allocated to Azure.

#### Integration with centrally managed Azure Hybrid Benefit

Centrally managed Azure Hybrid Benefit (CM-AHB) is a service that helps customers optimize their Azure costs along with other benefits such as:

- Move all pay-as-you-go (full price) SQL platform-as-a-service (PaaS)/(IaaS) workloads to take advantage of your Azure Hybrid Benefits without having to individually configure them to enable the benefit.

- Ensure that all your SQL Server workloads are licensed in compliance with the existing license agreements.

- Separate the license compliance management roles from Azure DevOps roles using role-based access control (RBAC).

- Take advantage of free business continuity by ensuring that your passive and disaster recovery (DR) environments are properly identified.

- Use Microsoft Developer Network (MSDN) licenses in Azure for non-production environments.

CM-AHB uses data provided by the SQL IaaS Agent extension to account for the number of SQL Server licenses used by individual Azure VMs, and then provides recommendations to the billing admin during the license assignment process. By following these recommendations, your organization can realize the maximum discount by using Azure Hybrid Benefit. If your VMs aren't registered with the SQL IaaS Agent extension when CM-AHB is enabled by your billing admin, the service won't receive the full usage data from your Azure subscriptions and therefore the CM-AHB recommendations will be inaccurate.

#### Linux capabilities and eligibility

With Azure Hybrid Benefit for Linux, you can easily switch the software subscription model for your VM. You can remove licensing costs by bringing your Red Hat Enterprise Linux (RHEL) and SUSE Linux Enterprise Server (SLES) subscriptions directly to Azure, or by utilizing a model where you pay for subscriptions as you use them. This process applies to Azure Virtual Machine Scale Sets, Azure Spot Virtual Machines, and custom images. It allows for seamless bi-directional conversions between the two models.

Customers could realize combined savings, (up to 76 percent) with Azure Hybrid Benefit for Linux and three-year Azure Reserved Virtual Machine Instances. Savings estimates are based on one standard D2s v5 Azure VM with RHEL or SLES subscription in the East US region running at a pay-as-you-go rate vs a reduced rate for a three-year reserved instance plan. This is based on Azure pricing as of September 2024. You should keep in mind that prices are subject to change. Actual savings might vary based on location, instance type, or usage.

In Azure, there are two main licensing pricing options: 'pay-as-you-go' and 'bring-your-own-subscription' (BYOS). Pay-as-you-go is a pricing option where you pay for the resources you use on an hourly or monthly basis. You only pay for what you use and can scale up or down as needed. BYOS is a licensing option where you can use your existing licenses for certain software, in this case RHEL and SLES, on Azure VMs. You can use your existing licenses and don't have to purchase new ones for use in Azure.

:::image type="content" source="../media/azure-hybrid-benefit-compare.png" alt-text="Screenshot of diagram that depicts the use of Azure Hybrid Benefit to switch Linux virtual machines between pay-as-you-go and bring-your-own-subscription." border="false":::

> [!NOTE]
> VMs deployed from pay-as-you-go images or VMs converted from BYOS models incur both an infrastructure fee and a software fee. If you have your own license, use Azure Hybrid Benefit to convert from a pay-as-you-go to BYOS model.

You can use Azure Hybrid Benefit to switch back to pay-as-you-go billing at any time. If you already use Azure Hybrid Benefit with Linux VMs, Azure, dedicated host instances and SQL hybrid benefits aren't eligible for Azure Hybrid Benefit.

> [!NOTE]
> For Red Hat VMs, the Azure account needs to be part of Red Hat Cloud Access. You must register with Red Hat Cloud Access before you try to enable Azure Hybrid Benefit on your VMs.
