## Introduction

Welcome to the solution demo covering Windows Server and SQL Server migration to Azure. Microsoft Azure offers solutions that help assess on-premises applications, allowing organizations to discover servers, visualize dependencies, and confidently plan and execute server and service migration to Azure.

Contoso is a technology company that’s planning to rehost its IT support web application by using a “lift-and-shift” migration strategy. They are currently running the web application on Windows Server 2008 R2 and SQL Server 2008 R2 platforms virtualized in VMware.

Victor Melo, the Cloud Administrator at Contoso, is going to rehost the application web servers to Azure IaaS virtual machines and move the SQL Server database to a fully managed Azure database service.

## Microsoft Azure migration: Assess and rehost applications

|||
| :--- | :--- |
| ![Icon indicating play video](../media/video-icon.png)| Watch as Victor uses Azure Migrate, Azure Database Migration Service, and Azure Site Recovery to migrate Contoso's support application to Azure.|

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE3dj3C]

You’ve just seen how Microsoft Azure Migrate, Azure Database Migration Service, and Azure Site Recovery can help your organization assess its on-premises applications for migration, and then rehost these applications to Azure.

### Key points

- Use the Azure Migrate solution to easily discover and assess your on-premises virtual machines, eliminating the need for your IT department to manually count servers and determine specs.

- Deploying the Azure Migrate Collector will not only help you evaluate your physical on-premises servers but will also work with vSphere to assess virtual servers.

- The collector appliance gathers metadata from on-premises servers running both Windows and Linux and sends it to the migration project. Azure Migrate then uses the collector appliance data to make application-specific migration recommendations including cost estimates for both migration and operation in the cloud.

- The Azure Hybrid Benefit allows you to capitalize on your existing Windows licensing investments with discounts for VMs turned on in Azure.

- Azure Database Migration Service is a seamless, end-to-end solution for moving on-premises SQL Server databases to a managed SQL environment with minimal downtime, replacing multiple tools with a single comprehensive service.

- After moving to Azure you can save as much as 80% by reserving capacity rather than using the pay-as-you-go model.

- Azure Site Recovery offers a method for migrating your on-premises virtual machines (VMs) to the cloud without taking the servers down by replicating those VMs from a primary site (on-premises) to a secondary location (Azure).

- Connecting to a load balancer in Azure keeps your servers from bogging down, allowing a smooth flow of traffic. The availability set ensures that your site is always up and running without the need for duplicate servers.

Next, we'll see how easy it is to migrate and modernize an application without changes to the code.

