## Introduction

Victor Melo is the Cloud Administrator at Contoso, a small technology company just beginning their digital transformation. Contoso's line-of-business support application is running on Windows Server 2008 R2 and SQL Server 2008 R2 virtualized in VMware.

Victor has decided to move the support application to Azure using a lift and shift strategy. He will rehost the application web servers to Azure IaaS virtual machines and move the SQL Server database to a fully managed Azure database service.

The process Victor follows as he completes the lift and shift migration of Contoso's support application is separated into six segments, as illustrated by the following animation:

|||
| :--- | :--- |
| ![Icon indicating play video](../media/video_icon.png)| Watch this brief animation for a visual roadmap of the demo.|

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2QLWz]

## Azure Migrate

Before beginning the migration of Contoso's support application, Victor creates a new service ticket and reviews the on-premises virtual machines (VMs). He then uses **Azure Migrate** to create and provision a new migration project.

|||
| :--- | :--- |
| ![Icon indicating play video](../media/video_icon.png)| Watch as Victor prepares to migrate Contoso's service ticket application.|

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PyM6]

| | |
| ---: | :--- |
| ![Recap icon](../media/Recap.png)| *Use the Azure Migrate solution to easily discover and assess your on-premises virtual machines, eliminating the need for your IT department to manually count servers and determine specs.*|
|

---

**#comment**

Alternative presentation of value prop text:

> [!IMPORTANT]
> Use the Azure Migrate solution to easily discover and assess your on-premises virtual machines, eliminating the need for your IT department to manually count servers and determine specs.

---

## Data collection

Victor deploys and configures an appliance called a "collector," which will discover and assess the on-premises VMs and upload the metadata to the migration project in preparation for migrating the VMs and database that support Contoso's service ticket.

|||
| :--- | :--- |
| ![Icon indicating play video](../media/video_icon.png)| Watch this video to see how Victor uses the Azure Migrate collector VM to gather the data needed for migration.|

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PyM7]

| | |
| ---: | :--- |
| ![Recap icon](../media/Recap.png)| *Deploying the Azure Migrate Collector will not only help you evaluate your physical on-premises servers but will also work with vSphere to assess virtual servers.*|
|

## Recommendations

**Azure Migrate** helps Victor visualize dependencies and then makes recommendations that help Victor plan his migration.

|||
| :--- | :--- |
| ![Icon indicating play video](../media/video_icon.png)| Watch this video to see how Azure Migrate uses the data collected to make recommendations for migration.|

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PQUq]

| | |
| ---: | :--- |
| ![Recap icon](../media/Recap.png)| *The collector appliance gathers metadata from on-premises servers running both Windows and Linux and sends it to the migration project. Azure Migrate then uses the collector appliance data to make application-specific migration recommendations including cost estimates for both migration and operation in the cloud. The Azure Hybrid Benefit allows you to capitalize on your existing Windows licensing investments with discounts for VMs turned on in Azure.*|
|

## Database Migration

With his assessment complete, Victor begins by migrating Contoso's database from SQL Server to **Azure SQL Database Managed Instance** using **Azure Database Migration Service**.

|||
| :--- | :--- |
| ![Icon indicating play video](../media/video_icon.png)| Watch this video to follow the steps to migrate Contoso's database.|

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PBj3]

| | |
| ---: | :--- |
| ![Recap icon](../media/Recap.png)| *Azure Database Migration Service is a seamless, end-to-end solution for moving on-premises SQL Server databases to a managed SQL environment with minimal downtime, replacing multiple tools with a single comprehensive service. After moving to Azure you can save as much as 80% by reserving capacity rather than using the pay-as-you-go model.*|
|

## Application server migration

With the database migration complete, Victor is ready to migrate Contoso's on-premises application servers using **Azure Site Recovery**.

|||
| :--- | :--- |
| ![Icon indicating play video](../media/video_icon.png)| Watch this video to see how Victor migrates the application servers.|

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PLJp]

| | |
| ---: | :--- |
| ![Recap icon](../media/Recap.png)| *Azure Site Recovery offers a method for migrating your on-premises VMs to the cloud without taking the servers down by replicating those VMs from a primary site (on-premises) to a secondary location (Azure). The Azure Hybrid Benefit allows you to save costs by using your existing Windows Server license.*|
|

## Post-migration

With the migration complete, Victor needs to complete a couple of final steps to bring the migrated systems to full functionality in Azure.

|||
| :--- | :--- |
| ![Icon indicating play video](../media/video_icon.png)| Watch this video for a demonstration of these post-migration steps.|

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PQUr]

| | |
| ---: | :--- |
| ![Recap icon](../media/Recap.png)| *Connecting to a load balancer in Azure keeps your servers from bogging down, allowing a smooth flow of traffic. The availability set ensures that your site is always up and running without the need for duplicate servers.*|
|
