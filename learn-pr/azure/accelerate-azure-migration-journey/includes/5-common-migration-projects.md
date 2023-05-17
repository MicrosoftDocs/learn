Azure provides access to a comprehensive set of cloud services. As developers and IT professionals, you can use these services to build, deploy, and manage applications on a range of tools and frameworks through a global network of datacenters. 

Common migration and modernization projects include:

- .NET and Java applications
- SQL Server
- Open-source databases
- Azure Infrastructure as a Service (IaaS)
- VMware
- SAP
- Virtual Desktop Infrastructure (VDI)
- DevTest

> [!NOTE]
> Connect to the Cloud Adoption Framework (CAF) for more information about these [migration and modernization scenarios](/azure/cloud-adoption-framework/scenarios/?azure-portal=true).

For all workloads, the decision to migrate or modernize drives the solution that's chosen. With a *migration*, the workload is moved into an IaaS running on virtual machines (VMs) in Azure. With a *modernize* approach, PaaS components are used to deploy the application after changes are made to the code base or architecture.

## .NET and Java applications

Custom applications are a common workload to migrate and modernize on Azure. In the case of .NET and Java applications, modernization is the most common approach, however, sometimes a migration is still necessary.

### Migrate

When you migrate a .NET or Java application, it's more of a VM migration. In this scenario, you just take the server that the application is hosted on and rehost that server as a VM in Azure.

### Modernize

When you modernize an application, you use additional cloud provider services to optimize the cost, reliability, and performance. Your application can take advantage of PaaS products such as Azure App Service, Azure SQL Database Managed Instance, and containers. When looking to modernize, it almost always leads to at least updates to your application.

For a .NET or Java web application, you can migrate to Azure App Services with minor changes to your codebase. The advantages of employing modernized services in this scenario include: lower cost and management, using your current application as-is or with some minor code or configuration changes, and connecting to new infrastructure services.

If you take your modernization to the next level, you can redesign some parts of your applications. This is when you would transform it with a modular architecture. In this scenario, you modify or extend an existing application’s codebase to optimize it for a cloud platform and better scalability. Cloud provider services can be used directly as back-end services of modern apps, which are highly scalable and reliable. The advantages include: improving agility by applying innovative DevOps practices, bringing new Azure capabilities to existing apps, and cost-effectively meeting scalability requirements.

The final modernization scenario you can use for your applications is to completely rebuild them. The rebuild strategy revises the existing application by aggressively adopting PaaS or even SaaS architecture. The advantages of this strategy include: building new applications using cloud-native technologies, faster development if your existing application is slowing you down, and innovation opportunities that take advantage of advancements in technology like AI, blockchain, and IoT.

:::image type="content" source="../media/migrate-applications.png" alt-text="Diagram showing how to migrate .NET and Java applications.":::

**Deep dive on migration and modernization scenarios:**

- Migrate an application to [Azure App Service](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-refactor-web-app-sql/?azure-portal=true) and SQL Database.
- Migrate [SQL Server databases](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-sql-server-db-to-azure/?azure-portal=true) to Azure.
- [Refactor](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-refactor-web-app-sql-managed-instance/?azure-portal=true) an on-premises application to run as an Azure App Service web app and a SQL managed instance.
- [Rebuild a new version](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-rebuild/?azure-portal=true) of an on-premises application in Azure.
- Migrate an on-premises application with Azure VMs and [SQL Server Always On availability groups](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-rehost-vm-sql-ag/?azure-portal=true).

## SQL Server

Azure is the cloud that knows SQL Server best. There are many options for the migration and modernization of these applications.

:::image type="content" source="../media/migrate-sql.png" alt-text="Diagram showing how to migrate Windows & SQL Server to Azure.":::

### SQL Server on a virtual machine

A typical reason for migrating SQL to Azure is that a two-tier application is being moved, a Windows .NET front-end application connected to SQL Server running on VMs. These applications can be migrated by simply moving the servers by using [Azure Migrate](https://azure.microsoft.com/services/azure-migrate/?azure-portal=true) and hosting them using IaaS. They run just as they did in the datacenter, only now they're connected to a virtual network running in Azure.

### Azure SQL Server Managed Instance

Migrating to SQL Server Managed Instance is both a migration and a modernization in one. SQL Server Managed Instance is nearly identical to SQL Server on a VM in terms of the feature set available. However, it's a PaaS offering in Azure. So, you get the benefits of a full SQL Server as well as the benefits of not having to worry about the backend infrastructure that SQL is hosted on.

### Azure SQL Server

You can also modernize your SQL Server by moving to an Azure SQL Database. Azure SQL provides you with most of the database-level features without the server-level features. Due to this, moving to Azure SQL is a little more of a modernization. Azure SQL Server also has elastic pools and automatic tuning. The move to Azure SQL is most common when you're also doing a modernization of your frontend application to a PaaS service such as Azure App Service.

**Deep dive on migration scenarios:**

- [Migrate a server](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-rehost-vm/?azure-portal=true) running an instance of SQL Server.
- Migrate SQL with Azure VMs and [SQL Server Always On availability groups](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-rehost-vm-sql-ag/?azure-portal=true).
- Migrate an on-premises SQL Server by migrating to Azure VMs and [Azure SQL Managed Instance](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-rehost-vm-sql-managed-instance/?azure-portal=true).
- [Import a BACPAC File](/sql/relational-databases/data-tier-applications/import-a-bacpac-file-to-create-a-new-user-database) to migrate a database to Azure SQL.

## Open-source databases

Azure has broad support for open-source databases. There's support for moving MySQL and PostgreSQL to fully managed Azure services, which helps achieve minimal downtime and built-in high availability (HA), monitoring, and security. There are many options for the migration of these applications, including both a migration path and a modernization path.

:::image type="content" source="../media/migrate-modernize-opensource-db.png" alt-text="Diagram showing how to migrate OSS Databases.":::

### Migrate

To migrate a Linux or Windows server that hosts an open-source database to Azure, the experience is similar to migrating a Windows SQL Server. When you host these databases on a VM in Azure, they can be moved by using [Azure Migrate](https://azure.microsoft.com/services/azure-migrate/?azure-portal=true) and run just as they did in the datacenter, only now they're connected to a virtual network running in Azure.

### Modernize

Azure offers multiple managed database services for open-source databases. They include:

- Azure Database for PostgreSQL
- Azure Database for MySQL
- Azure Database for MariaDB

Each database provides a fully managed PaaS offering with flexibility in the compute options for the database. When choosing compute, there's a serverless option, provisioned compute resources, or even create database pools that you can use with your applications. All three of these managed databases are a great way to modernize a database running on an on-premises server running Windows or Linux.

**Deep dive on migration and modernization scenarios:**

- Azure Database [migration guides](/data-migration/?step=1)
- [Migrate MySQL to Azure Database for MySQL](/azure/mysql/migrate/mysql-on-premises-azure-db/01-mysql-migration-guide-intro)
- [Migrate PostgreSQL to Azure Database for PostgreSQL](/azure/postgresql/howto-migrate-using-dump-and-restore)
- [Migrate MariaDB to Azure Database for MariaDB](/azure/mariadb/howto-migrate-dump-restore)
- Migrate on-premises Linux application to [Azure VMs](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-rehost-linux-vm/?azure-portal=true)
- Migrate an on-premises Linux application to [Azure VMs and Azure Database for MySQL](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-rehost-linux-vm-mysql/?azure-portal=true)

## Azure IaaS

Azure has broad support for Linux and Windows virtual machines. Tailwind Traders can quickly move on-premises Linux distributions or versions of Windows to Azure. Migrating to Azure IaaS is the best approach when none of the other scenarios provide a method for migrating and modernizing your application. This can also be referred to as a lift-and-shift migration where the server is "lifted" out of your on-premises data center and "shifted" in Azure IaaS with minimal changes. To do this type of migration, [Azure Migrate](https://azure.microsoft.com/services/azure-migrate/?azure-portal=true) is the best way to migrate to Azure IaaS.

With an Azure IaaS migration, there isn't a modernization path similar to the other services. However, modernization can be done with tools to support your IaaS environment. Modernization of IaaS could be doing things like using Azure Backup to back your VMs instead of an on-premises backup solution. Other modern services that can be used to improve an IaaS environment in Azure is Defender for Cloud for monitoring VMs or Microsoft Sentinel for a modern security information event management (SIEM) and security orchestration automated response (SOAR) service in Azure. Azure Advisor and Azure Policy can help by recommending ways to optimize an IaaS deployment as well as govern the services deployed to Azure.

While an IaaS migration to Azure might not be modernizing the applications themselves, the other modern services can be used to provide a modernized toolset for managing your IaaS deployment.

:::image type="content" source="../media/migrate-modernize-infra.png" alt-text="Diagram showing migrate and modernize OSS apps on Azure.":::

**Deep dive on migration scenarios:**

- [Azure Migrate](https://azure.microsoft.com/products/azure-migrate/)
- [Backup Azure VMs in a recovery services vault](/azure/backup/backup-azure-arm-vms-prepare)
- An overview of the [security options](/azure/security/fundamentals/virtual-machines-overview) available for virtual machines in Azure
- Reduce the cost of VMs in Azure with [Azure advisor](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations)

## VMware

Using [Azure VMware Solution](https://azure.microsoft.com/products/azure-vmware), VMware workloads run natively on Azure. These workloads can be seamlessly moved from your datacenter to Azure. Tailwind Traders can keep managing your existing environments with the same VMware tools you already know while you modernize your applications with Azure native services.

> [!IMPORTANT]
> Azure VMware Solution is a Microsoft service, verified by VMware, that runs on Azure infrastructure.

:::image type="content" source="../media/migrate-modernize-vmware.png" alt-text="Diagram showing how to migrate VMware VMs to Azure.":::

Tailwind Traders can use Azure VMware Solution to create a private cloud in Azure with native access to VMware vCenter and other tools that are supported by VMware for workload migration. Move to Azure seamlessly using VMware’s HCX technology and continue to manage your environment using the same VMware tools you already know: vSphere Client, NSX-T, Power CLI, or any popular DevOps toolchain.

Once deployed to Azure VMware Solution, you can create vSphere VMs in the Azure portal via API calls or CLI, automate deployments, and enable single sign-on. Enhance your workloads with the full range of Azure compute, monitor, backup, database, IoT, and AI services.

VMware VMs running on Azure VMware Solution are made accessible using [ExpressRoute](https://azure.microsoft.com/services/expressroute/?azure-portal=true), so services or users on-premises can access the VMs that have been migrated to Azure. These VMs also have connectivity to other Azure Services such as Azure Databases, Azure Key Vault, and Azure Storage.

:::image type="content" source="../media/vmware-azure.png" alt-text="Diagram showing how to migrate to Azure VMware Solutions Connection.":::

Learn more about [deploying Azure VMware solutions](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-vmware-to-azure/?azure-portal=true).

## SAP

Azure is SAP-certified to run your mission-critical SAP applications. Azure is the industry's most performant and scalable SAP cloud infrastructure, offering 192-gigabyte to 12-terabyte SAP HANA-certified VMs in more regions than any other public cloud provider.

:::image type="content" source="../media/migrate-modernize-sap.png" alt-text="Diagram showing how to migrate SAP to Azure.":::

A commissioned [Forrester Consulting TEI study](https://azure.microsoft.com/resources/sap-on-azure-forrester-tei/?azure-portal=true) showed that organizations can experience a three-year ROI of more than 100 percent after moving their legacy SAP infrastructure to Azure, with investment payback in nine months.

Learn more about running SAP on Azure:

- SAP on Azure [implementation guide](https://azure.microsoft.com/resources/sap-on-azure-implementation-guide/?azure-portal=true)
- eBook: [Migrating SAP applications](https://azure.microsoft.com/resources/migrating-sap-applications-to-azure/?azure-portal=true) to Azure
- SAP to Azure migration [methodology](https://azure.microsoft.com/resources/migration-methodologies-for-sap-on-azure/?azure-portal=true)

## Virtual Desktop Infrastructure (VDI)

Moving an organization's end-user desktops to the cloud is a common scenario. Doing so helps improve employee productivity and accelerate the migration and modernization of various workloads to support the organization's user experience. In addition, there's a heavy focus on remote workers worldwide.

:::image type="content" source="../media/migrate-modernize-vdi.png" alt-text="Diagram showing how to modernize VDI in Azure.":::

### Migrate

The migration option for VDI is like other server migrations. Your current Remote Desktop Services VMs move to Azure running in IaaS. This can be done by using [Azure Migrate](https://azure.microsoft.com/services/azure-migrate/?azure-portal=true).

### Modernize

To modernize VDI implementations, take existing Citrix, VMware, or Remote Desktop Services farms and replace them with a PaaS solution called [Azure Virtual Desktop](https://azure.microsoft.com/services/virtual-desktop/?azure-portal=true).

Tailwind Traders can set up Azure Virtual Desktop in minutes to enable secure remote work. Provide the familiarity and compatibility of Windows 10 with the new scalable multi-session experience for your end-users and save costs by using the same Windows licenses. Also manage the end-to-end Azure Virtual Desktop deployment alongside other Azure services within the Azure portal.

In this scenario, desktop images are either migrated to Azure, or new images are generated. Similarly, user profiles are either migrated to Azure or new profiles are created. Usually, the client solution is enabled but largely unchanged by this migration effort.

Learn more about using [Azure Virtual Desktop](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-rds-to-wvd/?azure-portal=true) to move an on-premises RDS environment to Azure.

## DevTest

Azure is a great choice for running DevTest workloads in the cloud. Tailwind Traders can provision fast, lean, and secure dev/test environments while saving substantially with the [Azure Dev/Test offer](https://azure.microsoft.com/offers/ms-azr-0023p/). There are a few options for the migration of DevTest VMs, including both a migration path or modernization.

### Migrate

When your DevTest environment migrates to Azure, it runs on VMs in the cloud. The VMs can be moved by using [Azure Migrate](https://azure.microsoft.com/services/azure-migrate/?azure-portal=true) and run just as they did in the datacenter, only now they're connected to a virtual network running in Azure.

:::image type="content" source="../media/migrate-devtest.png" alt-text="Diagram showing how to migrate DevTest to Azure.":::

**Deep dive on migration scenarios:**

Migrate an [on-premises dev test environment](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-devtest-to-iaas/?azure-portal=true) on Azure Virtual Machines via Azure Migrate.

### Modernize

You can use purpose-built managed developer services like [Azure DevTest Labs](https://azure.microsoft.com/services/devtest-lab/?azure-portal=true) to deliver quality products, applications, and services.

:::image type="content" source="../media/modernize-dev-test-labs.png" alt-text="Diagram showing how to modernize using DevTest Labs.":::

Migrate a dev/test environment to [Azure DevTest Labs](/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-devtest-to-labs/?azure-portal=true).

### Azure DevTest pricing

There are [discounted rates on Azure](https://azure.microsoft.com/pricing/dev-test?azure-portal=true) to support your ongoing development and testing:

- No Microsoft software charges on VMs
- Significant dev/test pricing discounts on various other Azure services
- Access to Windows 10 VMs and Azure Virtual Desktop service
