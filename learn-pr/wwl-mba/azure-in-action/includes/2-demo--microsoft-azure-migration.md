## Introduction

Victor Melo is the Cloud Administrator at Contoso, a small technology company just beginning their digital transformation. Contoso's line-of-business support application is running on Windows Server 2008 R2 and SQL Server 2008 R2 virtualized in VMware.

Victor has decided to move the support application to Azure using a lift and shift strategy. He will rehost the application web servers to Azure IaaS virtual machines and move the SQL Server database to a fully managed Azure database service.

The process Victor follows as he completes the lift and shift migration of Contoso's support application is separated into six segments, as illustrated by the following table:


:::row:::

![Azure Migrate icon](../media/azure-migrate.png)


:::column span="1":::


### Azure Migrate

- Create a service ticket
- Review VMs
- Create migration project

:::column-end:::
:::row-end:::

:::row:::

![Data collection icon](../media/data-collection.png)

:::column span="1":::

### Data collection

- Deploy collector
- Configure collector
- Assess environment

:::column-end:::
:::row-end:::

:::row:::


![Recommendations icon](../media/recommendations.png)

:::column span="1":::

### Recommendations

- Visualize dependencies
- Group machines
- View assessment

:::column-end:::
:::row-end:::

:::row:::


![Database migration icon](../media/database-migration.png)

:::column span="1":::

### Database migration

- Create database migration project
- Configure migration
- Run migration

:::column-end:::
:::row-end:::

:::row:::

![Application server migration icon](../media/server-migration.png)

:::column span="1":::

### Application server migration

- Replicate machines
- Verify sizing
- Run test failover

:::column-end:::
:::row-end:::

:::row:::

![Post-migration icon](../media/post-migration.png)

:::column span="1":::

### Post-migration

- Connect to load balancers
- Perform cutover
- Verify functionality

:::column-end:::
:::row-end:::

## Azure Migrate

:::row:::

![Icon indicating play video](../media/video-icon.png)

:::column span="1":::

Before beginning the migration of Contoso's support application, Victor creates a new service ticket and reviews the on-premises virtual machines (VMs). He then uses Azure Migrate to create and provision a new migration project. Watch as Victor prepares to migrate Contoso's service ticket application.

 :::column-end:::
:::row-end:::

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PyM6]

Use the **Azure Migrate** solution to easily discover and assess your on-premises virtual machines, eliminating the need for your IT department to manually count servers and determine specs.


## Data collection

:::row:::

![Icon indicating play video](../media/video-icon.png)

:::column span="1":::

Victor deploys and configures an appliance called a "collector," which will discover and assess the on-premises VMs and upload the metadata to the migration project. Watch this video to see how Victor uses the Azure Migrate collector VM to gather the data needed for migration.

:::column-end:::
:::row-end:::

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PyM7]

Deploying the **Azure Migrate Collector** will not only help you evaluate your physical on-premises servers but will also work with vSphere to assess virtual servers.

## Recommendations

:::row:::

![Icon indicating play video](../media/video-icon.png)

:::column span="1":::

Victor uses Azure Migrate to visualize dependencies to help him plan his migration. Watch this video to see how Azure Migrate uses the data collected to make recommendations for migration.

:::column-end:::
:::row-end:::

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PQUq]

**Azure Migrate** saves time and money by pulling data from the collector appliance and telling you exactly what servers are ready to migrate, and what costs they would incur running in the cloud.  Additionally, the **Azure Hybrid Use Benefit** can lower costs by up to 1/5 by leveraging existing on-premises licenses (see more detail at the URL provided on the resources page).

## Database Migration

:::row:::

![Icon indicating play video](../media/video-icon.png)

:::column span="1":::

Victor migrates Contoso's database from SQL Server to Azure SQL Database Managed Instance using Azure Database Migration Service. Watch this video to follow the steps to migrate Contoso's database.

:::column-end:::
:::row-end:::

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PBj3]

**Azure Database Migration Service** is a seamless, end-to-end solution for moving on-premises SQL Server databases to a managed SQL environment with minimal downtime, replacing multiple tools with a single comprehensive service. After moving to Azure you can save as much as 80% by reserving capacity rather than using the pay-as-you-go model.

## Application server migration

:::row:::

![Icon indicating play video](../media/video-icon.png)

:::column span="1":::

In the next video, Victor will migrate Contoso's on-premises application servers using Azure Site Recovery. Watch this video to see the steps in the application server migration.

:::column-end:::
:::row-end:::

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PLJp]

**Azure Site Recovery** offers a method for migrating your on-premises VMs to the cloud without taking the servers down by replicating those VMs from a primary site (on-premises) to a secondary location (Azure). The **Azure Hybrid Benefit** allows you to save costs by using your existing Windows Server license.

## Post-migration

:::row:::

![Icon indicating play video](../media/video-icon.png)

:::column span="1":::

Victor completes the final steps to bring the migrated systems to full functionality in Azure. Watch this video for a demonstration of these post-migration steps.

:::column-end:::
:::row-end:::

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE2PQUr]

Connecting to a load balancer in Azure keeps your servers from bogging down, allowing a smooth flow of traffic. The availability set ensures that your site is always up and running without the need for duplicate servers.

---

Next, we'll see how easy it is to migrate and modernize an application without changes to the code.
